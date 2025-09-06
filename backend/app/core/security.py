from datetime import datetime, timedelta
from typing import Any, Union, Optional
from jose import jwt, JWTError
from passlib.context import CryptContext
import hashlib
import secrets
from app.core.config import settings

# Password hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def create_access_token(
    subject: Union[str, Any], expires_delta: Optional[timedelta] = None
) -> str:
    """Create JWT access token"""
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(
            minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES
        )
    
    to_encode = {"exp": expire, "sub": str(subject), "type": "access"}
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
    return encoded_jwt

def create_refresh_token(
    subject: Union[str, Any], expires_delta: Optional[timedelta] = None
) -> str:
    """Create JWT refresh token"""
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(
            days=settings.REFRESH_TOKEN_EXPIRE_DAYS
        )
    
    to_encode = {"exp": expire, "sub": str(subject), "type": "refresh"}
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
    return encoded_jwt

def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verify password against hash"""
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password: str) -> str:
    """Generate password hash"""
    return pwd_context.hash(password)

def verify_token(token: str) -> Optional[str]:
    """Verify JWT token and return subject"""
    try:
        payload = jwt.decode(
            token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM]
        )
        user_id: str = payload.get("sub")
        token_type: str = payload.get("type")
        
        if user_id is None or token_type != "access":
            return None
        return user_id
    except JWTError:
        return None

def verify_refresh_token(token: str) -> Optional[str]:
    """Verify JWT refresh token and return subject"""
    try:
        payload = jwt.decode(
            token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM]
        )
        user_id: str = payload.get("sub")
        token_type: str = payload.get("type")
        
        if user_id is None or token_type != "refresh":
            return None
        return user_id
    except JWTError:
        return None

def generate_device_fingerprint(
    user_agent: str,
    ip_address: str,
    screen_resolution: Optional[str] = None,
    timezone: Optional[str] = None
) -> str:
    """Generate device fingerprint for device tracking"""
    fingerprint_data = f"{user_agent}:{ip_address}"
    
    if screen_resolution:
        fingerprint_data += f":{screen_resolution}"
    if timezone:
        fingerprint_data += f":{timezone}"
    
    return hashlib.sha256(fingerprint_data.encode()).hexdigest()

def generate_api_key() -> str:
    """Generate secure API key"""
    return secrets.token_urlsafe(32)

def generate_otp() -> str:
    """Generate 6-digit OTP"""
    return secrets.randbelow(900000) + 100000

def hash_string(value: str, salt: Optional[str] = None) -> str:
    """Hash string with optional salt"""
    if salt:
        value = f"{value}:{salt}"
    return hashlib.sha256(value.encode()).hexdigest()

def verify_string_hash(value: str, hash_value: str, salt: Optional[str] = None) -> bool:
    """Verify string against hash"""
    return hash_string(value, salt) == hash_value