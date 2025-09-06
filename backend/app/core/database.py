from google.cloud import firestore
from google.oauth2 import service_account
from typing import Dict, List, Optional, Any
import json
import logging
from app.core.config import settings

logger = logging.getLogger(__name__)

class FirestoreClient:
    """Firebase Firestore database client"""
    
    def __init__(self):
        self._client = None
        self._initialize_client()
    
    def _initialize_client(self):
        """Initialize Firestore client"""
        try:
            # For development, use application default credentials
            # For production, use service account key
            if settings.ENVIRONMENT == "development":
                self._client = firestore.Client(project=settings.FIREBASE_PROJECT_ID)
            else:
                # Use service account credentials
                credentials_dict = {
                    "type": "service_account",
                    "project_id": settings.FIREBASE_PROJECT_ID,
                    "private_key_id": settings.FIREBASE_PRIVATE_KEY_ID,
                    "private_key": settings.FIREBASE_PRIVATE_KEY.replace("\\n", "\n") if settings.FIREBASE_PRIVATE_KEY else None,
                    "client_email": settings.FIREBASE_CLIENT_EMAIL,
                    "client_id": settings.FIREBASE_CLIENT_ID,
                    "auth_uri": settings.FIREBASE_AUTH_URI,
                    "token_uri": settings.FIREBASE_TOKEN_URI,
                    "auth_provider_x509_cert_url": settings.FIREBASE_AUTH_PROVIDER_CERT_URL,
                    "client_x509_cert_url": settings.FIREBASE_CLIENT_CERT_URL
                }
                
                credentials = service_account.Credentials.from_service_account_info(credentials_dict)
                self._client = firestore.Client(credentials=credentials, project=settings.FIREBASE_PROJECT_ID)
            
            logger.info(f"Firestore client initialized for project: {settings.FIREBASE_PROJECT_ID}")
        except Exception as e:
            logger.error(f"Failed to initialize Firestore client: {e}")
            raise
    
    @property
    def client(self) -> firestore.Client:
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
            doc_ref = self.client.collection(collection).document(document_id)
            doc_ref.update(data)
            return True
        except Exception as e:
            logger.error(f"Failed to update document {document_id} in {collection}: {e}")
            return False
    
    async def delete_document(self, collection: str, document_id: str) -> bool:
        """Delete a document"""
        try:
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
            batch = self.client.batch()
            
            for op in operations:
                operation_type = op.get('type')  # 'create', 'update', 'delete'
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