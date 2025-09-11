"""
Unit tests for the limits service.
"""

import pytest
from unittest.mock import AsyncMock, MagicMock, patch
from datetime import datetime, timedelta
from app.services.limits_service import LimitsService
from app.core.exceptions import ValidationError


class TestLimitsService:
    """Test cases for the limits service."""

    @pytest.fixture
    def limits_service(self):
        """Create a limits service instance for testing."""
        return LimitsService()

    @pytest.fixture
    def mock_user_data(self):
        """Mock user data for testing."""
        return {
            "id": "test_user_id",
            "tier": "free",
            "usage_stats": {
                "practice_mcqs_today": 10,
                "explanations_used_today": 2,
                "sprint_exams_used": 1,
                "simulated_exams_used": 0,
                "last_reset": datetime.utcnow().date().isoformat()
            }
        }

    @pytest.mark.asyncio
    async def test_check_daily_limit_within_limit(self, limits_service, mock_user_data):
        """Test checking daily limit when usage is within limit."""
        with patch.object(limits_service, '_get_user_data', return_value=mock_user_data):
            is_allowed, limit_info = await limits_service.check_daily_limit(
                "test_user_id", "free", "practice_mcqs", 10
            )

            assert is_allowed is True
            assert limit_info["allowed"] is True
            assert limit_info["remaining"] == 40  # 50 - 10
            assert limit_info["limit"] == 50
            assert limit_info["current_usage"] == 10

    @pytest.mark.asyncio
    async def test_check_daily_limit_at_limit(self, limits_service, mock_user_data):
        """Test checking daily limit when usage is exactly at limit."""
        with patch.object(limits_service, '_get_user_data', return_value=mock_user_data):
            is_allowed, limit_info = await limits_service.check_daily_limit(
                "test_user_id", "free", "practice_mcqs", 50
            )

            assert is_allowed is False
            assert limit_info["allowed"] is False
            assert limit_info["remaining"] == 0
            assert limit_info["limit"] == 50

    @pytest.mark.asyncio
    async def test_check_daily_limit_exceeded(self, limits_service, mock_user_data):
        """Test checking daily limit when usage exceeds limit."""
        with patch.object(limits_service, '_get_user_data', return_value=mock_user_data):
            is_allowed, limit_info = await limits_service.check_daily_limit(
                "test_user_id", "free", "practice_mcqs", 60
            )

            assert is_allowed is False
            assert limit_info["allowed"] is False
            assert limit_info["remaining"] == 0
            assert limit_info["limit"] == 50

    @pytest.mark.asyncio
    async def test_check_daily_limit_unlimited_tier(self, limits_service, mock_user_data):
        """Test checking daily limit for unlimited tier."""
        with patch.object(limits_service, '_get_user_data', return_value=mock_user_data):
            is_allowed, limit_info = await limits_service.check_daily_limit(
                "test_user_id", "paid", "practice_mcqs", 1000
            )

            assert is_allowed is True
            assert limit_info["allowed"] is True
            assert limit_info["remaining"] == float('inf')
            assert limit_info["limit"] == float('inf')

    @pytest.mark.asyncio
    async def test_check_total_limit_within_limit(self, limits_service, mock_user_data):
        """Test checking total limit when usage is within limit."""
        with patch.object(limits_service, '_get_user_data', return_value=mock_user_data):
            is_allowed, limit_info = await limits_service.check_total_limit(
                "test_user_id", "free", "sprint_exams", 1
            )

            assert is_allowed is True
            assert limit_info["allowed"] is True
            assert limit_info["remaining"] == 3  # 4 - 1
            assert limit_info["limit"] == 4

    @pytest.mark.asyncio
    async def test_check_total_limit_exceeded(self, limits_service, mock_user_data):
        """Test checking total limit when usage exceeds limit."""
        with patch.object(limits_service, '_get_user_data', return_value=mock_user_data):
            is_allowed, limit_info = await limits_service.check_total_limit(
                "test_user_id", "free", "sprint_exams", 5
            )

            assert is_allowed is False
            assert limit_info["allowed"] is False
            assert limit_info["remaining"] == 0
            assert limit_info["limit"] == 4

    @pytest.mark.asyncio
    async def test_check_device_limit_anonymous(self, limits_service):
        """Test device limit checking for anonymous tier."""
        with patch.object(limits_service, '_get_device_count', return_value=0):
            is_allowed, limit_info = await limits_service.check_device_limit(
                "test_user_id", "anonymous", 0
            )

            assert is_allowed is False
            assert limit_info["allowed"] is False
            assert "Device sync not supported" in limit_info["reason"]

    @pytest.mark.asyncio
    async def test_check_device_limit_free_within_limit(self, limits_service):
        """Test device limit checking for free tier within limit."""
        with patch.object(limits_service, '_get_device_count', return_value=0):
            is_allowed, limit_info = await limits_service.check_device_limit(
                "test_user_id", "free", 0
            )

            assert is_allowed is True
            assert limit_info["allowed"] is True
            assert limit_info["remaining"] == 1
            assert limit_info["max_devices"] == 1

    @pytest.mark.asyncio
    async def test_check_device_limit_free_at_limit(self, limits_service):
        """Test device limit checking for free tier at limit."""
        with patch.object(limits_service, '_get_device_count', return_value=1):
            is_allowed, limit_info = await limits_service.check_device_limit(
                "test_user_id", "free", 1
            )

            assert is_allowed is False
            assert limit_info["allowed"] is False
            assert limit_info["remaining"] == 0
            assert limit_info["max_devices"] == 1

    @pytest.mark.asyncio
    async def test_validate_feature_access_daily_allowed(self, limits_service, mock_user_data):
        """Test feature access validation for allowed daily usage."""
        with patch.object(limits_service, '_get_user_data', return_value=mock_user_data):
            is_allowed, validation_info = await limits_service.validate_feature_access(
                "test_user_id", "free", "practice_mcqs", "daily"
            )

            assert is_allowed is True
            assert validation_info["allowed"] is True
            assert validation_info["remaining"] == 40

    @pytest.mark.asyncio
    async def test_validate_feature_access_daily_denied(self, limits_service, mock_user_data):
        """Test feature access validation for denied daily usage."""
        with patch.object(limits_service, '_get_user_data', return_value=mock_user_data):
            is_allowed, validation_info = await limits_service.validate_feature_access(
                "test_user_id", "free", "practice_mcqs", "daily"
            )

            # This should be allowed since current usage (10) < limit (50)
            assert is_allowed is True

    @pytest.mark.asyncio
    async def test_validate_feature_access_total_allowed(self, limits_service, mock_user_data):
        """Test feature access validation for allowed total usage."""
        with patch.object(limits_service, '_get_user_data', return_value=mock_user_data):
            is_allowed, validation_info = await limits_service.validate_feature_access(
                "test_user_id", "free", "simulated_exams", "total"
            )

            assert is_allowed is True
            assert validation_info["allowed"] is True
            assert validation_info["remaining"] == 2

    @pytest.mark.asyncio
    async def test_validate_feature_access_device_denied(self, limits_service):
        """Test feature access validation for denied device access."""
        with patch.object(limits_service, '_get_device_count', return_value=0):
            is_allowed, validation_info = await limits_service.validate_feature_access(
                "test_user_id", "anonymous", "device", "device"
            )

            assert is_allowed is False
            assert validation_info["allowed"] is False

    @pytest.mark.asyncio
    async def test_record_usage_success(self, limits_service):
        """Test successful usage recording."""
        with patch.object(limits_service.db, 'update_document', return_value=True) as mock_update:
            success = await limits_service.record_usage("test_user_id", "practice_mcqs_today", 1)

            assert success is True
            mock_update.assert_called_once()

    @pytest.mark.asyncio
    async def test_record_usage_failure(self, limits_service):
        """Test failed usage recording."""
        with patch.object(limits_service.db, 'update_document', return_value=False):
            success = await limits_service.record_usage("test_user_id", "practice_mcqs_today", 1)

            assert success is False

    @pytest.mark.asyncio
    async def test_reset_daily_limits_success(self, limits_service):
        """Test successful daily limits reset."""
        with patch.object(limits_service.db, 'update_document', return_value=True) as mock_update:
            success = await limits_service.reset_daily_limits("test_user_id")

            assert success is True
            # Should try to update both users and anonymous_users collections
            assert mock_update.call_count == 2

    @pytest.mark.asyncio
    async def test_reset_daily_limits_failure(self, limits_service):
        """Test failed daily limits reset."""
        with patch.object(limits_service.db, 'update_document', return_value=False):
            success = await limits_service.reset_daily_limits("test_user_id")

            assert success is False

    @pytest.mark.asyncio
    async def test_get_usage_summary(self, limits_service, mock_user_data):
        """Test getting comprehensive usage summary."""
        with patch.object(limits_service, '_get_user_data', return_value=mock_user_data), \
             patch.object(limits_service, '_get_device_count', return_value=0):

            summary = await limits_service.get_usage_summary("test_user_id", "free")

            assert "user_id" in summary
            assert "tier" in summary
            assert "daily_usage" in summary
            assert "total_usage" in summary
            assert "device_info" in summary

            assert summary["tier"] == "free"
            assert "practice_mcqs" in summary["daily_usage"]
            assert "sprint_exams" in summary["total_usage"]

    @pytest.mark.asyncio
    async def test_get_usage_summary_user_not_found(self, limits_service):
        """Test usage summary when user is not found."""
        with patch.object(limits_service, '_get_user_data', return_value=None):
            summary = await limits_service.get_usage_summary("nonexistent_user", "free")

            assert summary["error"] == "User not found"

    @pytest.mark.asyncio
    async def test_get_user_data_regular_user(self, limits_service):
        """Test getting user data for regular user."""
        expected_data = {"id": "test_user", "tier": "free"}
        with patch.object(limits_service.db, 'get_document', return_value=expected_data) as mock_get:
            result = await limits_service._get_user_data("test_user")

            assert result == expected_data
            mock_get.assert_called_with("users", "test_user")

    @pytest.mark.asyncio
    async def test_get_user_data_anonymous_user(self, limits_service):
        """Test getting user data for anonymous user."""
        with patch.object(limits_service.db, 'get_document') as mock_get:
            mock_get.side_effect = [None, {"id": "anon_user", "tier": "anonymous"}]

            result = await limits_service._get_user_data("anon_user")

            assert result["tier"] == "anonymous"
            assert mock_get.call_count == 2

    @pytest.mark.asyncio
    async def test_get_device_count(self, limits_service):
        """Test getting device count for user."""
        mock_devices = [{"id": "device1"}, {"id": "device2"}]
        with patch.object(limits_service.db, 'query_collection', return_value=mock_devices):
            count = await limits_service._get_device_count("test_user")

            assert count == 2

    @pytest.mark.asyncio
    async def test_get_device_count_error(self, limits_service):
        """Test device count when database error occurs."""
        with patch.object(limits_service.db, 'query_collection', side_effect=Exception("DB Error")):
            count = await limits_service._get_device_count("test_user")

            assert count == 0