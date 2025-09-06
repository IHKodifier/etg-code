from typing import Optional, Dict, Any
from datetime import datetime, timedelta
import logging
import firebase_admin
from firebase_admin import auth as firebase_auth
from app.core.database import db
from app.core.security import (
    create_access_token,
    create_refresh_token,
    verify_password,
    get_password_hash,
    verify_token,
    verify_refresh_token,
    generate_device_fingerprint
)
from app.core.exceptions import AuthenticationError, ValidationError, ConflictError

logger = logging.getLogger(__name__)

class AuthService:
    """Authentication service for user management"""
    
    async def create_user(
        self,
        email: str,
        password: str,
        exam_type: str,
        user_data: Optional[Dict[str, Any]] = None
    ) -> Dict[str, Any]:
        """Create a new user account"""
        try:
            # Check if user already exists
            existing_users = await db.query_collection(
                "users",
                filters=[{"field": "email", "operator": "==", "value": email}]
            )
            
            if existing_users:
                raise ConflictError("User with this email already exists")
            
            # Hash password
            hashed_password = get_password_hash(password)
            
            # Prepare user data
            user_dict = {
                "email": email,
                "password_hash": hashed_password,
                "exam_type": exam_type,
                "tier": "free",  # Default tier
                "is_active": True,
                "is_verified": False,
                "created_at": datetime.utcnow(),
                "updated_at": datetime.utcnow(),
                "profile": user_data or {},
                "usage_stats": {
                    "practice_mcqs_today": 0,
                    "explanations_used_today": 0,
                    "sprint_exams_used": 0,
                    "simulated_exams_used": 0,
                    "last_reset": datetime.utcnow().date().isoformat()
                }
            }
            
            # Create user document
            user_id = await db.create_document("users", user_dict)
            
            logger.info(f"User created successfully: {user_id}")
            
            # Return user data without password
            user_dict.pop("password_hash")
            user_dict["id"] = user_id
            
            return user_dict
            
        except Exception as e:
            logger.error(f"Failed to create user: {e}")
            raise
    
    async def authenticate_user(self, email: str, password: str) -> Optional[Dict[str, Any]]:
        """Authenticate user with email and password"""
        try:
            # Get user by email
            users = await db.query_collection(
                "users",
                filters=[{"field": "email", "operator": "==", "value": email}]
            )
            
            if not users:
                return None
            
            user = users[0]
            
            # Verify password
            if not verify_password(password, user["password_hash"]):
                return None
            
            # Check if user is active
            if not user.get("is_active", True):
                raise AuthenticationError("Account is deactivated")
            
            # Remove password hash from returned data
            user.pop("password_hash", None)
            
            return user
            
        except Exception as e:
            logger.error(f"Authentication failed: {e}")
            return None
    
    async def create_anonymous_user(self, device_fingerprint: str) -> Dict[str, Any]:
        """Create anonymous user session"""
        try:
            # Check if anonymous user already exists for this device
            existing_users = await db.query_collection(
                "anonymous_users",
                filters=[{"field": "device_fingerprint", "operator": "==", "value": device_fingerprint}]
            )
            
            if existing_users:
                # Return existing anonymous user
                return existing_users[0]
            
            # Create new anonymous user
            anonymous_user = {
                "device_fingerprint": device_fingerprint,
                "tier": "anonymous",
                "is_active": True,
                "created_at": datetime.utcnow(),
                "usage_stats": {
                    "practice_mcqs_today": 0,
                    "explanations_used_today": 0,
                    "sprint_exams_used": 0,
                    "simulated_exams_used": 0,
                    "last_reset": datetime.utcnow().date().isoformat()
                }
            }
            
            user_id = await db.create_document("anonymous_users", anonymous_user)
            anonymous_user["id"] = user_id
            
            logger.info(f"Anonymous user created: {user_id}")
            
            return anonymous_user
            
        except Exception as e:
            logger.error(f"Failed to create anonymous user: {e}")
            raise
    
    async def generate_tokens(self, user_id: str) -> Dict[str, str]:
        """Generate access and refresh tokens for user"""
        access_token = create_access_token(subject=user_id)
        refresh_token = create_refresh_token(subject=user_id)
        
        return {
            "access_token": access_token,
            "refresh_token": refresh_token,
            "token_type": "bearer"
        }
    
    async def refresh_access_token(self, refresh_token: str) -> Dict[str, str]:
        """Refresh access token using refresh token"""
        user_id = verify_refresh_token(refresh_token)
        
        if not user_id:
            raise AuthenticationError("Invalid refresh token")
        
        # Generate new tokens
        new_access_token = create_access_token(subject=user_id)
        new_refresh_token = create_refresh_token(subject=user_id)
        
        return {
            "access_token": new_access_token,
            "refresh_token": new_refresh_token,
            "token_type": "bearer"
        }
    
    async def get_current_user(self, token: str) -> Optional[Dict[str, Any]]:
        """Get current user from token"""
        user_id = verify_token(token)
        
        if not user_id:
            return None
        
        # Try to get regular user first
        user = await db.get_document("users", user_id)
        if user:
            user.pop("password_hash", None)
            return user
        
        # Try anonymous user
        user = await db.get_document("anonymous_users", user_id)
        return user
    
    async def register_device(
        self,
        user_id: str,
        device_fingerprint: str,
        device_info: Dict[str, Any]
    ) -> bool:
        """Register a device for a user"""
        try:
            # Check existing devices for this user
            existing_devices = await db.query_collection(
                "user_devices",
                filters=[{"field": "user_id", "operator": "==", "value": user_id}]
            )
            
            # Check device limit (3 devices max)
            if len(existing_devices) >= 3:
                # Check if this device already exists
                for device in existing_devices:
                    if device["device_fingerprint"] == device_fingerprint:
                        # Update existing device
                        await db.update_document(
                            "user_devices",
                            device["id"],
                            {
                                "last_active": datetime.utcnow(),
                                "device_info": device_info
                            }
                        )
                        return True
                
                # Device limit exceeded
                raise ValidationError("Device limit exceeded (3 devices maximum)")
            
            # Create new device entry
            device_data = {
                "user_id": user_id,
                "device_fingerprint": device_fingerprint,
                "device_info": device_info,
                "registered_at": datetime.utcnow(),
                "last_active": datetime.utcnow(),
                "is_active": True
            }
            
            await db.create_document("user_devices", device_data)
            
            logger.info(f"Device registered for user {user_id}")
            return True
            
        except Exception as e:
            logger.error(f"Failed to register device: {e}")
            raise
    
    async def reset_daily_limits(self, user_id: str) -> bool:
        """Reset daily usage limits for user"""
        try:
            reset_data = {
                "usage_stats.practice_mcqs_today": 0,
                "usage_stats.explanations_used_today": 0,
                "usage_stats.last_reset": datetime.utcnow().date().isoformat(),
                "updated_at": datetime.utcnow()
            }
            
            # Update regular user
            await db.update_document("users", user_id, reset_data)
            
            # Also try anonymous users
            await db.update_document("anonymous_users", user_id, reset_data)
            
            return True
            
        except Exception as e:
            logger.error(f"Failed to reset daily limits: {e}")
            return False
    
    async def authenticate_with_google(
        self,
        id_token: str,
        device_info: Dict[str, Any],
        exam_type: Optional[str] = None
    ) -> Dict[str, Any]:
        """Authenticate user with Google ID token"""
        try:
            # Verify Google ID token
            decoded_token = firebase_auth.verify_id_token(id_token)
            google_uid = decoded_token['uid']
            email = decoded_token.get('email')
            name = decoded_token.get('name')
            picture = decoded_token.get('picture')
            
            if not email:
                raise AuthenticationError("Email not provided by Google")
            
            # Check if user already exists
            existing_users = await db.query_collection(
                "users",
                filters=[{"field": "email", "operator": "==", "value": email}]
            )
            
            if existing_users:
                user = existing_users[0]
                # Update last login
                await db.update_document(
                    "users",
                    user["id"],
                    {
                        "updated_at": datetime.utcnow(),
                        "google_uid": google_uid,
                        "profile.picture": picture
                    }
                )
            else:
                # Create new user
                user_dict = {
                    "email": email,
                    "google_uid": google_uid,
                    "exam_type": exam_type or "ECAT",  # Default
                    "tier": "free",
                    "is_active": True,
                    "is_verified": True,  # Google accounts are verified
                    "created_at": datetime.utcnow(),
                    "updated_at": datetime.utcnow(),
                    "profile": {
                        "name": name,
                        "picture": picture
                    },
                    "usage_stats": {
                        "practice_mcqs_today": 0,
                        "explanations_used_today": 0,
                        "sprint_exams_used": 0,
                        "simulated_exams_used": 0,
                        "last_reset": datetime.utcnow().date().isoformat()
                    }
                }
                
                user_id = await db.create_document("users", user_dict)
                user_dict["id"] = user_id
                user = user_dict
                
                logger.info(f"New Google user created: {user_id}")
            
            # Remove sensitive data
            user.pop("password_hash", None)
            user.pop("google_uid", None)
            
            return user
            
        except firebase_auth.InvalidIdTokenError:
            raise AuthenticationError("Invalid Google ID token")
        except Exception as e:
            logger.error(f"Google authentication failed: {e}")
            raise AuthenticationError("Google authentication failed")

# Global auth service instance
auth_service = AuthService()