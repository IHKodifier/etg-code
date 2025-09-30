#!/usr/bin/env python3
"""
Test script to verify correct answer mapping logic against CSV data
"""
import pandas as pd
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def test_correct_answer_logic():
    """Test the correct answer mapping logic"""

    # Read the CSV file
    df = pd.read_csv('test_correct_answers.csv')

    correct_predictions = 0
    wrong_predictions = 0
    results = []

    for index, row in df.iterrows():
        question_id = int(row['questionId'])
        correct_answers_csv = str(row['correctAnswers']).strip()

        # Build options map (same logic as bulk upload service)
        option_map = {
            'A': row.get('optionA'),
            'B': row.get('optionB'),
            'C': row.get('optionC'),
            'D': row.get('optionD'),
            'E': row.get('optionE'),
            'F': row.get('optionF'),
        }

        # Parse correct answers (same logic as bulk upload service)
        correct_ids = [ans.strip() for ans in correct_answers_csv.split(',')]

        # Determine which options should be correct
        expected_correct_options = []
        for option_id, option_text in option_map.items():
            if pd.notna(option_text) and option_text.strip():
                is_correct = option_id in correct_ids
                if is_correct:
                    expected_correct_options.append(option_id)

        # Check if our logic matches the CSV
        expected_correct = set(correct_ids)
        actual_correct = set(expected_correct_options)

        is_correct = expected_correct == actual_correct

        if is_correct:
            correct_predictions += 1
            status = "CORRECT"
        else:
            wrong_predictions += 1
            status = "WRONG"

        result = {
            'question_id': question_id,
            'csv_correct': correct_answers_csv,
            'expected_ids': sorted(list(expected_correct)),
            'actual_ids': sorted(list(actual_correct)),
            'status': status,
            'options': {k: v for k, v in option_map.items() if pd.notna(v)}
        }

        results.append(result)

        print(f"Question {question_id}: {status}")
        print(f"  CSV correct_answers: '{correct_answers_csv}'")
        print(f"  Expected correct IDs: {result['expected_ids']}")
        print(f"  Actual correct IDs: {result['actual_ids']}")
        if not is_correct:
            print(f"  Options: {result['options']}")
        print()

    # Summary
    total_questions = len(results)
    accuracy = (correct_predictions / total_questions) * 100 if total_questions > 0 else 0

    print("=" * 50)
    print("SUMMARY")
    print("=" * 50)
    print(f"Total questions tested: {total_questions}")
    print(f"Correct predictions: {correct_predictions}")
    print(f"Wrong predictions: {wrong_predictions}")
    print(".1f")

    if wrong_predictions > 0:
        print("\nWrong predictions:")
        for result in results:
            if result['status'] == "✗ WRONG":
                print(f"  Question {result['question_id']}: expected {result['expected_ids']}, got {result['actual_ids']}")

    return {
        'total': total_questions,
        'correct': correct_predictions,
        'wrong': wrong_predictions,
        'accuracy': accuracy,
        'results': results
    }

if __name__ == "__main__":
    test_correct_answer_logic()