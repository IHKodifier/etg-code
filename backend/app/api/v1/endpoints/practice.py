from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import HTTPBearer
from typing import Dict, Any
import logging

from app.services.auth_service import auth_service

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

@router.get("/")
async def get_practice_sessions(
    current_user = Depends(get_current_user_dependency)
):
    """Get user's practice sessions"""
    # TODO: Implement practice session retrieval
    return {"message": "Practice sessions endpoint - to be implemented"}

@router.post("/session")
async def create_practice_session(
    session_data: Dict[str, Any],
    current_user = Depends(get_current_user_dependency)
):
    """Create a new practice session"""
    # TODO: Implement practice session creation
    return {"message": "Create practice session - to be implemented"}

@router.put("/session/{session_id}")
async def update_practice_session(
    session_id: str,
    session_data: Dict[str, Any],
    current_user = Depends(get_current_user_dependency)
):
    """Update practice session"""
    # TODO: Implement practice session update
    return {"message": "Update practice session - to be implemented"}