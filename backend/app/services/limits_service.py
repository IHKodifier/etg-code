"""
Dedicated service for managing tier-based usage limits.
Handles limit validation, usage tracking, and enforcement logic.
"""

from typing import Dict, Any, Optional, Tuple, Union
from datetime import datetime, timedelta
import logging
from app.core.database import db
from app.core.limits_config import (
    get_tier_config, get_daily_limit, get_total_limit,
    get_rate_limit, is_unlimited, get_trial_period_days,
    get_max_devices, supports_device_sync, ERROR_MESSAGES,
    GRACE_PERIODS, USAGE_FIELDS
)
from app.core.exceptions import ValidationError

logger = logging.getLogger(__name__)

class LimitsService:
    """Service for managing and enforcing tier-based usage limits."""

    def __init__(self):
        self.db = db

    async def check_daily_limit(
        self,
        user_id: str,
        tier: str,
        feature: str,
        current_usage: int
    ) -> Tuple[bool, Dict[str, Any]]:
        """
        Check if user has exceeded daily limit for a feature.

        Args:
            user_id: User ID
            tier: User tier
            feature: Feature to check (e.g., 'practice_mcqs', 'explanations')
            current_usage: Current usage count

        Returns:
            Tuple of (is_allowed: bool, limit_info: dict)
        """
        try:
            limit = get_daily_limit(tier, feature)

            if is_unlimited(limit):
                return True, {
                    "allowed": True,
                    "remaining": float('inf'),
                    "limit": float('inf'),
                    "reset_time": None
                }

            remaining = max(0, limit - current_usage)
            is_allowed = current_usage < limit

            # Calculate next reset time (next midnight UTC)
            now = datetime.utcnow()
            reset_time = (now + timedelta(days=1)).replace(hour=0, minute=0, second=0, microsecond=0)

            return is_allowed, {
                "allowed": is_allowed,
                "remaining": remaining,
                "limit": limit,
                "reset_time": reset_time.isoformat(),
                "current_usage": current_usage
            }

        except Exception as e:
            logger.error(f"Error checking daily limit for user {user_id}: {e}")
            # Allow access on error to prevent blocking users
            return True, {
                "allowed": True,
                "remaining": 0,
                "limit": 0,
                "reset_time": None,
                "error": str(e)
            }

    async def check_total_limit(
        self,
        user_id: str,
        tier: str,
        feature: str,
        current_usage: int
    ) -> Tuple[bool, Dict[str, Any]]:
        """
        Check if user has exceeded total limit for a feature.

        Args:
            user_id: User ID
            tier: User tier
            feature: Feature to check
            current_usage: Current total usage

        Returns:
            Tuple of (is_allowed: bool, limit_info: dict)
        """
        try:
            limit = get_total_limit(tier, feature)

            if is_unlimited(limit):
                return True, {
                    "allowed": True,
                    "remaining": float('inf'),
                    "limit": float('inf'),
                    "current_usage": current_usage
                }

            remaining = max(0, limit - current_usage)
            is_allowed = current_usage < limit

            return is_allowed, {
                "allowed": is_allowed,
                "remaining": remaining,
                "limit": limit,
                "current_usage": current_usage
            }

        except Exception as e:
            logger.error(f"Error checking total limit for user {user_id}: {e}")
            return True, {
                "allowed": True,
                "remaining": 0,
                "limit": 0,
                "error": str(e)
            }

    async def check_device_limit(
        self,
        user_id: str,
        tier: str,
        current_device_count: int
    ) -> Tuple[bool, Dict[str, Any]]:
        """
        Check if user can register additional devices.

        Args:
            user_id: User ID
            tier: User tier
            current_device_count: Current number of registered devices

        Returns:
            Tuple of (is_allowed: bool, limit_info: dict)
        """
        try:
            max_devices = get_max_devices(tier)
            supports_sync = supports_device_sync(tier)

            if not supports_sync:
                return False, {
                    "allowed": False,
                    "reason": "Device sync not supported for this tier",
                    "max_devices": 0,
                    "current_devices": current_device_count
                }

            is_allowed = current_device_count < max_devices
            remaining = max(0, max_devices - current_device_count)

            return is_allowed, {
                "allowed": is_allowed,
                "remaining": remaining,
                "max_devices": max_devices,
                "current_devices": current_device_count
            }

        except Exception as e:
            logger.error(f"Error checking device limit for user {user_id}: {e}")
            return False, {
                "allowed": False,
                "error": str(e)
            }

    async def validate_feature_access(
        self,
        user_id: str,
        tier: str,
        feature: str,
        usage_type: str = "daily"
    ) -> Tuple[bool, Dict[str, Any]]:
        """
        Validate if user can access a specific feature.

        Args:
            user_id: User ID
            tier: User tier
            feature: Feature to validate
            usage_type: Type of usage check ('daily', 'total', 'device')

        Returns:
            Tuple of (is_allowed: bool, validation_info: dict)
        """
        try:
            # Get current user data
            user_data = await self._get_user_data(user_id)
            if not user_data:
                return False, {"error": "User not found"}

            current_usage = user_data.get("usage_stats", {}).get(feature, 0)

            if usage_type == "daily":
                return await self.check_daily_limit(user_id, tier, feature, current_usage)
            elif usage_type == "total":
                return await self.check_total_limit(user_id, tier, feature, current_usage)
            elif usage_type == "device":
                device_count = await self._get_device_count(user_id)
                return await self.check_device_limit(user_id, tier, device_count)
            else:
                return False, {"error": f"Unknown usage type: {usage_type}"}

        except Exception as e:
            logger.error(f"Error validating feature access for user {user_id}: {e}")
            return False, {"error": str(e)}

    async def record_usage(
        self,
        user_id: str,
        feature: str,
        amount: int = 1
    ) -> bool:
        """
        Record usage for a specific feature.

        Args:
            user_id: User ID
            feature: Feature to record usage for
            amount: Amount to increment (default: 1)

        Returns:
            Success status
        """
        try:
            # Determine if this is daily or total usage
            if feature in USAGE_FIELDS["daily"]:
                field_path = f"usage_stats.{feature}"
            elif feature in USAGE_FIELDS["total"]:
                field_path = f"usage_stats.{feature}"
            else:
                logger.warning(f"Unknown feature for usage tracking: {feature}")
                return False

            # Update usage in database
            update_data = {
                field_path: amount,  # This will increment the field
                "updated_at": datetime.utcnow()
            }

            # Try regular users first, then anonymous users
            success = await db.update_document("users", user_id, update_data)
            if not success:
                success = await db.update_document("anonymous_users", user_id, update_data)

            if success:
                logger.info(f"Recorded usage for user {user_id}: {feature} +{amount}")
            else:
                logger.error(f"Failed to record usage for user {user_id}: {feature}")

            return success

        except Exception as e:
            logger.error(f"Error recording usage for user {user_id}: {e}")
            return False

    async def reset_daily_limits(self, user_id: str) -> bool:
        """
        Reset daily usage limits for a user.

        Args:
            user_id: User ID

        Returns:
            Success status
        """
        try:
            reset_data = {
                "usage_stats.practice_mcqs_today": 0,
                "usage_stats.explanations_used_today": 0,
                "usage_stats.last_reset": datetime.utcnow().date().isoformat(),
                "updated_at": datetime.utcnow()
            }

            # Reset for both regular and anonymous users
            success = await db.update_document("users", user_id, reset_data)
            if not success:
                success = await db.update_document("anonymous_users", user_id, reset_data)

            if success:
                logger.info(f"Reset daily limits for user {user_id}")
            else:
                logger.warning(f"Failed to reset daily limits for user {user_id}")

            return success

        except Exception as e:
            logger.error(f"Error resetting daily limits for user {user_id}: {e}")
            return False

    async def get_usage_summary(self, user_id: str, tier: str) -> Dict[str, Any]:
        """
        Get comprehensive usage summary for a user.

        Args:
            user_id: User ID
            tier: User tier

        Returns:
            Usage summary dictionary
        """
        try:
            user_data = await self._get_user_data(user_id)
            if not user_data:
                return {"error": "User not found"}

            usage_stats = user_data.get("usage_stats", {})
            summary = {
                "user_id": user_id,
                "tier": tier,
                "daily_usage": {},
                "total_usage": {},
                "limits": {},
                "device_info": {}
            }

            # Get daily limits and usage
            for feature in USAGE_FIELDS["daily"]:
                current_usage = usage_stats.get(feature, 0)
                _, limit_info = await self.check_daily_limit(user_id, tier, feature, current_usage)
                summary["daily_usage"][feature] = {
                    "current": current_usage,
                    "limit": limit_info.get("limit"),
                    "remaining": limit_info.get("remaining"),
                    "reset_time": limit_info.get("reset_time")
                }

            # Get total limits and usage
            for feature in USAGE_FIELDS["total"]:
                current_usage = usage_stats.get(feature, 0)
                _, limit_info = await self.check_total_limit(user_id, tier, feature, current_usage)
                summary["total_usage"][feature] = {
                    "current": current_usage,
                    "limit": limit_info.get("limit"),
                    "remaining": limit_info.get("remaining")
                }

            # Get device information
            device_count = await self._get_device_count(user_id)
            _, device_info = await self.check_device_limit(user_id, tier, device_count)
            summary["device_info"] = device_info

            return summary

        except Exception as e:
            logger.error(f"Error getting usage summary for user {user_id}: {e}")
            return {"error": str(e)}

    async def _get_user_data(self, user_id: str) -> Optional[Dict[str, Any]]:
        """Get user data from database."""
        try:
            # Try regular users first
            user_data = await db.get_document("users", user_id)
            if user_data:
                return user_data

            # Try anonymous users
            user_data = await db.get_document("anonymous_users", user_id)
            return user_data

        except Exception as e:
            logger.error(f"Error getting user data for {user_id}: {e}")
            return None

    async def _get_device_count(self, user_id: str) -> int:
        """Get count of devices registered for a user."""
        try:
            devices = await db.query_collection(
                "user_devices",
                filters=[{"field": "user_id", "operator": "==", "value": user_id}]
            )
            return len(devices)
        except Exception as e:
            logger.error(f"Error getting device count for user {user_id}: {e}")
            return 0

# Global limits service instance
limits_service = LimitsService()