import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/question.dart';
import '../models/question_filter.dart';
import '../models/question_enums.dart';

/// Service for real-time question updates using Firestore listeners
class RealtimeQuestionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot>? _questionsSubscription;
  final StreamController<List<Question>> _questionsController =
      StreamController<List<Question>>.broadcast();

  /// Stream of real-time question updates
  Stream<List<Question>> get questionsStream => _questionsController.stream;

  /// Start listening to question changes with filtering
  void startListening(QuestionFilter filter) {
    // Stop existing listener
    stopListening();

    // Build Firestore query based on filter
    Query query = _firestore
        .collection('questions')
        .where('is_active', isEqualTo: true);

    // Add filters
    if (filter.examCategories?.isNotEmpty ?? false) {
      query = query.where('exam_type', whereIn: filter.examCategories);
    }

    if (filter.subjects?.isNotEmpty ?? false) {
      query = query.where('subject', whereIn: filter.subjects);
    }

    if (filter.difficulties?.isNotEmpty ?? false) {
      final difficultyNames = filter.difficulties!.map((d) => d.name).toList();
      query = query.where('difficulty', whereIn: difficultyNames);
    }

    if (filter.questionTypes?.isNotEmpty ?? false) {
      query = query.where('question_type', whereIn: filter.questionTypes);
    }

    // Order by creation date (newest first)
    query = query.orderBy('created_at', descending: true);

    // Limit results
    if (filter.limit != null) {
      query = query.limit(filter.limit!);
    }

    // Start listening
    _questionsSubscription = query.snapshots().listen(
      _onQuestionsSnapshot,
      onError: _onSnapshotError,
    );
  }

  /// Handle Firestore snapshot updates
  void _onQuestionsSnapshot(QuerySnapshot snapshot) {
    try {
      final questions = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Ensure ID is set

        // Sanitize data for parsing
        final safeData = _sanitizeQuestionData(data);

        return Question.fromJson(safeData);
      }).toList();

      // Apply additional client-side filters that can't be done in Firestore
      var filteredQuestions = questions;

      // Search query filtering (client-side)
      if (_currentFilter?.searchQuery?.isNotEmpty ?? false) {
        final query = _currentFilter!.searchQuery!.toLowerCase();
        filteredQuestions = filteredQuestions
            .where((q) => q.searchableText.contains(query))
            .toList();
      }

      // ARDE probability filtering (client-side approximation)
      if (_currentFilter?.ardeProbabilities?.isNotEmpty ?? false) {
        // This is a simplified client-side filter
        // In production, you might want server-side filtering
        filteredQuestions = filteredQuestions.where((q) {
          final level = _getArdeLevel(q.ardeProbability);
          return _currentFilter!.ardeProbabilities!.contains(level);
        }).toList();
      }

      _questionsController.add(filteredQuestions);
    } catch (e) {
      _questionsController.addError(e);
    }
  }

  /// Handle snapshot errors
  void _onSnapshotError(Object error) {
    _questionsController.addError(error);
  }

  /// Stop listening to changes
  void stopListening() {
    _questionsSubscription?.cancel();
    _questionsSubscription = null;
  }

  /// Dispose of resources
  void dispose() {
    stopListening();
    _questionsController.close();
  }

  QuestionFilter? _currentFilter;

  /// Update the current filter
  void updateFilter(QuestionFilter filter) {
    _currentFilter = filter;
    startListening(filter);
  }

  /// Sanitize question data for parsing (similar to present_question_provider)
  Map<String, dynamic> _sanitizeQuestionData(Map<String, dynamic> data) {
    // Helper functions for type safety
    int _safeInt(dynamic value, int defaultValue) {
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value) ?? defaultValue;
      return defaultValue;
    }

    double _safeDouble(dynamic value, double defaultValue) {
      if (value == null) return defaultValue;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? defaultValue;
      return defaultValue;
    }

    String? _safeDateTimeString(dynamic value) {
      if (value == null) return null;
      if (value is DateTime) return value.toIso8601String();
      if (value is String) return value;
      // Handle Firestore Timestamp
      if (value != null && value.toString().contains('Timestamp')) {
        try {
          final timestamp = value;
          if (timestamp.seconds != null) {
            final dateTime = DateTime.fromMillisecondsSinceEpoch(
              timestamp.seconds * 1000,
            );
            return dateTime.toIso8601String();
          }
        } catch (e) {
          print('Error parsing Firestore timestamp: $e');
        }
      }
      return null;
    }

    return {
      'id': data['id'] ?? 'unknown_${DateTime.now().millisecondsSinceEpoch}',
      'questionId': _safeInt(data['questionId'] ?? data['question_id'], 0),
      'examCategory': data['examCategory'] ?? data['exam_type'] ?? 'General',
      'subject': data['subject'] ?? 'General',
      'topic': data['topic'] ?? 'General',
      'subTopic': data['subTopic'],
      'questionText':
          data['questionText'] ??
          data['question_text'] ??
          'Question text not available',
      'questionImageUrls': data['questionImageUrls'] ?? [],
      'questionLatex': data['questionLatex'] ?? [],
      'options': _sanitizeOptions(data['options']),
      'correctAnswer': data['correctAnswer'] ?? data['correct_answer'] ?? ['A'],
      'questionType': data['questionType'] ?? 'singleChoice',
      'explanationText':
          data['explanationText'] ??
          data['explanation']?['text'] ??
          'Explanation not available',
      'explanationVideoUrl':
          data['explanationVideoUrl'] ?? data['video_explanation_url'],
      'explanationSteps': data['explanationSteps'] ?? [],
      'references': data['references'] ?? [],
      'ardeProbability': _safeDouble(
        data['ardeProbability'] ?? data['arde_probability'],
        0.5,
      ),
      'ardeFrequency': _safeInt(
        data['ardeFrequency'] ?? data['historical_frequency'],
        0,
      ),
      'ardeAppearanceYears': data['ardeAppearanceYears'] ?? [],
      'ardeNotes': data['ardeNotes'],
      'ardeContext': data['ardeContext'] ?? data['arde_context'],
      'difficulty': data['difficulty'] ?? 'medium',
      'estimatedTimeSeconds': _safeInt(data['estimatedTimeSeconds'], 60),
      'globalStats':
          data['globalStats'] ??
          data['performance_stats'] ??
          {
            'totalAttempts': 0.0,
            'totalCorrect': 0.0,
            'globalAccuracy': 0.0,
            'averageTimeSeconds': 0.0,
            'medianTimeSeconds': 0.0,
            'p95TimeSeconds': 0.0,
            'calculatedDifficulty': 0.5,
          },
      'tags': data['tags'] ?? [],
      'relatedQuestions': data['relatedQuestions'] ?? [],
      'createdAt':
          _safeDateTimeString(data['createdAt'] ?? data['created_at']) ??
          DateTime.now().toIso8601String(),
      'updatedAt':
          _safeDateTimeString(data['updatedAt'] ?? data['updated_at']) ??
          DateTime.now().toIso8601String(),
      'createdBy': data['createdBy'] ?? data['created_by'] ?? 'unknown',
      'createdByName': data['createdByName'],
      'isActive': data['isActive'] ?? true,
      'version': _safeInt(data['version'], 1),
      'status': data['status'] ?? 'draft',
      'approval_status': data['approval_status'] ?? data['status'] ?? 'pending',
      'reviewer_id': data['reviewer_id'] ?? data['reviewerId'],
      'reviewer_name': data['reviewer_name'] ?? data['reviewerName'],
      'review_comments': data['review_comments'] ?? data['reviewComments'],
      'submitted_at':
          _safeDateTimeString(data['submittedAt'] ?? data['submitted_at']) ??
          DateTime.now().toIso8601String(),
      'reviewed_at': _safeDateTimeString(
        data['reviewedAt'] ?? data['reviewed_at'],
      ),
      'approved_at': _safeDateTimeString(
        data['approvedAt'] ?? data['approved_at'],
      ),
    };
  }

  /// Sanitize options array
  List<Map<String, dynamic>> _sanitizeOptions(dynamic optionsData) {
    if (optionsData == null) {
      return [
        {'id': 'A', 'text': 'Option A'},
        {'id': 'B', 'text': 'Option B'},
      ];
    }

    if (optionsData is! List) {
      return [
        {'id': 'A', 'text': 'Option A'},
        {'id': 'B', 'text': 'Option B'},
      ];
    }

    final options = optionsData as List;
    if (options.isEmpty) {
      return [
        {'id': 'A', 'text': 'Option A'},
        {'id': 'B', 'text': 'Option B'},
      ];
    }

    final sanitizedOptions = <Map<String, dynamic>>[];
    for (int i = 0; i < options.length; i++) {
      final option = options[i];
      if (option is Map<String, dynamic>) {
        sanitizedOptions.add({
          'id':
              option['id'] ??
              option['option_id'] ??
              String.fromCharCode(65 + i),
          'text': option['text'] ?? 'Option ${String.fromCharCode(65 + i)}',
          'imageUrl': option['imageUrl'],
          'latex': option['latex'],
          'isCorrect': option['isCorrect'] ?? option['is_correct'] ?? false,
        });
      } else {
        sanitizedOptions.add({
          'id': String.fromCharCode(65 + i),
          'text': 'Option ${String.fromCharCode(65 + i)}',
        });
      }
    }

    if (sanitizedOptions.length < 2) {
      while (sanitizedOptions.length < 2) {
        sanitizedOptions.add({
          'id': String.fromCharCode(65 + sanitizedOptions.length),
          'text': 'Option ${String.fromCharCode(65 + sanitizedOptions.length)}',
        });
      }
    }

    return sanitizedOptions;
  }

  /// Convert ARDE probability to level (simplified)
  ArdeLevel _getArdeLevel(double probability) {
    if (probability >= 0.7) return ArdeLevel.high;
    if (probability >= 0.3) return ArdeLevel.medium;
    return ArdeLevel.low;
  }
}

/// Provider for the real-time question service
final realtimeQuestionServiceProvider = Provider<RealtimeQuestionService>((
  ref,
) {
  final service = RealtimeQuestionService();
  ref.onDispose(() => service.dispose());
  return service;
});
