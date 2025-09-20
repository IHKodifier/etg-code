import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../../../../widgets/app_button.dart';

class BulkUploadWidget extends ConsumerStatefulWidget {
  const BulkUploadWidget({super.key});

  @override
  ConsumerState<BulkUploadWidget> createState() => _BulkUploadWidgetState();
}

class _BulkUploadWidgetState extends ConsumerState<BulkUploadWidget> {
  PlatformFile? _selectedFile;
  bool _isValidating = false;
  bool _isUploading = false;
  String? _validationMessage;
  Map<String, dynamic>? _previewData;
  String? _uploadId;
  Map<String, dynamic>? _uploadProgress;
  List<Map<String, dynamic>> _questionResults = [];
  Map<String, dynamic>? _uploadSummary;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Bulk Upload Questions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),

        // Content
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (_uploadSummary != null) {
      return _buildSummary();
    }

    if (_uploadProgress != null) {
      return _buildProgress();
    }

    if (_previewData != null) {
      return _buildPreview();
    }

    return _buildFileSelection();
  }

  Widget _buildFileSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Excel or CSV File',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Upload a file containing questions in the specified format. Maximum file size: 50MB.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),

        // File selection area
        Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: InkWell(
            onTap: _pickFile,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.upload_file,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  _selectedFile != null
                      ? _selectedFile!.name
                      : 'Click to select file',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                if (_selectedFile != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${(_selectedFile!.size / 1024 / 1024).toStringAsFixed(2)} MB',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Download template button
        OutlinedButton.icon(
          onPressed: _downloadTemplate,
          icon: const Icon(Icons.download),
          label: const Text('Download Template'),
        ),

        const SizedBox(height: 24),

        // Action buttons
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: 'Validate & Preview',
                onPressed: _selectedFile != null && !_isValidating
                    ? _previewFile
                    : null,
                isLoading: _isValidating,
              ),
            ),
          ],
        ),

        if (_validationMessage != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _validationMessage!.contains('successfully')
                  ? Colors.green.shade50
                  : Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _validationMessage!.contains('successfully')
                    ? Colors.green.shade200
                    : Colors.red.shade200,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _validationMessage!.contains('successfully')
                      ? Icons.check_circle
                      : Icons.error,
                  color: _validationMessage!.contains('successfully')
                      ? Colors.green
                      : Colors.red,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _validationMessage!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPreview() {
    final totalQuestions = _previewData!['total_questions'] as int;
    final validQuestions = _previewData!['valid_questions'] as int;
    final errors = _previewData!['errors'] as List;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preview Questions',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),

        // Summary
        Row(
          children: [
            _buildSummaryCard('Total', totalQuestions.toString(), Colors.blue),
            const SizedBox(width: 16),
            _buildSummaryCard('Valid', validQuestions.toString(), Colors.green),
            const SizedBox(width: 16),
            _buildSummaryCard('Errors', errors.length.toString(), Colors.red),
          ],
        ),

        const SizedBox(height: 16),

        // Errors
        if (errors.isNotEmpty) ...[
          Text(
            'Validation Errors',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              itemCount: errors.length,
              itemBuilder: (context, index) {
                final error = errors[index] as Map<String, dynamic>;
                return ListTile(
                  dense: true,
                  title: Text(
                    'Row ${error['row']}: ${error['question_text']}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text(
                    (error['errors'] as List).join(', '),
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.red),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Sample questions
        Text('Sample Questions', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.builder(
            itemCount: (_previewData!['sample_questions'] as List).length,
            itemBuilder: (context, index) {
              final question =
                  _previewData!['sample_questions'][index]
                      as Map<String, dynamic>;
              return ListTile(
                dense: true,
                title: Text(
                  question['question_text'],
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${question['question_type']} • ${question['options_count']} options',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        // Action buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _previewData = null;
                    _validationMessage = null;
                  });
                },
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppButton(
                text: 'Start Upload',
                onPressed: validQuestions > 0 && !_isUploading
                    ? _startUpload
                    : null,
                isLoading: _isUploading,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgress() {
    final total = _uploadProgress!['total'] as int;
    final processed = _uploadProgress!['processed'] as int;
    final successful = _uploadProgress!['successful'] as int;
    final failed = _uploadProgress!['failed'] as int;
    final status = _uploadProgress!['status'] as String;

    final progress = total > 0 ? processed / total : 0.0;

    return Column(
      children: [
        Text(
          'Uploading Questions',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),

        // Progress indicator
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${processed}/${total} questions processed',
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: 16),

        // Status cards
        Row(
          children: [
            _buildSummaryCard(
              'Successful',
              successful.toString(),
              Colors.green,
            ),
            const SizedBox(width: 16),
            _buildSummaryCard('Failed', failed.toString(), Colors.red),
          ],
        ),

        const SizedBox(height: 16),

        // Question results
        if (_questionResults.isNotEmpty) ...[
          Text(
            'Question Status',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              itemCount: _questionResults.length,
              itemBuilder: (context, index) {
                final result = _questionResults[index];
                return ListTile(
                  dense: true,
                  leading: Icon(
                    result['status'] == 'success'
                        ? Icons.check_circle
                        : result['status'] == 'failed'
                        ? Icons.error
                        : result['status'] == 'processing'
                        ? Icons.hourglass_top
                        : Icons.schedule,
                    color: result['status'] == 'success'
                        ? Colors.green
                        : result['status'] == 'failed'
                        ? Colors.red
                        : result['status'] == 'processing'
                        ? Colors.blue
                        : Colors.grey,
                    size: 20,
                  ),
                  title: Text(
                    'Row ${result['row']}: ${result['question_text']}',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: result['error'] != null
                      ? Text(
                          result['error'],
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.red),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  trailing:
                      result['status'] == 'failed' && status == 'completed'
                      ? IconButton(
                          icon: const Icon(Icons.refresh, size: 20),
                          onPressed: () => _retryQuestion(result['row']),
                          tooltip: 'Retry this question',
                        )
                      : null,
                );
              },
            ),
          ),
        ],

        const SizedBox(height: 16),

        // Status text
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: status == 'completed'
                ? Colors.green.shade50
                : status == 'failed'
                ? Colors.red.shade50
                : Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                status == 'completed'
                    ? Icons.check_circle
                    : status == 'failed'
                    ? Icons.error
                    : Icons.hourglass_top,
                color: status == 'completed'
                    ? Colors.green
                    : status == 'failed'
                    ? Colors.red
                    : Colors.blue,
              ),
              const SizedBox(width: 8),
              Text(
                status == 'completed'
                    ? 'Upload completed successfully!'
                    : status == 'failed'
                    ? 'Upload failed'
                    : 'Processing questions...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),

        if (status == 'completed') ...[
          const SizedBox(height: 16),
          AppButton(text: 'View Summary', onPressed: _loadSummary),
        ],
      ],
    );
  }

  Widget _buildSummary() {
    final total = _uploadSummary!['total_questions'] as int;
    final successful = _uploadSummary!['successful'] as int;
    final failed = _uploadSummary!['failed'] as int;
    final errors = _uploadSummary!['errors'] as List;
    final processingTime = _uploadSummary!['processing_time_seconds'] as double;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upload Summary', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),

        // Summary cards
        Row(
          children: [
            _buildSummaryCard('Total', total.toString(), Colors.blue),
            const SizedBox(width: 16),
            _buildSummaryCard(
              'Successful',
              successful.toString(),
              Colors.green,
            ),
            const SizedBox(width: 16),
            _buildSummaryCard('Failed', failed.toString(), Colors.red),
          ],
        ),

        const SizedBox(height: 16),

        // Processing time
        Text(
          'Processing Time: ${processingTime.toStringAsFixed(1)} seconds',
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: 16),

        // Errors
        if (errors.isNotEmpty) ...[
          Text(
            'Errors',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              itemCount: errors.length,
              itemBuilder: (context, index) {
                final error = errors[index] as Map<String, dynamic>;
                return ListTile(
                  dense: true,
                  title: Text(
                    'Row ${error['row']}: ${error['question_text']}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text(
                    error['error'],
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.red),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Action buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _copySummaryToClipboard,
                icon: const Icon(Icons.copy),
                label: const Text('Copy Report'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppButton(
                text: 'Done',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'csv'],
      allowMultiple: false,
      withData: true,
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.single;
        _validationMessage = null;
        _previewData = null;
      });
    }
  }

  Future<void> _previewFile() async {
    if (_selectedFile == null) return;

    setState(() {
      _isValidating = true;
    });

    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          _selectedFile!.bytes!,
          filename: _selectedFile!.name,
        ),
        'filename': _selectedFile!.name,
      });

      final response = await ref
          .read(apiClientProvider)
          .post(
            '/questions/bulk-upload/preview',
            data: formData,
            options: Options(contentType: 'multipart/form-data'),
          );

      setState(() {
        _previewData = response.data;
      });
    } catch (e) {
      setState(() {
        _validationMessage = 'Preview failed: $e';
      });
    } finally {
      setState(() {
        _isValidating = false;
      });
    }
  }

  Future<void> _startUpload() async {
    if (_selectedFile == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          _selectedFile!.bytes!,
          filename: _selectedFile!.name,
        ),
        'filename': _selectedFile!.name,
      });

      final response = await ref
          .read(apiClientProvider)
          .post(
            '/questions/bulk-upload',
            data: formData,
            options: Options(contentType: 'multipart/form-data'),
          );

      setState(() {
        _uploadId = response.data['upload_id'];
        _uploadProgress = {
          'total': response.data['total_questions'],
          'processed': 0,
          'successful': 0,
          'failed': 0,
          'status': 'processing',
          'errors': [],
        };
      });

      // Start polling for progress
      _pollProgress();
    } catch (e) {
      setState(() {
        _validationMessage = 'Upload failed: $e';
        _isUploading = false;
      });
    }
  }

  Future<void> _pollProgress() async {
    if (_uploadId == null) return;

    try {
      final response = await ref
          .read(apiClientProvider)
          .get('/questions/bulk-upload/$_uploadId/progress');

      setState(() {
        _uploadProgress = response.data;
        _questionResults = List<Map<String, dynamic>>.from(
          response.data['question_results'] ?? [],
        );
      });

      if (response.data['status'] == 'completed' ||
          response.data['status'] == 'failed') {
        setState(() {
          _isUploading = false;
        });
      } else {
        // Continue polling
        Future.delayed(const Duration(seconds: 2), _pollProgress);
      }
    } catch (e) {
      // Continue polling on error
      Future.delayed(const Duration(seconds: 2), _pollProgress);
    }
  }

  Future<void> _loadSummary() async {
    if (_uploadId == null) return;

    try {
      final response = await ref
          .read(apiClientProvider)
          .get('/questions/bulk-upload/$_uploadId/summary');

      setState(() {
        _uploadSummary = response.data;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _copySummaryToClipboard() async {
    if (_uploadSummary == null) return;

    final summaryText =
        '''
Upload Summary:
Total Questions: ${_uploadSummary!['total_questions']}
Successful: ${_uploadSummary!['successful']}
Failed: ${_uploadSummary!['failed']}
Processing Time: ${_uploadSummary!['processing_time_seconds'].toStringAsFixed(1)} seconds

Errors:
${_uploadSummary!['errors'].map((e) => 'Row ${e['row']}: ${e['error']}').join('\n')}
''';

    await Clipboard.setData(ClipboardData(text: summaryText));

    // Show a snackbar to indicate success
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Summary copied to clipboard')),
      );
    }
  }

  Future<void> _retryQuestion(int rowNumber) async {
    if (_uploadId == null) return;

    try {
      final response = await ref
          .read(apiClientProvider)
          .post('/questions/bulk-upload/$_uploadId/retry', data: [rowNumber]);

      if (response.data['retry_results'] != null) {
        final result = response.data['retry_results'][0];
        if (result['status'] == 'success') {
          // Refresh progress
          _pollProgress();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Question at row $rowNumber retried successfully',
                ),
              ),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Failed to retry row $rowNumber: ${result['error']}',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to retry question: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _downloadTemplate() async {
    try {
      // Load the template CSV from assets
      final templateContent = await rootBundle.loadString(
        'assets/templates/bulk_upload_template.csv',
      );

      // Copy to clipboard
      await Clipboard.setData(ClipboardData(text: templateContent));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Template copied to clipboard! Paste into Excel or save as .csv file',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to load template: $e')));
      }
    }
  }
}
