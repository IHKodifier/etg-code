from typing import Any, Dict, Optional, List

class ETGException(Exception):
    """Base exception for EntryTestGuru API"""
    message: str = "An error occurred"

    def __init__(self, message: str = None):
        if message:
            self.message = message
        super().__init__(self.message)

class ValidationError(ETGException):
    """Validation error exception"""
    
    def __init__(self, message: str = "Validation error", errors: Optional[List[Dict[str, Any]]] = None):
        self.message = message
        self.errors = errors or []
        super().__init__(self.message)

class AuthenticationError(ETGException):
    """Authentication error exception"""
    message = "Authentication failed"

class AuthorizationError(ETGException):
    """Authorization error exception"""
    message = "Not authorized to access this resource"

class NotFoundError(ETGException):
    """Resource not found error"""
    message = "Resource not found"

class ConflictError(ETGException):
    """Resource conflict error"""
    message = "Resource already exists or conflicts with existing data"

class RateLimitError(ETGException):
    """Rate limit exceeded error"""
    message = "Rate limit exceeded. Please try again later"

class InternalServerError(ETGException):
    """Internal server error"""
    message = "An internal server error occurred"

class ExternalServiceError(ETGException):
    """External service error"""
    message = "External service is unavailable"

class FileUploadError(ETGException):
    """File upload error"""
    message = "File upload failed"

class DatabaseError(ETGException):
    """Database operation error"""
    message = "Database operation failed"