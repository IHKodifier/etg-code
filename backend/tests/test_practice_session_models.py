import pytest
from datetime import datetime, timedelta
from app.models.practice_session import (
    PracticeSession,
    PracticeSessionFilter,
    PracticeSessionSettings,
    PracticeSessionCreateRequest,
    PracticeSessionResponse,
    PracticeSessionSummary,
    PracticeSessionStatistics,
    PracticeSessionAttempt,
    create_practice_session,
    create_session_attempt,
)


class TestPracticeSessionFilter:
    """Test PracticeSessionFilter model"""

    def test_valid_filter_creation(self):
        """Test creating a valid filter"""
        filter_data = {
            "exam_type": "ECAT",
            "subject": "Mathematics",
            "topic": "Calculus",
            "difficulty": "Medium",
            "arde_probability": "medium",
            "question_count": 25
        }
        filter_obj = PracticeSessionFilter(**filter_data)
        assert filter_obj.exam_type == "ECAT"
        assert filter_obj.subject == "Mathematics"
        assert filter_obj.topic == "Calculus"
        assert filter_obj.difficulty == "Medium"
        assert filter_obj.arde_probability == "medium"
        assert filter_obj.question_count == 25

    def test_invalid_exam_type(self):
        """Test invalid exam type validation"""
        with pytest.raises(ValueError, match="Exam type must be one of"):
            PracticeSessionFilter(exam_type="INVALID", question_count=10)

    def test_invalid_difficulty(self):
        """Test invalid difficulty validation"""
        with pytest.raises(ValueError, match="Difficulty must be one of"):
            PracticeSessionFilter(exam_type="ECAT", difficulty="INVALID", question_count=10)

    def test_invalid_question_count(self):
        """Test invalid question count validation"""
        with pytest.raises(ValueError, match="Question count must be between"):
            PracticeSessionFilter(exam_type="ECAT", question_count=150)

    @pytest.mark.parametrize("exam_type", ["ECAT", "MCAT", "CCAT", "GMAT", "GRE", "SAT"])
    def test_valid_exam_types(self, exam_type):
        """Test all valid exam types"""
        filter_obj = PracticeSessionFilter(exam_type=exam_type, question_count=10)
        assert filter_obj.exam_type == exam_type

    @pytest.mark.parametrize("difficulty", ["Easy", "Medium", "Hard"])
    def test_valid_difficulties(self, difficulty):
        """Test all valid difficulty levels"""
        filter_obj = PracticeSessionFilter(exam_type="ECAT", difficulty=difficulty, question_count=10)
        assert filter_obj.difficulty == difficulty


class TestPracticeSessionSettings:
    """Test PracticeSessionSettings model"""

    def test_default_settings(self):
        """Test default settings creation"""
        settings = PracticeSessionSettings()
        assert settings.show_explanations is True
        assert settings.randomize_order is True
        assert settings.allow_skipping is True
        assert settings.time_limit_per_question is None
        assert settings.max_attempts_per_question == 3

    def test_custom_settings(self):
        """Test custom settings creation"""
        settings = PracticeSessionSettings(
            show_explanations=False,
            randomize_order=False,
            allow_skipping=False,
            time_limit_per_question=300,
            max_attempts_per_question=5
        )
        assert settings.show_explanations is False
        assert settings.randomize_order is False
        assert settings.allow_skipping is False
        assert settings.time_limit_per_question == 300
        assert settings.max_attempts_per_question == 5

    def test_invalid_max_attempts(self):
        """Test invalid max attempts validation"""
        with pytest.raises(ValueError, match="Max attempts per question must be between"):
            PracticeSessionSettings(max_attempts_per_question=15)


class TestPracticeSession:
    """Test PracticeSession model"""

    def test_session_creation(self):
        """Test creating a practice session"""
        now = datetime.utcnow()
        filter_criteria = PracticeSessionFilter(exam_type="ECAT", question_count=20)
        settings = PracticeSessionSettings()
        question_ids = ["q1", "q2", "q3"]

        session = PracticeSession(
            id="session_123",
            user_id="user_456",
            filter_criteria=filter_criteria,
            question_ids=question_ids,
            started_at=now,
            total_questions=3,
            settings=settings,
            created_at=now,
            updated_at=now
        )

        assert session.id == "session_123"
        assert session.user_id == "user_456"
        assert session.session_type == "practice"
        assert session.status == "active"
        assert session.current_question_index == 0
        assert session.answered_questions == 0
        assert session.correct_answers == 0
        assert session.total_time_spent == 0

    def test_session_properties(self):
        """Test session computed properties"""
        now = datetime.utcnow()
        filter_criteria = PracticeSessionFilter(exam_type="ECAT", question_count=10)
        settings = PracticeSessionSettings()
        question_ids = ["q1", "q2", "q3", "q4"]

        session = PracticeSession(
            id="session_123",
            user_id="user_456",
            filter_criteria=filter_criteria,
            question_ids=question_ids,
            started_at=now,
            total_questions=4,
            answered_questions=2,
            correct_answers=1,
            total_time_spent=120,
            settings=settings,
            created_at=now,
            updated_at=now
        )

        assert session.progress_percentage == 50.0
        assert session.accuracy_percentage == 50.0
        assert session.average_time_per_question == 60.0
        assert session.is_active is True
        assert session.is_completed is False
        assert session.current_question_id == "q1"
        assert session.has_next_question is True
        assert session.has_previous_question is False

    def test_completed_session(self):
        """Test completed session properties"""
        now = datetime.utcnow()
        filter_criteria = PracticeSessionFilter(exam_type="ECAT", question_count=10)
        settings = PracticeSessionSettings()
        question_ids = ["q1", "q2", "q3"]

        session = PracticeSession(
            id="session_123",
            user_id="user_456",
            filter_criteria=filter_criteria,
            question_ids=question_ids,
            started_at=now,
            completed_at=now + timedelta(minutes=30),
            total_questions=3,
            answered_questions=3,
            correct_answers=2,
            total_time_spent=1800,
            status="completed",
            settings=settings,
            created_at=now,
            updated_at=now
        )

        assert session.is_completed is True
        assert session.is_active is False
        assert session.progress_percentage == 100.0
        assert session.accuracy_percentage == (2/3) * 100

    def test_invalid_session_type(self):
        """Test invalid session type validation"""
        now = datetime.utcnow()
        filter_criteria = PracticeSessionFilter(exam_type="ECAT", question_count=10)
        settings = PracticeSessionSettings()

        with pytest.raises(ValueError, match="Session type must be one of"):
            PracticeSession(
                id="session_123",
                user_id="user_456",
                session_type="invalid",
                filter_criteria=filter_criteria,
                question_ids=["q1"],
                started_at=now,
                total_questions=1,
                settings=settings,
                created_at=now,
                updated_at=now
            )

    def test_invalid_status(self):
        """Test invalid status validation"""
        now = datetime.utcnow()
        filter_criteria = PracticeSessionFilter(exam_type="ECAT", question_count=10)
        settings = PracticeSessionSettings()

        with pytest.raises(ValueError, match="Status must be one of"):
            PracticeSession(
                id="session_123",
                user_id="user_456",
                status="invalid",
                filter_criteria=filter_criteria,
                question_ids=["q1"],
                started_at=now,
                total_questions=1,
                settings=settings,
                created_at=now,
                updated_at=now
            )


class TestPracticeSessionAttempt:
    """Test PracticeSessionAttempt model"""

    def test_attempt_creation(self):
        """Test creating a session attempt"""
        now = datetime.utcnow()

        attempt = PracticeSessionAttempt(
            id="attempt_123",
            session_id="session_456",
            question_id="question_789",
            user_id="user_101",
            selected_answers=["A", "B"],
            correct_answers=["A", "C"],
            is_correct=False,
            time_spent=30000,  # 30 seconds in milliseconds
            attempt_number=1,
            timestamp=now
        )

        assert attempt.id == "attempt_123"
        assert attempt.session_id == "session_456"
        assert attempt.question_id == "question_789"
        assert attempt.user_id == "user_101"
        assert attempt.selected_answers == ["A", "B"]
        assert attempt.correct_answers == ["A", "C"]
        assert attempt.is_correct is False
        assert attempt.time_spent == 30000
        assert attempt.time_spent_seconds == 30.0
        assert attempt.attempt_number == 1

    def test_correct_attempt(self):
        """Test correct attempt detection"""
        now = datetime.utcnow()

        attempt = PracticeSessionAttempt(
            id="attempt_123",
            session_id="session_456",
            question_id="question_789",
            user_id="user_101",
            selected_answers=["A", "C"],
            correct_answers=["A", "C"],
            is_correct=True,
            time_spent=15000,
            attempt_number=2,
            timestamp=now,
            explanation_shown=True,
            hint_used=False
        )

        assert attempt.is_correct is True
        assert attempt.explanation_shown is True
        assert attempt.hint_used is False

    def test_invalid_time_spent(self):
        """Test invalid time spent validation"""
        now = datetime.utcnow()

        with pytest.raises(ValueError, match="Time spent cannot be negative"):
            PracticeSessionAttempt(
                id="attempt_123",
                session_id="session_456",
                question_id="question_789",
                user_id="user_101",
                selected_answers=["A"],
                correct_answers=["A"],
                is_correct=True,
                time_spent=-1000,
                timestamp=now
            )

        with pytest.raises(ValueError, match="Time spent cannot exceed"):
            PracticeSessionAttempt(
                id="attempt_123",
                session_id="session_456",
                question_id="question_789",
                user_id="user_101",
                selected_answers=["A"],
                correct_answers=["A"],
                is_correct=True,
                time_spent=4000000,  # More than 1 hour
                timestamp=now
            )


class TestFactoryFunctions:
    """Test factory functions"""

    def test_create_practice_session(self):
        """Test practice session factory function"""
        filter_criteria = PracticeSessionFilter(exam_type="ECAT", question_count=15)
        question_ids = ["q1", "q2", "q3", "q4", "q5"]

        session = create_practice_session(
            user_id="user_123",
            filter_criteria=filter_criteria,
            question_ids=question_ids
        )

        assert session.user_id == "user_123"
        assert session.filter_criteria.exam_type == "ECAT"
        assert session.question_ids == question_ids
        assert session.total_questions == 5
        assert session.status == "active"
        assert session.current_question_index == 0
        assert session.answered_questions == 0
        assert session.correct_answers == 0
        assert session.total_time_spent == 0
        assert session.is_active is True
        assert session.is_completed is False

    def test_create_session_attempt(self):
        """Test session attempt factory function"""
        attempt = create_session_attempt(
            session_id="session_123",
            question_id="question_456",
            user_id="user_789",
            selected_answers=["A"],
            correct_answers=["A"],
            time_spent=20000,
            attempt_number=1
        )

        assert attempt.session_id == "session_123"
        assert attempt.question_id == "question_456"
        assert attempt.user_id == "user_789"
        assert attempt.selected_answers == ["A"]
        assert attempt.correct_answers == ["A"]
        assert attempt.is_correct is True
        assert attempt.time_spent == 20000
        assert attempt.attempt_number == 1

    def test_create_incorrect_attempt(self):
        """Test creating an incorrect attempt"""
        attempt = create_session_attempt(
            session_id="session_123",
            question_id="question_456",
            user_id="user_789",
            selected_answers=["B"],
            correct_answers=["A"],
            time_spent=25000,
            attempt_number=2
        )

        assert attempt.is_correct is False
        assert attempt.attempt_number == 2


class TestResponseModels:
    """Test response model serialization"""

    def test_session_response_creation(self):
        """Test creating a session response"""
        now = datetime.utcnow()
        filter_criteria = PracticeSessionFilter(exam_type="MCAT", question_count=20)
        settings = PracticeSessionSettings()

        response = PracticeSessionResponse(
            id="session_123",
            session_type="practice",
            filter_criteria=filter_criteria,
            current_question_index=2,
            status="active",
            started_at=now,
            completed_at=None,
            total_questions=20,
            answered_questions=3,
            correct_answers=2,
            total_time_spent=450,
            settings=settings,
            progress_percentage=15.0,
            accuracy_percentage=66.67,
            average_time_per_question=150.0,
            current_question_id="q3",
            has_next_question=True,
            has_previous_question=True
        )

        assert response.id == "session_123"
        assert response.session_type == "practice"
        assert response.progress_percentage == 15.0
        assert response.accuracy_percentage == 66.67

    def test_session_summary_creation(self):
        """Test creating a session summary"""
        now = datetime.utcnow()

        summary = PracticeSessionSummary(
            id="session_123",
            session_type="practice",
            exam_type="ECAT",
            subject="Physics",
            total_questions=25,
            answered_questions=25,
            correct_answers=20,
            accuracy_percentage=80.0,
            total_time_spent=1800,
            started_at=now,
            completed_at=now + timedelta(minutes=45),
            status="completed"
        )

        assert summary.id == "session_123"
        assert summary.accuracy_percentage == 80.0
        assert summary.status == "completed"