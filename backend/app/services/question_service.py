from typing import List, Dict, Any, Optional
from datetime import datetime
import logging
from app.core.database import db
from app.core.exceptions import NotFoundError, ValidationError

logger = logging.getLogger(__name__)

class QuestionService:
    """Question bank management service"""
    
    async def create_question(
        self,
        question_data: Dict[str, Any],
        created_by: str
    ) -> str:
        """Create a new question"""
        try:
            # Validate required fields
            required_fields = [
                "question_text", "options", "correct_answer", 
                "exam_type", "subject", "topic", "difficulty"
            ]
            
            for field in required_fields:
                if field not in question_data:
                    raise ValidationError(f"Missing required field: {field}")
            
            # Prepare question document
            question = {
                **question_data,
                "created_by": created_by,
                "created_at": datetime.utcnow(),
                "updated_at": datetime.utcnow(),
                "is_active": True,
                "approval_status": "pending",
                "arde_probability": question_data.get("arde_probability", "medium"),
                "historical_frequency": question_data.get("historical_frequency", 0),
                "performance_stats": {
                    "total_attempts": 0,
                    "correct_attempts": 0,
                    "average_time": 0.0,
                    "difficulty_score": 0.0
                },
                "variations": []
            }
            
            question_id = await db.create_document("questions", question)
            
            logger.info(f"Question created: {question_id}")
            return question_id
            
        except Exception as e:
            logger.error(f"Failed to create question: {e}")
            raise
    
    async def get_question(self, question_id: str) -> Optional[Dict[str, Any]]:
        """Get a question by ID"""
        try:
            question = await db.get_document("questions", question_id)
            
            if not question or not question.get("is_active", True):
                return None
            
            return question
            
        except Exception as e:
            logger.error(f"Failed to get question {question_id}: {e}")
            return None
    
    async def get_questions_for_practice(
        self,
        exam_type: str,
        subject: Optional[str] = None,
        topic: Optional[str] = None,
        difficulty: Optional[str] = None,
        arde_probability: Optional[str] = None,
        limit: int = 20
    ) -> List[Dict[str, Any]]:
        """Get questions for practice session"""
        try:
            filters = [
                {"field": "exam_type", "operator": "==", "value": exam_type},
                {"field": "is_active", "operator": "==", "value": True},
                {"field": "approval_status", "operator": "==", "value": "approved"}
            ]
            
            # Add optional filters
            if subject:
                filters.append({"field": "subject", "operator": "==", "value": subject})
            if topic:
                filters.append({"field": "topic", "operator": "==", "value": topic})
            if difficulty:
                filters.append({"field": "difficulty", "operator": "==", "value": difficulty})
            if arde_probability:
                filters.append({"field": "arde_probability", "operator": "==", "value": arde_probability})
            
            questions = await db.query_collection(
                "questions",
                filters=filters,
                limit=limit,
                order_by="-created_at"
            )

            # Add creator names before removing sensitive info
            for question in questions:
                creator_id = question.get("created_by")
                if creator_id:
                    user = await db.get_document("users", creator_id)
                    if user and user.get("profile"):
                        question["created_by_name"] = user["profile"].get("name", "Unknown")
                    else:
                        question["created_by_name"] = "Unknown"
                else:
                    question["created_by_name"] = "Unknown"

            # Remove sensitive information for practice
            for question in questions:
                question.pop("created_by", None)
                question.pop("approval_status", None)

            return questions
            
        except Exception as e:
            logger.error(f"Failed to get practice questions: {e}")
            return []
    
    async def get_questions_for_exam(
        self,
        exam_type: str,
        question_count: int,
        arde_priority: bool = True
    ) -> List[Dict[str, Any]]:
        """Get questions for simulated exam"""
        try:
            filters = [
                {"field": "exam_type", "operator": "==", "value": exam_type},
                {"field": "is_active", "operator": "==", "value": True},
                {"field": "approval_status", "operator": "==", "value": "approved"}
            ]
            
            if arde_priority:
                # Prioritize high ARDE probability questions
                filters.append({"field": "arde_probability", "operator": "==", "value": "high"})
                
                high_arde_questions = await db.query_collection(
                    "questions",
                    filters=filters,
                    limit=question_count // 2
                )
                
                # Get remaining questions from medium/low ARDE
                remaining_count = question_count - len(high_arde_questions)
                
                if remaining_count > 0:
                    filters[-1] = {"field": "arde_probability", "operator": "in", "value": ["medium", "low"]}
                    other_questions = await db.query_collection(
                        "questions",
                        filters=filters,
                        limit=remaining_count
                    )
                    questions = high_arde_questions + other_questions
                else:
                    questions = high_arde_questions
            else:
                # Random selection
                questions = await db.query_collection(
                    "questions",
                    filters=filters,
                    limit=question_count
                )
            
            # Add creator names before removing sensitive info
            for question in questions:
                creator_id = question.get("created_by")
                if creator_id:
                    user = await db.get_document("users", creator_id)
                    if user and user.get("profile"):
                        question["created_by_name"] = user["profile"].get("name", "Unknown")
                    else:
                        question["created_by_name"] = "Unknown"
                else:
                    question["created_by_name"] = "Unknown"

            # Remove sensitive information
            for question in questions:
                question.pop("created_by", None)
                question.pop("approval_status", None)

            return questions[:question_count]  # Ensure exact count
            
        except Exception as e:
            logger.error(f"Failed to get exam questions: {e}")
            return []
    
    async def record_question_attempt(
        self,
        question_id: str,
        user_id: str,
        is_correct: bool,
        time_taken: float
    ) -> bool:
        """Record a question attempt for analytics"""
        try:
            # Record individual attempt
            attempt_data = {
                "question_id": question_id,
                "user_id": user_id,
                "is_correct": is_correct,
                "time_taken": time_taken,
                "attempted_at": datetime.utcnow()
            }
            
            await db.create_document("question_attempts", attempt_data)
            
            # Update question performance stats
            question = await self.get_question(question_id)
            if question:
                stats = question.get("performance_stats", {})
                
                total_attempts = stats.get("total_attempts", 0) + 1
                correct_attempts = stats.get("correct_attempts", 0) + (1 if is_correct else 0)
                current_avg_time = stats.get("average_time", 0.0)
                
                # Calculate new average time
                new_avg_time = (current_avg_time * (total_attempts - 1) + time_taken) / total_attempts
                
                # Update stats
                updated_stats = {
                    "performance_stats.total_attempts": total_attempts,
                    "performance_stats.correct_attempts": correct_attempts,
                    "performance_stats.average_time": new_avg_time,
                    "performance_stats.difficulty_score": (correct_attempts / total_attempts) * 100,
                    "updated_at": datetime.utcnow()
                }
                
                await db.update_document("questions", question_id, updated_stats)
            
            return True
            
        except Exception as e:
            logger.error(f"Failed to record question attempt: {e}")
            return False
    
    async def get_question_explanation(
        self,
        question_id: str,
        user_id: str
    ) -> Optional[Dict[str, Any]]:
        """Get question explanation (subject to user limits)"""
        try:
            question = await self.get_question(question_id)
            
            if not question:
                raise NotFoundError("Question not found")
            
            # Check if explanation exists
            explanation = question.get("explanation", {})
            
            if not explanation:
                return None
            
            # Record explanation usage
            usage_data = {
                "question_id": question_id,
                "user_id": user_id,
                "accessed_at": datetime.utcnow()
            }
            
            await db.create_document("explanation_usage", usage_data)
            
            return {
                "question_id": question_id,
                "explanation": explanation,
                "references": question.get("references", []),
                "video_url": question.get("video_explanation_url"),
                "arde_context": question.get("arde_context")
            }
            
        except Exception as e:
            logger.error(f"Failed to get question explanation: {e}")
            return None
    
    async def update_question_arde_data(
        self,
        question_id: str,
        arde_probability: str,
        historical_frequency: int,
        arde_context: Optional[str] = None
    ) -> bool:
        """Update ARDE probability data for a question"""
        try:
            update_data = {
                "arde_probability": arde_probability,
                "historical_frequency": historical_frequency,
                "updated_at": datetime.utcnow()
            }

            if arde_context:
                update_data["arde_context"] = arde_context

            await db.update_document("questions", question_id, update_data)

            logger.info(f"ARDE data updated for question: {question_id}")
            return True

        except Exception as e:
            logger.error(f"Failed to update ARDE data: {e}")
            return False

    # Approval Workflow Methods

    async def get_pending_questions(
        self,
        exam_type: Optional[str] = None,
        subject: Optional[str] = None,
        limit: int = 20
    ) -> List[Dict[str, Any]]:
        """Get questions pending approval"""
        try:
            filters = [
                {"field": "is_active", "operator": "==", "value": True},
                {"field": "approval_status", "operator": "==", "value": "pending"}
            ]

            if exam_type:
                filters.append({"field": "exam_type", "operator": "==", "value": exam_type})
            if subject:
                filters.append({"field": "subject", "operator": "==", "value": subject})

            questions = await db.query_collection(
                "questions",
                filters=filters,
                limit=limit,
                order_by="created_at"
            )

            # Add creator names
            for question in questions:
                creator_id = question.get("created_by")
                if creator_id:
                    user = await db.get_document("users", creator_id)
                    if user and user.get("profile"):
                        question["created_by_name"] = user["profile"].get("name", "Unknown")
                    else:
                        question["created_by_name"] = "Unknown"

            return questions

        except Exception as e:
            logger.error(f"Failed to get pending questions: {e}")
            return []

    async def approve_question(
        self,
        question_id: str,
        reviewer_id: str,
        reviewer_name: str,
        action: str,
        comments: Optional[str] = None
    ) -> Dict[str, Any]:
        """Approve or reject a question"""
        try:
            # Get the question first
            question = await self.get_question(question_id)
            if not question:
                raise NotFoundError("Question not found")

            # Determine new status
            new_status = "approved" if action == "approve" else "rejected"

            # Prepare update data
            update_data = {
                "approval_status": new_status,
                "reviewer_id": reviewer_id,
                "reviewer_name": reviewer_name,
                "reviewed_at": datetime.utcnow(),
                "updated_at": datetime.utcnow()
            }

            if comments:
                update_data["review_comments"] = comments

            if action == "approve":
                update_data["approved_at"] = datetime.utcnow()

            # Update the question
            await db.update_document("questions", question_id, update_data)

            # Log the approval action
            audit_data = {
                "question_id": question_id,
                "reviewer_id": reviewer_id,
                "action": action,
                "comments": comments,
                "timestamp": datetime.utcnow(),
                "question_creator": question.get("created_by")
            }
            await db.create_document("question_approvals", audit_data)

            logger.info(f"Question {question_id} {action}d by {reviewer_name}")

            return {
                "question_id": question_id,
                "status": new_status,
                "reviewer_id": reviewer_id,
                "reviewer_name": reviewer_name,
                "reviewed_at": update_data["reviewed_at"],
                "comments": comments
            }

        except Exception as e:
            logger.error(f"Failed to approve question: {e}")
            raise

    async def bulk_approve_questions(
        self,
        question_ids: List[str],
        reviewer_id: str,
        reviewer_name: str,
        action: str,
        comments: Optional[str] = None
    ) -> List[Dict[str, Any]]:
        """Bulk approve or reject multiple questions"""
        try:
            results = []

            for question_id in question_ids:
                try:
                    result = await self.approve_question(
                        question_id=question_id,
                        reviewer_id=reviewer_id,
                        reviewer_name=reviewer_name,
                        action=action,
                        comments=comments
                    )
                    results.append(result)
                except Exception as e:
                    logger.error(f"Failed to process question {question_id}: {e}")
                    # Continue with other questions even if one fails
                    continue

            logger.info(f"Bulk {action} completed: {len(results)}/{len(question_ids)} questions processed")
            return results

        except Exception as e:
            logger.error(f"Failed to bulk approve questions: {e}")
            raise

    async def get_user_submissions(
        self,
        user_id: str,
        status: Optional[str] = None,
        limit: int = 20
    ) -> List[Dict[str, Any]]:
        """Get user's question submissions with workflow status"""
        try:
            filters = [
                {"field": "created_by", "operator": "==", "value": user_id},
                {"field": "is_active", "operator": "==", "value": True}
            ]

            if status:
                filters.append({"field": "approval_status", "operator": "==", "value": status})

            submissions = await db.query_collection(
                "questions",
                filters=filters,
                limit=limit,
                order_by="-created_at"
            )

            # Format for workflow status response
            workflow_submissions = []
            for submission in submissions:
                workflow_submissions.append({
                    "question_id": submission["id"],
                    "status": submission.get("approval_status", "pending"),
                    "created_by": submission["created_by"],
                    "submitted_at": submission["created_at"],
                    "reviewer_id": submission.get("reviewer_id"),
                    "reviewer_name": submission.get("reviewer_name"),
                    "reviewed_at": submission.get("reviewed_at"),
                    "comments": submission.get("review_comments")
                })

            return workflow_submissions

        except Exception as e:
            logger.error(f"Failed to get user submissions: {e}")
            return []

    async def get_review_stats(self, reviewer_id: str) -> Dict[str, Any]:
        """Get review statistics for a reviewer"""
        try:
            # Get total reviews by this reviewer
            total_reviews = await db.query_collection(
                "question_approvals",
                filters=[{"field": "reviewer_id", "operator": "==", "value": reviewer_id}]
            )

            # Count approvals and rejections
            approved_count = sum(1 for review in total_reviews if review["action"] == "approve")
            rejected_count = sum(1 for review in total_reviews if review["action"] == "reject")

            # Get pending questions count
            pending_questions = await self.get_pending_questions(limit=1000)
            pending_count = len(pending_questions)

            # Get recent activity (last 30 days)
            thirty_days_ago = datetime.utcnow().replace(day=datetime.utcnow().day - 30)
            recent_reviews = [
                review for review in total_reviews
                if review["timestamp"] > thirty_days_ago
            ]

            return {
                "total_reviews": len(total_reviews),
                "approved_count": approved_count,
                "rejected_count": rejected_count,
                "pending_questions": pending_count,
                "recent_activity": len(recent_reviews),
                "approval_rate": (approved_count / len(total_reviews) * 100) if total_reviews else 0
            }

        except Exception as e:
            logger.error(f"Failed to get review stats: {e}")
            return {
                "total_reviews": 0,
                "approved_count": 0,
                "rejected_count": 0,
                "pending_questions": 0,
                "recent_activity": 0,
                "approval_rate": 0
            }

# Global question service instance
question_service = QuestionService()