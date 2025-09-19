#!/usr/bin/env python3
"""
Migration script for existing Firebase Auth users to Firestore.

This script:
1. Gets all existing Firebase Auth users
2. Creates corresponding Firestore documents if they don't exist
3. Sets appropriate custom claims for users
4. Updates existing Firestore documents with missing data

Usage:
    python migrate_existing_users.py
"""

import firebase_admin
from firebase_admin import auth as firebase_auth, credentials
from app.core.database import db
from datetime import datetime
import logging
import sys
import os

# Add the backend directory to the path so we can import modules
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class UserMigrationService:
    def __init__(self):
        self.migrated_count = 0
        self.skipped_count = 0
        self.error_count = 0

    async def migrate_existing_users(self):
        """Migrate existing Firebase Auth users to Firestore"""
        logger.info("Starting user migration...")

        try:
            # Get all Firebase Auth users
            users = firebase_auth.list_users().iterate_all()

            for firebase_user in users:
                try:
                    await self._migrate_single_user(firebase_user)
                except Exception as e:
                    logger.error(f"Failed to migrate user {firebase_user.email}: {e}")
                    self.error_count += 1

            logger.info(f"Migration completed. Migrated: {self.migrated_count}, Skipped: {self.skipped_count}, Errors: {self.error_count}")
            return self.migrated_count

        except Exception as e:
            logger.error(f"Migration failed: {e}")
            raise

    async def _migrate_single_user(self, firebase_user):
        """Migrate a single Firebase Auth user"""
        try:
            # Check if user document exists in Firestore
            existing_doc = await db.get_document("users", firebase_user.uid)

            if existing_doc:
                # User document exists, check if it needs updates
                await self._update_existing_user(firebase_user, existing_doc)
                self.skipped_count += 1
                logger.info(f"User already exists, updated: {firebase_user.email}")
            else:
                # Create new Firestore document
                await self._create_new_user_document(firebase_user)
                self.migrated_count += 1
                logger.info(f"Created Firestore document for user: {firebase_user.email}")

        except Exception as e:
            logger.error(f"Failed to migrate user {firebase_user.email}: {e}")
            raise

    async def _create_new_user_document(self, firebase_user):
        """Create a new Firestore document for a Firebase Auth user"""
        # Get user claims
        user_record = firebase_auth.get_user(firebase_user.uid)
        custom_claims = user_record.custom_claims or {}

        # Create Firestore document
        user_data = {
            "id": firebase_user.uid,
            "email": firebase_user.email,
            "exam_type": custom_claims.get('exam_type', 'ECAT'),
            "role": custom_claims.get('role', 'regularUser'),
            "tier": custom_claims.get('tier', 'free'),
            "is_active": True,
            "is_verified": firebase_user.email_verified,
            "is_anonymous": False,
            "created_at": datetime.fromtimestamp(
                firebase_user.user_metadata.creation_timestamp / 1000
            ) if firebase_user.user_metadata.creation_timestamp else datetime.utcnow(),
            "updated_at": datetime.utcnow(),
            "profile": {
                "displayName": firebase_user.display_name,
                "photoURL": firebase_user.photo_url,
            },
            "usage_stats": {
                "practice_mcqs_today": 0,
                "explanations_used_today": 0,
                "sprint_exams_used": 0,
                "simulated_exams_used": 0,
                "last_reset": datetime.utcnow().date().isoformat()
            }
        }

        await db.create_document("users", user_data, document_id=firebase_user.uid)

        # Set custom claims if not already set
        if not custom_claims:
            claims = {
                "role": "regularUser",
                "tier": "free",
                "exam_type": "ECAT"
            }
            firebase_auth.set_custom_user_claims(firebase_user.uid, claims)

    async def _update_existing_user(self, firebase_user, existing_doc):
        """Update an existing Firestore user document"""
        updates = {}

        # Check if profile information needs updating
        if firebase_user.display_name and not existing_doc.get('profile', {}).get('displayName'):
            updates['profile.displayName'] = firebase_user.display_name

        if firebase_user.photo_url and not existing_doc.get('profile', {}).get('photoURL'):
            updates['profile.photoURL'] = firebase_user.photo_url

        # Check if verification status needs updating
        if firebase_user.email_verified != existing_doc.get('is_verified', False):
            updates['is_verified'] = firebase_user.email_verified

        # Update if there are changes
        if updates:
            updates['updated_at'] = datetime.utcnow()
            await db.update_document("users", firebase_user.uid, updates)

    async def set_admin_for_user(self, email: str):
        """Set admin role for a specific user by email"""
        try:
            # Get Firebase user by email
            firebase_user = firebase_auth.get_user_by_email(email)

            # Set admin claims
            claims = {
                "role": "admin",
                "tier": "pro",
                "exam_type": "ECAT"
            }

            firebase_auth.set_custom_user_claims(firebase_user.uid, claims)

            # Update Firestore document
            await db.update_document("users", firebase_user.uid, {
                "role": "admin",
                "tier": "pro",
                "updated_at": datetime.utcnow()
            })

            logger.info(f"Set admin role for user: {email}")
            return firebase_user.uid

        except Exception as e:
            logger.error(f"Failed to set admin role for user {email}: {e}")
            raise

async def main():
    """Main migration function"""
    try:
        # Initialize Firebase Admin SDK
        # You'll need to set the path to your service account key
        cred_path = os.getenv('FIREBASE_SERVICE_ACCOUNT_KEY', 'path/to/service-account-key.json')
        cred = credentials.Certificate(cred_path)
        firebase_admin.initialize_app(cred)

        migration_service = UserMigrationService()

        # Run migration
        migrated_count = await migration_service.migrate_existing_users()

        # Optionally set admin for specific user
        admin_email = os.getenv('ADMIN_EMAIL', 'enigmatech.inc@gmail.com')
        if admin_email:
            await migration_service.set_admin_for_user(admin_email)
            logger.info(f"Set admin role for: {admin_email}")

        logger.info(f"Migration completed successfully. {migrated_count} users migrated.")

    except Exception as e:
        logger.error(f"Migration failed: {e}")
        sys.exit(1)

if __name__ == "__main__":
    import asyncio
    asyncio.run(main())