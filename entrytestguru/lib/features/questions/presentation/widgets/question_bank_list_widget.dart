import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/question.dart';
import '../../data/models/question_filter.dart';
import '../../../../core/utils/time_utils.dart';
import '../providers/present_question_provider.dart';
import '../providers/add_question_provider.dart';
import 'add_question_widget.dart';
import 'bulk_upload_widget.dart';
import 'bulk_upload_widget.dart';
import 'question_filters_widget.dart';

class QuestionBankListWidget extends ConsumerStatefulWidget {
  const QuestionBankListWidget({super.key});

  @override
  ConsumerState<QuestionBankListWidget> createState() =>
      _QuestionBankListWidgetState();
}

class _QuestionBankListWidgetState
    extends ConsumerState<QuestionBankListWidget> {
  @override
  void initState() {
    super.initState();
    // Load questions when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(presentQuestionNotifierProvider.notifier)
          .loadQuestions(const QuestionFilter());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(presentQuestionNotifierProvider);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.errorMessage!,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(presentQuestionNotifierProvider.notifier)
                    .loadQuestions(const QuestionFilter());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final questions = state.questionQueue;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          // Add buttons at the top - always show these
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showAddQuestionDialog(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Question'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showBulkUploadDialog(context),
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Bulk Upload'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Theme.of(
                        context,
                      ).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Quick Filters
          const QuestionFiltersWidget(),

          // Questions list or empty state
          if (questions.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.question_answer_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No questions available',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start by adding your first question or uploading a bulk file',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final question = questions[index];
                        return _buildQuestionTile(question);
                      },
                    ),
                  ),
                  // Load More button
                  if (state.hasMore && !state.isLoadingMore)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(presentQuestionNotifierProvider.notifier)
                              .loadQuestions(
                                state.currentFilter ?? const QuestionFilter(),
                                loadMore: true,
                              );
                        },
                        child: const Text('Load More'),
                      ),
                    ),
                  // Loading indicator for load more
                  if (state.isLoadingMore)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuestionTile(Question question) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(4, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        child: InkWell(
          onTap: () => _showEditQuestionDialog(context, question),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header row with ID and time
                Row(
                  children: [
                    Text(
                      'ID: ${question.questionId}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          TimeUtils.timeAgo(question.createdAt),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          question.createdByName ?? 'Unknown User',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Question text
                Text(
                  question.questionText,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                // const SizedBox(height: 8),

                // Status and type row
                Row(
                  children: [
                    // Status
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(question.approvalStatus),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        question.approvalStatus,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Question type
                    Text(
                      question.questionTypeDisplay,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Options preview
                Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: question.options.asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    return Chip(
                      label: Text(
                        '${String.fromCharCode(65 + index)}. ${option.text}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.surfaceVariant,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'draft':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  void _showAddQuestionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 800,
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dialog Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Add Question',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(dialogContext).pop(),
                      ),
                    ],
                  ),
                ),
                // Dialog Content
                Flexible(
                  child: SingleChildScrollView(
                    child: AddQuestionWidget(showScaffold: false),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      // Refresh the list after dialog closes
      ref
          .read(presentQuestionNotifierProvider.notifier)
          .loadQuestions(const QuestionFilter());
      // Reset the add question form
      ref.read(addQuestionNotifierProvider.notifier).reset();
    });
  }

  void _showEditQuestionDialog(BuildContext context, Question question) {
    // Load question into the add question provider for editing
    ref
        .read(addQuestionNotifierProvider.notifier)
        .loadQuestionForEditing(question);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 800,
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dialog Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Edit Question',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(dialogContext).pop(),
                      ),
                    ],
                  ),
                ),
                // Dialog Content
                Flexible(
                  child: SingleChildScrollView(
                    child: AddQuestionWidget(showScaffold: false),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      // Refresh the list after dialog closes
      ref
          .read(presentQuestionNotifierProvider.notifier)
          .loadQuestions(const QuestionFilter());
      // Reset the add question form
      ref.read(addQuestionNotifierProvider.notifier).reset();
    });
  }

  void _showBulkUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800, maxHeight: 600),
          child: const BulkUploadWidget(),
        ),
      ),
    ).then((_) {
      // Refresh the list after dialog closes
      ref
          .read(presentQuestionNotifierProvider.notifier)
          .loadQuestions(const QuestionFilter());
    });
  }
}
