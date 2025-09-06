#!/usr/bin/env python3
"""
Quick test server - no dependencies needed
Run this to test your Flutter app API integration
"""

import http.server
import json
import uuid
from datetime import datetime
from urllib.parse import urlparse, parse_qs

class CORSHandler(http.server.BaseHTTPRequestHandler):
    def _set_cors_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type, Authorization')
        self.send_header('Content-Type', 'application/json')

    def do_OPTIONS(self):
        self.send_response(200)
        self._set_cors_headers()
        self.end_headers()

    def do_GET(self):
        if self.path == '/' or self.path == '/health':
            self.send_response(200)
            self._set_cors_headers()
            self.end_headers()
            response = {
                "message": "EntryTestGuru Test API is running",
                "status": "healthy",
                "timestamp": datetime.now().isoformat()
            }
            self.wfile.write(json.dumps(response).encode())
        else:
            self.send_response(404)
            self._set_cors_headers()
            self.end_headers()
            self.wfile.write(json.dumps({"error": "Not found"}).encode())

    def do_POST(self):
        content_length = int(self.headers.get('Content-Length', 0))
        post_data = self.rfile.read(content_length).decode('utf-8') if content_length > 0 else '{}'
        
        try:
            request_data = json.loads(post_data) if post_data else {}
        except:
            request_data = {}

        # Mock responses for different endpoints
        if self.path == '/api/v1/auth/anonymous':
            self._handle_anonymous_login()
        elif self.path == '/api/v1/auth/login':
            self._handle_login(request_data)
        elif self.path == '/api/v1/auth/register':
            self._handle_register(request_data)
        elif self.path == '/api/v1/auth/google':
            self._handle_google_auth(request_data)
        else:
            self.send_response(404)
            self._set_cors_headers()
            self.end_headers()
            self.wfile.write(json.dumps({"error": "Endpoint not found"}).encode())

    def _handle_anonymous_login(self):
        user_id = f"anon_{uuid.uuid4().hex[:8]}"
        response = {
            "access_token": f"test_access_{user_id}",
            "refresh_token": f"test_refresh_{user_id}",
            "token_type": "bearer",
            "user": {
                "id": user_id,
                "email": None,
                "exam_type": None,
                "tier": "anonymous",
                "is_active": True,
                "is_verified": None,
                "created_at": datetime.now().isoformat(),
                "profile": {},
                "usage_stats": {
                    "practice_mcqs_today": 0,
                    "explanations_used_today": 0,
                    "sprint_exams_used": 0,
                    "simulated_exams_used": 0,
                    "last_reset": datetime.now().date().isoformat()
                }
            }
        }
        self._send_json_response(200, response)

    def _handle_login(self, data):
        email = data.get('email', 'test@example.com')
        user_id = f"user_{uuid.uuid4().hex[:8]}"
        response = {
            "access_token": f"test_access_{user_id}",
            "refresh_token": f"test_refresh_{user_id}",
            "token_type": "bearer",
            "user": {
                "id": user_id,
                "email": email,
                "exam_type": "ECAT",
                "tier": "free",
                "is_active": True,
                "is_verified": True,
                "created_at": datetime.now().isoformat(),
                "profile": {},
                "usage_stats": {
                    "practice_mcqs_today": 5,
                    "explanations_used_today": 2,
                    "sprint_exams_used": 1,
                    "simulated_exams_used": 0,
                    "last_reset": datetime.now().date().isoformat()
                }
            }
        }
        self._send_json_response(200, response)

    def _handle_register(self, data):
        email = data.get('email', 'new@example.com')
        user_id = f"user_{uuid.uuid4().hex[:8]}"
        user = {
            "id": user_id,
            "email": email,
            "exam_type": data.get('exam_type', 'ECAT'),
            "tier": "free",
            "is_active": True,
            "is_verified": False,
            "created_at": datetime.now().isoformat(),
            "profile": data.get('profile', {}),
            "usage_stats": {
                "practice_mcqs_today": 0,
                "explanations_used_today": 0,
                "sprint_exams_used": 0,
                "simulated_exams_used": 0,
                "last_reset": datetime.now().date().isoformat()
            }
        }
        self._send_json_response(200, user)

    def _handle_google_auth(self, data):
        user_id = f"google_{uuid.uuid4().hex[:8]}"
        response = {
            "access_token": f"test_access_{user_id}",
            "refresh_token": f"test_refresh_{user_id}",
            "token_type": "bearer",
            "user": {
                "id": user_id,
                "email": "googleuser@gmail.com",
                "exam_type": data.get('exam_type', 'ECAT'),
                "tier": "free",
                "is_active": True,
                "is_verified": True,
                "created_at": datetime.now().isoformat(),
                "profile": {"name": "Google User"},
                "usage_stats": {
                    "practice_mcqs_today": 0,
                    "explanations_used_today": 0,
                    "sprint_exams_used": 0,
                    "simulated_exams_used": 0,
                    "last_reset": datetime.now().date().isoformat()
                }
            }
        }
        self._send_json_response(200, response)

    def _send_json_response(self, status_code, data):
        self.send_response(status_code)
        self._set_cors_headers()
        self.end_headers()
        self.wfile.write(json.dumps(data).encode())

    def log_message(self, format, *args):
        print(f"[{datetime.now().strftime('%H:%M:%S')}] {format % args}")

if __name__ == "__main__":
    PORT = 8000
    print("Starting EntryTestGuru Test API Server...")
    print(f"Server: http://localhost:{PORT}")
    print("Test your Flutter app now!")
    print("=" * 50)
    
    server = http.server.HTTPServer(("localhost", PORT), CORSHandler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nServer stopped")
        server.server_close()