from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import HTTPBearer
from typing import Dict, Any, List
import logging

from app.services.auth_service import auth_service
from app.services.question_service import question_service

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

@router.post("/sprint")
async def create_sprint_exam(
    exam_config: Dict[str, Any],
    current_user = Depends(get_current_user_dependency)
):
    """Create a sprint exam (5-50 questions)"""
    try:
        question_count = exam_config.get("question_count", 10)
        exam_type = exam_config.get("exam_type")
        
        if not exam_type:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Exam type is required"
            )
        
        if question_count < 5 or question_count > 50:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Question count must be between 5 and 50"
            )
        
        questions = await question_service.get_questions_for_exam(
            exam_type=exam_type,
            question_count=question_count,
            arde_priority=exam_config.get("arde_priority", True)
        )
        
        return {
            "exam_id": f"sprint_{current_user['id']}_{exam_type}",
            "questions": questions,
            "exam_config": exam_config
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to create sprint exam: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to create sprint exam"
        )

@router.post("/simulated")
async def create_simulated_exam(
    exam_config: Dict[str, Any],
    current_user = Depends(get_current_user_dependency)
):
    """Create a simulated real exam (SRE)"""
    try:
        exam_type = exam_config.get("exam_type")
        
        if not exam_type:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Exam type is required"
            )
        
        # Define official exam patterns
        exam_patterns = {
            "ECAT": {"question_count": 100, "time_minutes": 100},
            "MCAT": {"question_count": 200, "time_minutes": 150},
            "CCAT": {"question_count": 80, "time_minutes": 90},
            "SAT": {"question_count": 154, "time_minutes": 180},
            "GMAT": {"question_count": 80, "time_minutes": 210},
            "GRE": {"question_count": 80, "time_minutes": 180}
        }
        
        pattern = exam_patterns.get(exam_type)
        if not pattern:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Unsupported exam type"
            )
        
        questions = await question_service.get_questions_for_exam(
            exam_type=exam_type,
            question_count=pattern["question_count"],
            arde_priority=True
        )
        
        return {
            "exam_id": f"sre_{current_user['id']}_{exam_type}",
            "questions": questions,
            "exam_pattern": pattern,
            "instructions": f"This simulates the actual {exam_type} exam pattern"
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to create simulated exam: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to create simulated exam"
        )

@router.get("/results")
async def get_exam_results(
    current_user = Depends(get_current_user_dependency)
):
    """Get user's exam results"""
    # TODO: Implement exam results retrieval
    return {"message": "Exam results endpoint - to be implemented"}

@router.post("/submit")
async def submit_exam(
    exam_data: Dict[str, Any],
    current_user = Depends(get_current_user_dependency)
):
    """Submit exam for grading"""
    # TODO: Implement exam submission and grading
    return {"message": "Exam submission endpoint - to be implemented"}