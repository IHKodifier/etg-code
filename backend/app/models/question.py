from pydantic import BaseModel, validator
from typing import List, Dict, Any, Optional
from datetime import datetime

class QuestionOption(BaseModel):
    option_id: str
    text: str
    is_correct: bool = False

class QuestionCreateRequest(BaseModel):
    question_text: str
    options: List[QuestionOption]
    correct_answer: str
    exam_type: str
    subject: str
    topic: str
    difficulty: str
    arde_probability: str = "medium"
    historical_frequency: int = 0
    explanation: Optional[Dict[str, Any]] = None
    video_explanation_url: Optional[str] = None
    references: List[str] = []
    arde_context: Optional[str] = None
    
    @validator('exam_type')
    def validate_exam_type(cls, v):
        allowed_types = ['ECAT', 'MCAT', 'CCAT', 'GMAT', 'GRE', 'SAT']
        if v not in allowed_types:
            raise ValueError(f'Exam type must be one of: {", ".join(allowed_types)}')
        return v
    
    @validator('difficulty')
    def validate_difficulty(cls, v):
        allowed_difficulties = ['easy', 'medium', 'hard']
        if v not in allowed_difficulties:
            raise ValueError(f'Difficulty must be one of: {", ".join(allowed_difficulties)}')
        return v
    
    @validator('arde_probability')
    def validate_arde_probability(cls, v):
        allowed_probabilities = ['low', 'medium', 'high']
        if v not in allowed_probabilities:
            raise ValueError(f'ARDE probability must be one of: {", ".join(allowed_probabilities)}')
        return v
    
    @validator('options')
    def validate_options(cls, v):
        if len(v) < 2:
            raise ValueError('Question must have at least 2 options')
        if len(v) > 6:
            raise ValueError('Question cannot have more than 6 options')
        
        correct_count = sum(1 for option in v if option.is_correct)
        if correct_count != 1:
            raise ValueError('Question must have exactly one correct answer')
        
        return v

class QuestionResponse(BaseModel):
    id: str
    question_text: str
    options: List[QuestionOption]
    correct_answer: str
    exam_type: str
    subject: str
    topic: str
    difficulty: str
    arde_probability: str
    historical_frequency: int
    created_at: datetime
    performance_stats: Dict[str, Any] = {}
    
    class Config:
        from_attributes = True

class QuestionExplanationResponse(BaseModel):
    question_id: str
    explanation: Dict[str, Any]
    references: List[str] = []
    video_url: Optional[str] = None
    arde_context: Optional[str] = None

class QuestionAttemptRequest(BaseModel):
    question_id: str
    selected_answer: str
    time_taken: float
    
    @validator('time_taken')
    def validate_time_taken(cls, v):
        if v < 0:
            raise ValueError('Time taken cannot be negative')
        if v > 3600:  # 1 hour max
            raise ValueError('Time taken cannot exceed 1 hour')
        return v

class QuestionFilterRequest(BaseModel):
    exam_type: str
    subject: Optional[str] = None
    topic: Optional[str] = None
    difficulty: Optional[str] = None
    arde_probability: Optional[str] = None
    limit: int = 20
    
    @validator('limit')
    def validate_limit(cls, v):
        if v < 1 or v > 100:
            raise ValueError('Limit must be between 1 and 100')
        return v