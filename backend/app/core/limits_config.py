"""
Centralized configuration for tier-based usage limits.
This file contains all limit definitions and business rules for different user tiers.
"""

from typing import Dict, Any, Union
from datetime import timedelta

# Tier definitions with their limits
TIER_LIMITS = {
    "anonymous": {
        "name": "Anonymous User",
        "description": "Limited access for guest users",
        "daily_limits": {
            "practice_mcqs": 20,
            "explanations": 2,
        },
        "total_limits": {
            "sprint_exams": 1,
            "simulated_exams": 1,  # half-length SRE
        },
        "features": {
            "device_sync": False,
            "max_devices": 0,
        },
        "rate_limits": {
            "requests_per_minute": 30,
            "requests_per_hour": 100,
        }
    },
    "free": {
        "name": "Free User",
        "description": "Basic access with trial period",
        "daily_limits": {
            "practice_mcqs": 50,
            "explanations": 4,
        },
        "total_limits": {
            "sprint_exams": 4,
            "simulated_exams": 2,  # full-length SRE
        },
        "trial_period_days": 14,
        "features": {
            "device_sync": True,
            "max_devices": 1,
        },
        "rate_limits": {
            "requests_per_minute": 60,
            "requests_per_hour": 500,
        }
    },
    "paid": {
        "name": "Paid User",
        "description": "Full access with premium features",
        "daily_limits": {
            "practice_mcqs": float('inf'),  # unlimited
            "explanations": 100,  # fair usage cap
        },
        "total_limits": {
            "sprint_exams": float('inf'),  # unlimited
            "simulated_exams": float('inf'),  # unlimited
        },
        "features": {
            "device_sync": True,
            "max_devices": 3,
        },
        "rate_limits": {
            "requests_per_minute": 300,
            "requests_per_hour": 5000,
        }
    }
}

# Reset schedules
RESET_SCHEDULES = {
    "daily": {
        "hour": 0,  # Midnight UTC
        "minute": 0,
    },
    "weekly": {
        "weekday": 0,  # Monday
        "hour": 0,
        "minute": 0,
    },
    "monthly": {
        "day": 1,  # First day of month
        "hour": 0,
        "minute": 0,
    }
}

# Usage tracking fields that need to be monitored
USAGE_FIELDS = {
    "daily": [
        "practice_mcqs_today",
        "explanations_used_today",
    ],
    "total": [
        "sprint_exams_used",
        "simulated_exams_used",
    ]
}

# Error messages for limit exceeded scenarios
ERROR_MESSAGES = {
    "daily_limit_exceeded": "Daily limit exceeded for {feature}. Reset at {reset_time}.",
    "total_limit_exceeded": "Total limit exceeded for {feature}. Upgrade to continue.",
    "rate_limit_exceeded": "Too many requests. Please wait {retry_after} seconds.",
    "device_limit_exceeded": "Device limit exceeded ({current}/{max}). Remove a device to continue.",
    "trial_expired": "Free trial expired. Upgrade to continue using premium features.",
}

# Grace periods for different scenarios (in seconds)
GRACE_PERIODS = {
    "daily_reset_buffer": 300,  # 5 minutes buffer before daily reset
    "rate_limit_cooldown": 60,  # 1 minute cooldown after rate limit
}

def get_tier_config(tier: str) -> Dict[str, Any]:
    """Get configuration for a specific tier."""
    if tier not in TIER_LIMITS:
        raise ValueError(f"Unknown tier: {tier}")
    return TIER_LIMITS[tier]

def get_daily_limit(tier: str, feature: str) -> Union[int, float]:
    """Get daily limit for a specific tier and feature."""
    config = get_tier_config(tier)
    return config["daily_limits"].get(feature, 0)

def get_total_limit(tier: str, feature: str) -> Union[int, float]:
    """Get total limit for a specific tier and feature."""
    config = get_tier_config(tier)
    return config["total_limits"].get(feature, 0)

def get_rate_limit(tier: str, period: str) -> int:
    """Get rate limit for a specific tier and period."""
    config = get_tier_config(tier)
    return config["rate_limits"].get(period, 60)

def is_unlimited(value: Union[int, float]) -> bool:
    """Check if a limit value represents unlimited access."""
    return value == float('inf')

def get_trial_period_days(tier: str) -> int:
    """Get trial period in days for a tier."""
    config = get_tier_config(tier)
    return config.get("trial_period_days", 0)

def get_max_devices(tier: str) -> int:
    """Get maximum number of devices allowed for a tier."""
    config = get_tier_config(tier)
    return config["features"].get("max_devices", 0)

def supports_device_sync(tier: str) -> bool:
    """Check if a tier supports device synchronization."""
    config = get_tier_config(tier)
    return config["features"].get("device_sync", False)

# Validation functions
def validate_tier(tier: str) -> bool:
    """Validate if a tier exists in the configuration."""
    return tier in TIER_LIMITS

def validate_feature(tier: str, feature: str) -> bool:
    """Validate if a feature exists for a given tier."""
    config = get_tier_config(tier)
    return (feature in config.get("daily_limits", {}) or
            feature in config.get("total_limits", {}))

# Available tiers list
AVAILABLE_TIERS = list(TIER_LIMITS.keys())

# Default tier for new users
DEFAULT_TIER = "free"