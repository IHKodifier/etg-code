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
    correct_answer: List[str]
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
    def validate_options(cls, v, values):
        if len(v) < 2:
            raise ValueError('Question must have at least 2 options')
        if len(v) > 6:
            raise ValueError('Question cannot have more than 6 options')

        correct_count = sum(1 for option in v if option.is_correct)
        # Allow multiple correct answers for multi-select questions
        # For now, we'll determine question type from the correct_answer field format
        # If correct_answer has multiple items, it's multi-select
        correct_answer = values.get('correct_answer', [])
        is_multi_select = len(correct_answer) > 1

        if is_multi_select:
            if correct_count < 1:
                raise ValueError('Multi-select questions must have at least one correct answer')
        else:
            if correct_count != 1:
                raise ValueError('Single-select questions must have exactly one correct answer')

        return v

class QuestionResponse(BaseModel):
    id: str
    question_text: str
    options: List[QuestionOption]
    correct_answer: List[str]
    exam_type: str
    subject: str
    topic: str
    difficulty: str
    arde_probability: str
    historical_frequency: int
    created_at: datetime
    performance_stats: Dict[str, Any] = {}
    created_by_name: Optional[str] = None

    # Approval workflow fields
    status: str = "pending"  # pending, approved, rejected
    created_by: str
    reviewer_id: Optional[str] = None
    reviewer_name: Optional[str] = None
    review_comments: Optional[str] = None
    submitted_at: datetime
    reviewed_at: Optional[datetime] = None
    approved_at: Optional[datetime] = None

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

# Approval Workflow Models
class QuestionApprovalRequest(BaseModel):
    question_id: str
    action: str  # "approve" or "reject"
    comments: Optional[str] = None

    @validator('action')
    def validate_action(cls, v):
        allowed_actions = ['approve', 'reject']
        if v not in allowed_actions:
            raise ValueError(f'Action must be one of: {", ".join(allowed_actions)}')
        return v

class QuestionApprovalResponse(BaseModel):
    question_id: str
    status: str
    reviewer_id: str
    reviewer_name: str
    reviewed_at: datetime
    comments: Optional[str] = None

class QuestionWorkflowStatus(BaseModel):
    question_id: str
    status: str
    created_by: str
    submitted_at: datetime
    reviewer_id: Optional[str] = None
    reviewer_name: Optional[str] = None
    reviewed_at: Optional[datetime] = None
    comments: Optional[str] = None

class BulkApprovalRequest(BaseModel):
    question_ids: List[str]
    action: str
    comments: Optional[str] = None

    @validator('action')
    def validate_action(cls, v):
        allowed_actions = ['approve', 'reject']
        if v not in allowed_actions:
            raise ValueError(f'Action must be one of: {", ".join(allowed_actions)}')
        return v

    @validator('question_ids')
    def validate_question_ids(cls, v):
        if len(v) < 1:
            raise ValueError('At least one question ID must be provided')
        if len(v) > 50:
            raise ValueError('Cannot process more than 50 questions at once')
        return v

# Bulk Upload Models
class BulkUploadQuestion(BaseModel):
    question_text: str
    question_type: str
    exam_category: Optional[str] = None
    subject: Optional[str] = None
    topic: Optional[str] = None
    sub_topic: Optional[str] = None
    option_a: Optional[str] = None
    option_b: Optional[str] = None
    option_c: Optional[str] = None
    option_d: Optional[str] = None
    option_e: Optional[str] = None
    option_f: Optional[str] = None
    correct_answers: str  # Comma-separated option IDs
    explanation_text: Optional[str] = None
    difficulty: Optional[str] = None
    tags: Optional[str] = None  # Comma-separated tags
    estimated_time_seconds: Optional[int] = None
    arde_probability: Optional[str] = None
    question_image_urls: Optional[str] = None  # Comma-separated URLs
    explanation_video_url: Optional[str] = None

    @validator('question_type')
    def validate_question_type(cls, v):
        allowed_types = ['MCQ - Single-select', 'MCQ - Multi-select']
        if v not in allowed_types:
            raise ValueError(f'Question type must be one of: {", ".join(allowed_types)}')
        return v

    @validator('difficulty')
    def validate_difficulty(cls, v):
        if v is None:
            return v
        allowed_difficulties = ['Easy', 'Medium', 'Hard']
        if v not in allowed_difficulties:
            raise ValueError(f'Difficulty must be one of: {", ".join(allowed_difficulties)}')
        return v

    @validator('arde_probability')
    def validate_arde_probability(cls, v):
        if v is None:
            return v
        # Allow decimal values between 0 and 1
        try:
            float_val = float(v)
            if not (0.0 <= float_val <= 1.0):
                raise ValueError('ARDE probability must be between 0.0 and 1.0')
            return v
        except ValueError:
            raise ValueError('ARDE probability must be a decimal number between 0.0 and 1.0')

class BulkUploadRequest(BaseModel):
    questions: List[BulkUploadQuestion]

class BulkUploadResponse(BaseModel):
    upload_id: str
    total_questions: int
    status: str  # 'processing', 'completed', 'failed'
    processed: int = 0
    successful: int = 0
    failed: int = 0
    errors: List[Dict[str, Any]] = []

class BulkUploadProgress(BaseModel):
    upload_id: str
    total: int
    processed: int
    successful: int
    failed: int
    status: str
    errors: List[Dict[str, Any]] = []
    estimated_time_remaining: Optional[int] = None
    question_results: List[Dict[str, Any]] = []  # Individual question status

class BulkUploadSummary(BaseModel):
    upload_id: str
    total_questions: int
    successful: int
    failed: int
    errors: List[Dict[str, Any]]
    processing_time_seconds: float
    created_at: datetime