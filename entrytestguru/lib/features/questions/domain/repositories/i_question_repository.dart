import '../../data/models/question.dart';
import '../../data/models/question_filter.dart';
import '../../data/models/question_attempt.dart';

/// Interface for question data operations
/// Defines the contract for question repository implementations
abstract class IQuestionRepository {
  /// Fetches questions based on the provided filter
  /// Returns a list of questions matching the filter criteria
  Future<List<Question>> getFilteredQuestions(QuestionFilter filter);

  /// Fetches a single question by its ID
  /// Returns null if the question is not found or inactive
  Future<Question?> getQuestion(String questionId);

  /// Searches for questions based on a text query
  /// Returns questions that match the search terms
  Future<List<Question>> searchQuestions(
    String query, {
    String? examCategory,
    int limit = 20,
  });

  /// Fetches questions for a specific practice session
  /// Optimized for practice mode with performance considerations
  Future<List<Question>> getQuestionsForPractice({
    required String examCategory,
    String? subject,
    String? topic,
    int limit = 20,
  });

  /// Fetches questions for a simulated exam
  /// Returns questions optimized for exam conditions
  Future<List<Question>> getQuestionsForExam({
    required String examCategory,
    int questionCount = 100,
    bool prioritizeHighArde = true,
  });

  /// Records a question attempt for analytics
  /// Updates user progress and question statistics
  Future<void> recordAttempt(QuestionAttempt attempt);

  /// Fetches attempt history for a specific question
  /// Returns all attempts by the current user for the question
  Future<List<QuestionAttempt>> getQuestionAttempts(
    String questionId, {
    String? userId,
  });

  /// Fetches attempt history for a session
  /// Returns all attempts in a specific practice session
  Future<List<QuestionAttempt>> getSessionAttempts(String sessionId);

  /// Bookmarks or unbookmarks a question for the user
  /// Updates the user's bookmark list
  Future<void> toggleBookmark(String questionId, {String? userId});

  /// Fetches all bookmarked questions for the user
  /// Returns questions marked as favorites by the user
  Future<List<Question>> getBookmarkedQuestions({String? userId});

  /// Adds a personal note to a question
  /// Stores user-specific notes for questions
  Future<void> addQuestionNote(
    String questionId,
    String note, {
    String? userId,
  });

  /// Fetches questions that the user struggles with
  /// Based on incorrect attempts and low accuracy
  Future<List<Question>> getWeakAreaQuestions({
    String? examCategory,
    int limit = 20,
  });

  /// Fetches questions that the user hasn't attempted yet
  /// Returns unattempted questions for practice
  Future<List<Question>> getUnattemptedQuestions({
    String? examCategory,
    String? subject,
    int limit = 20,
  });

  /// Fetches questions with high ARDE probability
  /// Prioritizes questions most likely to appear in exams
  Future<List<Question>> getHighArdeQuestions({
    String? examCategory,
    int limit = 20,
  });

  /// Gets question performance statistics
  /// Returns aggregated stats for questions
  Future<Map<String, dynamic>> getQuestionStats(String questionId);

  /// Prefetches questions for offline use
  /// Downloads and caches questions for offline practice
  Future<void> prefetchQuestions(List<String> questionIds);

  /// Clears cached questions
  /// Removes locally stored questions to free up space
  Future<void> clearQuestionCache();

  /// Syncs local attempts with the server
  /// Uploads pending attempts when online
  Future<void> syncPendingAttempts();

  /// Gets the count of pending attempts to sync
  /// Returns the number of attempts waiting to be uploaded
  Future<int> getPendingAttemptsCount();
}
