#!/usr/bin/env python3
"""
FastAPI server with Firebase Authentication integration
Supports both mock authentication and Firebase ID token validation
"""

try:
    from fastapi import FastAPI, HTTPException, Request, Depends
    from fastapi.middleware.cors import CORSMiddleware
    from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
    from pydantic import BaseModel
    import uvicorn
    import json
    from datetime import datetime
    from typing import Dict, Any, Optional
except ImportError as e:
    print(f"Missing required package: {e}")
    print("Please install: pip install fastapi uvicorn pydantic")
    exit(1)

# Firebase Admin SDK (optional, fallback to mock if not available)
try:
    import firebase_admin
    from firebase_admin import credentials, auth
    FIREBASE_AVAILABLE = True
    print("Firebase Admin SDK available - real authentication enabled")
except ImportError:
    FIREBASE_AVAILABLE = False
    print("Firebase Admin SDK not available - using mock authentication")

# Simple models for testing
class UserLogin(BaseModel):
    email: str
    password: str

class UserRegister(BaseModel):
    email: str
    password: str
    exam_type: str
    device_info: Dict[str, Any] = {}
    profile: Optional[Dict[str, Any]] = None

class GoogleAuth(BaseModel):
    id_token: str
    device_info: Dict[str, Any] = {}
    exam_type: Optional[str] = None

class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str
    user: Dict[str, Any]

class FirebaseTokenValidation(BaseModel):
    id_token: str

# Initialize Firebase Admin SDK if available
if FIREBASE_AVAILABLE:
    try:
        # Try to initialize Firebase Admin SDK
        # In production, you would use a service account key file
        # For demo purposes, we'll try to initialize without credentials
        # This will work if default credentials are configured
        if not firebase_admin._apps:
            # You can also initialize with a service account key:
            # cred = credentials.Certificate("path/to/serviceAccountKey.json")
            # firebase_admin.initialize_app(cred)
            firebase_admin.initialize_app()
        print("Firebase Admin SDK initialized successfully")
    except Exception as e:
        print(f"Firebase Admin SDK initialization failed: {e}")
        FIREBASE_AVAILABLE = False

# Security scheme for Bearer tokens
security = HTTPBearer()

# Create FastAPI app
app = FastAPI(
    title="EntryTestGuru API",
    description="API for EntryTestGuru with Firebase Authentication",
    version="1.0.0"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins for testing
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Mock data store (in-memory for testing)
users_db = {}
anonymous_users = {}

def generate_mock_tokens(user_id: str) -> Dict[str, str]:
    """Generate mock JWT tokens"""
    return {
        "access_token": f"mock_access_token_{user_id}_{datetime.now().timestamp()}",
        "refresh_token": f"mock_refresh_token_{user_id}_{datetime.now().timestamp()}",
        "token_type": "bearer"
    }

async def verify_firebase_token(credentials: HTTPAuthorizationCredentials = Depends(security)) -> Dict[str, Any]:
    """Verify Firebase ID token and return decoded token"""
    if not FIREBASE_AVAILABLE:
        # Fallback to mock validation for testing
        return await mock_token_validation(credentials)
    
    try:
        # Extract the token from the Authorization header
        token = credentials.credentials
        
        # Verify the Firebase ID token
        decoded_token = auth.verify_id_token(token)
        return decoded_token
    except Exception as e:
        print(f"Firebase token verification failed: {e}")
        raise HTTPException(status_code=401, detail="Invalid authentication token")

async def mock_token_validation(credentials: HTTPAuthorizationCredentials) -> Dict[str, Any]:
    """Mock token validation for testing when Firebase is not available"""
    token = credentials.credentials
    
    # Simple mock validation - check if it's a mock token format
    if token.startswith("mock_access_token_"):
        try:
            # Extract user_id from mock token
            parts = token.split("_")
            if len(parts) >= 4:
                user_id = parts[3]
                
                # Find user in either regular or anonymous users
                for user_data in users_db.values():
                    if user_data["id"] == user_id:
                        return {"uid": user_id, "email": user_data.get("email")}
                
                if user_id in anonymous_users:
                    return {"uid": user_id, "email": None}
        except Exception:
            pass
    
    raise HTTPException(status_code=401, detail="Invalid authentication token")

def firebase_user_to_app_user(firebase_user: Dict[str, Any], exam_type: str = None) -> Dict[str, Any]:
    """Convert Firebase user data to app user format"""
    return {
        "id": firebase_user.get("uid"),
        "email": firebase_user.get("email"),
        "exam_type": exam_type,
        "tier": "free",
        "is_active": True,
        "is_verified": firebase_user.get("email_verified", False),
        "created_at": datetime.now().isoformat(),
        "profile": {
            "displayName": firebase_user.get("name"),
            "photoURL": firebase_user.get("picture"),
            "phoneNumber": firebase_user.get("phone_number"),
        },
        "usage_stats": {
            "practice_mcqs_today": 0,
            "explanations_used_today": 0,
            "sprint_exams_used": 0,
            "simulated_exams_used": 0,
            "last_reset": datetime.now().date().isoformat()
        }
    }

def create_mock_user(email: str = None, exam_type: str = "ECAT") -> Dict[str, Any]:
    """Create a mock user"""
    user_id = f"user_{len(users_db) + 1}"
    return {
        "id": user_id,
        "email": email,
        "exam_type": exam_type,
        "tier": "free",
        "is_active": True,
        "is_verified": True,
        "created_at": datetime.now().isoformat(),
        "profile": {},
        "usage_stats": {
            "practice_mcqs_today": 0,
            "explanations_used_today": 0,
            "sprint_exams_used": 0,
            "simulated_exams_used": 0,
            "last_reset": datetime.now().date().isoformat()
        }
    }

# Root endpoints
@app.get("/")
async def root():
    return {
        "message": "EntryTestGuru API is running",
        "version": "1.0.0",
        "environment": "development",
        "docs": "/docs"
    }

@app.get("/health")
async def health_check():
    return {
        "status": "healthy",
        "service": "entrytestguru-api",
        "version": "1.0.0",
        "timestamp": datetime.now().isoformat()
    }

# Auth endpoints
@app.post("/api/v1/auth/register")
async def register(user_data: UserRegister):
    """Mock user registration"""
    print(f"📝 Registration attempt for email: {user_data.email}")
    
    if user_data.email in users_db:
        print(f"❌ User already exists: {user_data.email}")
        raise HTTPException(status_code=409, detail="User with this email already exists")
    
    user = create_mock_user(user_data.email, user_data.exam_type)
    stored_user_data = {**user, "password": user_data.password}  # Store password for mock auth
    users_db[user_data.email] = stored_user_data
    
    print(f"✅ User registered successfully:")
    print(f"   Email: {user_data.email}")
    print(f"   Password stored: '{user_data.password}'")
    print(f"   User ID: {user['id']}")
    
    return user

@app.post("/api/v1/auth/login")
async def login(login_data: UserLogin):
    """Mock user login"""
    print(f"🔐 Login attempt for email: {login_data.email}")
    
    if login_data.email not in users_db:
        print(f"❌ User not found: {login_data.email}")
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    stored_user = users_db[login_data.email]
    stored_password = stored_user.get("password", "")
    provided_password = login_data.password
    
    print(f"🔍 Password comparison:")
    print(f"   Stored password: '{stored_password}'")
    print(f"   Provided password: '{provided_password}'")
    print(f"   Match: {stored_password == provided_password}")
    
    if stored_password != provided_password:
        print(f"❌ Password mismatch for user: {login_data.email}")
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    print(f"✅ Login successful for user: {login_data.email}")
    tokens = generate_mock_tokens(stored_user["id"])
    user = {k: v for k, v in stored_user.items() if k != "password"}  # Remove password
    
    return {
        **tokens,
        "user": user
    }

@app.post("/api/v1/auth/google")
async def google_auth(google_data: GoogleAuth):
    """Mock Google authentication"""
    # Mock Google ID token validation
    mock_email = f"google_user_{len(users_db) + 1}@gmail.com"
    
    user = create_mock_user(mock_email, google_data.exam_type or "ECAT")
    users_db[mock_email] = user
    
    tokens = generate_mock_tokens(user["id"])
    
    return {
        **tokens,
        "user": user
    }

@app.post("/api/v1/auth/anonymous")
async def anonymous_login(device_info: Dict[str, Any] = {}):
    """Mock anonymous user session"""
    user_id = f"anon_{len(anonymous_users) + 1}"
    user = {
        "id": user_id,
        "email": None,
        "exam_type": None,
        "tier": "anonymous",
        "is_active": True,
        "is_verified": None,
        "created_at": datetime.now().isoformat(),
        "profile": {},
        "usage_stats": {
            "practice_mcqs_today": 0,
            "explanations_used_today": 0,
            "sprint_exams_used": 0,
            "simulated_exams_used": 0,
            "last_reset": datetime.now().date().isoformat()
        }
    }
    
    anonymous_users[user_id] = user
    tokens = generate_mock_tokens(user_id)
    
    return {
        **tokens,
        "user": user
    }

@app.post("/api/v1/auth/refresh")
async def refresh_token(refresh_token_data: Dict[str, str]):
    """Mock token refresh"""
    refresh_token = refresh_token_data.get("refresh_token")
    if not refresh_token or not refresh_token.startswith("mock_refresh_token"):
        raise HTTPException(status_code=401, detail="Invalid refresh token")
    
    # Extract user_id from mock token
    try:
        user_id = refresh_token.split("_")[3]
        tokens = generate_mock_tokens(user_id)
        return tokens
    except:
        raise HTTPException(status_code=401, detail="Invalid refresh token")

@app.get("/api/v1/auth/me")
async def get_current_user(firebase_user: Dict[str, Any] = Depends(verify_firebase_token)):
    """Get current authenticated user"""
    try:
        # Convert Firebase user to app user format
        user_data = firebase_user_to_app_user(firebase_user)
        print(f"✅ Current user retrieved: {user_data['id']}")
        return user_data
    except Exception as e:
        print(f"❌ Get current user failed: {e}")
        raise HTTPException(status_code=500, detail=f"Failed to get user: {str(e)}")

@app.post("/api/v1/auth/firebase/validate")
async def validate_firebase_token(token_data: FirebaseTokenValidation):
    """Validate Firebase ID token and return user data"""
    if not FIREBASE_AVAILABLE:
        raise HTTPException(status_code=501, detail="Firebase authentication not configured")
    
    try:
        decoded_token = auth.verify_id_token(token_data.id_token)
        user_data = firebase_user_to_app_user(decoded_token)
        
        print(f"✅ Firebase token validated for user: {user_data['id']}")
        return {
            "valid": True,
            "user": user_data,
            "token_data": {
                "uid": decoded_token.get("uid"),
                "email": decoded_token.get("email"),
                "email_verified": decoded_token.get("email_verified"),
                "provider": decoded_token.get("firebase", {}).get("sign_in_provider"),
            }
        }
    except Exception as e:
        print(f"❌ Firebase token validation failed: {e}")
        raise HTTPException(status_code=401, detail="Invalid Firebase token")

# Additional mock endpoints
@app.get("/api/v1/questions/practice")
async def get_practice_questions():
    """Mock practice questions endpoint"""
    return {
        "message": "Practice questions endpoint",
        "status": "Mock implementation",
        "note": "Connect to your question service for real data"
    }

if __name__ == "__main__":
    print("🚀 Starting EntryTestGuru Test API Server...")
    print("📖 API Docs: http://localhost:8000/docs")
    print("🔍 Health Check: http://localhost:8000/health")
    print("=" * 50)
    
    uvicorn.run(
        "simple_fastapi_server:app",
        host="0.0.0.0",
        port=8000,
        reload=True,
        log_level="info"
    )