from typing import List, Dict, Any, Optional
from datetime import datetime
import logging
import uuid
from app.core.database import db
from app.core.exceptions import NotFoundError, ValidationError
from app.models.practice_session import (
    PracticeSession,
    PracticeSessionFilter,
    PracticeSessionSettings,
    PracticeSessionResponse,
    PracticeSessionSummary,
    PracticeSessionStatistics,
    PracticeSessionAttempt,
    create_practice_session,
    create_session_attempt,
)
from app.services.question_service import QuestionService

# Create service instance
question_service = QuestionService()

logger = logging.getLogger(__name__)


class PracticeSessionService:
    """Service for managing practice sessions and attempts"""

    async def create_session(
        self,
        user_id: str,
        filter_criteria: PracticeSessionFilter,
        settings: PracticeSessionSettings = None
    ) -> str:
        """Create a new practice session with filtered questions"""
        try:
            if settings is None:
                settings = PracticeSessionSettings()

            # Get questions based on filter criteria
            questions = await question_service.get_questions_for_practice(
                exam_type=filter_criteria.exam_type,
                subject=filter_criteria.subject,
                topic=filter_criteria.topic,
                difficulty=filter_criteria.difficulty,
                arde_probability=filter_criteria.arde_probability,
                limit=filter_criteria.question_count
            )

            if not questions:
                raise ValidationError("No questions found matching the specified criteria")

            # Extract question IDs
            question_ids = [q["id"] for q in questions]

            # Apply randomization if enabled
            if settings.randomize_order:
                import random
                random.shuffle(question_ids)

            # Create session using factory function
            session = create_practice_session(
                user_id=user_id,
                filter_criteria=filter_criteria,
                question_ids=question_ids,
                settings=settings
            )

            # Convert to dict for Firestore storage
            session_data = {
                "id": session.id,
                "user_id": session.user_id,
                "session_type": session.session_type,
                "filter_criteria": session.filter_criteria.dict(),
                "question_ids": session.question_ids,
                "current_question_index": session.current_question_index,
                "status": session.status,
                "started_at": session.started_at.isoformat(),
                "total_questions": session.total_questions,
                "settings": session.settings.dict(),
                "created_at": session.created_at.isoformat(),
                "updated_at": session.updated_at.isoformat(),
            }

            # Add optional fields
            if session.completed_at:
                session_data["completed_at"] = session.completed_at.isoformat()

            # Store in Firestore
            await db.create_document("practice_sessions", session_data)

            logger.info(f"Practice session created: {session.id} for user {user_id}")
            return session.id

        except Exception as e:
            logger.error(f"Failed to create practice session: {e}")
            raise

    async def get_session(self, session_id: str, user_id: str = None) -> Optional[PracticeSession]:
        """Get a practice session by ID"""
        try:
            logger.info(f"Getting practice session {session_id} for user {user_id}")
            session_data = await db.get_document("practice_sessions", session_id)
            logger.info(f"Session data retrieved: {session_data}")

            if not session_data:
                logger.warning(f"Session {session_id} not found in database")
                return None

            # Check ownership if user_id provided
            if user_id and session_data.get("user_id") != user_id:
                raise ValidationError("Access denied: session belongs to another user")

            # Convert back to PracticeSession model
            session = self._dict_to_session(session_data)
            logger.info(f"Session converted successfully: {session.id}")
            return session

        except Exception as e:
            logger.error(f"Failed to get practice session {session_id}: {e}")
            return None

    async def get_user_sessions(
        self,
        user_id: str,
        limit: int = 20,
        status: Optional[str] = None
    ) -> List[PracticeSessionSummary]:
        """Get user's practice sessions"""
        try:
            filters = [{"field": "user_id", "operator": "==", "value": user_id}]

            if status:
                filters.append({"field": "status", "operator": "==", "value": status})

            sessions_data = await db.query_collection(
                "practice_sessions",
                filters=filters,
                limit=limit,
                order_by="-created_at"
            )

            summaries = []
            for session_data in sessions_data:
                summary = PracticeSessionSummary(
                    id=session_data["id"],
                    session_type=session_data.get("session_type", "practice"),
                    exam_type=session_data["filter_criteria"]["exam_type"],
                    subject=session_data["filter_criteria"].get("subject"),
                    total_questions=session_data["total_questions"],
                    answered_questions=session_data.get("answered_questions", 0),
                    correct_answers=session_data.get("correct_answers", 0),
                    accuracy_percentage=self._calculate_accuracy_percentage(
                        session_data.get("answered_questions", 0),
                        session_data.get("correct_answers", 0)
                    ),
                    total_time_spent=session_data.get("total_time_spent", 0),
                    started_at=datetime.fromisoformat(session_data["started_at"]),
                    completed_at=self._parse_datetime(session_data.get("completed_at")),
                    status=session_data["status"]
                )
                summaries.append(summary)

            return summaries

        except Exception as e:
            logger.error(f"Failed to get user sessions for {user_id}: {e}")
            return []

    async def update_session_progress(
        self,
        session_id: str,
        user_id: str,
        question_index: int,
        time_spent: int
    ) -> bool:
        """Update session progress"""
        try:
            # Get current session
            session = await self.get_session(session_id, user_id)
            if not session:
                raise NotFoundError("Practice session not found")

            # Validate question index
            if question_index < 0 or question_index >= session.total_questions:
                raise ValidationError("Invalid question index")

            # Update session data
            update_data = {
                "current_question_index": question_index,
                "total_time_spent": session.total_time_spent + time_spent,
                "updated_at": datetime.utcnow().isoformat(),
            }

            await db.update_document("practice_sessions", session_id, update_data)

            logger.info(f"Session progress updated: {session_id}, question {question_index}")
            return True

        except Exception as e:
            logger.error(f"Failed to update session progress: {e}")
            return False

    async def record_attempt(
        self,
        session_id: str,
        question_id: str,
        user_id: str,
        selected_answers: List[str],
        time_spent: int,
        attempt_number: int = 1,
        explanation_shown: bool = False,
        hint_used: bool = False,
        notes: Optional[str] = None
    ) -> str:
        """Record a question attempt for a practice session"""
        try:
            # Get the question to determine correct answers
            question = await question_service.get_question(question_id)
            if not question:
                raise NotFoundError("Question not found")

            correct_answers = question.get("correct_answer", [])
            is_correct = set(selected_answers) == set(correct_answers)

            # Create attempt using factory function
            attempt = create_session_attempt(
                session_id=session_id,
                question_id=question_id,
                user_id=user_id,
                selected_answers=selected_answers,
                correct_answers=correct_answers,
                time_spent=time_spent,
                attempt_number=attempt_number
            )

            # Override additional fields
            attempt.explanation_shown = explanation_shown
            attempt.hint_used = hint_used
            attempt.notes = notes

            # Convert to dict for Firestore storage
            attempt_data = {
                "id": attempt.id,
                "session_id": attempt.session_id,
                "question_id": attempt.question_id,
                "user_id": attempt.user_id,
                "selected_answers": attempt.selected_answers,
                "correct_answers": attempt.correct_answers,
                "is_correct": attempt.is_correct,
                "time_spent": attempt.time_spent,
                "attempt_number": attempt.attempt_number,
                "timestamp": attempt.timestamp.isoformat(),
                "explanation_shown": attempt.explanation_shown,
                "hint_used": attempt.hint_used,
            }

            if attempt.notes:
                attempt_data["notes"] = attempt.notes

            # Store attempt
            await db.create_document("practice_session_attempts", attempt_data)

            # Update session statistics
            await self._update_session_statistics(session_id, is_correct, time_spent)

            logger.info(f"Attempt recorded: session {session_id}, question {question_id}, correct: {is_correct}")
            return attempt.id

        except Exception as e:
            logger.error(f"Failed to record attempt: {e}")
            raise

    async def complete_session(self, session_id: str, user_id: str) -> bool:
        """Mark a practice session as completed"""
        try:
            session = await self.get_session(session_id, user_id)
            if not session:
                raise NotFoundError("Practice session not found")

            if session.is_completed:
                return True  # Already completed

            update_data = {
                "status": "completed",
                "completed_at": datetime.utcnow().isoformat(),
                "updated_at": datetime.utcnow().isoformat(),
            }

            await db.update_document("practice_sessions", session_id, update_data)

            logger.info(f"Practice session completed: {session_id}")
            return True

        except Exception as e:
            logger.error(f"Failed to complete session {session_id}: {e}")
            return False

    async def pause_session(self, session_id: str, user_id: str) -> bool:
        """Pause a practice session"""
        try:
            session = await self.get_session(session_id, user_id)
            if not session:
                raise NotFoundError("Practice session not found")

            if session.status != "active":
                return False

            update_data = {
                "status": "paused",
                "updated_at": datetime.utcnow().isoformat(),
            }

            await db.update_document("practice_sessions", session_id, update_data)

            logger.info(f"Practice session paused: {session_id}")
            return True

        except Exception as e:
            logger.error(f"Failed to pause session {session_id}: {e}")
            return False

    async def resume_session(self, session_id: str, user_id: str) -> bool:
        """Resume a paused practice session"""
        try:
            session = await self.get_session(session_id, user_id)
            if not session:
                raise NotFoundError("Practice session not found")

            if session.status != "paused":
                return False

            update_data = {
                "status": "active",
                "updated_at": datetime.utcnow().isoformat(),
            }

            await db.update_document("practice_sessions", session_id, update_data)

            logger.info(f"Practice session resumed: {session_id}")
            return True

        except Exception as e:
            logger.error(f"Failed to resume session {session_id}: {e}")
            return False

    async def get_session_attempts(self, session_id: str, user_id: str) -> List[PracticeSessionAttempt]:
        """Get all attempts for a practice session"""
        try:
            # Verify session ownership
            session = await self.get_session(session_id, user_id)
            if not session:
                raise NotFoundError("Practice session not found")

            attempts_data = await db.query_collection(
                "practice_session_attempts",
                filters=[
                    {"field": "session_id", "operator": "==", "value": session_id},
                    {"field": "user_id", "operator": "==", "value": user_id}
                ],
                order_by="timestamp"
            )

            attempts = []
            for attempt_data in attempts_data:
                attempt = PracticeSessionAttempt(
                    id=attempt_data["id"],
                    session_id=attempt_data["session_id"],
                    question_id=attempt_data["question_id"],
                    user_id=attempt_data["user_id"],
                    selected_answers=attempt_data["selected_answers"],
                    correct_answers=attempt_data["correct_answers"],
                    is_correct=attempt_data["is_correct"],
                    time_spent=attempt_data["time_spent"],
                    attempt_number=attempt_data.get("attempt_number", 1),
                    timestamp=datetime.fromisoformat(attempt_data["timestamp"]),
                    explanation_shown=attempt_data.get("explanation_shown", False),
                    hint_used=attempt_data.get("hint_used", False),
                    notes=attempt_data.get("notes")
                )
                attempts.append(attempt)

            return attempts

        except Exception as e:
            logger.error(f"Failed to get session attempts for {session_id}: {e}")
            return []

    async def get_session_statistics(self, session_id: str, user_id: str) -> Optional[PracticeSessionStatistics]:
        """Get detailed statistics for a practice session"""
        try:
            session = await self.get_session(session_id, user_id)
            if not session:
                return None

            attempts = await self.get_session_attempts(session_id, user_id)

            # Calculate statistics
            total_attempts = len(attempts)
            correct_attempts = [a for a in attempts if a.is_correct]
            incorrect_attempts = [a for a in attempts if not a.is_correct]

            # Time statistics
            fastest_correct = min((a.time_spent for a in correct_attempts), default=None)
            slowest_correct = max((a.time_spent for a in correct_attempts), default=None)

            # Subject/topic breakdown (would need question data)
            subject_breakdown = {}
            difficulty_breakdown = {}

            stats = PracticeSessionStatistics(
                session_id=session_id,
                total_questions=session.total_questions,
                answered_questions=session.answered_questions,
                correct_answers=session.correct_answers,
                incorrect_answers=session.answered_questions - session.correct_answers,
                skipped_questions=session.total_questions - session.answered_questions,
                accuracy_percentage=session.accuracy_percentage,
                total_time_spent=session.total_time_spent,
                average_time_per_question=session.average_time_per_question,
                fastest_correct_time=fastest_correct,
                slowest_correct_time=slowest_correct,
                subject_breakdown=subject_breakdown,
                difficulty_breakdown=difficulty_breakdown,
                time_distribution={}
            )

            return stats

        except Exception as e:
            logger.error(f"Failed to get session statistics for {session_id}: {e}")
            return None

    async def delete_session(self, session_id: str, user_id: str) -> bool:
        """Delete a practice session and all its attempts"""
        try:
            # Verify ownership
            session = await self.get_session(session_id, user_id)
            if not session:
                raise NotFoundError("Practice session not found")

            # Delete all attempts first
            attempts = await self.get_session_attempts(session_id, user_id)
            for attempt in attempts:
                await db.delete_document("practice_session_attempts", attempt.id)

            # Delete session
            await db.delete_document("practice_sessions", session_id)

            logger.info(f"Practice session deleted: {session_id}")
            return True

        except Exception as e:
            logger.error(f"Failed to delete session {session_id}: {e}")
            return False

    # Private helper methods

    def _dict_to_session(self, data: Dict[str, Any]) -> PracticeSession:
        """Convert dictionary to PracticeSession model"""
        return PracticeSession(
            id=data["id"],
            user_id=data["user_id"],
            session_type=data.get("session_type", "practice"),
            filter_criteria=PracticeSessionFilter(**data["filter_criteria"]),
            question_ids=data["question_ids"],
            current_question_index=data.get("current_question_index", 0),
            status=data["status"],
            started_at=datetime.fromisoformat(data["started_at"]),
            completed_at=self._parse_datetime(data.get("completed_at")),
            total_questions=data["total_questions"],
            answered_questions=data.get("answered_questions", 0),
            correct_answers=data.get("correct_answers", 0),
            total_time_spent=data.get("total_time_spent", 0),
            settings=PracticeSessionSettings(**data.get("settings", {})),
            created_at=datetime.fromisoformat(data["created_at"]),
            updated_at=datetime.fromisoformat(data["updated_at"])
        )

    def _parse_datetime(self, datetime_str: Optional[str]) -> Optional[datetime]:
        """Parse datetime string safely"""
        if not datetime_str:
            return None
        try:
            return datetime.fromisoformat(datetime_str)
        except (ValueError, TypeError):
            return None

    def _calculate_accuracy_percentage(self, answered: int, correct: int) -> float:
        """Calculate accuracy percentage"""
        if answered == 0:
            return 0.0
        return (correct / answered) * 100.0

    async def _update_session_statistics(self, session_id: str, is_correct: bool, time_spent: int):
        """Update session statistics after recording an attempt"""
        try:
            # Get current session data
            session_data = await db.get_document("practice_sessions", session_id)
            if not session_data:
                return

            # Update counters
            answered_questions = session_data.get("answered_questions", 0) + 1
            correct_answers = session_data.get("correct_answers", 0) + (1 if is_correct else 0)
            total_time_spent = session_data.get("total_time_spent", 0) + time_spent

            update_data = {
                "answered_questions": answered_questions,
                "correct_answers": correct_answers,
                "total_time_spent": total_time_spent,
                "updated_at": datetime.utcnow().isoformat(),
            }

            await db.update_document("practice_sessions", session_id, update_data)

        except Exception as e:
            logger.error(f"Failed to update session statistics: {e}")


# Global practice session service instance
practice_session_service = PracticeSessionService()