#!/usr/bin/env python3
"""
Script to fix question exam_type
"""
import asyncio
from app.core.database import db

async def fix_question():
    try:
        # Get the approved question
        approved_questions = await db.query_collection('questions', filters=[
            {"field": "approval_status", "operator": "==", "value": "approved"}
        ], limit=1)

        if not approved_questions:
            print("No approved questions found")
            return

        question = approved_questions[0]
        question_id = question['id']

        print(f"Fixing question {question_id}")
        print(f"Current exam_type: {question.get('exam_type')}")

        # Update the question with correct exam_type and required fields
        update_data = {
            "exam_type": "ECAT",
            "is_active": True,
            "subject": "General Knowledge",
            "topic": "Geography",
            "difficulty": "Easy",
            "question_type": "multiple_choice",
            "options": ["Islamabad", "Karachi", "Lahore", "Peshawar"],
            "correct_answer": ["Islamabad"]
        }

        await db.update_document('questions', question_id, update_data)
        print(f"Updated question {question_id} with exam_type: ECAT")

        # Verify the update
        updated_question = await db.get_document('questions', question_id)
        print(f"Verified exam_type: {updated_question.get('exam_type')}")

    except Exception as e:
        print(f'Error: {e}')

if __name__ == '__main__':
    asyncio.run(fix_question())