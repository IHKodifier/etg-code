from fastapi import Request, HTTPException, status
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import JSONResponse
import time
import logging
from typing import Dict, Tuple, Optional
from app.core.config import settings
from app.services.limits_service import limits_service
from app.core.limits_config import get_rate_limit, DEFAULT_TIER

logger = logging.getLogger(__name__)

class RateLimitMiddleware(BaseHTTPMiddleware):
    """Tier-aware rate limiting middleware using sliding window"""

    def __init__(self, app):
        super().__init__(app)
        # In-memory storage for rate limiting
        # In production, use Redis for distributed rate limiting
        self.requests: Dict[str, list] = {}
        # Keep fallback values for backward compatibility
        self.fallback_max_requests = settings.RATE_LIMIT_REQUESTS
        self.fallback_window_seconds = settings.RATE_LIMIT_WINDOW
        
        # Routes exempt from rate limiting
        self.exempt_routes = {
            "/health",
            "/docs",
            "/redoc",
            "/openapi.json"
        }
    
    def _get_client_key(self, request: Request) -> str:
        """Get unique client identifier for rate limiting"""
        # Use IP address as default
        client_ip = request.client.host

        # If authenticated, use user ID for better rate limiting
        user_id = getattr(request.state, 'user_id', None)
        if user_id:
            return f"user:{user_id}"

        return f"ip:{client_ip}"

    def _get_user_tier(self, request: Request) -> str:
        """Get user's tier from request state, fallback to default"""
        try:
            user_tier = getattr(request.state, 'user_tier', None)
            return user_tier if user_tier else DEFAULT_TIER
        except Exception:
            return DEFAULT_TIER

    def _is_rate_limited(self, client_key: str, tier: str) -> Tuple[bool, int, int, int]:
        """
        Check if client is rate limited based on their tier.

        Returns:
            Tuple of (is_limited: bool, reset_time: int, limit: int, window: int)
        """
        try:
            # Get tier-specific rate limits
            max_requests = get_rate_limit(tier, "requests_per_minute")
            window_seconds = 60  # 1 minute window for per-minute limits

            # For hourly limits, use a different window
            if "hour" in client_key:
                max_requests = get_rate_limit(tier, "requests_per_hour")
                window_seconds = 3600  # 1 hour window

        except Exception as e:
            logger.warning(f"Error getting tier limits for {tier}, using fallback: {e}")
            # Fallback to original settings
            max_requests = self.fallback_max_requests
            window_seconds = self.fallback_window_seconds

        current_time = time.time()
        window_start = current_time - window_seconds

        # Get existing requests for this client
        if client_key not in self.requests:
            self.requests[client_key] = []

        client_requests = self.requests[client_key]

        # Remove old requests outside the window
        client_requests[:] = [req_time for req_time in client_requests if req_time > window_start]

        # Check if limit exceeded
        if len(client_requests) >= max_requests:
            # Calculate time until reset
            oldest_request = min(client_requests)
            reset_time = int(oldest_request + window_seconds)
            return True, reset_time, max_requests, window_seconds

        # Add current request
        client_requests.append(current_time)
        return False, 0, max_requests, window_seconds
    
    async def dispatch(self, request: Request, call_next):
        # Skip rate limiting for exempt routes
        if request.url.path in self.exempt_routes:
            response = await call_next(request)
            return response

        # Skip for static files
        if request.url.path.startswith("/static/"):
            response = await call_next(request)
            return response

        # Get user tier and apply tier-aware rate limiting
        client_key = self._get_client_key(request)
        user_tier = self._get_user_tier(request)

        is_limited, reset_time, limit, window = self._is_rate_limited(client_key, user_tier)

        if is_limited:
            return JSONResponse(
                status_code=status.HTTP_429_TOO_MANY_REQUESTS,
                content={
                    "detail": "Rate limit exceeded",
                    "tier": user_tier,
                    "reset_time": reset_time,
                    "limit": limit,
                    "window": window,
                    "retry_after": reset_time - int(time.time())
                },
                headers={
                    "X-RateLimit-Limit": str(limit),
                    "X-RateLimit-Window": str(window),
                    "X-RateLimit-Reset": str(reset_time),
                    "X-RateLimit-Tier": user_tier,
                    "Retry-After": str(reset_time - int(time.time()))
                }
            )

        # Add rate limit headers to response
        response = await call_next(request)

        # Get current request count for headers
        client_requests = self.requests.get(client_key, [])
        remaining = max(0, limit - len(client_requests))

        response.headers["X-RateLimit-Limit"] = str(limit)
        response.headers["X-RateLimit-Remaining"] = str(remaining)
        response.headers["X-RateLimit-Window"] = str(window)
        response.headers["X-RateLimit-Tier"] = user_tier

        return response