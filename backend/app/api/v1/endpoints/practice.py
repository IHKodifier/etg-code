from fastapi import APIRouter, Depends, HTTPException, status, Query
from fastapi.security import HTTPBearer
from typing import Dict, Any, List, Optional
import logging

from app.services.auth_service import auth_service
from app.services.practice_session_service import practice_session_service
from app.models.practice_session import (
    PracticeSessionCreateRequest,
    PracticeSessionCreateResponse,
    PracticeSessionResponse,
    PracticeSessionSummary,
    PracticeSessionStatistics,
)

router = APIRouter()
security = HTTPBearer(auto_error=False)
logger = logging.getLogger(__name__)

async def get_current_user_dependency(token: str = Depends(security)):
    """Get current user from token"""
    if not token:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token required"
        )

    user = await auth_service.get_current_user(token.credentials)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token"
        )

    return user

@router.get("/", response_model=List[PracticeSessionSummary])
async def get_practice_sessions(
    status_filter: Optional[str] = Query(None, alias="status"),
    limit: int = Query(20, ge=1, le=100),
    current_user = Depends(get_current_user_dependency)
):
    """Get user's practice sessions"""
    try:
        sessions = await practice_session_service.get_user_sessions(
            user_id=current_user["id"],
            limit=limit,
            status=status_filter
        )
        return sessions
    except Exception as e:
        logger.error(f"Failed to get practice sessions: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve practice sessions"
        )

@router.post("/session", response_model=PracticeSessionCreateResponse)
async def create_practice_session(
    request: PracticeSessionCreateRequest
    # current_user = Depends(get_current_user_dependency)  # TEMPORARILY DISABLED
):
    """Create a new practice session"""
    try:
        # TEMPORARY: Use a test user ID for development
        # TODO: Remove this once authentication is working properly
        test_user_id = "test_user_123"

        session_id = await practice_session_service.create_session(
            user_id=test_user_id,  # current_user["id"]
            filter_criteria=request.filter_criteria,
            settings=request.settings
        )
        return PracticeSessionCreateResponse(id=session_id)
    except Exception as e:
        logger.error(f"Failed to create practice session: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to create practice session"
        )

@router.get("/session/{session_id}", response_model=PracticeSessionResponse)
async def get_practice_session(
    session_id: str
    # current_user = Depends(get_current_user_dependency)  # TEMPORARILY DISABLED
):
    """Get a specific practice session"""
    try:
        session = await practice_session_service.get_session(
            session_id=session_id,
            user_id=None  # TEMPORARILY DISABLED
        )
        if not session:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Practice session not found"
            )

        # Convert to response model
        response = PracticeSessionResponse(
            id=session.id,
            session_type=session.session_type,
            filter_criteria=session.filter_criteria,
            current_question_index=session.current_question_index,
            status=session.status,
            started_at=session.started_at,
            completed_at=session.completed_at,
            total_questions=session.total_questions,
            answered_questions=session.answered_questions,
            correct_answers=session.correct_answers,
            total_time_spent=session.total_time_spent,
            settings=session.settings,
            progress_percentage=session.progress_percentage,
            accuracy_percentage=session.accuracy_percentage,
            average_time_per_question=session.average_time_per_question,
            current_question_id=session.current_question_id,
            has_next_question=session.has_next_question,
            has_previous_question=session.has_previous_question
        )
        return response
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get practice session {session_id}: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve practice session"
        )

@router.put("/session/{session_id}/progress")
async def update_session_progress(
    session_id: str,
    question_index: int,
    time_spent: int,
    current_user = Depends(get_current_user_dependency)
):
    """Update session progress"""
    try:
        success = await practice_session_service.update_session_progress(
            session_id=session_id,
            user_id=current_user["id"],
            question_index=question_index,
            time_spent=time_spent
        )
        if not success:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Failed to update session progress"
            )
        return {"message": "Progress updated successfully"}
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to update session progress: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to update session progress"
        )

@router.post("/session/{session_id}/attempt")
async def record_attempt(
    session_id: str,
    question_id: str,
    selected_answers: List[str],
    time_spent: int,
    attempt_number: int = 1,
    explanation_shown: bool = False,
    hint_used: bool = False,
    notes: Optional[str] = None,
    current_user = Depends(get_current_user_dependency)
):
    """Record a question attempt for a practice session"""
    try:
        attempt_id = await practice_session_service.record_attempt(
            session_id=session_id,
            question_id=question_id,
            user_id=current_user["id"],
            selected_answers=selected_answers,
            time_spent=time_spent,
            attempt_number=attempt_number,
            explanation_shown=explanation_shown,
            hint_used=hint_used,
            notes=notes
        )
        return {"attempt_id": attempt_id, "message": "Attempt recorded successfully"}
    except Exception as e:
        logger.error(f"Failed to record attempt: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to record attempt"
        )

@router.post("/session/{session_id}/complete")
async def complete_session(
    session_id: str,
    current_user = Depends(get_current_user_dependency)
):
    """Mark a practice session as completed"""
    try:
        success = await practice_session_service.complete_session(
            session_id=session_id,
            user_id=current_user["id"]
        )
        if not success:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Failed to complete session"
            )
        return {"message": "Session completed successfully"}
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to complete session {session_id}: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to complete session"
        )

@router.post("/session/{session_id}/pause")
async def pause_session(
    session_id: str,
    current_user = Depends(get_current_user_dependency)
):
    """Pause a practice session"""
    try:
        success = await practice_session_service.pause_session(
            session_id=session_id,
            user_id=current_user["id"]
        )
        if not success:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Failed to pause session"
            )
        return {"message": "Session paused successfully"}
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to pause session {session_id}: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to pause session"
        )

@router.post("/session/{session_id}/resume")
async def resume_session(
    session_id: str,
    current_user = Depends(get_current_user_dependency)
):
    """Resume a paused practice session"""
    try:
        success = await practice_session_service.resume_session(
            session_id=session_id,
            user_id=current_user["id"]
        )
        if not success:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Failed to resume session"
            )
        return {"message": "Session resumed successfully"}
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to resume session {session_id}: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to resume session"
        )

@router.get("/session/{session_id}/attempts")
async def get_session_attempts(
    session_id: str,
    current_user = Depends(get_current_user_dependency)
):
    """Get all attempts for a practice session"""
    try:
        attempts = await practice_session_service.get_session_attempts(
            session_id=session_id,
            user_id=current_user["id"]
        )
        return {"attempts": [attempt.dict() for attempt in attempts]}
    except Exception as e:
        logger.error(f"Failed to get session attempts for {session_id}: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve session attempts"
        )

@router.get("/session/{session_id}/statistics", response_model=PracticeSessionStatistics)
async def get_session_statistics(
    session_id: str,
    current_user = Depends(get_current_user_dependency)
):
    """Get detailed statistics for a practice session"""
    try:
        stats = await practice_session_service.get_session_statistics(
            session_id=session_id,
            user_id=current_user["id"]
        )
        if not stats:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Session statistics not found"
            )
        return stats
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get session statistics for {session_id}: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve session statistics"
        )

@router.delete("/session/{session_id}")
async def delete_session(
    session_id: str,
    current_user = Depends(get_current_user_dependency)
):
    """Delete a practice session and all its attempts"""
    try:
        success = await practice_session_service.delete_session(
            session_id=session_id,
            user_id=current_user["id"]
        )
        if not success:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Failed to delete session"
            )
        return {"message": "Session deleted successfully"}
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to delete session {session_id}: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to delete session"
        )