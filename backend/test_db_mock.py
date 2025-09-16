# test_db_mock.py
import sys
from unittest.mock import MagicMock

# Mock the database module
mock_db = MagicMock()
mock_db.create_document = MagicMock(return_value='test_id')
mock_db.get_document = MagicMock(return_value={'id': 'test', 'usage_stats': {'practice_mcqs_today': 0}})
mock_db.update_document = MagicMock(return_value=True)
mock_db.query_collection = MagicMock(return_value=[])

# Replace the real database
sys.modules['app.core.database'] = type(sys)('database')
sys.modules['app.core.database'].db = mock_db

print('Database mocked for testing')
