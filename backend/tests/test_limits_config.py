"""
Unit tests for tier-based limits configuration.
"""

import pytest
from app.core.limits_config import (
    TIER_LIMITS, get_tier_config, get_daily_limit, get_total_limit,
    get_rate_limit, is_unlimited, get_trial_period_days,
    get_max_devices, supports_device_sync, validate_tier,
    validate_feature, AVAILABLE_TIERS, DEFAULT_TIER
)


class TestLimitsConfig:
    """Test cases for limits configuration functions."""

    def test_available_tiers(self):
        """Test that all expected tiers are available."""
        expected_tiers = ["anonymous", "free", "paid"]
        assert set(AVAILABLE_TIERS) == set(expected_tiers)

    def test_default_tier(self):
        """Test default tier is set correctly."""
        assert DEFAULT_TIER == "free"

    def test_get_tier_config_valid(self):
        """Test getting configuration for valid tiers."""
        for tier in AVAILABLE_TIERS:
            config = get_tier_config(tier)
            assert isinstance(config, dict)
            assert "name" in config
            assert "description" in config
            assert "daily_limits" in config
            assert "total_limits" in config
            assert "features" in config
            assert "rate_limits" in config

    def test_get_tier_config_invalid(self):
        """Test getting configuration for invalid tier raises error."""
        with pytest.raises(ValueError, match="Unknown tier"):
            get_tier_config("invalid_tier")

    def test_get_daily_limit_anonymous(self):
        """Test daily limits for anonymous tier."""
        assert get_daily_limit("anonymous", "practice_mcqs") == 20
        assert get_daily_limit("anonymous", "explanations") == 2

    def test_get_daily_limit_free(self):
        """Test daily limits for free tier."""
        assert get_daily_limit("free", "practice_mcqs") == 50
        assert get_daily_limit("free", "explanations") == 4

    def test_get_daily_limit_paid(self):
        """Test daily limits for paid tier."""
        assert get_daily_limit("paid", "practice_mcqs") == float('inf')
        assert get_daily_limit("paid", "explanations") == 100

    def test_get_total_limit_anonymous(self):
        """Test total limits for anonymous tier."""
        assert get_total_limit("anonymous", "sprint_exams") == 1
        assert get_total_limit("anonymous", "simulated_exams") == 1

    def test_get_total_limit_free(self):
        """Test total limits for free tier."""
        assert get_total_limit("free", "sprint_exams") == 4
        assert get_total_limit("free", "simulated_exams") == 2

    def test_get_total_limit_paid(self):
        """Test total limits for paid tier."""
        assert get_total_limit("paid", "sprint_exams") == float('inf')
        assert get_total_limit("paid", "simulated_exams") == float('inf')

    def test_get_rate_limit_anonymous(self):
        """Test rate limits for anonymous tier."""
        assert get_rate_limit("anonymous", "requests_per_minute") == 30
        assert get_rate_limit("anonymous", "requests_per_hour") == 100

    def test_get_rate_limit_free(self):
        """Test rate limits for free tier."""
        assert get_rate_limit("free", "requests_per_minute") == 60
        assert get_rate_limit("free", "requests_per_hour") == 500

    def test_get_rate_limit_paid(self):
        """Test rate limits for paid tier."""
        assert get_rate_limit("paid", "requests_per_minute") == 300
        assert get_rate_limit("paid", "requests_per_hour") == 5000

    def test_is_unlimited(self):
        """Test unlimited limit detection."""
        assert is_unlimited(float('inf')) is True
        assert is_unlimited(100) is False
        assert is_unlimited(0) is False

    def test_get_trial_period_days(self):
        """Test trial period days for different tiers."""
        assert get_trial_period_days("anonymous") == 0
        assert get_trial_period_days("free") == 14
        assert get_trial_period_days("paid") == 0

    def test_get_max_devices(self):
        """Test maximum devices for different tiers."""
        assert get_max_devices("anonymous") == 0
        assert get_max_devices("free") == 1
        assert get_max_devices("paid") == 3

    def test_supports_device_sync(self):
        """Test device sync support for different tiers."""
        assert supports_device_sync("anonymous") is False
        assert supports_device_sync("free") is True
        assert supports_device_sync("paid") is True

    def test_validate_tier(self):
        """Test tier validation."""
        for tier in AVAILABLE_TIERS:
            assert validate_tier(tier) is True

        assert validate_tier("invalid_tier") is False

    def test_validate_feature_daily(self):
        """Test feature validation for daily limits."""
        assert validate_feature("anonymous", "practice_mcqs") is True
        assert validate_feature("free", "explanations") is True
        assert validate_feature("paid", "practice_mcqs") is True

    def test_validate_feature_total(self):
        """Test feature validation for total limits."""
        assert validate_feature("anonymous", "sprint_exams") is True
        assert validate_feature("free", "simulated_exams") is True
        assert validate_feature("paid", "sprint_exams") is True

    def test_validate_feature_invalid(self):
        """Test feature validation for invalid features."""
        assert validate_feature("anonymous", "invalid_feature") is False

    def test_tier_config_structure(self):
        """Test that tier configurations have required structure."""
        for tier in AVAILABLE_TIERS:
            config = TIER_LIMITS[tier]

            # Check required top-level keys
            required_keys = ["name", "description", "daily_limits", "total_limits", "features", "rate_limits"]
            for key in required_keys:
                assert key in config, f"Tier {tier} missing required key: {key}"

            # Check daily limits structure
            assert "practice_mcqs" in config["daily_limits"]
            assert "explanations" in config["daily_limits"]

            # Check total limits structure
            assert "sprint_exams" in config["total_limits"]
            assert "simulated_exams" in config["total_limits"]

            # Check features structure
            assert "device_sync" in config["features"]
            assert "max_devices" in config["features"]

            # Check rate limits structure
            assert "requests_per_minute" in config["rate_limits"]
            assert "requests_per_hour" in config["rate_limits"]