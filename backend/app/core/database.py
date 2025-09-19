import os 
from google.cloud import firestore
from google.oauth2 import service_account
from typing import Dict, List, Optional, Any, Union
import json
import logging
import uuid
from app.core.config import settings

logger = logging.getLogger(__name__)

class MockFirestoreClient:
    """Mock Firestore client for testing without Firebase setup"""
    
    def __init__(self):
        self._data: Dict[str, Dict[str, Any]] = {}
        logger.info("Mock Firestore client initialized")
    
    async def create_document(
        self, 
        collection: str, 
        data: Dict[str, Any], 
        document_id: Optional[str] = None
    ) -> str:
        """Create a document"""
        try:
            if not document_id:
                document_id = str(uuid.uuid4())
            
            if collection not in self._data:
                self._data[collection] = {}
            
            data_copy = data.copy()
            data_copy['id'] = document_id
            self._data[collection][document_id] = data_copy
            return document_id
        except Exception as e:
            logger.error(f"Failed to create document in {collection}: {e}")
            raise
    
    async def get_document(self, collection: str, document_id: str) -> Optional[Dict[str, Any]]:
        """Get a document by ID"""
        try:
            return self._data.get(collection, {}).get(document_id)
        except Exception as e:
            logger.error(f"Failed to get document {document_id} from {collection}: {e}")
            raise
    
    async def update_document(
        self, 
        collection: str, 
        document_id: str, 
        data: Dict[str, Any]
    ) -> bool:
        """Update a document"""
        try:
            if collection in self._data and document_id in self._data[collection]:
                self._data[collection][document_id].update(data)
                return True
            return False
        except Exception as e:
            logger.error(f"Failed to update document {document_id} in {collection}: {e}")
            return False
    
    async def delete_document(self, collection: str, document_id: str) -> bool:
        """Delete a document"""
        try:
            if collection in self._data and document_id in self._data[collection]:
                del self._data[collection][document_id]
                return True
            return False
        except Exception as e:
            logger.error(f"Failed to delete document {document_id} from {collection}: {e}")
            return False
    
    async def query_collection(
        self,
        collection: str,
        filters: Optional[List[Dict[str, Any]]] = None,
        order_by: Optional[str] = None,
        limit: Optional[int] = None,
        offset: Optional[int] = None
    ) -> List[Dict[str, Any]]:
        """Query a collection with filters"""
        try:
            if collection not in self._data:
                return []
            
            results = list(self._data[collection].values())
            
            # Apply filters
            if filters:
                for filter_dict in filters:
                    field = filter_dict.get('field')
                    operator = filter_dict.get('operator', '==')
                    value = filter_dict.get('value')
                    
                    if operator == '==':
                        results = [r for r in results if r.get(field) == value]
            
            # Apply offset and limit
            if offset:
                results = results[offset:]
            if limit:
                results = results[:limit]
            
            return results
        except Exception as e:
            logger.error(f"Failed to query collection {collection}: {e}")
            raise
    
    async def batch_write(self, operations: List[Dict[str, Any]]) -> bool:
        """Perform batch write operations"""
        try:
            for op in operations:
                operation_type = op.get('type')
                collection = op.get('collection')
                document_id = op.get('document_id')
                data = op.get('data', {})
                
                if operation_type == 'create':
                    await self.create_document(collection, data, document_id)
                elif operation_type == 'update':
                    await self.update_document(collection, document_id, data)
                elif operation_type == 'delete':
                    await self.delete_document(collection, document_id)
            
            return True
        except Exception as e:
            logger.error(f"Failed to perform batch write: {e}")
            return False

class FirestoreClient:
    """Firebase Firestore database client"""
    
    def __init__(self):
        self._client: Optional[Union[firestore.Client, MockFirestoreClient]] = None
        self._initialize_client()
    
    def _initialize_client(self):
        """Initialize Firestore client"""
        try:
            # Check if we should use mock database
            if (os.getenv('USE_MOCK_DB') == 'true' or
                os.getenv('TESTING') == 'true'):

                self._client = MockFirestoreClient()
                logger.info("Using mock database for testing")
                return

            # Try to load credentials from service account key file
            key_file_path = os.path.join(os.path.dirname(__file__), '..', '..', '..', 'firebase-service-account-key.json')
            if os.path.exists(key_file_path):
                with open(key_file_path, 'r') as f:
                    credentials_dict = json.load(f)

                credentials = service_account.Credentials.from_service_account_info(credentials_dict)
                self._client = firestore.Client(credentials=credentials, project=credentials_dict['project_id'])
                logger.info(f"Firestore client initialized for project: {credentials_dict['project_id']} using service account key")
                return

            # Fallback to environment variables
            if not settings.FIREBASE_PROJECT_ID:
                raise ValueError("Firebase project ID not configured")

            # Use application default credentials for development
            self._client = firestore.Client(project=settings.FIREBASE_PROJECT_ID)
            logger.info(f"Firestore client initialized for project: {settings.FIREBASE_PROJECT_ID} using ADC")

        except Exception as e:
            logger.error(f"Failed to initialize Firestore client: {e}")
            # Fallback to mock client
            self._client = MockFirestoreClient()
            logger.warning("Falling back to mock database due to initialization error")
    
    @property
    def client(self) -> Union[firestore.Client, MockFirestoreClient]:
        """Get Firestore client"""
        if self._client is None:
            self._initialize_client()
        return self._client
    
    async def create_document(
        self, 
        collection: str, 
        data: Dict[str, Any], 
        document_id: Optional[str] = None
    ) -> str:
        """Create a document"""
        try:
            if isinstance(self._client, MockFirestoreClient):
                return await self._client.create_document(collection, data, document_id)
            
            # Real Firebase logic
            if document_id:
                doc_ref = self.client.collection(collection).document(document_id)
                doc_ref.set(data)
                return document_id
            else:
                doc_ref = self.client.collection(collection).add(data)
                return doc_ref[1].id
        except Exception as e:
            logger.error(f"Failed to create document in {collection}: {e}")
            raise
    
    async def get_document(self, collection: str, document_id: str) -> Optional[Dict[str, Any]]:
        """Get a document by ID"""
        try:
            if isinstance(self._client, MockFirestoreClient):
                return await self._client.get_document(collection, document_id)
            
            # Real Firebase logic
            doc_ref = self.client.collection(collection).document(document_id)
            doc = doc_ref.get()
            
            if doc.exists:
                data = doc.to_dict()
                data['id'] = doc.id
                return data
            return None
        except Exception as e:
            logger.error(f"Failed to get document {document_id} from {collection}: {e}")
            raise
    
    async def update_document(
        self, 
        collection: str, 
        document_id: str, 
        data: Dict[str, Any]
    ) -> bool:
        """Update a document"""
        try:
            if isinstance(self._client, MockFirestoreClient):
                return await self._client.update_document(collection, document_id, data)
            
            # Real Firebase logic
            doc_ref = self.client.collection(collection).document(document_id)
            doc_ref.update(data)
            return True
        except Exception as e:
            logger.error(f"Failed to update document {document_id} in {collection}: {e}")
            return False
    
    async def delete_document(self, collection: str, document_id: str) -> bool:
        """Delete a document"""
        try:
            if isinstance(self._client, MockFirestoreClient):
                return await self._client.delete_document(collection, document_id)
            
            # Real Firebase logic
            doc_ref = self.client.collection(collection).document(document_id)
            doc_ref.delete()
            return True
        except Exception as e:
            logger.error(f"Failed to delete document {document_id} from {collection}: {e}")
            return False
    
    async def query_collection(
        self,
        collection: str,
        filters: Optional[List[Dict[str, Any]]] = None,
        order_by: Optional[str] = None,
        limit: Optional[int] = None,
        offset: Optional[int] = None
    ) -> List[Dict[str, Any]]:
        """Query a collection with filters"""
        try:
            if isinstance(self._client, MockFirestoreClient):
                return await self._client.query_collection(collection, filters, order_by, limit, offset)
            
            # Real Firebase logic
            query = self.client.collection(collection)
            
            # Apply filters
            if filters:
                for filter_dict in filters:
                    field = filter_dict.get('field')
                    operator = filter_dict.get('operator', '==')
                    value = filter_dict.get('value')
                    query = query.where(field, operator, value)
            
            # Apply ordering
            if order_by:
                if order_by.startswith('-'):
                    query = query.order_by(order_by[1:], direction=firestore.Query.DESCENDING)
                else:
                    query = query.order_by(order_by, direction=firestore.Query.ASCENDING)
            
            # Apply pagination
            if offset:
                query = query.offset(offset)
            if limit:
                query = query.limit(limit)
            
            docs = query.stream()
            results = []
            
            for doc in docs:
                data = doc.to_dict()
                data['id'] = doc.id
                results.append(data)
            
            return results
        except Exception as e:
            logger.error(f"Failed to query collection {collection}: {e}")
            raise
    
    async def batch_write(self, operations: List[Dict[str, Any]]) -> bool:
        """Perform batch write operations"""
        try:
            if isinstance(self._client, MockFirestoreClient):
                return await self._client.batch_write(operations)
            
            # Real Firebase logic
            batch = self.client.batch()
            
            for op in operations:
                operation_type = op.get('type')
                collection = op.get('collection')
                document_id = op.get('document_id')
                data = op.get('data', {})
                
                doc_ref = self.client.collection(collection).document(document_id)
                
                if operation_type == 'create':
                    batch.set(doc_ref, data)
                elif operation_type == 'update':
                    batch.update(doc_ref, data)
                elif operation_type == 'delete':
                    batch.delete(doc_ref)
            
            batch.commit()
            return True
        except Exception as e:
            logger.error(f"Failed to perform batch write: {e}")
            return False

# Global database instance
db = FirestoreClient()
