"""
Unit tests for the tier-aware rate limiter middleware.
"""

import pytest
from unittest.mock import MagicMock, AsyncMock, patch
from fastapi import Request
from starlette.responses import JSONResponse
from app.middleware.rate_limiter import RateLimitMiddleware
from app.core.limits_config import get_rate_limit


class TestRateLimitMiddleware:
    """Test cases for the tier-aware rate limiter middleware."""

    @pytest.fixture
    def middleware(self):
        """Create a rate limiter middleware instance for testing."""
        # Mock app
        mock_app = MagicMock()
        mock_app.return_value = None

        middleware = RateLimitMiddleware(mock_app)
        return middleware

    def test_init(self, middleware):
        """Test middleware initialization."""
        assert hasattr(middleware, 'requests')
        assert hasattr(middleware, 'fallback_max_requests')
        assert hasattr(middleware, 'fallback_window_seconds')
        assert hasattr(middleware, 'exempt_routes')

    def test_get_client_key_authenticated_user(self, middleware):
        """Test client key generation for authenticated user."""
        # Mock request with user_id
        mock_request = MagicMock(spec=Request)
        mock_request.client.host = "192.168.1.1"
        mock_request.state.user_id = "user123"

        key = middleware._get_client_key(mock_request)
        assert key == "user:user123"

    def test_get_client_key_unauthenticated_user(self, middleware):
        """Test client key generation for unauthenticated user."""
        # Mock request without user_id
        mock_request = MagicMock(spec=Request)
        mock_request.client.host = "192.168.1.1"
        mock_request.state.user_id = None

        key = middleware._get_client_key(mock_request)
        assert key == "ip:192.168.1.1"

    def test_get_user_tier_from_request(self, middleware):
        """Test getting user tier from request state."""
        # Mock request with user_tier
        mock_request = MagicMock(spec=Request)
        mock_request.state.user_tier = "paid"

        tier = middleware._get_user_tier(mock_request)
        assert tier == "paid"

    def test_get_user_tier_default(self, middleware):
        """Test getting default user tier when not set."""
        # Mock request without user_tier
        mock_request = MagicMock(spec=Request)
        mock_request.state.user_tier = None

        tier = middleware._get_user_tier(mock_request)
        assert tier == "free"  # DEFAULT_TIER

    def test_get_user_tier_error_fallback(self, middleware):
        """Test user tier fallback on error."""
        # Mock request that raises error when accessing state
        mock_request = MagicMock(spec=Request)
        mock_request.state = MagicMock()
        mock_request.state.user_tier = MagicMock(side_effect=AttributeError)

        tier = middleware._get_user_tier(mock_request)
        assert tier == "free"  # DEFAULT_TIER

    def test_is_rate_limited_within_limit(self, middleware):
        """Test rate limiting when within limit."""
        client_key = "user:test_user"
        tier = "free"

        # First request should be allowed
        is_limited, reset_time, limit, window = middleware._is_rate_limited(client_key, tier)

        assert is_limited is False
        assert reset_time == 0
        assert limit == get_rate_limit(tier, "requests_per_minute")
        assert window == 60

    def test_is_rate_limited_exceeded(self, middleware):
        """Test rate limiting when limit exceeded."""
        client_key = "user:test_user"
        tier = "anonymous"  # Lower limit for testing

        # Make requests up to the limit
        limit_value = get_rate_limit(tier, "requests_per_minute")
        for i in range(limit_value):
            middleware._is_rate_limited(client_key, tier)

        # Next request should be limited
        is_limited, reset_time, limit, window = middleware._is_rate_limited(client_key, tier)

        assert is_limited is True
        assert reset_time > 0
        assert limit == limit_value
        assert window == 60

    def test_is_rate_limited_different_tiers(self, middleware):
        """Test that different tiers have different limits."""
        client_key_free = "user:free_user"
        client_key_paid = "user:paid_user"

        # Free tier limit
        _, _, free_limit, _ = middleware._is_rate_limited(client_key_free, "free")

        # Paid tier limit
        _, _, paid_limit, _ = middleware._is_rate_limited(client_key_paid, "paid")

        assert free_limit != paid_limit
        assert paid_limit > free_limit  # Paid should have higher limit

    def test_is_rate_limited_fallback_on_error(self, middleware):
        """Test fallback to default limits when tier config fails."""
        client_key = "user:test_user"

        # Mock get_rate_limit to raise an exception
        with patch('app.middleware.rate_limiter.get_rate_limit', side_effect=Exception("Config error")):
            is_limited, reset_time, limit, window = middleware._is_rate_limited(client_key, "invalid_tier")

            # Should use fallback values
            assert limit == middleware.fallback_max_requests
            assert window == middleware.fallback_window_seconds

    @pytest.mark.asyncio
    async def test_dispatch_exempt_route(self, middleware):
        """Test that exempt routes are not rate limited."""
        # Mock request for exempt route
        mock_request = MagicMock(spec=Request)
        mock_request.url.path = "/health"
        mock_request.client.host = "192.168.1.1"

        # Mock call_next
        mock_response = MagicMock()
        call_next = AsyncMock(return_value=mock_response)

        response = await middleware.dispatch(mock_request, call_next)

        # Should return response without rate limiting
        assert response == mock_response
        call_next.assert_called_once_with(mock_request)

    @pytest.mark.asyncio
    async def test_dispatch_static_file(self, middleware):
        """Test that static files are not rate limited."""
        # Mock request for static file
        mock_request = MagicMock(spec=Request)
        mock_request.url.path = "/static/app.js"
        mock_request.client.host = "192.168.1.1"

        # Mock call_next
        mock_response = MagicMock()
        call_next = AsyncMock(return_value=mock_response)

        response = await middleware.dispatch(mock_request, call_next)

        # Should return response without rate limiting
        assert response == mock_response
        call_next.assert_called_once_with(mock_request)

    @pytest.mark.asyncio
    async def test_dispatch_within_limit(self, middleware):
        """Test successful request within rate limit."""
        # Mock request
        mock_request = MagicMock(spec=Request)
        mock_request.url.path = "/api/questions"
        mock_request.client.host = "192.168.1.1"
        mock_request.state.user_id = "test_user"
        mock_request.state.user_tier = "free"

        # Mock call_next
        mock_response = MagicMock()
        mock_response.headers = {}
        call_next = AsyncMock(return_value=mock_response)

        response = await middleware.dispatch(mock_request, call_next)

        # Should return response with rate limit headers
        assert response == mock_response
        assert "X-RateLimit-Limit" in response.headers
        assert "X-RateLimit-Remaining" in response.headers
        assert "X-RateLimit-Window" in response.headers
        assert "X-RateLimit-Tier" in response.headers

    @pytest.mark.asyncio
    async def test_dispatch_rate_limited(self, middleware):
        """Test rate limited request returns 429 response."""
        # Mock request
        mock_request = MagicMock(spec=Request)
        mock_request.url.path = "/api/questions"
        mock_request.client.host = "192.168.1.1"
        mock_request.state.user_id = "test_user"
        mock_request.state.user_tier = "anonymous"  # Low limit for testing

        # Exhaust the rate limit
        client_key = "user:test_user"
        limit_value = get_rate_limit("anonymous", "requests_per_minute")
        for i in range(limit_value):
            middleware._is_rate_limited(client_key, "anonymous")

        # Mock call_next (shouldn't be called due to rate limiting)
        call_next = AsyncMock()

        response = await middleware.dispatch(mock_request, call_next)

        # Should return 429 response
        assert isinstance(response, JSONResponse)
        assert response.status_code == 429

        response_data = response.body
        assert "detail" in response_data
        assert "tier" in response_data
        assert "reset_time" in response_data
        assert "limit" in response_data

        # Check response headers
        assert response.headers["X-RateLimit-Limit"] == str(limit_value)
        assert "X-RateLimit-Tier" in response.headers
        assert "Retry-After" in response.headers

        # call_next should not have been called
        call_next.assert_not_called()

    @pytest.mark.asyncio
    async def test_dispatch_unauthenticated_user(self, middleware):
        """Test rate limiting for unauthenticated users."""
        # Mock request without user authentication
        mock_request = MagicMock(spec=Request)
        mock_request.url.path = "/api/questions"
        mock_request.client.host = "192.168.1.1"
        mock_request.state.user_id = None
        mock_request.state.user_tier = None

        # Mock call_next
        mock_response = MagicMock()
        mock_response.headers = {}
        call_next = AsyncMock(return_value=mock_response)

        response = await middleware.dispatch(mock_request, call_next)

        # Should use IP-based key and default tier
        assert response == mock_response
        assert "X-RateLimit-Tier" in response.headers
        assert response.headers["X-RateLimit-Tier"] == "free"  # DEFAULT_TIER

    def test_exempt_routes_list(self, middleware):
        """Test that exempt routes are properly configured."""
        expected_exempt = {"/health", "/docs", "/redoc", "/openapi.json"}
        assert middleware.exempt_routes == expected_exempt

    def test_multiple_clients_isolated(self, middleware):
        """Test that different clients have isolated rate limits."""
        client1_key = "user:user1"
        client2_key = "user:user2"

        # User1 makes requests
        for i in range(5):
            middleware._is_rate_limited(client1_key, "free")

        # User2 should not be affected
        is_limited, _, _, _ = middleware._is_rate_limited(client2_key, "free")
        assert is_limited is False

    def test_rate_limit_reset_over_time(self, middleware):
        """Test that rate limits reset over time (sliding window)."""
        import time

        client_key = "user:test_user"
        tier = "anonymous"

        # Make requests up to limit
        limit_value = get_rate_limit(tier, "requests_per_minute")
        for i in range(limit_value):
            middleware._is_rate_limited(client_key, tier)

        # Next request should be limited
        is_limited, _, _, _ = middleware._is_rate_limited(client_key, tier)
        assert is_limited is True

        # Simulate time passing (clear the requests to simulate window moving)
        middleware.requests[client_key] = []

        # Next request should be allowed again
        is_limited, _, _, _ = middleware._is_rate_limited(client_key, tier)
        assert is_limited is False