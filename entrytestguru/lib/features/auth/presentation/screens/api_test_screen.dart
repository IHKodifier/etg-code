import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/models/user.dart';

class ApiTestScreen extends ConsumerStatefulWidget {
  const ApiTestScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends ConsumerState<ApiTestScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _status = 'Ready to test API endpoints';
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateStatus(String status) {
    setState(() {
      _status = status;
    });
  }

  void _setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  Future<void> _testAnonymousLogin() async {
    _setLoading(true);
    _updateStatus('Testing anonymous login...');

    try {
      final authService = ref.read(authServiceProvider);
      final authTokens = await authService.signInAnonymously();
      _updateStatus(
        '✅ Anonymous login successful! User ID: ${authTokens.user.id}',
      );
    } catch (e) {
      _updateStatus('❌ Anonymous login failed: $e');
    }

    _setLoading(false);
  }

  Future<void> _testRegister() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _updateStatus('❌ Please enter email and password');
      return;
    }

    _setLoading(true);
    _updateStatus('Testing registration...');

    try {
      final authService = ref.read(authServiceProvider);
      final user = await authService.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
        examType: 'ECAT',
      );
      _updateStatus('✅ Registration successful! User ID: ${user.id}');
    } catch (e) {
      _updateStatus('❌ Registration failed: $e');
    }

    _setLoading(false);
  }

  Future<void> _testLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _updateStatus('❌ Please enter email and password');
      return;
    }

    _setLoading(true);
    _updateStatus('Testing login...');

    try {
      final authService = ref.read(authServiceProvider);
      final authTokens = await authService.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      _updateStatus('✅ Login successful! User ID: ${authTokens.user.id}');
    } catch (e) {
      _updateStatus('❌ Login failed: $e');
    }

    _setLoading(false);
  }

  Future<void> _testGoogleSignIn() async {
    _setLoading(true);
    _updateStatus(
      'Testing Google Sign In (Mock)...\nNote: Using mock Google authentication for testing purposes.',
    );

    try {
      final authService = ref.read(authServiceProvider);
      final authTokens = await authService.signInWithGoogle(examType: 'ECAT');

      _updateStatus(
        '✅ Google Sign In (Mock) successful! User ID: ${authTokens.user.id}\nEmail: ${authTokens.user.email}',
      );
    } catch (e) {
      _updateStatus('❌ Google Sign In failed: $e');
    }

    _setLoading(false);
  }

  Future<void> _testGetCurrentUser() async {
    _setLoading(true);
    _updateStatus('Testing get current user...');

    try {
      final authService = ref.read(authServiceProvider);
      final user = await authService.getCurrentUser();
      if (user != null) {
        _updateStatus(
          '✅ Current user: ${user.email ?? 'Anonymous'} (ID: ${user.id})',
        );
      } else {
        _updateStatus('❌ No current user found');
      }
    } catch (e) {
      _updateStatus('❌ Get current user failed: $e');
    }

    _setLoading(false);
  }

  Future<void> _testSignOut() async {
    _setLoading(true);
    _updateStatus('Testing sign out...');

    try {
      final authService = ref.read(authServiceProvider);
      await authService.signOut();
      _updateStatus('✅ Sign out successful!');
    } catch (e) {
      _updateStatus('❌ Sign out failed: $e');
    }

    _setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Test'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Current Auth State
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Auth State:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    authState.when(
                      data: (user) => Text(
                        user != null
                            ? 'Logged in: ${user.email ?? 'Anonymous'} (${user.tier})'
                            : 'Not logged in',
                      ),
                      loading: () => const Text('Loading...'),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Email/Password inputs
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),

            // Test buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : _testAnonymousLogin,
                  child: const Text('Anonymous Login'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _testRegister,
                  child: const Text('Register'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _testLogin,
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _testGoogleSignIn,
                  child: const Text('Google Sign In'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _testGetCurrentUser,
                  child: const Text('Get Current User'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _testSignOut,
                  child: const Text('Sign Out'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Status display
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Test Status:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SingleChildScrollView(child: Text(_status)),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
