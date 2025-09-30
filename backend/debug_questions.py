#!/usr/bin/env python3
"""
Debug script to check questions data in Firestore
"""
import asyncio
import sys
import os
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from app.core.database import db

async def debug_questions():
    """Debug questions collection"""
    try:
        print("Checking questions collection...")

        # Get all questions
        questions = await db.query_collection("questions", limit=50)

        print(f"Found {len(questions)} questions")

        for i, q in enumerate(questions[:10]):  # Show first 10
            print(f"\n--- Question {i+1} ---")
            print(f"ID: {q.get('id', 'N/A')}")
            print(f"Question ID: {q.get('question_id', 'N/A')} (type: {type(q.get('question_id'))})")
            print(f"Question Text: {q.get('question_text', 'N/A')[:100]}...")
            print(f"Subject: {q.get('subject', 'N/A')}")
            print(f"Topic: {q.get('topic', 'N/A')}")
            print(f"Difficulty: {q.get('difficulty', 'N/A')}")
            print(f"Tags: {q.get('tags', [])}")
            print(f"Is Active: {q.get('is_active', 'N/A')}")

        # Test search functionality
        print("\nTesting search for '19'...")
        search_query = "19"
        query_lower = search_query.lower()

        matching_questions = []
        for q in questions:
            if (query_lower in q.get("question_text", "").lower() or
                query_lower in q.get("subject", "").lower() or
                query_lower in q.get("topic", "").lower() or
                any(query_lower in tag for tag in q.get("tags", []))):
                matching_questions.append(q)

        print(f"Found {len(matching_questions)} questions matching '{search_query}'")
        for q in matching_questions[:3]:  # Show first 3 matches
            print(f"  - ID: {q.get('id')}, Text: {q.get('question_text', '')[:50]}...")

    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    asyncio.run(debug_questions())