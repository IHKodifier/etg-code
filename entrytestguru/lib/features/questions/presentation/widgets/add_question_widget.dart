import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/question_enums.dart';
import '../../data/models/question_option.dart';
import '../states/add_question_state.dart';
import '../providers/add_question_provider.dart';

class AddQuestionWidget extends ConsumerStatefulWidget {
  const AddQuestionWidget({super.key});

  @override
  ConsumerState<AddQuestionWidget> createState() => _AddQuestionWidgetState();
}

class _AddQuestionWidgetState extends ConsumerState<AddQuestionWidget> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _explanationController = TextEditingController();
  final _tagController = TextEditingController();
  final List<TextEditingController> _optionControllers = [];
  final List<TextEditingController> _optionImageControllers = [];
  final List<TextEditingController> _optionLatexControllers = [];
  final List<TextEditingController> _questionImageUrlControllers = [];
  final List<TextEditingController> _questionLatexControllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize with at least 2 options
    _addOptionController();
    _addOptionController();
  }

  @override
  void dispose() {
    _questionController.dispose();
    _explanationController.dispose();
    _tagController.dispose();
    for (final controller in _optionControllers) {
      controller.dispose();
    }
    for (final controller in _optionImageControllers) {
      controller.dispose();
    }
    for (final controller in _optionLatexControllers) {
      controller.dispose();
    }
    for (final controller in _questionImageUrlControllers) {
      controller.dispose();
    }
    for (final controller in _questionLatexControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addOptionController() {
    _optionControllers.add(TextEditingController());
    _optionImageControllers.add(TextEditingController());
    _optionLatexControllers.add(TextEditingController());
  }

  void _removeOptionController(int index) {
    _optionControllers[index].dispose();
    _optionImageControllers[index].dispose();
    _optionLatexControllers[index].dispose();
    _optionControllers.removeAt(index);
    _optionImageControllers.removeAt(index);
    _optionLatexControllers.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addQuestionNotifierProvider);
    final notifier = ref.read(addQuestionNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Question'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => notifier.reset(),
            tooltip: 'Reset Form',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Text
              _buildQuestionTextField(state, notifier),

              const SizedBox(height: 24),

              // Multiple Question Image URLs
              _buildQuestionImageUrlsSection(state, notifier),

              const SizedBox(height: 24),

              // Multiple Question LaTeX Expressions
              _buildQuestionLatexSection(state, notifier),

              const SizedBox(height: 24),

              // Question Type
              _buildQuestionTypeSelector(state, notifier),

              const SizedBox(height: 24),

              // Options
              _buildOptionsSection(state, notifier),

              const SizedBox(height: 24),

              // Metadata
              _buildMetadataSection(state, notifier),

              const SizedBox(height: 24),

              // Explanation
              _buildExplanationField(state, notifier),

              const SizedBox(height: 24),

              // Tags
              _buildTagsSection(state, notifier),

              const SizedBox(height: 32),

              // Submit Button
              _buildSubmitButton(state, notifier),

              // Error Message
              if (state.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    state.errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),

              // Success Message
              if (state.isSuccess)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Question added successfully!',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionTextField(
    AddQuestionState state,
    AddQuestionNotifier notifier,
  ) {
    return TextFormField(
      controller: _questionController,
      decoration: const InputDecoration(
        labelText: 'Question Text *',
        hintText: 'Enter your question here...',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Question text is required';
        }
        return null;
      },
      onChanged: notifier.updateQuestionText,
    );
  }

  Widget _buildQuestionImageUrlsSection(
    AddQuestionState state,
    AddQuestionNotifier notifier,
  ) {
    final imageUrls = state.questionImageUrls ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Additional Question Images (Optional)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  final controller = TextEditingController();
                  _questionImageUrlControllers.add(controller);
                  notifier.addQuestionImageUrl('');
                });
              },
              tooltip: 'Add Image',
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Display existing image URLs
        ...List.generate(imageUrls.length, (index) {
          // Ensure we have enough controllers
          while (_questionImageUrlControllers.length <= index) {
            _questionImageUrlControllers.add(TextEditingController());
          }

          final controller = _questionImageUrlControllers[index];
          // Only set text if it's different to avoid cursor jumping
          if (controller.text != imageUrls[index]) {
            controller.text = imageUrls[index];
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Image URL ${index + 1}',
                      hintText: 'https://example.com/image${index + 1}.jpg',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.image),
                    ),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final uri = Uri.tryParse(value);
                        if (uri == null || !uri.hasScheme) {
                          return 'Please enter a valid URL';
                        }
                      }
                      return null;
                    },
                    onChanged: (value) =>
                        notifier.updateQuestionImageUrlAt(index, value),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      notifier.removeQuestionImageUrl(imageUrls[index]);
                      _questionImageUrlControllers[index].dispose();
                      _questionImageUrlControllers.removeAt(index);
                    });
                  },
                  tooltip: 'Remove Image',
                ),
              ],
            ),
          );
        }),

        if (imageUrls.isEmpty)
          const Text(
            'No additional images added yet. Click + to add images.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
      ],
    );
  }

  Widget _buildQuestionLatexSection(
    AddQuestionState state,
    AddQuestionNotifier notifier,
  ) {
    final latexExpressions = state.questionLatex ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Question LaTeX Expressions (Optional)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  final controller = TextEditingController();
                  _questionLatexControllers.add(controller);
                  notifier.addQuestionLatex('');
                });
              },
              tooltip: 'Add LaTeX Expression',
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Display existing LaTeX expressions
        ...List.generate(latexExpressions.length, (index) {
          // Ensure we have enough controllers
          while (_questionLatexControllers.length <= index) {
            _questionLatexControllers.add(TextEditingController());
          }

          final controller = _questionLatexControllers[index];
          // Only set text if it's different to avoid cursor jumping
          if (controller.text != latexExpressions[index]) {
            controller.text = latexExpressions[index];
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'LaTeX Expression ${index + 1}',
                      hintText: r'\frac{a}{b} = c',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.functions),
                    ),
                    maxLines: 2,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        // Basic LaTeX validation - check for common LaTeX patterns
                        if (!value.contains(r'\') &&
                            !value.contains('^') &&
                            !value.contains('_')) {
                          return 'Please enter a valid LaTeX expression';
                        }
                      }
                      return null;
                    },
                    onChanged: (value) =>
                        notifier.updateQuestionLatexAt(index, value),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      notifier.removeQuestionLatex(latexExpressions[index]);
                      _questionLatexControllers[index].dispose();
                      _questionLatexControllers.removeAt(index);
                    });
                  },
                  tooltip: 'Remove LaTeX Expression',
                ),
              ],
            ),
          );
        }),

        if (latexExpressions.isEmpty)
          const Text(
            'No LaTeX expressions added yet. Click + to add mathematical expressions.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
      ],
    );
  }

  Widget _buildQuestionTypeSelector(
    AddQuestionState state,
    AddQuestionNotifier notifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Question Type',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SegmentedButton<QuestionType>(
          segments: const [
            ButtonSegment(
              value: QuestionType.singleChoice,
              label: Text('Single Choice'),
            ),
            ButtonSegment(
              value: QuestionType.multipleChoice,
              label: Text('Multiple Choice'),
            ),
          ],
          selected: {state.questionType},
          onSelectionChanged: (selected) {
            if (selected.isNotEmpty) {
              notifier.updateQuestionType(selected.first);
            }
          },
        ),
      ],
    );
  }

  Widget _buildOptionsSection(
    AddQuestionState state,
    AddQuestionNotifier notifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Options',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (state.options.length < 6)
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  notifier.addOption();
                  _addOptionController();
                },
                tooltip: 'Add Option',
              ),
          ],
        ),
        const SizedBox(height: 8),
        ...List.generate(state.options.length, (index) {
          return _buildOptionField(index, state, notifier);
        }),
        if (!state.hasValidOptions)
          const Text(
            'At least 2 options are required',
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
      ],
    );
  }

  Widget _buildOptionField(
    int index,
    AddQuestionState state,
    AddQuestionNotifier notifier,
  ) {
    final option = state.options[index];
    final isCorrect = state.correctAnswers.contains(option.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Option Header
            Row(
              children: [
                // Option Label
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCorrect ? Colors.green : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      option.id,
                      style: TextStyle(
                        color: isCorrect ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Correct Answer Checkbox
                const Text('Correct Answer'),
                Checkbox(
                  value: isCorrect,
                  onChanged: (_) => notifier.toggleCorrectAnswer(option.id),
                ),

                const Spacer(),

                // Remove Button (only if more than 2 options)
                if (state.options.length > 2)
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      notifier.removeOption(index);
                      _removeOptionController(index);
                    },
                    tooltip: 'Remove Option',
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Option Text Field
            TextFormField(
              controller: _optionControllers[index],
              decoration: InputDecoration(
                labelText: 'Option ${option.id} Text *',
                hintText: 'Enter option text...',
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Option text is required';
                }
                return null;
              },
              onChanged: (value) => notifier.updateOptionText(index, value),
            ),

            const SizedBox(height: 12),

            // Option Image URL Field
            TextFormField(
              controller: _optionImageControllers[index],
              decoration: InputDecoration(
                labelText: 'Option ${option.id} Image URL (Optional)',
                hintText: 'https://example.com/option-image.jpg',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.image),
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final uri = Uri.tryParse(value);
                  if (uri == null || !uri.hasScheme) {
                    return 'Please enter a valid URL';
                  }
                }
                return null;
              },
              onChanged: (value) => notifier.updateOptionImageUrl(
                index,
                value.isEmpty ? null : value,
              ),
            ),

            const SizedBox(height: 12),

            // Option LaTeX Field
            TextFormField(
              controller: _optionLatexControllers[index],
              decoration: InputDecoration(
                labelText: 'Option ${option.id} LaTeX (Optional)',
                hintText: r'x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.functions),
              ),
              maxLines: 2,
              onChanged: (value) => notifier.updateOptionLatex(
                index,
                value.isEmpty ? null : value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadataSection(
    AddQuestionState state,
    AddQuestionNotifier notifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Metadata', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),

        // Exam Category and Subject
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Exam Category *',
                  border: OutlineInputBorder(),
                ),
                items: ['ECAT', 'MCAT', 'MDCAT', 'Other']
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) notifier.updateExamCategory(value);
                },
                validator: (value) {
                  if (value?.isEmpty ?? true)
                    return 'Exam category is required';
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Subject *',
                  hintText: 'e.g., Physics, Chemistry',
                  border: OutlineInputBorder(),
                ),
                onChanged: notifier.updateSubject,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Subject is required';
                  return null;
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Topic and Difficulty
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Topic *',
                  hintText: 'e.g., Kinematics, Organic Chemistry',
                  border: OutlineInputBorder(),
                ),
                onChanged: notifier.updateTopic,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Topic is required';
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<DifficultyLevel>(
                decoration: const InputDecoration(
                  labelText: 'Difficulty',
                  border: OutlineInputBorder(),
                ),
                value: state.difficulty,
                items: DifficultyLevel.values.map((level) {
                  return DropdownMenuItem(
                    value: level,
                    child: Text(level.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) notifier.updateDifficulty(value);
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Estimated Time
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Estimated Time (seconds)',
            hintText: 'e.g., 60',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          initialValue: state.estimatedTimeSeconds.toString(),
          onChanged: (value) {
            final seconds = int.tryParse(value) ?? 60;
            notifier.updateEstimatedTime(seconds);
          },
        ),
      ],
    );
  }

  Widget _buildExplanationField(
    AddQuestionState state,
    AddQuestionNotifier notifier,
  ) {
    return TextFormField(
      controller: _explanationController,
      decoration: const InputDecoration(
        labelText: 'Explanation',
        hintText: 'Provide explanation for the correct answer...',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      onChanged: notifier.updateExplanationText,
    );
  }

  Widget _buildTagsSection(
    AddQuestionState state,
    AddQuestionNotifier notifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tags', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Current Tags
        if (state.tags.isNotEmpty)
          Wrap(
            spacing: 8,
            children: state.tags.map((tag) {
              return Chip(
                label: Text(tag),
                onDeleted: () => notifier.removeTag(tag),
              );
            }).toList(),
          ),

        // Add Tag Field
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _tagController,
                decoration: const InputDecoration(
                  hintText: 'Add a tag...',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    notifier.addTag(value);
                    _tagController.clear();
                  }
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                final value = _tagController.text.trim();
                if (value.isNotEmpty) {
                  notifier.addTag(value);
                  _tagController.clear();
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubmitButton(
    AddQuestionState state,
    AddQuestionNotifier notifier,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: state.isLoading || !state.isValid
            ? null
            : () async {
                if (_formKey.currentState?.validate() ?? false) {
                  await notifier.submitQuestion();
                }
              },
        child: state.isLoading
            ? const CircularProgressIndicator()
            : const Text('Add Question'),
      ),
    );
  }
}
