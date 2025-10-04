import pytest
from unittest.mock import AsyncMock, MagicMock, patch
from datetime import datetime, timedelta
from app.services.practice_session_service import PracticeSessionService
from app.models.practice_session import (
    PracticeSession,
    PracticeSessionFilter,
    PracticeSessionSettings,
    PracticeSessionSummary,
    PracticeSessionStatistics,
    PracticeSessionAttempt,
    create_practice_session,
    create_session_attempt,
)
from app.core.exceptions import NotFoundError, ValidationError


class TestPracticeSessionService:
    """Test PracticeSessionService"""

    @pytest.fixture
    def service(self):
        """Create service instance"""
        return PracticeSessionService()

    @pytest.fixture
    def mock_db(self):
        """Mock database operations"""
        with patch('app.services.practice_session_service.db') as mock_db:
            # Mock the async methods
            mock_db.create_document = AsyncMock()
            mock_db.get_document = AsyncMock()
            mock_db.update_document = AsyncMock()
            mock_db.query_collection = AsyncMock()
            mock_db.delete_document = AsyncMock()
            yield mock_db

    @pytest.fixture
    def mock_question_service(self):
        """Mock question service"""
        with patch('app.services.practice_session_service.question_service') as mock_qs:
            # Mock the async methods
            mock_qs.get_questions_for_practice = AsyncMock()
            mock_qs.get_question = AsyncMock()
            yield mock_qs

    @pytest.fixture
    def sample_filter(self):
        """Sample practice session filter"""
        return PracticeSessionFilter(exam_type="ECAT", question_count=10)

    @pytest.fixture
    def sample_settings(self):
        """Sample practice session settings"""
        return PracticeSessionSettings()

    @pytest.fixture
    def sample_questions(self):
        """Sample questions data"""
        return [
            {"id": "q1", "question_text": "Question 1", "correct_answer": ["A"]},
            {"id": "q2", "question_text": "Question 2", "correct_answer": ["B"]},
            {"id": "q3", "question_text": "Question 3", "correct_answer": ["C"]},
        ]

    @pytest.fixture
    def sample_session_data(self):
        """Sample session data for database"""
        now = datetime.utcnow()
        return {
            "id": "session_123",
            "user_id": "user_456",
            "session_type": "practice",
            "filter_criteria": {"exam_type": "ECAT", "question_count": 10},
            "question_ids": ["q1", "q2", "q3"],
            "current_question_index": 0,
            "status": "active",
            "started_at": now.isoformat(),
            "total_questions": 3,
            "settings": {},
            "created_at": now.isoformat(),
            "updated_at": now.isoformat(),
        }

    @pytest.mark.asyncio
    async def test_create_session_success(self, service, mock_db, mock_question_service, sample_filter, sample_settings, sample_questions):
        """Test successful session creation"""
        # Setup mocks
        mock_question_service.get_questions_for_practice.return_value = sample_questions
        mock_db.create_document.return_value = None

        # Execute
        result = await service.create_session(
            user_id="user_123",
            filter_criteria=sample_filter,
            settings=sample_settings
        )

        # Assert
        assert isinstance(result, str)
        mock_question_service.get_questions_for_practice.assert_called_once()
        mock_db.create_document.assert_called_once()
        call_args = mock_db.create_document.call_args
        assert call_args[0][0] == "practice_sessions"
        session_data = call_args[0][1]
        assert session_data["user_id"] == "user_123"
        assert session_data["total_questions"] == 3
        assert session_data["question_ids"] == ["q1", "q2", "q3"]

    @pytest.mark.asyncio
    async def test_create_session_no_questions(self, service, mock_question_service, sample_filter):
        """Test session creation with no matching questions"""
        mock_question_service.get_questions_for_practice.return_value = []

        with pytest.raises(ValidationError, match="No questions found"):
            await service.create_session(
                user_id="user_123",
                filter_criteria=sample_filter
            )

    @pytest.mark.asyncio
    async def test_get_session_success(self, service, mock_db, sample_session_data):
        """Test successful session retrieval"""
        mock_db.get_document.return_value = sample_session_data

        result = await service.get_session("session_123", "user_456")

        assert isinstance(result, PracticeSession)
        assert result.id == "session_123"
        assert result.user_id == "user_456"
        assert result.total_questions == 3
        mock_db.get_document.assert_called_once_with("practice_sessions", "session_123")

    @pytest.mark.asyncio
    async def test_get_session_not_found(self, service, mock_db):
        """Test session retrieval when not found"""
        mock_db.get_document.return_value = None

        result = await service.get_session("session_123", "user_456")

        assert result is None

    @pytest.mark.asyncio
    async def test_get_session_wrong_user(self, service, mock_db, sample_session_data):
        """Test session retrieval with wrong user"""
        mock_db.get_document.return_value = sample_session_data

        result = await service.get_session("session_123", "wrong_user")

        assert result is None

    @pytest.mark.asyncio
    async def test_get_user_sessions_success(self, service, mock_db):
        """Test successful user sessions retrieval"""
        sessions_data = [
            {
                "id": "session_1",
                "session_type": "practice",
                "exam_type": "ECAT",
                "total_questions": 10,
                "answered_questions": 5,
                "correct_answers": 4,
                "total_time_spent": 300,
                "started_at": datetime.utcnow().isoformat(),
                "status": "active",
            }
        ]
        mock_db.query_collection.return_value = sessions_data

        result = await service.get_user_sessions("user_123")

        assert len(result) == 1
        assert isinstance(result[0], PracticeSessionSummary)
        assert result[0].id == "session_1"
        assert result[0].accuracy_percentage == 80.0

    @pytest.mark.asyncio
    async def test_update_session_progress_success(self, service, mock_db, sample_session_data):
        """Test successful session progress update"""
        mock_db.get_document.return_value = sample_session_data
        mock_db.update_document.return_value = None

        result = await service.update_session_progress(
            session_id="session_123",
            user_id="user_456",
            question_index=2,
            time_spent=150
        )

        assert result is True
        mock_db.update_document.assert_called_once()
        call_args = mock_db.update_document.call_args
        assert call_args[0][0] == "practice_sessions"
        assert call_args[0][1] == "session_123"
        update_data = call_args[0][2]
        assert update_data["current_question_index"] == 2
        assert update_data["total_time_spent"] == 150

    @pytest.mark.asyncio
    async def test_update_session_progress_invalid_index(self, service, mock_db, sample_session_data):
        """Test session progress update with invalid question index"""
        mock_db.get_document.return_value = sample_session_data

        with pytest.raises(ValidationError, match="Invalid question index"):
            await service.update_session_progress(
                session_id="session_123",
                user_id="user_456",
                question_index=10,  # Beyond total questions
                time_spent=150
            )

    @pytest.mark.asyncio
    async def test_record_attempt_success(self, service, mock_db, mock_question_service):
        """Test successful attempt recording"""
        # Setup mocks
        question_data = {"id": "q1", "correct_answer": ["A"]}
        session_data = {
            "id": "session_123",
            "user_id": "user_456",
            "answered_questions": 0,
            "correct_answers": 0,
            "total_time_spent": 0,
        }
        mock_question_service.get_question.return_value = question_data
        mock_db.create_document.return_value = None
        mock_db.get_document.return_value = session_data
        mock_db.update_document.return_value = None

        # Execute
        result = await service.record_attempt(
            session_id="session_123",
            question_id="q1",
            user_id="user_456",
            selected_answers=["A"],
            time_spent=30000,
            attempt_number=1
        )

        # Assert
        assert isinstance(result, str)
        mock_question_service.get_question.assert_called_once_with("q1")
        mock_db.create_document.assert_called_once()
        mock_db.update_document.assert_called_once()  # Session stats update

    @pytest.mark.asyncio
    async def test_record_attempt_question_not_found(self, service, mock_question_service):
        """Test attempt recording with non-existent question"""
        mock_question_service.get_question.return_value = None

        with pytest.raises(NotFoundError, match="Question not found"):
            await service.record_attempt(
                session_id="session_123",
                question_id="q1",
                user_id="user_456",
                selected_answers=["A"],
                time_spent=30000
            )

    @pytest.mark.asyncio
    async def test_complete_session_success(self, service, mock_db, sample_session_data):
        """Test successful session completion"""
        mock_db.get_document.return_value = sample_session_data
        mock_db.update_document.return_value = None

        result = await service.complete_session("session_123", "user_456")

        assert result is True
        mock_db.update_document.assert_called_once()
        call_args = mock_db.update_document.call_args
        update_data = call_args[0][2]
        assert update_data["status"] == "completed"
        assert "completed_at" in update_data

    @pytest.mark.asyncio
    async def test_complete_session_already_completed(self, service, mock_db, sample_session_data):
        """Test completing an already completed session"""
        sample_session_data["status"] = "completed"
        mock_db.get_document.return_value = sample_session_data

        result = await service.complete_session("session_123", "user_456")

        assert result is True
        mock_db.update_document.assert_not_called()

    @pytest.mark.asyncio
    async def test_pause_session_success(self, service, mock_db, sample_session_data):
        """Test successful session pause"""
        mock_db.get_document.return_value = sample_session_data
        mock_db.update_document.return_value = None

        result = await service.pause_session("session_123", "user_456")

        assert result is True
        mock_db.update_document.assert_called_once()
        call_args = mock_db.update_document.call_args
        update_data = call_args[0][2]
        assert update_data["status"] == "paused"

    @pytest.mark.asyncio
    async def test_pause_session_already_paused(self, service, mock_db, sample_session_data):
        """Test pausing an already paused session"""
        sample_session_data["status"] = "paused"
        mock_db.get_document.return_value = sample_session_data

        result = await service.pause_session("session_123", "user_456")

        assert result is False
        mock_db.update_document.assert_not_called()

    @pytest.mark.asyncio
    async def test_resume_session_success(self, service, mock_db, sample_session_data):
        """Test successful session resume"""
        sample_session_data["status"] = "paused"
        mock_db.get_document.return_value = sample_session_data
        mock_db.update_document.return_value = None

        result = await service.resume_session("session_123", "user_456")

        assert result is True
        mock_db.update_document.assert_called_once()
        call_args = mock_db.update_document.call_args
        update_data = call_args[0][2]
        assert update_data["status"] == "active"

    @pytest.mark.asyncio
    async def test_get_session_attempts_success(self, service, mock_db, sample_session_data):
        """Test successful session attempts retrieval"""
        attempts_data = [
            {
                "id": "attempt_1",
                "session_id": "session_123",
                "question_id": "q1",
                "user_id": "user_456",
                "selected_answers": ["A"],
                "correct_answers": ["A"],
                "is_correct": True,
                "time_spent": 30000,
                "attempt_number": 1,
                "timestamp": datetime.utcnow().isoformat(),
            }
        ]
        mock_db.get_document.return_value = sample_session_data
        mock_db.query_collection.return_value = attempts_data

        result = await service.get_session_attempts("session_123", "user_456")

        assert len(result) == 1
        assert isinstance(result[0], PracticeSessionAttempt)
        assert result[0].is_correct is True

    @pytest.mark.asyncio
    async def test_delete_session_success(self, service, mock_db, sample_session_data):
        """Test successful session deletion"""
        attempts = [
            PracticeSessionAttempt(
                id="attempt_1",
                session_id="session_123",
                question_id="q1",
                user_id="user_456",
                selected_answers=["A"],
                correct_answers=["A"],
                is_correct=True,
                time_spent=30000,
                timestamp=datetime.utcnow()
            )
        ]

        mock_db.get_document.return_value = sample_session_data
        with patch.object(service, 'get_session_attempts', return_value=attempts):
            mock_db.delete_document.return_value = None

            result = await service.delete_session("session_123", "user_456")

            assert result is True
            assert mock_db.delete_document.call_count == 2  # One for attempts, one for session

    @pytest.mark.asyncio
    async def test_delete_session_not_found(self, service, mock_db):
        """Test session deletion when session not found"""
        mock_db.get_document.return_value = None

        with pytest.raises(NotFoundError, match="Practice session not found"):
            await service.delete_session("session_123", "user_456")

    @pytest.mark.asyncio
    async def test_get_session_statistics_success(self, service, mock_db, sample_session_data):
        """Test successful session statistics retrieval"""
        attempts = [
            PracticeSessionAttempt(
                id="attempt_1",
                session_id="session_123",
                question_id="q1",
                user_id="user_456",
                selected_answers=["A"],
                correct_answers=["A"],
                is_correct=True,
                time_spent=30000,
                timestamp=datetime.utcnow()
            )
        ]

        mock_db.get_document.return_value = sample_session_data
        with patch.object(service, 'get_session_attempts', return_value=attempts):
            result = await service.get_session_statistics("session_123", "user_456")

            assert isinstance(result, PracticeSessionStatistics)
            assert result.session_id == "session_123"
            assert result.total_questions == 3
            assert result.correct_answers == 0  # From session data
            assert result.accuracy_percentage == 0.0

    # Edge cases and error handling
    @pytest.mark.asyncio
    async def test_invalid_time_spent_in_attempt(self, service):
        """Test attempt recording with invalid time spent"""
        with pytest.raises(ValidationError, match="Time spent cannot be negative"):
            await service.record_attempt(
                session_id="session_123",
                question_id="q1",
                user_id="user_456",
                selected_answers=["A"],
                time_spent=-1000
            )

    def test_session_properties_calculation(self, sample_session_data):
        """Test session property calculations"""
        session = PracticeSession(
            id="session_123",
            user_id="user_456",
            filter_criteria=PracticeSessionFilter(exam_type="ECAT", question_count=10),
            question_ids=["q1", "q2", "q3", "q4"],
            current_question_index=1,
            status="active",
            started_at=datetime.utcnow(),
            total_questions=4,
            answered_questions=2,
            correct_answers=1,
            total_time_spent=300,
            settings=PracticeSessionSettings(),
            created_at=datetime.utcnow(),
            updated_at=datetime.utcnow()
        )

        assert session.progress_percentage == 50.0
        assert session.accuracy_percentage == 50.0
        assert session.average_time_per_question == 150.0
        assert session.current_question_id == "q2"
        assert session.has_next_question is True
        assert session.has_previous_question is True
        assert session.is_active is True
        assert session.is_completed is False

    def test_session_boundary_conditions(self):
        """Test session boundary conditions"""
        now = datetime.utcnow()
        session = PracticeSession(
            id="session_123",
            user_id="user_456",
            filter_criteria=PracticeSessionFilter(exam_type="ECAT", question_count=1),
            question_ids=["q1"],
            current_question_index=0,
            status="active",
            started_at=now,
            total_questions=1,
            answered_questions=0,
            correct_answers=0,
            total_time_spent=0,
            settings=PracticeSessionSettings(),
            created_at=now,
            updated_at=now
        )

        assert session.has_next_question is False
        assert session.has_previous_question is False
        assert session.current_question_id == "q1"

        # Test with index at end
        session.current_question_index = 0  # Last question (0-indexed)
        assert session.has_next_question is False