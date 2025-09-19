#!/usr/bin/env python3
"""
Script to set admin role for a specific user by email.

Usage:
    python set_admin_user.py user@example.com

This script:
1. Finds the user by email in Firebase Auth
2. Sets custom claims with admin role
3. Updates the Firestore document with admin role
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

async def set_admin_role_for_user(email: str):
    """Set admin role for a specific user by email"""
    try:
        logger.info(f"Setting admin role for user: {email}")

        # Get Firebase user by email
        firebase_user = firebase_auth.get_user_by_email(email)
        logger.info(f"Found Firebase user: {firebase_user.uid}")

        # Set admin claims
        claims = {
            "role": "admin",
            "tier": "pro",
            "exam_type": "ECAT"
        }

        firebase_auth.set_custom_user_claims(firebase_user.uid, claims)
        logger.info(f"Set custom claims for user {firebase_user.uid}")

        # Update Firestore document
        await db.update_document("users", firebase_user.uid, {
            "role": "admin",
            "tier": "pro",
            "updated_at": datetime.utcnow()
        })

        logger.info(f"Successfully set admin role for user: {email}")
        return firebase_user.uid

    except firebase_auth.UserNotFoundError:
        logger.error(f"User with email {email} not found in Firebase Auth")
        raise
    except Exception as e:
        logger.error(f"Failed to set admin role for user {email}: {e}")
        raise

async def main():
    """Main function"""
    if len(sys.argv) != 2:
        print("Usage: python set_admin_user.py <email>")
        print("Example: python set_admin_user.py user@example.com")
        sys.exit(1)

    email = sys.argv[1]

    try:
        # Initialize Firebase Admin SDK
        # Make sure you have your service account key set up
        # You can set the path via environment variable or hardcode it
        cred_path = os.getenv('FIREBASE_SERVICE_ACCOUNT_KEY')
        if not cred_path:
            # Try common locations
            possible_paths = [
                'firebase-service-account-key.json',
                '../firebase-service-account-key.json',
                './firebase-service-account-key.json',
                os.path.expanduser('~/firebase-service-account-key.json')
            ]
            for path in possible_paths:
                if os.path.exists(path):
                    cred_path = path
                    break

        if not cred_path:
            print("Error: Firebase service account key not found.")
            print("Please set the FIREBASE_SERVICE_ACCOUNT_KEY environment variable")
            print("or place the key file in one of these locations:")
            for path in possible_paths:
                print(f"  - {path}")
            sys.exit(1)

        cred = credentials.Certificate(cred_path)
        firebase_admin.initialize_app(cred)

        # Set admin role
        await set_admin_role_for_user(email)

        print(f"✅ Successfully set admin role for {email}")
        print("The user can now access admin features in the app.")

    except Exception as e:
        logger.error(f"Script failed: {e}")
        print(f"❌ Failed to set admin role: {e}")
        sys.exit(1)

if __name__ == "__main__":
    import asyncio
    asyncio.run(main())