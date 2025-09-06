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

# Global question service instance
question_service = QuestionService()