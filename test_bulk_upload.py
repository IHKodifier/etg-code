import asyncio
from backend.app.services.bulk_upload_service import bulk_upload_service

async def test_parse():
    with open('test_question.csv', 'rb') as f:
        file_content = f.read()

    questions = await bulk_upload_service.parse_file(file_content, 'test_question.csv')
    print(f"Parsed {len(questions)} questions")
    for q in questions:
        print(f"Question: {q.question_text[:50]}...")
        print(f"Correct answers: {q.correct_answers}")
        print(f"Options: A={q.option_a}, B={q.option_b}, C={q.option_c}, D={q.option_d}")
        print("---")

if __name__ == "__main__":
    asyncio.run(test_parse())