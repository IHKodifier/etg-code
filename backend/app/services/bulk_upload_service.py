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

    def _has_required_columns(self, df: pd.DataFrame) -> bool:
        """Check if DataFrame has required columns for bulk upload"""
        required_columns = ['questionText', 'questionType', 'correctAnswers']
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
                    question = BulkUploadQuestion(
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
                        arde_probability=str(row.get('ardeProbability', '')) if pd.notna(row.get('ardeProbability')) else None,
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

        for i, question in enumerate(questions):
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
                    try:
                        # Convert BulkUploadQuestion to QuestionCreateRequest
                        create_request = await self._convert_to_create_request(question, upload_data['user_id'])

                        # Create the question
                        question_id = await question_service.create_question(
                            question_data=create_request.dict(),
                            created_by=upload_data['user_id']
                        )

                        upload_data['successful'] += 1
                        logger.info(f"Created question {question_id} for upload {upload_id}")

                    except Exception as e:
                        upload_data['failed'] += 1
                        upload_data['errors'].append({
                            'row': questions.index(question) + 1,
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

    async def _convert_to_create_request(self, question: BulkUploadQuestion, user_id: str) -> QuestionCreateRequest:
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

        for option_id, option_text in option_map.items():
            if option_text:
                options.append(QuestionOption(
                    option_id=option_id,
                    text=option_text,
                    is_correct=option_id in correct_ids
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

        # Convert arde_probability from decimal to categorical
        internal_arde_probability = 'medium'  # default
        if question.arde_probability:
            try:
                prob_value = float(question.arde_probability)
                if prob_value >= 0.8:
                    internal_arde_probability = 'high'
                elif prob_value >= 0.4:
                    internal_arde_probability = 'medium'
                else:
                    internal_arde_probability = 'low'
            except ValueError:
                internal_arde_probability = 'medium'

        # All questions are MCQ types
        correct_answer = question.correct_answers

        return QuestionCreateRequest(
            question_text=question.question_text,
            options=options,
            correct_answer=correct_answer,
            exam_type=question.exam_category or 'ECAT',  # Default fallback
            subject=question.subject or 'General',
            topic=question.topic or 'General',
            difficulty=internal_difficulty,
            arde_probability=internal_arde_probability,
            historical_frequency=0,  # Will be updated based on actual data
            explanation={'text': question.explanation_text} if question.explanation_text else None,
            video_explanation_url=question.explanation_video_url,
            references=[],  # Could be parsed from tags or separate field
            arde_context=None
        )

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

        return BulkUploadProgress(
            upload_id=upload_id,
            total=upload_data['total'],
            processed=upload_data['processed'],
            successful=upload_data['successful'],
            failed=upload_data['failed'],
            status=upload_data['status'],
            errors=upload_data['errors']
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

# Global instance
bulk_upload_service = BulkUploadService()