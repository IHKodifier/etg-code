#!/usr/bin/env python3
"""
Simple test script to verify our backend structure
"""
import sys
import os

def check_structure():
    """Check if our module structure is correct"""
    print("Checking EntryTestGuru Backend Structure...")
    print("=" * 50)
    
    # Check main files
    files_to_check = [
        "app/__init__.py",
        "app/main.py",
        "app/core/config.py",
        "app/core/security.py",
        "app/core/database.py",
        "app/services/auth_service.py",
        "app/services/question_service.py",
        "app/api/v1/api.py",
        "app/models/auth.py",
        "app/middleware/auth_middleware.py",
        "requirements.txt"
    ]
    
    all_good = True
    for file_path in files_to_check:
        if os.path.exists(file_path):
            print(f"[OK] {file_path}")
        else:
            print(f"[MISSING] {file_path}")
            all_good = False
    
    print("\n" + "=" * 50)
    if all_good:
        print("SUCCESS: All backend files are in place!")
        print("Next: Install dependencies with pip install -r requirements.txt")
    else:
        print("ERROR: Some files are missing")
    
    return all_good

if __name__ == "__main__":
    check_structure()