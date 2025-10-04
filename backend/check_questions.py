#!/usr/bin/env python3
"""
Script to check questions in the database
"""
import asyncio
from app.core.database import db

async def check_questions():
    try:
        # Get all questions
        all_questions = await db.query_collection('questions', limit=10)
        print(f'Total questions in database: {len(all_questions)}')

        for i, q in enumerate(all_questions):
            print(f'Question {i+1}:')
            print(f'  ID: {q.get("id")}')
            print(f'  exam_type: {q.get("exam_type")}')
            print(f'  approval_status: {q.get("approval_status")}')
            print(f'  is_active: {q.get("is_active")}')
            print(f'  question_text: {q.get("question_text", "")[:50]}...')
            print()

        # Check approved questions specifically
        approved_questions = await db.query_collection('questions', filters=[
            {"field": "approval_status", "operator": "==", "value": "approved"}
        ], limit=10)
        print(f'Approved questions: {len(approved_questions)}')

        # Check ECAT questions
        ecat_questions = await db.query_collection('questions', filters=[
            {"field": "exam_type", "operator": "==", "value": "ECAT"}
        ], limit=10)
        print(f'ECAT questions: {len(ecat_questions)}')

    except Exception as e:
        print(f'Error: {e}')

if __name__ == '__main__':
    asyncio.run(check_questions())