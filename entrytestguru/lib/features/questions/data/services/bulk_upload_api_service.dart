import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/services/firestore_service.dart';
import '../models/question.dart';
import '../models/question_enums.dart';
import '../models/question_option.dart';
import '../../utils/question_schema_mapper.dart';

/// API service for bulk upload operations
/// Handles Excel file validation, preview, and upload with fallback to Firestore
class BulkUploadApiService {
  final ApiClient _apiClient;
  final FirestoreService _firestoreService;
  final Logger _logger = Logger('BulkUploadApiService');

  BulkUploadApiService(this._apiClient, this._firestoreService);

  /// Provider for dependency injection
  static final provider = Provider<BulkUploadApiService>((ref) {
    final apiClient = ref.watch(apiClientProvider);
    final firestoreService = ref.watch(firestoreServiceProvider);
    return BulkUploadApiService(apiClient, firestoreService);
  });

  /// Previews bulk upload file - validates and shows sample questions
  /// Falls back to Firestore-based validation if API fails
  Future<Map<String, dynamic>> previewBulkUpload(
    Uint8List file,
    String filename,
  ) async {
    try {
      _logger.info('Attempting API preview for bulk upload: $filename');

      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(file, filename: filename),
        'filename': filename,
      });

      // CORRECT path: no /questions prefix
      final response = await _apiClient.post(
        '/bulk-upload/preview',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      _logger.info('API preview successful');
      return response.data;
    } catch (e) {
      _logger.warning('API preview failed, falling back to Firestore: $e');

      try {
        return await _previewBulkUploadFromFirestore(file, filename);
      } catch (firestoreError) {
        _logger.severe(
          'Both API and Firestore preview failed: $firestoreError',
        );
        rethrow;
      }
    }
  }

  /// Starts bulk upload process
  /// Falls back to Firestore-based upload if API fails
  Future<Map<String, dynamic>> startBulkUpload(
    Uint8List file,
    String filename,
  ) async {
    try {
      _logger.info('Attempting API bulk upload: $filename');

      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(file, filename: filename),
        'filename': filename,
      });

      // CORRECT path: no /questions prefix
      final response = await _apiClient.post(
        '/bulk-upload',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      _logger.info('API bulk upload started successfully');
      return response.data;
    } catch (e) {
      _logger.warning('API bulk upload failed, falling back to Firestore: $e');

      try {
        return await _startBulkUploadFromFirestore(file, filename);
      } catch (firestoreError) {
        _logger.severe(
          'Both API and Firestore bulk upload failed: $firestoreError',
        );
        rethrow;
      }
    }
  }

  /// Gets bulk upload progress
  Future<Map<String, dynamic>> getBulkUploadProgress(String uploadId) async {
    try {
      _logger.info('Getting bulk upload progress for: $uploadId');

      // CORRECT path: no /questions prefix
      final response = await _apiClient.get('/bulk-upload/$uploadId/progress');

      return response.data;
    } catch (e) {
      _logger.warning('API progress check failed: $e');
      // For progress, we can't easily fall back to Firestore
      // Return a generic error state
      return {
        'status': 'failed',
        'error': 'Unable to check upload progress. Please refresh.',
        'total': 0,
        'processed': 0,
        'successful': 0,
        'failed': 0,
      };
    }
  }

  /// Gets bulk upload summary
  Future<Map<String, dynamic>> getBulkUploadSummary(String uploadId) async {
    try {
      _logger.info('Getting bulk upload summary for: $uploadId');

      // CORRECT path: no /questions prefix
      final response = await _apiClient.get('/bulk-upload/$uploadId/summary');

      return response.data;
    } catch (e) {
      _logger.warning('API summary failed: $e');
      // Return a generic error summary
      return {
        'total_questions': 0,
        'successful': 0,
        'failed': 0,
        'errors': [
          {'error': 'Unable to retrieve summary'},
        ],
        'processing_time_seconds': 0.0,
      };
    }
  }

  /// Retries failed questions in bulk upload
  Future<Map<String, dynamic>> retryFailedQuestions(
    String uploadId,
    List<int> rowNumbers,
  ) async {
    try {
      _logger.info('Retrying failed questions for upload: $uploadId');

      // CORRECT path: no /questions prefix
      final response = await _apiClient.post(
        '/bulk-upload/$uploadId/retry',
        data: rowNumbers,
      );

      return response.data;
    } catch (e) {
      _logger.warning('API retry failed: $e');
      return {
        'retry_results': [],
        'message': 'Unable to retry questions. Please try uploading again.',
      };
    }
  }

  /// Cancels bulk upload
  Future<void> cancelBulkUpload(String uploadId) async {
    try {
      _logger.info('Cancelling bulk upload: $uploadId');

      // CORRECT path: no /questions prefix
      await _apiClient.delete('/bulk-upload/$uploadId');
    } catch (e) {
      _logger.warning('API cancel failed: $e');
      // Cancellation is not critical, just log the error
    }
  }

  /// Atomically get the next available questionId from Firestore
  /// Uses a counter document to ensure uniqueness across concurrent requests
  /// Initializes counter based on existing questions if counter doesn't exist
  Future<int> getNextQuestionId() async {
    try {
      _logger.info('Getting next questionId using atomic counter');

      // Use Firestore counter document for atomic increments
      final counterRef = _firestoreService.firestore
          .collection('counters')
          .doc('questionId');

      // Run atomic transaction to increment counter
      final result = await _firestoreService.firestore.runTransaction((
        transaction,
      ) async {
        final snapshot = await transaction.get(counterRef);

        int currentMax;
        if (snapshot.exists) {
          // Counter exists, use its value
          currentMax = (snapshot.data()?['value'] as int?) ?? 0;
        } else {
          // Counter doesn't exist, initialize it based on existing questions
          _logger.info(
            'Counter document not found, initializing from existing questions',
          );

          // Query for the highest existing questionId
          final initQuery = await _firestoreService.firestore
              .collection('questions')
              .orderBy('questionId', descending: true)
              .limit(1)
              .get();

          currentMax = initQuery.docs.isNotEmpty
              ? initQuery.docs.first.data()['questionId'] as int? ?? 0
              : 0;

          _logger.info(
            'Initialized counter to: $currentMax (based on existing questions)',
          );
        }

        final nextId = currentMax + 1;

        // Update counter document
        transaction.set(counterRef, {
          'value': nextId,
          'updatedAt': DateTime.now().toIso8601String(),
        });

        return nextId;
      });

      _logger.info('Generated next questionId: $result');
      return result;
    } catch (e) {
      _logger.warning('Atomic counter failed, falling back to query: $e');

      // Fallback: Query for max existing questionId
      try {
        final querySnapshot = await _firestoreService.firestore
            .collection('questions')
            .orderBy('questionId', descending: true)
            .limit(1)
            .get();

        final maxExisting = querySnapshot.docs.isNotEmpty
            ? querySnapshot.docs.first.data()['questionId'] as int? ?? 0
            : 0;

        final nextId = maxExisting + 1;
        _logger.info('Fallback generated next questionId: $nextId');
        return nextId;
      } catch (fallbackError) {
        _logger.severe(
          'Both atomic counter and fallback failed: $fallbackError',
        );

        // Last resort: Use timestamp-based ID (should be very rare)
        final timestampId =
            DateTime.now().millisecondsSinceEpoch %
            1000000; // Keep it reasonable
        _logger.warning(
          'Using timestamp-based questionId as last resort: $timestampId',
        );
        return timestampId;
      }
    }
  }

  /// Fallback method: Preview bulk upload using Firestore
  /// Parse CSV file client-side for basic validation and preview
  Future<Map<String, dynamic>> _previewBulkUploadFromFirestore(
    Uint8List file,
    String filename,
  ) async {
    try {
      _logger.info('Performing CSV-based bulk upload preview (fallback mode)');

      // Parse CSV content
      final csvContent = String.fromCharCodes(file);
      final lines = _parseCsvLines(csvContent);

      if (lines.isEmpty) {
        return {
          'total_questions': 0,
          'valid_questions': 0,
          'errors': [
            {
              'row': 1,
              'question_text': 'Empty file',
              'errors': ['CSV file appears to be empty'],
            },
          ],
          'sample_questions': [],
          'fallback_mode': true,
          'message': 'Empty CSV file detected.',
        };
      }

      // Parse header row
      final headers = _parseCsvRow(lines[0]);
      final dataRows = lines.skip(1).toList(); // Skip header

      _logger.info(
        'Parsed CSV: ${dataRows.length} data rows, headers: $headers',
      );

      // Basic validation
      final errors = <Map<String, dynamic>>[];
      final sampleQuestions = <Map<String, dynamic>>[];
      int validCount = 0;

      // Check for required columns
      final requiredColumns = [
        'question_text',
        'option_a',
        'option_b',
        'option_c',
        'option_d',
        'correct_answer',
      ];
      final missingColumns = requiredColumns
          .where((col) => !headers.contains(col))
          .toList();

      if (missingColumns.isNotEmpty) {
        errors.add({
          'row': 1,
          'question_text': 'Invalid CSV format',
          'errors': ['Missing required columns: ${missingColumns.join(', ')}'],
        });
      } else {
        // Validate each row
        for (int i = 0; i < dataRows.length && i < 10; i++) {
          // Check first 10 rows for performance
          final rowNumber = i + 2; // +2 because we skip header and 0-indexed
          final rawRowData = _parseCsvRow(dataRows[i]);

          // Pad row data to match header length (CSV often omits trailing empty columns)
          final rowData = List<String>.from(rawRowData);
          while (rowData.length < headers.length) {
            rowData.add(''); // Pad with empty strings
          }

          // If row has more columns than header, that's an error
          if (rawRowData.length > headers.length) {
            errors.add({
              'row': rowNumber,
              'question_text': rawRowData.isNotEmpty
                  ? rawRowData[0]
                  : 'Unknown',
              'errors': [
                'Row has ${rawRowData.length} columns, expected ${headers.length} or fewer',
              ],
            });
            continue;
          }

          // Create question map
          final questionMap = <String, dynamic>{};
          for (int j = 0; j < headers.length && j < rowData.length; j++) {
            questionMap[headers[j]] = rowData[j];
          }

          // Basic validation
          final questionText =
              questionMap['question_text']?.toString().trim() ?? '';
          final optionA = questionMap['option_a']?.toString().trim() ?? '';
          final optionB = questionMap['option_b']?.toString().trim() ?? '';
          final correctAnswer =
              questionMap['correct_answer']?.toString().trim() ?? '';

          final rowErrors = <String>[];

          if (questionText.isEmpty) {
            rowErrors.add('Question text is required');
          }
          if (optionA.isEmpty || optionB.isEmpty) {
            rowErrors.add('At least options A and B are required');
          }
          if (correctAnswer.isEmpty) {
            rowErrors.add('Correct answer is required');
          } else if (![
            'A',
            'B',
            'C',
            'D',
            'E',
          ].contains(correctAnswer.toUpperCase())) {
            rowErrors.add('Correct answer must be A, B, C, D, or E');
          }

          if (rowErrors.isEmpty) {
            validCount++;
            // Add to sample questions (first 5)
            if (sampleQuestions.length < 5) {
              sampleQuestions.add({
                'question_id': rowNumber,
                'question_text': questionText.length > 100
                    ? '${questionText.substring(0, 100)}...'
                    : questionText,
                'question_type': 'single_choice', // Default assumption
                'options_count': _countOptions(questionMap),
              });
            }
          } else {
            errors.add({
              'row': rowNumber,
              'question_text': questionText.isNotEmpty
                  ? questionText
                  : 'Row ${rowNumber}',
              'errors': rowErrors,
            });
          }
        }
      }

      // Estimate total valid questions (basic heuristic)
      final estimatedValid =
          (validCount /
              (dataRows.length > 0
                  ? (dataRows.length < 10 ? dataRows.length : 10)
                  : 1)) *
          dataRows.length;

      return {
        'total_questions': dataRows.length,
        'valid_questions': estimatedValid.round(),
        'errors': errors,
        'sample_questions': sampleQuestions,
        'fallback_mode': true,
        'message':
            'Preview generated from CSV parsing. Full validation will occur during upload.',
      };
    } catch (e) {
      _logger.severe('CSV parsing failed: $e');
      return {
        'total_questions': 0,
        'valid_questions': 0,
        'errors': [
          {
            'row': 1,
            'question_text': 'CSV parsing failed',
            'errors': ['Failed to parse CSV file: ${e.toString()}'],
          },
        ],
        'sample_questions': [],
        'fallback_mode': true,
        'message': 'Unable to parse CSV file. Upload may still work.',
      };
    }
  }

  /// Parse CSV lines, properly handling multi-line quoted fields
  List<String> _parseCsvLines(String csvContent) {
    final lines = <String>[];
    final buffer = StringBuffer();
    bool inQuotes = false;
    int i = 0;

    while (i < csvContent.length) {
      final char = csvContent[i];

      if (char == '"') {
        if (inQuotes && i + 1 < csvContent.length && csvContent[i + 1] == '"') {
          // Escaped quote within quoted field
          buffer.write('"');
          i += 2; // Skip both quotes
          continue;
        } else {
          // Toggle quote state
          inQuotes = !inQuotes;
        }
      } else if (char == '\n' && !inQuotes) {
        // End of line (not inside quotes)
        final line = buffer.toString().trim();
        if (line.isNotEmpty) {
          lines.add(line);
        }
        buffer.clear();
        i++;
        continue;
      } else if (char == '\r' && !inQuotes) {
        // Handle Windows line endings (\r\n)
        if (i + 1 < csvContent.length && csvContent[i + 1] == '\n') {
          final line = buffer.toString().trim();
          if (line.isNotEmpty) {
            lines.add(line);
          }
          buffer.clear();
          i += 2; // Skip \r\n
          continue;
        }
      }

      buffer.write(char);
      i++;
    }

    // Add the last line if there's content
    final lastLine = buffer.toString().trim();
    if (lastLine.isNotEmpty) {
      lines.add(lastLine);
    }

    return lines;
  }

  /// Parse a single CSV row, handling quoted fields
  List<String> _parseCsvRow(String row) {
    final result = <String>[];
    bool inQuotes = false;
    String currentField = '';

    for (int i = 0; i < row.length; i++) {
      final char = row[i];

      if (char == '"') {
        if (inQuotes && i + 1 < row.length && row[i + 1] == '"') {
          // Escaped quote
          currentField += '"';
          i++; // Skip next quote
        } else {
          // Toggle quote state
          inQuotes = !inQuotes;
        }
      } else if (char == ',' && !inQuotes) {
        // Field separator
        result.add(currentField.trim());
        currentField = '';
      } else {
        currentField += char;
      }
    }

    // Add the last field
    result.add(currentField.trim());

    return result;
  }

  /// Count non-empty options in a question map
  int _countOptions(Map<String, dynamic> questionMap) {
    int count = 0;
    for (final option in [
      'option_a',
      'option_b',
      'option_c',
      'option_d',
      'option_e',
    ]) {
      if (questionMap[option]?.toString().trim().isNotEmpty ?? false) {
        count++;
      }
    }
    return count;
  }

  /// Fallback method: Start bulk upload using Firestore
  /// Parse CSV and upload questions directly to Firestore
  Future<Map<String, dynamic>> _startBulkUploadFromFirestore(
    Uint8List file,
    String filename,
  ) async {
    try {
      _logger.info('Performing CSV-based bulk upload to Firestore');

      // Generate a unique upload ID
      final uploadId = 'fallback_${DateTime.now().millisecondsSinceEpoch}';

      // Parse CSV content
      final csvContent = String.fromCharCodes(file);
      final lines = _parseCsvLines(csvContent);

      if (lines.isEmpty) {
        return {
          'upload_id': uploadId,
          'total_questions': 0,
          'status': 'completed',
          'processed': 0,
          'successful': 0,
          'failed': 0,
          'errors': [
            {'row': 1, 'error': 'Empty CSV file'},
          ],
          'fallback_mode': true,
          'message': 'Empty CSV file - no questions to upload.',
        };
      }

      // Parse header row
      final headers = _parseCsvRow(lines[0]);
      final dataRows = lines.skip(1).toList();

      _logger.info('Parsed CSV for upload: ${dataRows.length} data rows');

      int processed = 0;
      int successful = 0;
      int failed = 0;
      final errors = <Map<String, dynamic>>[];

      // Process each row
      for (int i = 0; i < dataRows.length; i++) {
        final rowNumber = i + 2; // +2 because we skip header and 0-indexed
        processed++;

        try {
          final rawRowData = _parseCsvRow(dataRows[i]);

          // Pad row data to match header length (CSV often omits trailing empty columns)
          final rowData = List<String>.from(rawRowData);
          while (rowData.length < headers.length) {
            rowData.add(''); // Pad with empty strings
          }

          // If row has more columns than header, that's an error
          if (rawRowData.length > headers.length) {
            failed++;
            errors.add({
              'row': rowNumber,
              'error':
                  'Row has ${rawRowData.length} columns, expected ${headers.length} or fewer',
            });
            continue;
          }

          // Create question map
          final questionMap = <String, dynamic>{};
          for (int j = 0; j < headers.length && j < rowData.length; j++) {
            questionMap[headers[j]] = rowData[j];
          }

          // Convert to Question object (now async)
          final question = await _createQuestionFromCsvRow(
            questionMap,
            rowNumber,
          );
          if (question != null) {
            // Save to Firestore
            await _firestoreService.addDocument('questions', question.toJson());
            successful++;
            _logger.info('Successfully uploaded question from row $rowNumber');
          } else {
            failed++;
            errors.add({
              'row': rowNumber,
              'error': 'Failed to create question object',
            });
          }
        } catch (e) {
          failed++;
          errors.add({
            'row': rowNumber,
            'error': 'Upload failed: ${e.toString()}',
          });
          _logger.warning('Failed to upload question from row $rowNumber: $e');
        }
      }

      _logger.info(
        'Bulk upload completed: $successful successful, $failed failed',
      );

      return {
        'upload_id': uploadId,
        'total_questions': dataRows.length,
        'status': 'completed',
        'processed': processed,
        'successful': successful,
        'failed': failed,
        'errors': errors,
        'fallback_mode': true,
        'message':
            'Upload completed in fallback mode. $successful questions uploaded successfully.',
      };
    } catch (e) {
      _logger.severe('Firestore bulk upload failed: $e');
      rethrow;
    }
  }

  /// Create a Question object from CSV row data using the schema mapper
  /// Ensures consistent schema between CSV and manual question creation
  Future<Question?> _createQuestionFromCsvRow(
    Map<String, dynamic> rowData,
    int rowNumber,
  ) async {
    try {
      // Validate CSV data first
      final validationErrors = QuestionSchemaMapper.validateCsvQuestionData(
        rowData,
      );
      if (validationErrors.isNotEmpty) {
        _logger.warning(
          'CSV validation failed for row $rowNumber: ${validationErrors.join(", ")}',
        );
        return null;
      }

      // Determine questionId: Use CSV value if available, otherwise generate timestamp-based ID
      int finalQuestionId;
      final csvQuestionId = rowData['questionId']?.toString().trim();

      if (csvQuestionId != null && csvQuestionId.isNotEmpty) {
        // Try to parse CSV questionId
        final parsedId = int.tryParse(csvQuestionId);
        if (parsedId != null && parsedId > 0) {
          finalQuestionId = parsedId;
          _logger.info(
            'Using CSV questionId: $finalQuestionId for row $rowNumber',
          );
        } else {
          // Invalid CSV questionId, generate timestamp-based ID
          finalQuestionId = QuestionSchemaMapper.generateUniqueQuestionId();
          _logger.info(
            'Invalid CSV questionId "$csvQuestionId", using timestamp ID: $finalQuestionId for row $rowNumber',
          );
        }
      } else {
        // No CSV questionId provided, generate timestamp-based ID
        finalQuestionId = QuestionSchemaMapper.generateUniqueQuestionId();
        _logger.info(
          'No CSV questionId provided, using timestamp ID: $finalQuestionId for row $rowNumber',
        );
      }

      // Use schema mapper to create consistent Question object
      return QuestionSchemaMapper.createQuestionFromCsvData(
        rowData,
        overrideQuestionId: finalQuestionId,
        createdBy:
            'bulk_upload_fallback', // Will be overridden by actual user ID
      );
    } catch (e) {
      _logger.warning('Failed to create question from CSV row $rowNumber: $e');
      return null;
    }
  }
}
