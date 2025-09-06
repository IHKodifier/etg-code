from pydantic import BaseModel, EmailStr, validator
from typing import Optional, Dict, Any
from datetime import datetime

class UserCreateRequest(BaseModel):
    email: EmailStr
    password: str
    exam_type: str
    device_info: Dict[str, Any] = {}
    profile: Optional[Dict[str, Any]] = None
    
    @validator('password')
    def validate_password(cls, v):
        if len(v) < 8:
            raise ValueError('Password must be at least 8 characters long')
        return v
    
    @validator('exam_type')
    def validate_exam_type(cls, v):
        allowed_types = ['ECAT', 'MCAT', 'CCAT', 'GMAT', 'GRE', 'SAT']
        if v not in allowed_types:
            raise ValueError(f'Exam type must be one of: {", ".join(allowed_types)}')
        return v

class UserLoginRequest(BaseModel):
    email: EmailStr
    password: str

class UserResponse(BaseModel):
    id: str
    email: Optional[str] = None
    exam_type: Optional[str] = None
    tier: str
    is_active: bool
    is_verified: Optional[bool] = None
    created_at: datetime
    profile: Dict[str, Any] = {}
    usage_stats: Dict[str, Any] = {}
    
    class Config:
        from_attributes = True

class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    user: UserResponse

class DeviceRegistrationRequest(BaseModel):
    device_info: Dict[str, Any]

class RefreshTokenRequest(BaseModel):
    refresh_token: str

class GoogleAuthRequest(BaseModel):
    id_token: str
    device_info: Dict[str, Any] = {}
    exam_type: Optional[str] = None