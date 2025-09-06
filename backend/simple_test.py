#!/usr/bin/env python3
"""
Simple test script to verify our backend structure without external dependencies
"""
import sys
import os
import importlib.util

def check_module_structure():
    """Check if our module structure is correct"""
    print("🔍 Checking EntryTestGuru Backend Structure...")
    print("=" * 50)
    
    # Check if we're in the right directory
    current_dir = os.getcwd()
    print(f"📍 Current directory: {current_dir}")
    
    # Check if app directory exists
    if os.path.exists("app"):
        print("✅ app/ directory found")
    else:
        print("❌ app/ directory not found")
        return False
    
    # Check main structure
    structure_checks = [
        ("app/__init__.py", "App package"),
        ("app/main.py", "FastAPI main application"),
        ("app/core/config.py", "Configuration"),
        ("app/core/security.py", "Security utilities"),
        ("app/core/database.py", "Database client"),
        ("app/services/auth_service.py", "Auth service"),
        ("app/services/question_service.py", "Question service"),
        ("app/api/v1/api.py", "API router"),
        ("app/models/auth.py", "Auth models"),
        ("app/middleware/auth_middleware.py", "Auth middleware"),
        ("requirements.txt", "Dependencies")
    ]
    
    all_good = True
    for file_path, description in structure_checks:
        if os.path.exists(file_path):
            print(f"✅ {description}: {file_path}")
        else:
            print(f"❌ {description}: {file_path} - NOT FOUND")
            all_good = False
    
    return all_good

def test_imports():
    """Test if our modules can be imported"""
    print("\n🔍 Testing Module Imports...")
    print("=" * 50)
    
    # Add app to Python path
    sys.path.insert(0, os.path.join(os.getcwd(), 'app'))
    
    import_tests = [
        ("app.core.config", "Configuration module"),
        ("app.core.exceptions", "Exceptions module"),
        ("app.services.auth_service", "Auth service module"),
        ("app.models.auth", "Auth models module"),
    ]
    
    all_imports_good = True
    for module_name, description in import_tests:
        try:
            spec = importlib.util.spec_from_file_location(
                module_name, 
                module_name.replace('.', '/') + '.py'
            )
            if spec and spec.loader:
                module = importlib.util.module_from_spec(spec)
                spec.loader.exec_module(module)
                print(f"✅ {description}: Successfully imported")
            else:
                print(f"❌ {description}: Could not create spec")
                all_imports_good = False
        except Exception as e:
            print(f"❌ {description}: {str(e)}")
            all_imports_good = False
    
    return all_imports_good

def main():
    """Run all tests"""
    print("🚀 EntryTestGuru Backend Structure Test")
    print("=" * 60)
    
    structure_ok = check_module_structure()
    imports_ok = test_imports()
    
    print("\n📊 Test Results:")
    print("=" * 50)
    
    if structure_ok and imports_ok:
        print("🎉 ALL TESTS PASSED!")
        print("✅ Backend structure is correct")
        print("✅ All modules can be imported")
        print("\n💡 Next steps:")
        print("   1. Install dependencies: pip install -r requirements.txt")
        print("   2. Start server: python -m app.main")
        print("   3. Visit: http://localhost:8000/docs")
        return True
    else:
        print("❌ SOME TESTS FAILED!")
        if not structure_ok:
            print("❌ Fix file structure issues")
        if not imports_ok:
            print("❌ Fix import issues")
        return False

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)