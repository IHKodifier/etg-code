import pandas as pd
import openpyxl
from typing import List, Dict, Any, Optional, Tuple
import asyncio
import uuid
import json
import logging
from datetime import datetime
import os
import tempfile
from pathlib import Path

from app.models.question import (
    BulkUploadQuestion,
    BulkUploadResponse,
    BulkUploadProgress,
    BulkUploadSummary,
    QuestionCreateRequest,
    QuestionOption
)
from app.services.question_service import question_service

logger = logging.getLogger(__name__)

class BulkUploadService:
    """Service for handling bulk question uploads"""

    MAX_FILE_SIZE = 50 * 1024 * 1024  # 50MB
    SUPPORTED_EXTENSIONS = ['.xlsx', '.csv']
    BATCH_SIZE = 100  # Process questions in batches

    def __init__(self):
        self.active_uploads = {}  # upload_id -> upload data
        self.question_results = {}  # upload_id -> list of question results

    def _has_required_columns(self, df: pd.DataFrame) -> bool:
        """Check if DataFrame has required columns for bulk upload"""
        required_columns = ['questionId', 'questionText', 'questionType', 'correctAnswers']
        return all(col in df.columns for col in required_columns)

    async def validate_file(self, file_content: bytes, filename: str) -> Tuple[bool, str]:
        """Validate uploaded file"""
        try:
            # Check file size
            if len(file_content) > self.MAX_FILE_SIZE:
                return False, "File size exceeds 50MB limit"

            # Check file extension
            file_ext = Path(filename).suffix.lower()
            if file_ext not in self.SUPPORTED_EXTENSIONS:
                return False, f"Unsupported file type. Supported: {', '.join(self.SUPPORTED_EXTENSIONS)}"

            # Try to read the file
            with tempfile.NamedTemporaryFile(suffix=file_ext, delete=False) as temp_file:
                temp_file.write(file_content)
                temp_file_path = temp_file.name

            try:
                if file_ext == '.xlsx':
                    # Try to find the worksheet with questions
                    excel_file = pd.ExcelFile(temp_file_path)
                    logger.info(f"Excel file has sheets: {excel_file.sheet_names}")
                    df = None

                    # First, try to read the first sheet
                    try:
                        df = pd.read_excel(temp_file_path)
                        logger.info(f"Read first sheet, columns: {list(df.columns)}")
                        logger.info(f"Has required columns: {self._has_required_columns(df)}")
                    except Exception as e:
                        logger.error(f"Failed to read first sheet: {e}")
                        pass

                    # If first sheet doesn't work or doesn't have required columns, try others
                    if df is None or not self._has_required_columns(df):
                        logger.info("Trying other sheets...")
                        for sheet_name in excel_file.sheet_names:
                            try:
                                df = pd.read_excel(temp_file_path, sheet_name=sheet_name)
                                logger.info(f"Read sheet '{sheet_name}', columns: {list(df.columns)}")
                                if self._has_required_columns(df):
                                    logger.info(f"Found required columns in sheet '{sheet_name}'")
                                    break
                            except Exception as e:
                                logger.error(f"Failed to read sheet '{sheet_name}': {e}")
                                continue

                    if df is None:
                        return False, "Could not read any worksheet from the Excel file"
                else:  # .csv
                    df = pd.read_csv(temp_file_path)

                # Check if required columns exist
                if not self._has_required_columns(df):
                    required_columns = ['questionText', 'questionType', 'correctAnswers']
                    missing_columns = [col for col in required_columns if col not in df.columns]
                    return False, f"Missing required columns: {', '.join(missing_columns)}"

                # Check if we have at least one row
                if df.empty:
                    return False, "File contains no data"

                return True, f"File validated successfully. {len(df)} questions found."

            finally:
                os.unlink(temp_file_path)

        except Exception as e:
            logger.error(f"File validation error: {e}")
            return False, f"File validation failed: {str(e)}"

    async def parse_file(self, file_content: bytes, filename: str) -> List[BulkUploadQuestion]:
        """Parse file content into BulkUploadQuestion objects"""
        file_ext = Path(filename).suffix.lower()

        with tempfile.NamedTemporaryFile(suffix=file_ext, delete=False) as temp_file:
            temp_file.write(file_content)
            temp_file_path = temp_file.name

        try:
            if file_ext == '.xlsx':
                # Try to find the worksheet with questions
                excel_file = pd.ExcelFile(temp_file_path)
                logger.info(f"Parse: Excel file has sheets: {excel_file.sheet_names}")
                df = None

                # First, try to read the first sheet
                try:
                    df = pd.read_excel(temp_file_path)
                    logger.info(f"Parse: Read first sheet, columns: {list(df.columns)}")
                except Exception as e:
                    logger.error(f"Parse: Failed to read first sheet: {e}")
                    pass

                # If first sheet doesn't work or doesn't have required columns, try others
                if df is None or not self._has_required_columns(df):
                    logger.info("Parse: Trying other sheets...")
                    for sheet_name in excel_file.sheet_names:
                        try:
                            df = pd.read_excel(temp_file_path, sheet_name=sheet_name)
                            logger.info(f"Parse: Read sheet '{sheet_name}', columns: {list(df.columns)}")
                            if self._has_required_columns(df):
                                logger.info(f"Parse: Found required columns in sheet '{sheet_name}'")
                                break
                        except Exception as e:
                            logger.error(f"Parse: Failed to read sheet '{sheet_name}': {e}")
                            continue

                if df is None:
                    raise ValueError("Could not find a worksheet with the required columns")
            else:
                df = pd.read_csv(temp_file_path)

            questions = []
            for index, row in df.iterrows():
                try:
                    # Parse questionId - convert to int if provided, otherwise None for auto-generation
                    question_id = None
                    if pd.notna(row.get('questionId')) and str(row.get('questionId', '')).strip():
                        try:
                            question_id = int(float(row.get('questionId')))
                        except (ValueError, TypeError):
                            logger.warning(f"Invalid questionId at row {index + 1}: {row.get('questionId')}, will auto-generate")
                            question_id = None

                    question = BulkUploadQuestion(
                        question_id=question_id,
                        question_text=str(row.get('questionText', '')).strip(),
                        question_type=str(row.get('questionType', '')).strip(),
                        exam_category=str(row.get('examCategory', '')) if pd.notna(row.get('examCategory')) else None,
                        subject=str(row.get('subject', '')) if pd.notna(row.get('subject')) else None,
                        topic=str(row.get('topic', '')) if pd.notna(row.get('topic')) else None,
                        sub_topic=str(row.get('subTopic', '')) if pd.notna(row.get('subTopic')) else None,
                        option_a=str(row.get('optionA', '')) if pd.notna(row.get('optionA')) else None,
                        option_b=str(row.get('optionB', '')) if pd.notna(row.get('optionB')) else None,
                        option_c=str(row.get('optionC', '')) if pd.notna(row.get('optionC')) else None,
                        option_d=str(row.get('optionD', '')) if pd.notna(row.get('optionD')) else None,
                        option_e=str(row.get('optionE', '')) if pd.notna(row.get('optionE')) else None,
                        option_f=str(row.get('optionF', '')) if pd.notna(row.get('optionF')) else None,
                        correct_answers=str(row.get('correctAnswers', '')).strip(),
                        explanation_text=str(row.get('explanationText', '')) if pd.notna(row.get('explanationText')) else None,
                        difficulty=str(row.get('difficulty', '')) if pd.notna(row.get('difficulty')) else None,
                        tags=str(row.get('tags', '')) if pd.notna(row.get('tags')) else None,
                        estimated_time_seconds=int(row.get('estimatedTimeSeconds', 60)) if pd.notna(row.get('estimatedTimeSeconds')) else None,
                        arde_probability=float(row.get('ardeProbability', 0.5)) if pd.notna(row.get('ardeProbability')) else None,
                        question_image_urls=str(row.get('questionImageUrls', '')) if pd.notna(row.get('questionImageUrls')) else None,
                        explanation_video_url=str(row.get('explanationVideoUrl', '')) if pd.notna(row.get('explanationVideoUrl')) else None,
                    )
                    questions.append(question)
                except Exception as e:
                    logger.warning(f"Failed to parse question at row {index + 1}: {e}")
                    continue

            return questions

        finally:
            try:
                os.unlink(temp_file_path)
            except OSError as e:
                logger.warning(f"Could not delete temp file {temp_file_path}: {e}")
                # Don't raise the error, just log it

    async def validate_questions(self, questions: List[BulkUploadQuestion]) -> List[Dict[str, Any]]:
        """Validate parsed questions and return errors"""
        errors = []
        logger.info(f"Validating {len(questions)} questions")

        for i, question in enumerate(questions):
            logger.info(f"Validating question {i+1}: text='{question.question_text[:50]}...', correct_answers='{question.correct_answers}'")
            question_errors = []

            # Validate required fields
            if not question.question_text:
                question_errors.append("Question text is required")

            if not question.correct_answers:
                question_errors.append("Correct answers are required")

            # All questions are MCQ types - validate options and correct answers
            options = []
            if question.option_a: options.append(('A', question.option_a))
            if question.option_b: options.append(('B', question.option_b))
            if question.option_c: options.append(('C', question.option_c))
            if question.option_d: options.append(('D', question.option_d))
            if question.option_e: options.append(('E', question.option_e))
            if question.option_f: options.append(('F', question.option_f))

            if len(options) < 2:
                question_errors.append("At least 2 options are required for choice questions")

            # For MCQ questions, correctAnswers should contain option letters (A, B, C, D, etc.)
            # NOT the actual answer text
            correct_answer_letters = [ans.strip() for ans in question.correct_answers.split(',')]
            valid_option_ids = [opt[0] for opt in options]

            # Check if all correct answer letters are valid option IDs
            for letter in correct_answer_letters:
                if letter not in valid_option_ids:
                    question_errors.append(f"Correct answer '{letter}' is not a valid option. Use option letters (A, B, C, D, etc.) in correctAnswers column, not the actual answer text.")

            if question.question_type == 'MCQ - Single-select' and len(correct_answer_letters) != 1:
                question_errors.append("Single choice questions must have exactly one correct answer")

            if question.question_type == 'MCQ - Multi-select' and len(correct_answer_letters) < 1:
                question_errors.append("Multiple choice questions must have at least one correct answer")

            if question_errors:
                errors.append({
                    'row': i + 1,
                    'question_text': question.question_text[:100] + '...' if len(question.question_text) > 100 else question.question_text,
                    'errors': question_errors
                })

        return errors

    async def start_bulk_upload(self, questions: List[BulkUploadQuestion], user_id: str) -> str:
        """Start bulk upload process"""
        upload_id = str(uuid.uuid4())

        # Initialize question results
        question_results = []
        for i, question in enumerate(questions):
            question_results.append({
                'row': i + 1,
                'question_text': question.question_text[:100] + '...' if len(question.question_text) > 100 else question.question_text,
                'status': 'pending',  # pending, processing, success, failed
                'question_id': None,
                'error': None
            })

        self.question_results[upload_id] = question_results

        self.active_uploads[upload_id] = {
            'user_id': user_id,
            'questions': questions,
            'total': len(questions),
            'processed': 0,
            'successful': 0,
            'failed': 0,
            'errors': [],
            'status': 'processing',
            'start_time': datetime.utcnow(),
            'progress_callback': None
        }

        # Start processing in background
        asyncio.create_task(self._process_bulk_upload(upload_id))

        return upload_id

    async def _process_bulk_upload(self, upload_id: str):
        """Process bulk upload in background"""
        upload_data = self.active_uploads[upload_id]
        questions = upload_data['questions']

        try:
            for i in range(0, len(questions), self.BATCH_SIZE):
                batch = questions[i:i + self.BATCH_SIZE]

                for question in batch:
                    question_index = questions.index(question)
                    question_result = self.question_results[upload_id][question_index]

                    try:
                        # Update status to processing
                        question_result['status'] = 'processing'
                        await self._update_progress(upload_id)

                        # Handle questionId assignment
                        assigned_question_id = question.question_id
                        if assigned_question_id is None:
                            # Auto-generate questionId if not provided
                            assigned_question_id = await question_service.get_next_question_id()
                            logger.info(f"Auto-generated questionId: {assigned_question_id} for upload {upload_id}")

                        # Check if question with this ID already exists
                        existing_question = await question_service.get_question_by_question_id(assigned_question_id)

                        if existing_question:
                            # Update existing question
                            question_dict = await self._convert_to_create_request(question, upload_data['user_id'], assigned_question_id)
                            updated_question_id = await question_service.update_question(
                                question_id=existing_question['id'],
                                question_data=question_dict,
                                updated_by=upload_data['user_id']
                            )
                            question_result['status'] = 'success'
                            question_result['question_id'] = assigned_question_id
                            upload_data['successful'] += 1
                            logger.info(f"Updated existing question {assigned_question_id} (Firestore ID: {updated_question_id}) for upload {upload_id}")
                        else:
                            # Create new question
                            question_dict = await self._convert_to_create_request(question, upload_data['user_id'], assigned_question_id)
                            firestore_question_id = await question_service.create_question(
                                question_data=question_dict,
                                created_by=upload_data['user_id'],
                                question_id=assigned_question_id
                            )
                            question_result['status'] = 'success'
                            question_result['question_id'] = assigned_question_id
                            upload_data['successful'] += 1
                            logger.info(f"Created new question {assigned_question_id} (Firestore ID: {firestore_question_id}) for upload {upload_id}")

                    except Exception as e:
                        # Update failure
                        question_result['status'] = 'failed'
                        question_result['error'] = str(e)
                        upload_data['failed'] += 1
                        upload_data['errors'].append({
                            'row': question_index + 1,
                            'question_text': question.question_text[:100] + '...' if len(question.question_text) > 100 else question.question_text,
                            'error': str(e)
                        })
                        logger.error(f"Failed to create question for upload {upload_id}: {e}")

                    upload_data['processed'] += 1

                    # Update progress (this could trigger WebSocket updates)
                    await self._update_progress(upload_id)

                # Small delay between batches to prevent overwhelming the system
                await asyncio.sleep(0.1)

            upload_data['status'] = 'completed'
            upload_data['end_time'] = datetime.utcnow()

        except Exception as e:
            upload_data['status'] = 'failed'
            upload_data['error'] = str(e)
            logger.error(f"Bulk upload {upload_id} failed: {e}")

        # Final progress update
        await self._update_progress(upload_id)

    async def _convert_to_create_request(self, question: BulkUploadQuestion, user_id: str, question_id: Optional[int] = None) -> Dict[str, Any]:
        """Convert BulkUploadQuestion to QuestionCreateRequest"""
        options = []

        # Build options list
        option_map = {
            'A': question.option_a,
            'B': question.option_b,
            'C': question.option_c,
            'D': question.option_d,
            'E': question.option_e,
            'F': question.option_f,
        }

        correct_ids = [ans.strip() for ans in question.correct_answers.split(',')]
        logger.info(f"Question {question_id}: correct_answers='{question.correct_answers}', correct_ids={correct_ids}")

        for option_id, option_text in option_map.items():
            if option_text:
                is_correct = option_id in correct_ids
                logger.info(f"Question {question_id}: option {option_id}='{option_text}' -> is_correct={is_correct}")
                options.append(QuestionOption(
                    option_id=option_id,
                    text=option_text,
                    is_correct=is_correct
                ))

        # Convert question type from user format to internal format
        question_type_mapping = {
            'MCQ - Single-select': 'singleChoice',
            'MCQ - Multi-select': 'multipleChoice'
        }
        internal_question_type = question_type_mapping.get(question.question_type, question.question_type)

        # Convert difficulty from user format to internal format
        difficulty_mapping = {
            'Easy': 'easy',
            'Medium': 'medium',
            'Hard': 'hard'
        }
        internal_difficulty = difficulty_mapping.get(question.difficulty, question.difficulty) or 'medium'

        # Use arde_probability as decimal value directly (no conversion to enum)
        arde_probability = question.arde_probability if question.arde_probability is not None else 0.5

        # All questions are MCQ types - convert correct_answers string to list
        correct_answer = [ans.strip() for ans in question.correct_answers.split(',')]

        logger.info(f"Creating QuestionCreateRequest for question {question_id}:")
        logger.info(f"  correct_answer list: {correct_answer}")
        logger.info(f"  options with is_correct: {[(opt.option_id, opt.is_correct) for opt in options]}")

        create_request = QuestionCreateRequest(
            question_text=question.question_text,
            options=options,
            correct_answer=correct_answer,
            exam_type=question.exam_category or 'ECAT',  # Default fallback
            subject=question.subject or 'General',
            topic=question.topic or 'General',
            difficulty=internal_difficulty,
            arde_probability=arde_probability,  # Now a float value
            historical_frequency=0,  # Will be updated based on actual data
            explanation={'text': question.explanation_text} if question.explanation_text else None,
            video_explanation_url=question.explanation_video_url,
            references=[],  # Could be parsed from tags or separate field
            arde_context=None
        )

        logger.info(f"QuestionCreateRequest created successfully")

        # Use model-based serialization instead of manual dictionary construction
        # This ensures consistency and prevents field name mismatches
        question_dict = create_request.dict()

        logger.info(f"Question dict created using model serialization: options with is_correct = {[(opt['option_id'], opt['is_correct']) for opt in question_dict['options']]}")
        return question_dict

    async def _update_progress(self, upload_id: str):
        """Update progress for upload"""
        upload_data = self.active_uploads.get(upload_id)
        if not upload_data:
            return

        # This could trigger WebSocket updates or store progress in Redis/cache
        # For now, we'll just update the in-memory data
        pass

    async def get_upload_progress(self, upload_id: str) -> Optional[BulkUploadProgress]:
        """Get current progress for upload"""
        upload_data = self.active_uploads.get(upload_id)
        if not upload_data:
            return None

        question_results = self.question_results.get(upload_id, [])

        return BulkUploadProgress(
            upload_id=upload_id,
            total=upload_data['total'],
            processed=upload_data['processed'],
            successful=upload_data['successful'],
            failed=upload_data['failed'],
            status=upload_data['status'],
            errors=upload_data['errors'],
            question_results=question_results
        )

    async def get_upload_summary(self, upload_id: str) -> Optional[BulkUploadSummary]:
        """Get final summary for completed upload"""
        upload_data = self.active_uploads.get(upload_id)
        if not upload_data or upload_data['status'] != 'completed':
            return None

        processing_time = (upload_data['end_time'] - upload_data['start_time']).total_seconds()

        return BulkUploadSummary(
            upload_id=upload_id,
            total_questions=upload_data['total'],
            successful=upload_data['successful'],
            failed=upload_data['failed'],
            errors=upload_data['errors'],
            processing_time_seconds=processing_time,
            created_at=upload_data['start_time']
        )

    async def retry_failed_questions(self, upload_id: str, row_numbers: List[int]) -> Dict[str, Any]:
        """Retry uploading failed questions"""
        upload_data = self.active_uploads.get(upload_id)
        question_results = self.question_results.get(upload_id)

        if not upload_data or not question_results:
            return {"error": "Upload not found"}

        if upload_data['status'] not in ['completed', 'failed']:
            return {"error": "Upload is still in progress"}

        retry_results = []
        questions = upload_data['questions']

        for row_num in row_numbers:
            if row_num < 1 or row_num > len(question_results):
                retry_results.append({"row": row_num, "status": "error", "error": "Invalid row number"})
                continue

            question_index = row_num - 1
            question_result = question_results[question_index]
            question = questions[question_index]

            if question_result['status'] != 'failed':
                retry_results.append({"row": row_num, "status": "skipped", "message": "Question was not failed"})
                continue

            try:
                # Reset status to processing
                question_result['status'] = 'processing'
                question_result['error'] = None

                # Handle questionId assignment (should already be set from original attempt)
                assigned_question_id = question.question_id
                if assigned_question_id is None:
                    # This shouldn't happen in retry, but handle it just in case
                    assigned_question_id = await question_service.get_next_question_id()

                # Check if question with this ID already exists
                existing_question = await question_service.get_question_by_question_id(assigned_question_id)

                if existing_question:
                    # Update existing question
                    question_dict = await self._convert_to_create_request(question, upload_data['user_id'], assigned_question_id)
                    updated_question_id = await question_service.update_question(
                        question_id=existing_question['id'],
                        question_data=question_dict,
                        updated_by=upload_data['user_id']
                    )
                    question_result['status'] = 'success'
                    question_result['question_id'] = assigned_question_id
                    upload_data['successful'] += 1
                    upload_data['failed'] -= 1
                else:
                    # Create new question
                    question_dict = await self._convert_to_create_request(question, upload_data['user_id'], assigned_question_id)
                    firestore_question_id = await question_service.create_question(
                        question_data=question_dict,
                        created_by=upload_data['user_id'],
                        question_id=assigned_question_id
                    )
                    question_result['status'] = 'success'
                    question_result['question_id'] = assigned_question_id
                    upload_data['successful'] += 1
                    upload_data['failed'] -= 1

                # Remove from errors
                upload_data['errors'] = [e for e in upload_data['errors'] if e['row'] != row_num]

                retry_results.append({"row": row_num, "status": "success", "question_id": question_id})

            except Exception as e:
                question_result['error'] = str(e)
                retry_results.append({"row": row_num, "status": "failed", "error": str(e)})

        return {"retry_results": retry_results}

    def cleanup_old_uploads(self, max_age_hours: int = 24):
        """Clean up old completed uploads"""
        cutoff_time = datetime.utcnow().timestamp() - (max_age_hours * 3600)

        to_remove = []
        for upload_id, upload_data in self.active_uploads.items():
            if upload_data['status'] in ['completed', 'failed']:
                if upload_data.get('end_time', datetime.min).timestamp() < cutoff_time:
                    to_remove.append(upload_id)

        for upload_id in to_remove:
            del self.active_uploads[upload_id]
            # Also clean up question results
            if upload_id in self.question_results:
                del self.question_results[upload_id]

# Global instance
bulk_upload_service = BulkUploadService()