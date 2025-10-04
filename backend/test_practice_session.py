#!/usr/bin/env python3
"""
Test script for practice session functionality
"""
import asyncio
import json
import aiohttp

async def test_practice_session():
    """Test practice session creation and retrieval"""
    base_url = "http://localhost:8081/api/v1"

    # Test data
    session_data = {
        "filter_criteria": {
            "exam_type": "ECAT",
            "question_count": 10
        },
        "settings": {
            "show_explanations": True,
            "randomize_order": True
        }
    }

    async with aiohttp.ClientSession() as session:
        try:
            # Create practice session
            print("Creating practice session...")
            async with session.post(
                f"{base_url}/practice/session",
                json=session_data,
                headers={"Content-Type": "application/json"}
            ) as response:
                if response.status == 200:
                    response_data = await response.json()
                    session_id = response_data['id']
                    print(f"Session created: {session_id}")
                else:
                    print(f"Failed to create session: {response.status}")
                    return

            # Get practice session
            print("Retrieving practice session...")
            async with session.get(f"{base_url}/practice/session/{session_id}") as response:
                if response.status == 200:
                    session_data = await response.json()
                    print(f"Session retrieved: {json.dumps(session_data, indent=2)}")
                else:
                    print(f"Failed to get session: {response.status}")
                    error_text = await response.text()
                    print(f"Error: {error_text}")

        except Exception as e:
            print(f"Error: {e}")

if __name__ == "__main__":
    asyncio.run(test_practice_session())