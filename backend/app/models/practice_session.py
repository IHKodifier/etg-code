from pydantic import BaseModel, validator
from typing import List, Dict, Any, Optional
from datetime import datetime
import uuid

class PracticeSessionFilter(BaseModel):
    """Filter criteria for practice session questions"""
    exam_type: str
    subject: Optional[str] = None
    topic: Optional[str] = None
    difficulty: Optional[str] = None
    arde_probability: Optional[str] = None
    question_count: int = 20

    @validator('exam_type')
    def validate_exam_type(cls, v):
        allowed_types = ['ECAT', 'MCAT', 'CCAT', 'GMAT', 'GRE', 'SAT']
        if v not in allowed_types:
            raise ValueError(f'Exam type must be one of: {", ".join(allowed_types)}')
        return v

    @validator('difficulty')
    def validate_difficulty(cls, v):
        if v is None:
            return v
        allowed_difficulties = ['Easy', 'Medium', 'Hard']
        if v not in allowed_difficulties:
            raise ValueError(f'Difficulty must be one of: {", ".join(allowed_difficulties)}')
        return v

    @validator('question_count')
    def validate_question_count(cls, v):
        if v < 1 or v > 100:
            raise ValueError('Question count must be between 1 and 100')
        return v

class PracticeSessionSettings(BaseModel):
    """Settings for practice session behavior"""
    show_explanations: bool = True
    randomize_order: bool = True
    allow_skipping: bool = True
    time_limit_per_question: Optional[int] = None  # seconds, None = no limit
    max_attempts_per_question: int = 3

    @validator('max_attempts_per_question')
    def validate_max_attempts(cls, v):
        if v < 1 or v > 10:
            raise ValueError('Max attempts per question must be between 1 and 10')
        return v

class PracticeSessionCreateRequest(BaseModel):
    """Request to create a new practice session"""
    filter_criteria: PracticeSessionFilter
    settings: PracticeSessionSettings = PracticeSessionSettings()

class PracticeSessionCreateResponse(BaseModel):
    """Response for practice session creation"""
    id: str

class PracticeSession(BaseModel):
    """Complete practice session model"""
    id: str
    user_id: str
    session_type: str = "practice"  # "practice" or "exam"
    filter_criteria: PracticeSessionFilter
    question_ids: List[str]  # Ordered list of question IDs
    current_question_index: int = 0
    status: str = "active"  # "active", "completed", "paused"
    started_at: datetime
    completed_at: Optional[datetime] = None
    total_questions: int
    answered_questions: int = 0
    correct_answers: int = 0
    total_time_spent: int = 0  # seconds
    settings: PracticeSessionSettings
    created_at: datetime
    updated_at: datetime

    @validator('session_type')
    def validate_session_type(cls, v):
        allowed_types = ['practice', 'exam']
        if v not in allowed_types:
            raise ValueError(f'Session type must be one of: {", ".join(allowed_types)}')
        return v

    @validator('status')
    def validate_status(cls, v):
        allowed_statuses = ['active', 'completed', 'paused']
        if v not in allowed_statuses:
            raise ValueError(f'Status must be one of: {", ".join(allowed_statuses)}')
        return v

    @property
    def progress_percentage(self) -> float:
        """Calculate completion percentage"""
        if self.total_questions == 0:
            return 0.0
        return (self.answered_questions / self.total_questions) * 100.0

    @property
    def accuracy_percentage(self) -> float:
        """Calculate accuracy percentage"""
        if self.answered_questions == 0:
            return 0.0
        return (self.correct_answers / self.answered_questions) * 100.0

    @property
    def average_time_per_question(self) -> float:
        """Calculate average time spent per question in seconds"""
        if self.answered_questions == 0:
            return 0.0
        return self.total_time_spent / self.answered_questions

    @property
    def is_completed(self) -> bool:
        """Check if session is completed"""
        return self.status == "completed"

    @property
    def is_active(self) -> bool:
        """Check if session is currently active"""
        return self.status == "active"

    @property
    def current_question_id(self) -> Optional[str]:
        """Get current question ID"""
        if self.current_question_index < len(self.question_ids):
            return self.question_ids[self.current_question_index]
        return None

    @property
    def has_next_question(self) -> bool:
        """Check if there's a next question"""
        return self.current_question_index < len(self.question_ids) - 1

    @property
    def has_previous_question(self) -> bool:
        """Check if there's a previous question"""
        return self.current_question_index > 0

    class Config:
        from_attributes = True

class PracticeSessionResponse(BaseModel):
    """Response model for practice session data"""
    id: str
    session_type: str
    filter_criteria: PracticeSessionFilter
    current_question_index: int
    status: str
    started_at: datetime
    completed_at: Optional[datetime]
    total_questions: int
    answered_questions: int
    correct_answers: int
    total_time_spent: int
    settings: PracticeSessionSettings
    progress_percentage: float
    accuracy_percentage: float
    average_time_per_question: float
    current_question_id: Optional[str]
    has_next_question: bool
    has_previous_question: bool

class PracticeSessionSummary(BaseModel):
    """Summary of practice session for listing"""
    id: str
    session_type: str
    exam_type: str
    subject: Optional[str]
    total_questions: int
    answered_questions: int
    correct_answers: int
    accuracy_percentage: float
    total_time_spent: int
    started_at: datetime
    completed_at: Optional[datetime]
    status: str

class PracticeSessionStatistics(BaseModel):
    """Detailed statistics for a practice session"""
    session_id: str
    total_questions: int
    answered_questions: int
    correct_answers: int
    incorrect_answers: int
    skipped_questions: int
    accuracy_percentage: float
    total_time_spent: int
    average_time_per_question: float
    fastest_correct_time: Optional[int] = None  # seconds
    slowest_correct_time: Optional[int] = None  # seconds
    subject_breakdown: Dict[str, Dict[str, Any]] = {}
    difficulty_breakdown: Dict[str, Dict[str, Any]] = {}
    time_distribution: Dict[str, int] = {}  # time ranges and counts

class PracticeSessionAttempt(BaseModel):
    """Enhanced question attempt model for practice sessions"""
    id: str
    session_id: str
    question_id: str
    user_id: str
    selected_answers: List[str]
    correct_answers: List[str]
    is_correct: bool
    time_spent: int  # milliseconds
    attempt_number: int = 1
    timestamp: datetime
    explanation_shown: bool = False
    hint_used: bool = False
    notes: Optional[str] = None

    @validator('time_spent')
    def validate_time_spent(cls, v):
        if v < 0:
            raise ValueError('Time spent cannot be negative')
        if v > 3600000:  # 1 hour in milliseconds
            raise ValueError('Time spent cannot exceed 1 hour')
        return v

    @property
    def time_spent_seconds(self) -> float:
        """Convert milliseconds to seconds"""
        return self.time_spent / 1000.0

    class Config:
        from_attributes = True

# Factory functions for creating new instances
def create_practice_session(
    user_id: str,
    filter_criteria: PracticeSessionFilter,
    question_ids: List[str],
    settings: PracticeSessionSettings = None
) -> PracticeSession:
    """Factory function to create a new practice session"""
    if settings is None:
        settings = PracticeSessionSettings()

    now = datetime.utcnow()
    session_id = str(uuid.uuid4())

    return PracticeSession(
        id=session_id,
        user_id=user_id,
        filter_criteria=filter_criteria,
        question_ids=question_ids,
        current_question_index=0,
        status="active",
        started_at=now,
        total_questions=len(question_ids),
        settings=settings,
        created_at=now,
        updated_at=now
    )

def create_session_attempt(
    session_id: str,
    question_id: str,
    user_id: str,
    selected_answers: List[str],
    correct_answers: List[str],
    time_spent: int,
    attempt_number: int = 1
) -> PracticeSessionAttempt:
    """Factory function to create a new session attempt"""
    attempt_id = str(uuid.uuid4())
    is_correct = set(selected_answers) == set(correct_answers)

    return PracticeSessionAttempt(
        id=attempt_id,
        session_id=session_id,
        question_id=question_id,
        user_id=user_id,
        selected_answers=selected_answers,
        correct_answers=correct_answers,
        is_correct=is_correct,
        time_spent=time_spent,
        attempt_number=attempt_number,
        timestamp=datetime.utcnow()
    )