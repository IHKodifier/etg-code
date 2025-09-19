# Question Bank Management Feature

A comprehensive Flutter feature for managing a question bank with the ability to add questions and present them for practice.

## Overview

This feature provides two main components:

1. **AddQuestionWidget** - A form-based widget for creating new questions
2. **PresentQuestionWidget** - An interactive widget for displaying and answering questions

## Architecture

### State Management
- Uses Riverpod for state management
- Freezed for immutable state classes
- Separate providers for add and present question functionality

### Project Structure
```
lib/features/questions/
├── data/
│   ├── models/          # Data models (Question, QuestionOption, etc.)
│   └── services/        # API services (QuestionApiService)
├── domain/
│   └── repositories/    # Repository interfaces
└── presentation/
    ├── states/          # State classes (AddQuestionState, PresentQuestionState)
    ├── providers/       # Riverpod providers and notifiers
    ├── widgets/         # UI widgets (AddQuestionWidget, PresentQuestionWidget)
    └── screens/         # Screen components (QuestionBankScreen)
```

## Features

### AddQuestionWidget
- **Form Validation**: Comprehensive validation for all required fields
- **Dynamic Options**: Add/remove options dynamically (minimum 2, maximum 6)
- **Question Types**: Support for single-choice and multiple-choice questions
- **Metadata**: Exam category, subject, topic, difficulty, estimated time
- **Tags**: Add custom tags for better organization
- **Real-time Validation**: Immediate feedback on form errors

### PresentQuestionWidget
- **Interactive Options**: Click to select answers
- **Progress Tracking**: Visual progress indicator
- **Answer Feedback**: Immediate feedback with explanations
- **Navigation**: Previous/Next question navigation
- **Attempt Recording**: Automatic recording of user attempts
- **Score Display**: Real-time scoring and feedback

## Usage

### Basic Setup

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/questions/presentation/screens/question_bank_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: QuestionBankScreen(),
      ),
    ),
  );
}
```

### Using Individual Widgets

#### Add Question Widget
```dart
import 'features/questions/presentation/widgets/add_question_widget.dart';

const AddQuestionWidget()
```

#### Present Question Widget
```dart
import 'features/questions/presentation/widgets/present_question_widget.dart';
import 'features/questions/data/models/question_filter.dart';

// With custom filter
PresentQuestionWidget(
  initialFilter: QuestionFilter(
    examCategories: ['ECAT'],
    subjects: ['Physics'],
    difficulties: [DifficultyLevel.medium],
  ),
)

// Without filter (shows all questions)
const PresentQuestionWidget()
```

## State Management

### AddQuestionState
Manages the state of question creation:

```dart
@freezed
class AddQuestionState with _$AddQuestionState {
  const factory AddQuestionState({
    @Default('') String questionText,
    @Default([]) List<QuestionOption> options,
    @Default([]) List<String> correctAnswers,
    @Default(QuestionType.singleChoice) QuestionType questionType,
    // ... other fields
  }) = _AddQuestionState;
}
```

### PresentQuestionState
Manages the state of question presentation:

```dart
@freezed
class PresentQuestionState with _$PresentQuestionState {
  const factory PresentQuestionState({
    Question? currentQuestion,
    @Default([]) List<String> selectedAnswers,
    @Default(false) bool showExplanation,
    @Default(false) bool isAnswered,
    @Default(false) bool isCorrect,
    // ... other fields
  }) = _PresentQuestionState;
}
```

## API Integration

The feature integrates with `QuestionApiService` for:

- **Question Creation**: `createQuestion(question)`
- **Question Retrieval**: `getFilteredQuestions(filter)`
- **Attempt Recording**: `recordAttempt(attempt)`
- **Statistics**: `getQuestionStats(questionId)`

## Error Handling

- **Network Errors**: Graceful handling of API failures
- **Validation Errors**: Real-time form validation feedback
- **Offline Support**: Basic offline functionality (can be extended)
- **Loading States**: Proper loading indicators throughout

## Testing

### Unit Tests
- Model validation tests
- State management tests
- Provider tests
- Widget tests with Mockito mocks

### Integration Tests
- Complete question creation workflow
- Question presentation workflow
- API integration tests

### Running Tests
```bash
# Run all question-related tests
flutter test test/features/questions/

# Run specific test files
flutter test test/features/questions/data/models/question_test.dart
flutter test test/features/questions/presentation/widgets/add_question_widget_test.dart
```

## Configuration

### Firebase Setup
The feature uses Firebase for data persistence. Configure Firebase:

1. Create a Firebase project
2. Add Android/iOS apps to Firebase
3. Run `flutterfire configure`
4. Update `firebase_options.dart` with your configuration

### API Configuration
Update the API service provider in your app:

```dart
final questionApiServiceProvider = Provider<QuestionApiService>((ref) {
  return QuestionApiService(
    // Your API client implementation
  );
});
```

## Customization

### Styling
The widgets use Material Design components and can be customized through:

- Theme customization
- Custom widget parameters
- Style overrides

### Validation Rules
Validation rules can be customized in the state classes:

- Minimum/maximum options
- Required fields
- Custom validation logic

### Question Types
Additional question types can be added by:

1. Extending `QuestionType` enum
2. Updating state management logic
3. Modifying UI components

## Future Enhancements

- **Offline Mode**: Enhanced offline question storage
- **Question Import/Export**: CSV/JSON import functionality
- **Advanced Filtering**: More sophisticated filtering options
- **Analytics Dashboard**: Detailed performance analytics
- **Collaborative Features**: Multi-user question management
- **Rich Text Editor**: Enhanced question text formatting

## Dependencies

- `flutter_riverpod`: State management
- `freezed`: Immutable state classes
- `dio`: HTTP client for API calls
- `firebase_core`: Firebase integration
- `mockito`: Testing utilities

## Contributing

1. Follow the existing code structure
2. Add comprehensive tests for new features
3. Update documentation
4. Ensure compatibility with existing models

## License

This feature is part of the EntryTestGuru application.