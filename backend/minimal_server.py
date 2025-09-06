#!/usr/bin/env python3
"""
Minimal HTTP server to test our backend endpoints without external dependencies
"""
import http.server
import socketserver
import json
import urllib.parse
from datetime import datetime

class EntryTestGuruHandler(http.server.BaseHTTPRequestHandler):
    """Custom handler for our API endpoints"""
    
    def do_GET(self):
        """Handle GET requests"""
        path = self.path
        
        if path == '/':
            self.send_json_response(200, {
                "message": "EntryTestGuru API is running",
                "version": "1.0.0",
                "environment": "development",
                "docs": "/docs"
            })
        
        elif path == '/health':
            self.send_json_response(200, {
                "status": "healthy", 
                "service": "entrytestguru-api",
                "version": "1.0.0",
                "timestamp": datetime.now().isoformat()
            })
        
        elif path == '/docs':
            self.send_html_response(200, """
            <html>
            <head><title>EntryTestGuru API Documentation</title></head>
            <body>
                <h1>EntryTestGuru API</h1>
                <h2>Available Endpoints:</h2>
                <ul>
                    <li><a href="/">GET / - Root endpoint</a></li>
                    <li><a href="/health">GET /health - Health check</a></li>
                    <li>POST /api/v1/auth/register - User registration</li>
                    <li>POST /api/v1/auth/login - User login</li>
                    <li>POST /api/v1/auth/anonymous - Anonymous login</li>
                    <li>GET /api/v1/questions/practice - Get practice questions</li>
                </ul>
                <p><strong>Status:</strong> Backend structure is complete!</p>
                <p><strong>Note:</strong> This is a minimal test server. Full functionality requires FastAPI.</p>
            </body>
            </html>
            """)
        
        elif path.startswith('/api/'):
            self.send_json_response(200, {
                "message": f"API endpoint: {path}",
                "status": "Backend structure ready",
                "note": "Full implementation requires FastAPI dependencies"
            })
        
        else:
            self.send_json_response(404, {"error": "Endpoint not found"})
    
    def do_POST(self):
        """Handle POST requests"""
        path = self.path
        
        # Read POST data
        content_length = int(self.headers.get('Content-Length', 0))
        post_data = self.rfile.read(content_length).decode('utf-8')
        
        if path.startswith('/api/v1/auth/'):
            self.send_json_response(200, {
                "message": f"Auth endpoint: {path}",
                "received_data": json.loads(post_data) if post_data else None,
                "status": "Backend structure ready"
            })
        
        elif path.startswith('/api/v1/'):
            self.send_json_response(200, {
                "message": f"API endpoint: {path}",
                "status": "Backend ready for FastAPI implementation"
            })
        
        else:
            self.send_json_response(404, {"error": "Endpoint not found"})
    
    def send_json_response(self, status_code, data):
        """Send JSON response"""
        self.send_response(status_code)
        self.send_header('Content-type', 'application/json')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()
        response = json.dumps(data, indent=2)
        self.wfile.write(response.encode('utf-8'))
    
    def send_html_response(self, status_code, html):
        """Send HTML response"""
        self.send_response(status_code)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(html.encode('utf-8'))
    
    def log_message(self, format, *args):
        """Override to customize logging"""
        print(f"[{datetime.now().strftime('%H:%M:%S')}] {format % args}")

def start_server(port=8000):
    """Start the minimal server"""
    try:
        with socketserver.TCPServer(("", port), EntryTestGuruHandler) as httpd:
            print(f"EntryTestGuru Backend Test Server")
            print(f"Server running at: http://localhost:{port}")
            print(f"API Documentation: http://localhost:{port}/docs")
            print(f"Health Check: http://localhost:{port}/health")
            print("Press Ctrl+C to stop")
            print("=" * 50)
            httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nShutting down server...")
    except OSError as e:
        print(f"Error starting server on port {port}: {e}")
        print("Try a different port or check if port is already in use")

if __name__ == "__main__":
    start_server()