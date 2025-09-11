"""
Pytest configuration and shared fixtures for backend tests.
"""

import pytest
import sys
import os

# Add the app directory to the Python path for imports
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'app'))

# Test configuration
@pytest.fixture(scope="session")
def test_config():
    """Test configuration fixture."""
    return {
        "test_database_url": "test_db_url",
        "test_redis_url": "redis://localhost:6379/1",
        "test_secret_key": "test_secret_key_for_testing"
    }

@pytest.fixture
def mock_db():
    """Mock database fixture for testing."""
    class MockDB:
        def __init__(self):
            self.data = {}

        async def get_document(self, collection, doc_id):
            return self.data.get(collection, {}).get(doc_id)

        async def create_document(self, collection, data):
            if collection not in self.data:
                self.data[collection] = {}
            doc_id = data.get('id', f"mock_{len(self.data[collection])}")
            self.data[collection][doc_id] = data
            return doc_id

        async def update_document(self, collection, doc_id, data):
            if collection in self.data and doc_id in self.data[collection]:
                self.data[collection][doc_id].update(data)
                return True
            return False

        async def query_collection(self, collection, filters=None):
            if collection not in self.data:
                return []
            docs = list(self.data[collection].values())
            if filters:
                # Simple filter implementation for testing
                for filter_item in filters:
                    field = filter_item.get('field')
                    operator = filter_item.get('operator')
                    value = filter_item.get('value')
                    if operator == '==':
                        docs = [doc for doc in docs if doc.get(field) == value]
            return docs

    return MockDB()

@pytest.fixture
def sample_user_data():
    """Sample user data for testing."""
    return {
        "id": "test_user_123",
        "email": "test@example.com",
        "tier": "free",
        "is_active": True,
        "usage_stats": {
            "practice_mcqs_today": 5,
            "explanations_used_today": 1,
            "sprint_exams_used": 0,
            "simulated_exams_used": 0,
            "last_reset": "2024-01-01"
        }
    }

@pytest.fixture
def sample_anonymous_user_data():
    """Sample anonymous user data for testing."""
    return {
        "id": "anon_user_456",
        "tier": "anonymous",
        "is_active": True,
        "usage_stats": {
            "practice_mcqs_today": 15,
            "explanations_used_today": 2,
            "sprint_exams_used": 0,
            "simulated_exams_used": 0,
            "last_reset": "2024-01-01"
        }
    }

@pytest.fixture
def sample_paid_user_data():
    """Sample paid user data for testing."""
    return {
        "id": "paid_user_789",
        "email": "paid@example.com",
        "tier": "paid",
        "is_active": True,
        "usage_stats": {
            "practice_mcqs_today": 75,
            "explanations_used_today": 50,
            "sprint_exams_used": 2,
            "simulated_exams_used": 1,
            "last_reset": "2024-01-01"
        }
    }