from fastapi import APIRouter
from app.api.v1.endpoints import auth, questions, practice, exams

api_router = APIRouter()

# Include endpoint routers
api_router.include_router(auth.router, prefix="/auth", tags=["authentication"])
api_router.include_router(questions.router, prefix="/questions", tags=["questions"])
api_router.include_router(practice.router, prefix="/practice", tags=["practice"])
api_router.include_router(exams.router, prefix="/exams", tags=["exams"])