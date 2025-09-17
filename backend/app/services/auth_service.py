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
        role: str = "regularUser",
        tier: str = "free",
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
            
            # Calculate trial/subscription expiry dates using limits config
            from app.core.limits_config import get_trial_period_days

            trial_expiry = None
            subscription_expiry = None

            if tier == "anonymous":
                # Use trial period from config (14 days for anonymous)
                trial_days = get_trial_period_days("anonymous") or 14
                trial_expiry = datetime.utcnow() + timedelta(days=trial_days)
            elif tier == "free":
                # Use trial period from config (14 days for free)
                trial_days = get_trial_period_days("free") or 14
                trial_expiry = datetime.utcnow() + timedelta(days=trial_days)
            elif tier == "paid":
                # 1-year subscription for paid users (this would be updated by payment system)
                subscription_expiry = datetime.utcnow() + timedelta(days=365)

            # Prepare user data
            user_dict = {
                "email": email,
                "password_hash": hashed_password,
                "exam_type": exam_type,
                "role": role,
                "tier": tier,
                "trial_expiry": trial_expiry,
                "subscription_expiry": subscription_expiry,
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
            
            # Calculate trial expiry (2 weeks for anonymous users)
            trial_expiry = datetime.utcnow() + timedelta(days=14)

            # Create new anonymous user
            anonymous_user = {
                "device_fingerprint": device_fingerprint,
                "role": "regularUser",
                "tier": "anonymous",
                "trial_expiry": trial_expiry,
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
        exam_type: Optional[str] = None,
        role: str = "regularUser",
        tier: str = "free"
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
                # Calculate trial/subscription expiry dates
                trial_expiry = None
                subscription_expiry = None

                if tier == "anonymous":
                    trial_expiry = datetime.utcnow() + timedelta(days=14)
                elif tier == "pro":
                    subscription_expiry = datetime.utcnow() + timedelta(days=365)

                # Create new user
                user_dict = {
                    "email": email,
                    "google_uid": google_uid,
                    "exam_type": exam_type or "ECAT",  # Default
                    "role": role,
                    "tier": tier,
                    "trial_expiry": trial_expiry,
                    "subscription_expiry": subscription_expiry,
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

    async def upgrade_anonymous_to_registered(
        self,
        anonymous_user_id: str,
        email: str,
        password: str,
        exam_type: str
    ) -> Dict[str, Any]:
        """Upgrade anonymous user to registered account"""
        try:
            # Verify anonymous user exists
            anonymous_user = await self.get_current_user(anonymous_user_id)
            if not anonymous_user or anonymous_user.get("tier") != "anonymous":
                raise ValidationError("Invalid anonymous user")

            # Create registered user
            registered_user = await self.create_user(
                email=email,
                password=password,
                exam_type=exam_type,
                role="regularUser",
                tier="free"
            )

            # TODO: Migrate data from anonymous to registered user
            # This would include bookmarks, attempt history, preferences, etc.

            logger.info(f"Anonymous user {anonymous_user_id} upgraded to registered user {registered_user['id']}")
            return registered_user

        except Exception as e:
            logger.error(f"Failed to upgrade anonymous user: {e}")
            raise

    async def upgrade_to_pro_tier(self, user_id: str) -> Dict[str, Any]:
        """Upgrade user to pro tier"""
        try:
            # Get current user
            user = await self.get_current_user(user_id)
            if not user:
                raise ValidationError("User not found")

            if user.get("tier") != "free":
                raise ValidationError("Only free tier users can upgrade to pro")

            # Calculate subscription expiry (1 year from now)
            from datetime import timedelta
            subscription_expiry = datetime.utcnow() + timedelta(days=365)

            # Update user in database
            await self.db.update_document(
                "users",
                user_id,
                {
                    "tier": "pro",
                    "subscription_expiry": subscription_expiry,
                    "updated_at": datetime.utcnow()
                }
            )

            logger.info(f"User {user_id} upgraded to pro tier")
            return {
                "tier": "pro",
                "subscription_expiry": subscription_expiry,
                "message": "Successfully upgraded to pro tier"
            }

        except Exception as e:
            logger.error(f"Failed to upgrade user to pro tier: {e}")
            raise

    async def get_subscription_status(self, user_id: str) -> Dict[str, Any]:
        """Get user's subscription status"""
        try:
            user = await self.get_current_user(user_id)
            if not user:
                raise ValidationError("User not found")

            user_tier = user.get("tier", "free")
            subscription_expiry = user.get("subscription_expiry")
            trial_expiry = user.get("trial_expiry")

            # Check expiry status
            now = datetime.utcnow()
            is_trial_expired = False
            is_subscription_expired = False

            if user_tier == "anonymous" and trial_expiry:
                if isinstance(trial_expiry, str):
                    trial_expiry = datetime.fromisoformat(trial_expiry.replace('Z', '+00:00'))
                is_trial_expired = now > trial_expiry

            if user_tier == "pro" and subscription_expiry:
                if isinstance(subscription_expiry, str):
                    subscription_expiry = datetime.fromisoformat(subscription_expiry.replace('Z', '+00:00'))
                is_subscription_expired = now > subscription_expiry

            return {
                "tier": user_tier,
                "role": user.get("role", "regularUser"),
                "trial_expiry": trial_expiry.isoformat() if trial_expiry else None,
                "subscription_expiry": subscription_expiry.isoformat() if subscription_expiry else None,
                "is_trial_expired": is_trial_expired,
                "is_subscription_expired": is_subscription_expired,
                "can_upgrade": user_tier in ["anonymous", "free"]
            }

        except Exception as e:
            logger.error(f"Failed to get subscription status: {e}")
            raise

    async def get_usage_limits(self, user_id: str) -> Dict[str, Any]:
        """Get user's usage limits"""
        try:
            user = await self.get_current_user(user_id)
            if not user:
                raise ValidationError("User not found")

            user_tier = user.get("tier", "free")
            usage_stats = user.get("usage_stats", {})

            limits = {
                "tier": user_tier,
                "daily_question_limit": None,
                "questions_used_today": usage_stats.get("practice_mcqs_today", 0),
                "remaining_questions": None,
                "unlimited": False
            }

            if user_tier == "anonymous":
                limits["daily_question_limit"] = 10
                limits["remaining_questions"] = max(0, 10 - usage_stats.get("practice_mcqs_today", 0))
            elif user_tier == "free":
                limits["daily_question_limit"] = 50
                limits["remaining_questions"] = max(0, 50 - usage_stats.get("practice_mcqs_today", 0))
            elif user_tier == "pro":
                limits["unlimited"] = True

            return limits

        except Exception as e:
            logger.error(f"Failed to get usage limits: {e}")
            raise

# Global auth service instance
auth_service = AuthService()