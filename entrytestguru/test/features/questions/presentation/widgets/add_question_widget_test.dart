import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:entrytestguru/features/questions/presentation/widgets/add_question_widget.dart';
import 'package:entrytestguru/features/questions/data/services/question_api_service.dart';

@GenerateMocks([QuestionApiService])
import 'add_question_widget_test.mocks.dart';

void main() {
  late MockQuestionApiService mockApiService;

  setUp(() {
    mockApiService = MockQuestionApiService();
  });

  testWidgets('AddQuestionWidget renders correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the API service provider with mock
          // Note: In a real implementation, you'd need to set up the provider properly
        ],
        child: const MaterialApp(home: AddQuestionWidget()),
      ),
    );

    // Verify that the widget renders without errors
    expect(find.text('Add Question'), findsOneWidget);
    expect(find.text('Question Text *'), findsOneWidget);
    expect(find.text('Question Type'), findsOneWidget);
    expect(find.text('Options'), findsOneWidget);
    expect(find.text('Metadata'), findsOneWidget);
    expect(find.text('Add Question'), findsOneWidget);
  });

  testWidgets('AddQuestionWidget shows form validation errors', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the API service provider with mock
        ],
        child: const MaterialApp(home: AddQuestionWidget()),
      ),
    );

    // Try to submit without filling required fields
    await tester.tap(find.text('Add Question'));
    await tester.pump();

    // Verify that validation errors are shown
    expect(find.text('Question text is required'), findsOneWidget);
    expect(find.text('Exam category is required'), findsOneWidget);
    expect(find.text('Subject is required'), findsOneWidget);
    expect(find.text('Topic is required'), findsOneWidget);
  });

  testWidgets('AddQuestionWidget allows adding options', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the API service provider with mock
        ],
        child: const MaterialApp(home: AddQuestionWidget()),
      ),
    );

    // Initially should have 2 options (A and B)
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);

    // Add a new option
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Should now have 3 options (A, B, C)
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
  });

  testWidgets('AddQuestionWidget allows removing options', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the API service provider with mock
        ],
        child: const MaterialApp(home: AddQuestionWidget()),
      ),
    );

    // Initially should have 2 options
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);

    // Add a third option first
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Should have 3 options now
    expect(find.text('C'), findsOneWidget);

    // Try to remove an option (should work since we have more than 2)
    await tester.tap(find.byIcon(Icons.remove).first);
    await tester.pump();

    // Should be back to 2 options
    expect(find.text('C'), findsNothing);
  });
}
