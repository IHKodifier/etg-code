import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'features/questions/data/models/question_test.dart' as question_tests;
import 'features/questions/data/models/question_option_test.dart'
    as question_option_tests;
import 'features/questions/data/models/question_attempt_test.dart'
    as question_attempt_tests;
import 'features/questions/data/models/question_filter_test.dart'
    as question_filter_tests;

void main() {
  group('All Question Model Tests', () {
    // Run question model tests
    question_tests.main();

    // Run question option tests
    question_option_tests.main();

    // Run question attempt tests
    question_attempt_tests.main();

    // Run question filter tests
    question_filter_tests.main();
  });
}
