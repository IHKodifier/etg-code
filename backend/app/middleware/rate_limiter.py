from fastapi import Request, HTTPException, status
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import JSONResponse
import time
import logging
from typing import Dict, Tuple
from app.core.config import settings

logger = logging.getLogger(__name__)

class RateLimitMiddleware(BaseHTTPMiddleware):
    """Rate limiting middleware using sliding window"""
    
    def __init__(self, app):
        super().__init__(app)
        # In-memory storage for rate limiting
        # In production, use Redis for distributed rate limiting
        self.requests: Dict[str, list] = {}
        self.max_requests = settings.RATE_LIMIT_REQUESTS
        self.window_seconds = settings.RATE_LIMIT_WINDOW
        
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
    
    def _is_rate_limited(self, client_key: str) -> Tuple[bool, int]:
        """Check if client is rate limited"""
        current_time = time.time()
        window_start = current_time - self.window_seconds
        
        # Get existing requests for this client
        if client_key not in self.requests:
            self.requests[client_key] = []
        
        client_requests = self.requests[client_key]
        
        # Remove old requests outside the window
        client_requests[:] = [req_time for req_time in client_requests if req_time > window_start]
        
        # Check if limit exceeded
        if len(client_requests) >= self.max_requests:
            # Calculate time until reset
            oldest_request = min(client_requests)
            reset_time = int(oldest_request + self.window_seconds)
            return True, reset_time
        
        # Add current request
        client_requests.append(current_time)
        return False, 0
    
    async def dispatch(self, request: Request, call_next):
        # Skip rate limiting for exempt routes
        if request.url.path in self.exempt_routes:
            response = await call_next(request)
            return response
        
        # Skip for static files
        if request.url.path.startswith("/static/"):
            response = await call_next(request)
            return response
        
        # Apply rate limiting
        client_key = self._get_client_key(request)
        is_limited, reset_time = self._is_rate_limited(client_key)
        
        if is_limited:
            return JSONResponse(
                status_code=status.HTTP_429_TOO_MANY_REQUESTS,
                content={
                    "detail": "Rate limit exceeded",
                    "reset_time": reset_time,
                    "limit": self.max_requests,
                    "window": self.window_seconds
                },
                headers={
                    "X-RateLimit-Limit": str(self.max_requests),
                    "X-RateLimit-Window": str(self.window_seconds),
                    "X-RateLimit-Reset": str(reset_time),
                    "Retry-After": str(reset_time - int(time.time()))
                }
            )
        
        # Add rate limit headers to response
        response = await call_next(request)
        
        # Get current request count
        client_requests = self.requests.get(client_key, [])
        remaining = max(0, self.max_requests - len(client_requests))
        
        response.headers["X-RateLimit-Limit"] = str(self.max_requests)
        response.headers["X-RateLimit-Remaining"] = str(remaining)
        response.headers["X-RateLimit-Window"] = str(self.window_seconds)
        
        return response