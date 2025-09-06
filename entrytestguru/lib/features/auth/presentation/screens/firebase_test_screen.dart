import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/services/firestore_service.dart';
import '../../../../core/services/storage_service.dart';

class FirebaseTestScreen extends ConsumerStatefulWidget {
  const FirebaseTestScreen({super.key});

  @override
  ConsumerState<FirebaseTestScreen> createState() => _FirebaseTestScreenState();
}

class _FirebaseTestScreenState extends ConsumerState<FirebaseTestScreen> {
  String authStatus = 'Not tested';
  String firestoreStatus = 'Not tested';
  String storageStatus = 'Not tested';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Connection Test'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Firebase Services Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildStatusRow('Authentication', authStatus),
                    _buildStatusRow('Firestore Database', firestoreStatus),
                    _buildStatusRow('Firebase Storage', storageStatus),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Authentication State',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    authState.when(
                      data: (user) => Text(
                        user != null
                            ? 'Signed in: ${user.email == null ? "Anonymous" : user.email!}'
                            : 'Not signed in',
                      ),
                      loading: () => const Text('Loading auth state...'),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isLoading ? null : _testAllServices,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Test All Firebase Services'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _signInAnonymously,
                    child: const Text('Sign In Anonymous'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _signOut,
                    child: const Text('Sign Out'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String service, String status) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'Connected ✅':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'Failed ❌':
        statusColor = Colors.red;
        statusIcon = Icons.error;
        break;
      case 'Testing...':
        statusColor = Colors.orange;
        statusIcon = Icons.hourglass_empty;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help_outline;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 20),
          const SizedBox(width: 8),
          Text('$service: '),
          Text(
            status,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<void> _testAllServices() async {
    setState(() {
      isLoading = true;
      authStatus = 'Testing...';
      firestoreStatus = 'Testing...';
      storageStatus = 'Testing...';
    });

    // Test Authentication
    final authService = ref.read(authServiceProvider);
    final authResult = await authService.testConnection();
    setState(() {
      authStatus = authResult ? 'Connected ✅' : 'Failed ❌';
    });

    // Test Firestore
    final firestoreService = ref.read(firestoreServiceProvider);
    final firestoreResult = await firestoreService.testConnection();
    setState(() {
      firestoreStatus = firestoreResult ? 'Connected ✅' : 'Failed ❌';
    });

    // Test Storage
    final storageService = ref.read(storageServiceProvider);
    final storageResult = await storageService.testConnection();
    setState(() {
      storageStatus = storageResult ? 'Connected ✅' : 'Failed ❌';
      isLoading = false;
    });

    // Show completion message
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Test completed! Auth: ${authResult ? "✅" : "❌"}, '
            'Firestore: ${firestoreResult ? "✅" : "❌"}, '
            'Storage: ${storageResult ? "✅" : "❌"}',
          ),
        ),
      );
    }
  }

  Future<void> _signInAnonymously() async {
    setState(() => isLoading = true);
    final authService = ref.read(authServiceProvider);
    await authService.signInAnonymously();
    setState(() => isLoading = false);
  }

  Future<void> _signOut() async {
    setState(() => isLoading = true);
    final authService = ref.read(authServiceProvider);
    await authService.signOut();
    setState(() => isLoading = false);
  }
}
