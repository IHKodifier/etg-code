from fastapi import APIRouter, Depends, HTTPException, status, Query, File, Form, UploadFile
from fastapi.security import HTTPBearer
from typing import List, Optional
import logging
from datetime import datetime

from app.services.auth_service import auth_service
from app.services.question_service import question_service
from app.services.bulk_upload_service import bulk_upload_service
from app.models.question import (
    QuestionResponse,
    QuestionCreateRequest,
    QuestionExplanationResponse,
    QuestionApprovalRequest,
    QuestionApprovalResponse,
    QuestionWorkflowStatus,
    BulkApprovalRequest,
    BulkUploadRequest,
    BulkUploadResponse,
    BulkUploadProgress,
    BulkUploadSummary,
    BulkUploadQuestion
)
from app.models.auth import UserRole, SubscriptionTier

router = APIRouter()
security = HTTPBearer(auto_error=False)
logger = logging.getLogger(__name__)


def check_user_permissions(user: dict, required_roles: List[str] = None, required_tiers: List[str] = None):
    """Check if user has required permissions"""
    user_role = user.get("role", "regularUser")
    user_tier = user.get("tier", "free")

    # Check role permissions
    if required_roles and user_role not in required_roles:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail=f"Required role: {required_roles}. Your role: {user_role}"
        )

    # Check tier permissions
    if required_tiers and user_tier not in required_tiers:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail=f"Required tier: {required_tiers}. Your tier: {user_tier}"
        )

    return True


def check_tier_limits(user: dict, action: str):
    """Check if user has exceeded tier limits"""
    user_tier = user.get("tier", "free")
    usage_stats = user.get("usage_stats", {})

    if user_tier == "anonymous":
        # Anonymous users: limited to 10 questions per day
        daily_questions = usage_stats.get("practice_mcqs_today", 0)
        if daily_questions >= 10:
            raise HTTPException(
                status_code=status.HTTP_429_TOO_MANY_REQUESTS,
                detail="Anonymous users are limited to 10 questions per day. Please upgrade to continue."
            )

    elif user_tier == "free":
        # Free users: limited to 50 questions per day
        daily_questions = usage_stats.get("practice_mcqs_today", 0)
        if daily_questions >= 50:
            raise HTTPException(
                status_code=status.HTTP_429_TOO_MANY_REQUESTS,
                detail="Free users are limited to 50 questions per day. Please upgrade to Pro for unlimited access."
            )

    # Pro users have unlimited access
    return True


def check_trial_expiry(user: dict):
    """Check if anonymous user's trial has expired"""
    user_tier = user.get("tier", "free")
    trial_expiry = user.get("trial_expiry")

    if user_tier == "anonymous" and trial_expiry:
        if isinstance(trial_expiry, str):
            trial_expiry = datetime.fromisoformat(trial_expiry.replace('Z', '+00:00'))

        if datetime.utcnow() > trial_expiry:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Your trial period has expired. Please create an account to continue."
            )

    return True

async def get_current_user_dependency(token: str = Depends(security)):
    """Get current user from token"""
    if not token:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token required"
        )
    
    user = await auth_service.get_current_user(token.credentials)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token"
        )
    
    return user

@router.get("/", response_model=List[QuestionResponse])
async def get_filtered_questions(
    exam_categories: Optional[str] = None,
    subjects: Optional[str] = None,
    topics: Optional[str] = None,
    difficulties: Optional[str] = None,
    arde_probabilities: Optional[str] = None,
    search_query: Optional[str] = None,
    tags: Optional[str] = None,
    limit: int = Query(20, ge=1, le=100),
    offset: int = Query(0, ge=0),
    current_user = Depends(get_current_user_dependency)
):
    """Get filtered questions for question bank management"""
    try:
        # Check trial expiry for anonymous users
        check_trial_expiry(current_user)

        # Check tier limits
        check_tier_limits(current_user, "practice")

        # Parse comma-separated values
        exam_category_list = exam_categories.split(',') if exam_categories else None
        subject_list = subjects.split(',') if subjects else None
        topic_list = topics.split(',') if topics else None
        difficulty_list = difficulties.split(',') if difficulties else None
        arde_probability_list = arde_probabilities.split(',') if arde_probabilities else None
        tag_list = tags.split(',') if tags else None

        # Use the new get_filtered_questions method with pagination
        questions = await question_service.get_filtered_questions(
            exam_categories=exam_category_list,
            subjects=subject_list,
            topics=topic_list,
            difficulties=difficulty_list,
            arde_probabilities=arde_probability_list,
            search_query=search_query,
            tags=tag_list,
            limit=limit,
            offset=offset
        )

        return [QuestionResponse(**q) for q in questions]

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get filtered questions: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve questions"
        )


@router.get("/practice", response_model=List[QuestionResponse])
async def get_practice_questions(
    exam_type: str,
    subject: Optional[str] = None,
    topic: Optional[str] = None,
    difficulty: Optional[str] = None,
    arde_probability: Optional[str] = None,
    limit: int = Query(20, ge=1, le=50),
    current_user = Depends(get_current_user_dependency)
):
    """Get questions for practice session"""
    try:
        # Check trial expiry for anonymous users
        check_trial_expiry(current_user)

        # Check tier limits
        check_tier_limits(current_user, "practice")

        # All authenticated users can practice (no specific role requirement)
        questions = await question_service.get_questions_for_practice(
            exam_type=exam_type,
            subject=subject,
            topic=topic,
            difficulty=difficulty,
            arde_probability=arde_probability,
            limit=limit
        )

        return [QuestionResponse(**q) for q in questions]

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get practice questions: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve questions"
        )

@router.get("/{question_id}", response_model=QuestionResponse)
async def get_question(
    question_id: str,
    current_user = Depends(get_current_user_dependency)
):
    """Get a specific question"""
    try:
        question = await question_service.get_question(question_id)
        
        if not question:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Question not found"
            )
        
        return QuestionResponse(**question)
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get question: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve question"
        )

@router.get("/{question_id}/explanation", response_model=QuestionExplanationResponse)
async def get_question_explanation(
    question_id: str,
    current_user = Depends(get_current_user_dependency)
):
    """Get question explanation"""
    try:
        explanation = await question_service.get_question_explanation(
            question_id=question_id,
            user_id=current_user["id"]
        )
        
        if not explanation:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Explanation not found"
            )
        
        return QuestionExplanationResponse(**explanation)
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get explanation: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve explanation"
        )

@router.post("/attempt")
async def record_question_attempt(
    question_id: str,
    is_correct: bool,
    time_taken: float,
    current_user = Depends(get_current_user_dependency)
):
    """Record a question attempt"""
    try:
        success = await question_service.record_question_attempt(
            question_id=question_id,
            user_id=current_user["id"],
            is_correct=is_correct,
            time_taken=time_taken
        )
        
        return {"success": success}
        
    except Exception as e:
        logger.error(f"Failed to record attempt: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to record attempt"
        )

@router.post("/", response_model=str)
async def create_question(
    question_data: QuestionCreateRequest,
    current_user = Depends(get_current_user_dependency)
):
    """Create a new question (admin or contentCreator roles only)"""
    try:
        # Check user permissions - allow admin and contentCreator roles
        check_user_permissions(
            current_user,
            required_roles=["admin", "contentCreator"],
            required_tiers=["free", "pro"]  # Anonymous users cannot create questions
        )

        # Check trial expiry for free users
        check_trial_expiry(current_user)

        question_id = await question_service.create_question(
            question_data=question_data.dict(),
            created_by=current_user["id"]
        )

        logger.info(f"Question created by user {current_user['id']} (role: {current_user.get('role')})")
        return question_id

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to create question: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to create question"
        )


# Subscription Management Endpoints

@router.post("/subscription/upgrade-anonymous")
async def upgrade_anonymous_to_registered(
    email: str,
    password: str,
    exam_type: str,
    current_user = Depends(get_current_user_dependency)
):
    """Upgrade anonymous user to registered account"""
    try:
        # Only anonymous users can use this endpoint
        if current_user.get("tier") != "anonymous":
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="This endpoint is only for anonymous users"
            )

        # Use auth service to handle the upgrade
        new_user = await auth_service.upgrade_anonymous_to_registered(
            anonymous_user_id=current_user["id"],
            email=email,
            password=password,
            exam_type=exam_type
        )

        # Generate tokens for the new user
        tokens = await auth_service.generate_tokens(new_user["id"])

        return {
            "message": "Account created successfully",
            "user": new_user,
            "tokens": tokens
        }

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to upgrade anonymous user: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to upgrade account"
        )


@router.post("/subscription/upgrade-to-pro")
async def upgrade_to_pro_tier(
    payment_token: str,  # Would come from payment processor like Stripe
    current_user = Depends(get_current_user_dependency)
):
    """Upgrade user to pro tier"""
    try:
        # Use auth service to handle the upgrade
        result = await auth_service.upgrade_to_pro_tier(current_user["id"])

        # TODO: Process payment with payment processor
        # This would integrate with Stripe, PayPal, etc.
        # For now, we assume payment processing is handled elsewhere

        return result

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to upgrade to pro tier: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to process upgrade"
        )


@router.get("/subscription/status")
async def get_subscription_status(current_user = Depends(get_current_user_dependency)):
    """Get current user's subscription status"""
    try:
        return await auth_service.get_subscription_status(current_user["id"])

    except Exception as e:
        logger.error(f"Failed to get subscription status: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve subscription status"
        )


@router.get("/subscription/limits")
async def get_usage_limits(current_user = Depends(get_current_user_dependency)):
    """Get current user's usage limits and remaining quota"""
    try:
        return await auth_service.get_usage_limits(current_user["id"])

    except Exception as e:
        logger.error(f"Failed to get usage limits: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve usage limits"
        )


# Approval Workflow Endpoints

@router.get("/pending", response_model=List[QuestionResponse])
async def get_pending_questions(
    exam_type: Optional[str] = None,
    subject: Optional[str] = None,
    limit: int = Query(20, ge=1, le=100),
    current_user = Depends(get_current_user_dependency)
):
    """Get pending questions for review (content reviewers and admins)"""
    try:
        # Check if user has review privileges
        check_user_permissions(
            current_user,
            required_roles=["admin", "contentReviewer"]
        )

        questions = await question_service.get_pending_questions(
            exam_type=exam_type,
            subject=subject,
            limit=limit
        )

        return [QuestionResponse(**q) for q in questions]

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get pending questions: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve pending questions"
        )

@router.post("/{question_id}/approve", response_model=QuestionApprovalResponse)
async def approve_question(
    question_id: str,
    approval_data: QuestionApprovalRequest,
    current_user = Depends(get_current_user_dependency)
):
    """Approve or reject a question (content reviewers and admins)"""
    try:
        # Check if user has review privileges
        check_user_permissions(
            current_user,
            required_roles=["admin", "contentReviewer"]
        )

        result = await question_service.approve_question(
            question_id=question_id,
            reviewer_id=current_user["id"],
            reviewer_name=current_user.get("profile", {}).get("name", "Unknown"),
            action=approval_data.action,
            comments=approval_data.comments
        )

        return QuestionApprovalResponse(**result)

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to approve question: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to process approval"
        )

@router.post("/bulk-approve", response_model=List[QuestionApprovalResponse])
async def bulk_approve_questions(
    bulk_data: BulkApprovalRequest,
    current_user = Depends(get_current_user_dependency)
):
    """Bulk approve or reject questions (content reviewers and admins)"""
    try:
        # Check if user has review privileges
        check_user_permissions(
            current_user,
            required_roles=["admin", "contentReviewer"]
        )

        results = await question_service.bulk_approve_questions(
            question_ids=bulk_data.question_ids,
            reviewer_id=current_user["id"],
            reviewer_name=current_user.get("profile", {}).get("name", "Unknown"),
            action=bulk_data.action,
            comments=bulk_data.comments
        )

        return [QuestionApprovalResponse(**result) for result in results]

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to bulk approve questions: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to process bulk approval"
        )

@router.get("/my-submissions", response_model=List[QuestionWorkflowStatus])
async def get_my_submissions(
    status: Optional[str] = None,
    limit: int = Query(20, ge=1, le=100),
    current_user = Depends(get_current_user_dependency)
):
    """Get user's question submissions with workflow status"""
    try:
        submissions = await question_service.get_user_submissions(
            user_id=current_user["id"],
            status=status,
            limit=limit
        )

        return [QuestionWorkflowStatus(**s) for s in submissions]

    except Exception as e:
        logger.error(f"Failed to get user submissions: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve submissions"
        )

@router.get("/review-stats")
async def get_review_stats(current_user = Depends(get_current_user_dependency)):
    """Get review statistics for content reviewers"""
    try:
        # Check if user has review privileges
        check_user_permissions(
            current_user,
            required_roles=["admin", "contentReviewer"]
        )

        stats = await question_service.get_review_stats(
            reviewer_id=current_user["id"]
        )

        return stats

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get review stats: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve review statistics"
        )


# Bulk Upload Endpoints

@router.post("/bulk-upload/validate", response_model=dict)
async def validate_bulk_upload_file(
    file: bytes = File(...),
    filename: str = Form(...),
    current_user = Depends(get_current_user_dependency)
):
    """Validate bulk upload file before processing"""
    try:
        # Check user permissions - allow admin and contentCreator roles
        check_user_permissions(
            current_user,
            required_roles=["admin", "contentCreator"],
            required_tiers=["free", "pro"]
        )

        is_valid, message = await bulk_upload_service.validate_file(file, filename)

        return {
            "valid": is_valid,
            "message": message
        }

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to validate bulk upload file: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to validate file"
        )


@router.post("/bulk-upload/preview", response_model=dict)
async def preview_bulk_upload(
    file: bytes = File(...),
    filename: str = Form(...)
):
    """Parse and preview questions from bulk upload file"""
    try:
        # Temporarily skip user authentication for testing
        # TODO: Re-enable authentication after testing
        # current_user = Depends(get_current_user_dependency)
        # check_user_permissions(current_user, required_roles=["admin", "contentCreator"], required_tiers=["free", "pro"])

        # Parse file
        questions = await bulk_upload_service.parse_file(file, filename)

        # Validate questions
        errors = await bulk_upload_service.validate_questions(questions)

        return {
            "total_questions": len(questions),
            "valid_questions": len(questions) - len(errors),
            "errors": errors,
            "sample_questions": [
                {
                    "question_text": q.question_text,
                    "question_type": q.question_type,
                    "options_count": sum(1 for opt in [q.option_a, q.option_b, q.option_c, q.option_d, q.option_e, q.option_f] if opt)
                }
                for q in questions[:5]  # Show first 5 questions
            ]
        }

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to preview bulk upload: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to preview file"
        )


@router.post("/bulk-upload", response_model=BulkUploadResponse)
async def start_bulk_upload(
    file: bytes = File(...),
    filename: str = Form(...)
):
    """Start bulk upload process"""
    try:
        # Temporarily skip user authentication for testing
        # TODO: Re-enable authentication after testing
        # current_user = Depends(get_current_user_dependency)
        # check_user_permissions(current_user, required_roles=["admin", "contentCreator"], required_tiers=["free", "pro"])

        # Parse and validate file
        questions = await bulk_upload_service.parse_file(file, filename)
        errors = await bulk_upload_service.validate_questions(questions)

        # Filter out invalid questions
        valid_questions = []
        for i, question in enumerate(questions):
            question_errors = [e for e in errors if e['row'] == i + 1]
            if not question_errors:
                valid_questions.append(question)

        if not valid_questions:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="No valid questions found in file"
            )

        # Start bulk upload with a dummy user ID for testing
        upload_id = await bulk_upload_service.start_bulk_upload(valid_questions, "test-user-id")

        return BulkUploadResponse(
            upload_id=upload_id,
            total_questions=len(valid_questions),
            status="processing",
            processed=0,
            successful=0,
            failed=0,
            errors=errors
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to start bulk upload: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to start bulk upload"
        )


@router.get("/bulk-upload/{upload_id}/progress", response_model=BulkUploadProgress)
async def get_bulk_upload_progress(
    upload_id: str
):
    """Get progress of bulk upload"""
    try:
        progress = await bulk_upload_service.get_upload_progress(upload_id)

        if not progress:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Upload not found"
            )

        # Temporarily skip user authentication for testing
        # TODO: Re-enable authentication after testing
        # upload_data = bulk_upload_service.active_uploads.get(upload_id)
        # if upload_data and upload_data['user_id'] != current_user["id"]:
        #     if current_user.get("role") != "admin":
        #         raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Not authorized to view this upload")

        return progress

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get bulk upload progress: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to get upload progress"
        )


@router.get("/bulk-upload/{upload_id}/summary", response_model=BulkUploadSummary)
async def get_bulk_upload_summary(
    upload_id: str,
    current_user = Depends(get_current_user_dependency)
):
    """Get summary of completed bulk upload"""
    try:
        summary = await bulk_upload_service.get_upload_summary(upload_id)

        if not summary:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Upload summary not found or upload not completed"
            )

        # Check if user owns this upload
        upload_data = bulk_upload_service.active_uploads.get(upload_id)
        if upload_data and upload_data['user_id'] != current_user["id"]:
            # Allow admins to view any upload
            if current_user.get("role") != "admin":
                raise HTTPException(
                    status_code=status.HTTP_403_FORBIDDEN,
                    detail="Not authorized to view this upload"
                )

        return summary

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to get bulk upload summary: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to get upload summary"
        )


@router.delete("/bulk-upload/{upload_id}")
async def cancel_bulk_upload(
    upload_id: str,
    current_user = Depends(get_current_user_dependency)
):
    """Cancel ongoing bulk upload"""
    try:
        upload_data = bulk_upload_service.active_uploads.get(upload_id)

        if not upload_data:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Upload not found"
            )

        # Check if user owns this upload
        if upload_data['user_id'] != current_user["id"]:
            # Allow admins to cancel any upload
            if current_user.get("role") != "admin":
                raise HTTPException(
                    status_code=status.HTTP_403_FORBIDDEN,
                    detail="Not authorized to cancel this upload"
                )

        # Mark as cancelled
        upload_data['status'] = 'cancelled'
        upload_data['cancelled_at'] = datetime.utcnow()

        return {"message": "Upload cancelled successfully"}

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Failed to cancel bulk upload: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to cancel upload"
        )