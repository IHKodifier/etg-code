from fastapi import APIRouter, Depends, HTTPException, status, Request
from fastapi.security import HTTPBearer
from typing import Dict, Any
import logging

from app.services.auth_service import auth_service
from app.models.auth import (
    UserCreateRequest,
    UserLoginRequest,
    TokenResponse,
    UserResponse,
    DeviceRegistrationRequest,
    GoogleAuthRequest
)
from app.core.exceptions import AuthenticationError, ValidationError, ConflictError
from app.core.security import generate_device_fingerprint

router = APIRouter()
security = HTTPBearer(auto_error=False)
logger = logging.getLogger(__name__)

@router.post("/register", response_model=UserResponse)
async def register_user(
    request: Request,
    user_data: UserCreateRequest
):
    """Register a new user"""
    try:
        user = await auth_service.create_user(
            email=user_data.email,
            password=user_data.password,
            exam_type=user_data.exam_type,
            user_data=user_data.profile
        )
        
        # Register device
        device_fingerprint = generate_device_fingerprint(
            user_agent=request.headers.get("user-agent", ""),
            ip_address=request.client.host,
            screen_resolution=user_data.device_info.get("screen_resolution"),
            timezone=user_data.device_info.get("timezone")
        )
        
        await auth_service.register_device(
            user_id=user["id"],
            device_fingerprint=device_fingerprint,
            device_info=user_data.device_info
        )
        
        return UserResponse(**user)
        
    except ConflictError as e:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail=str(e)
        )
    except ValidationError as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e)
        )
    except Exception as e:
        logger.error(f"Registration failed: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Registration failed"
        )

@router.post("/login", response_model=TokenResponse)
async def login(
    request: Request,
    login_data: UserLoginRequest
):
    """Login user"""
    try:
        user = await auth_service.authenticate_user(
            email=login_data.email,
            password=login_data.password
        )
        
        if not user:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid credentials"
            )
        
        # Generate tokens
        tokens = await auth_service.generate_tokens(user["id"])
        
        return TokenResponse(
            access_token=tokens["access_token"],
            refresh_token=tokens["refresh_token"],
            token_type=tokens["token_type"],
            user=UserResponse(**user)
        )
        
    except AuthenticationError as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=str(e)
        )
    except Exception as e:
        logger.error(f"Login failed: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Login failed"
        )

@router.post("/anonymous", response_model=TokenResponse)
async def anonymous_login(
    request: Request,
    device_info: Dict[str, Any] = {}
):
    """Create anonymous user session"""
    try:
        device_fingerprint = generate_device_fingerprint(
            user_agent=request.headers.get("user-agent", ""),
            ip_address=request.client.host,
            screen_resolution=device_info.get("screen_resolution"),
            timezone=device_info.get("timezone")
        )
        
        user = await auth_service.create_anonymous_user(device_fingerprint)
        tokens = await auth_service.generate_tokens(user["id"])
        
        return TokenResponse(
            access_token=tokens["access_token"],
            refresh_token=tokens["refresh_token"],
            token_type=tokens["token_type"],
            user=UserResponse(**user)
        )
        
    except Exception as e:
        logger.error(f"Anonymous login failed: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Anonymous login failed"
        )

@router.post("/refresh", response_model=Dict[str, str])
async def refresh_token(refresh_token: str):
    """Refresh access token"""
    try:
        tokens = await auth_service.refresh_access_token(refresh_token)
        return tokens
        
    except AuthenticationError as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=str(e)
        )

@router.get("/me", response_model=UserResponse)
async def get_current_user(token: str = Depends(security)):
    """Get current user info"""
    try:
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
        
        return UserResponse(**user)
        
    except Exception as e:
        logger.error(f"Get current user failed: {e}")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Authentication failed"
        )

@router.post("/device/register")
async def register_device(
    request: Request,
    device_data: DeviceRegistrationRequest,
    token: str = Depends(security)
):
    """Register a new device for the user"""
    try:
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
        
        device_fingerprint = generate_device_fingerprint(
            user_agent=request.headers.get("user-agent", ""),
            ip_address=request.client.host,
            screen_resolution=device_data.device_info.get("screen_resolution"),
            timezone=device_data.device_info.get("timezone")
        )
        
        success = await auth_service.register_device(
            user_id=user["id"],
            device_fingerprint=device_fingerprint,
            device_info=device_data.device_info
        )
        
        return {"success": success}
        
    except ValidationError as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e)
        )
    except Exception as e:
        logger.error(f"Device registration failed: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Device registration failed"
        )

@router.post("/google", response_model=TokenResponse)
async def google_auth(
    request: Request,
    google_data: GoogleAuthRequest
):
    """Authenticate with Google ID token"""
    try:
        user = await auth_service.authenticate_with_google(
            id_token=google_data.id_token,
            device_info=google_data.device_info,
            exam_type=google_data.exam_type
        )
        
        # Register device
        device_fingerprint = generate_device_fingerprint(
            user_agent=request.headers.get("user-agent", ""),
            ip_address=request.client.host,
            screen_resolution=google_data.device_info.get("screen_resolution"),
            timezone=google_data.device_info.get("timezone")
        )
        
        await auth_service.register_device(
            user_id=user["id"],
            device_fingerprint=device_fingerprint,
            device_info=google_data.device_info
        )
        
        # Generate tokens
        tokens = await auth_service.generate_tokens(user["id"])
        
        return TokenResponse(
            access_token=tokens["access_token"],
            refresh_token=tokens["refresh_token"],
            token_type=tokens["token_type"],
            user=UserResponse(**user)
        )
        
    except AuthenticationError as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=str(e)
        )
    except Exception as e:
        logger.error(f"Google authentication failed: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Google authentication failed"
        )