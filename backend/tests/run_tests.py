#!/usr/bin/env python3
"""
Test runner script for backend tier-based limits testing.
"""

import subprocess
import sys
import os

def run_tests():
    """Run all backend tests."""
    print("🚀 Running Backend Tier-Based Limits Tests")
    print("=" * 50)

    # Change to the backend directory
    backend_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(backend_dir)

    # Test files to run
    test_files = [
        "test_limits_config.py",
        "test_limits_service.py",
        "test_rate_limiter.py"
    ]

    success_count = 0
    total_tests = len(test_files)

    for test_file in test_files:
        print(f"\n📋 Running {test_file}...")
        print("-" * 30)

        try:
            # Run pytest on the specific test file
            result = subprocess.run([
                sys.executable, "-m", "pytest",
                test_file,
                "-v",
                "--tb=short"
            ], capture_output=True, text=True, cwd=backend_dir)

            if result.returncode == 0:
                print(f"✅ {test_file} PASSED")
                success_count += 1
            else:
                print(f"❌ {test_file} FAILED")
                print("STDOUT:", result.stdout)
                print("STDERR:", result.stderr)

        except Exception as e:
            print(f"❌ Error running {test_file}: {e}")

    print("\n" + "=" * 50)
    print(f"📊 Test Results: {success_count}/{total_tests} test files passed")

    if success_count == total_tests:
        print("🎉 All tests passed!")
        return True
    else:
        print("⚠️  Some tests failed. Please check the output above.")
        return False

def run_specific_test(test_name):
    """Run a specific test."""
    print(f"🎯 Running specific test: {test_name}")
    backend_dir = os.path.dirname(os.path.abspath(__file__))

    try:
        result = subprocess.run([
            sys.executable, "-m", "pytest",
            f"{test_name}.py",
            "-v",
            "--tb=short"
        ], cwd=backend_dir)

        return result.returncode == 0

    except Exception as e:
        print(f"Error running test {test_name}: {e}")
        return False

if __name__ == "__main__":
    if len(sys.argv) > 1:
        test_name = sys.argv[1]
        success = run_specific_test(test_name)
    else:
        success = run_tests()

    sys.exit(0 if success else 1)