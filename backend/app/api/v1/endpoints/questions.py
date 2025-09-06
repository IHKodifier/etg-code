from fastapi import APIRouter, Depends, HTTPException, status, Query
from fastapi.security import HTTPBearer
from typing import List, Optional
import logging

from app.services.auth_service import auth_service
from app.services.question_service import question_service
from app.models.question import (
    QuestionResponse,
    QuestionCreateRequest,
    QuestionExplanationResponse
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

@router.get("/practice", response_model=List[QuestionResponse])
async def get_practice_questions(
    exam_type: str,
    subject: Optional[str] = None,
    topic: Optional[str] = None,
    difficulty: Optional[str] = None,
    arde_probability: Optional[str] = None,
    limit: int = Query(20, ge=1, le=50),
    current_user = Depends(get_current_user_dependency)
):
    """Get questions for practice session"""
    try:
        questions = await question_service.get_questions_for_practice(
            exam_type=exam_type,
            subject=subject,
            topic=topic,
            difficulty=difficulty,
            arde_probability=arde_probability,
            limit=limit
        )
        
        return [QuestionResponse(**q) for q in questions]
        
    except Exception as e:
        logger.error(f"Failed to get practice questions: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve questions"
        )

@router.get("/{question_id}", response_model=QuestionResponse)
async def get_question(
    question_id: str,
    current_user = Depends(get_current_user_dependency)
):
    """Get a specific question"""
    try:
        question = await question_service.get_question(question_id)
        
        if not question:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Question not found"
            )
        
        return QuestionResponse(**question)
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get question: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve question"
        )

@router.get("/{question_id}/explanation", response_model=QuestionExplanationResponse)
async def get_question_explanation(
    question_id: str,
    current_user = Depends(get_current_user_dependency)
):
    """Get question explanation"""
    try:
        explanation = await question_service.get_question_explanation(
            question_id=question_id,
            user_id=current_user["id"]
        )
        
        if not explanation:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Explanation not found"
            )
        
        return QuestionExplanationResponse(**explanation)
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get explanation: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve explanation"
        )

@router.post("/attempt")
async def record_question_attempt(
    question_id: str,
    is_correct: bool,
    time_taken: float,
    current_user = Depends(get_current_user_dependency)
):
    """Record a question attempt"""
    try:
        success = await question_service.record_question_attempt(
            question_id=question_id,
            user_id=current_user["id"],
            is_correct=is_correct,
            time_taken=time_taken
        )
        
        return {"success": success}
        
    except Exception as e:
        logger.error(f"Failed to record attempt: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to record attempt"
        )

@router.post("/", response_model=str)
async def create_question(
    question_data: QuestionCreateRequest,
    current_user = Depends(get_current_user_dependency)
):
    """Create a new question (admin only)"""
    try:
        # Check if user has admin privileges
        if not current_user.get("is_admin", False):
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Admin access required"
            )
        
        question_id = await question_service.create_question(
            question_data=question_data.dict(),
            created_by=current_user["id"]
        )
        
        return question_id
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to create question: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to create question"
        )