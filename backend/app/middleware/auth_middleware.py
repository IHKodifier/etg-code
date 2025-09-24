from fastapi import Request, HTTPException, status
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import JSONResponse
import logging

from app.core.security import verify_token

logger = logging.getLogger(__name__)

class AuthMiddleware(BaseHTTPMiddleware):
    """Authentication middleware for protected routes"""
    
    def __init__(self, app):
        super().__init__(app)
        # Routes that don't require authentication
        self.public_routes = {
            "/",
            "/health",
            "/docs",
            "/redoc",
            "/openapi.json",
            "/api/v1/auth/login",
            "/api/v1/auth/register",
            "/api/v1/auth/anonymous",
            "/api/v1/auth/refresh",
            # Temporarily allow questions list for development
            "/api/v1/questions",
            "/api/v1/questions/",
        }

        # Add dynamic bulk upload progress and summary routes
        # These will be checked with startswith logic
        self.bulk_upload_prefixes = [
            "/api/v1/questions/bulk-upload",
        ]
    
    async def dispatch(self, request: Request, call_next):
        logger.info(f"Auth middleware: {request.method} {request.url.path}")

        # Skip auth for bulk upload dynamic routes (progress, summary, cancel) - check first
        for prefix in self.bulk_upload_prefixes:
            logger.info(f"Checking prefix '{prefix}' against path '{request.url.path}'")
            if request.url.path.startswith(prefix):
                logger.info(f"Skipping auth for bulk upload route: {request.url.path}")
                response = await call_next(request)
                return response

        # Skip auth for public routes
        if request.url.path in self.public_routes:
            logger.info(f"Skipping auth for public route: {request.url.path}")
            response = await call_next(request)
            return response

        # Skip auth for static files
        if request.url.path.startswith("/static/"):
            response = await call_next(request)
            return response
        
        # For protected routes, validate token
        if request.url.path.startswith("/api/"):
            auth_header = request.headers.get("authorization")
            
            if not auth_header or not auth_header.startswith("Bearer "):
                return JSONResponse(
                    status_code=status.HTTP_401_UNAUTHORIZED,
                    content={"detail": "Authorization header required"}
                )
            
            token = auth_header.replace("Bearer ", "")
            user_id = verify_token(token)
            
            if not user_id:
                return JSONResponse(
                    status_code=status.HTTP_401_UNAUTHORIZED,
                    content={"detail": "Invalid or expired token"}
                )
            
            # Add user_id to request state
            request.state.user_id = user_id
        
        response = await call_next(request)
        return response