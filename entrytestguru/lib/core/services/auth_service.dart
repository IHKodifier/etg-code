import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import 'firebase_auth_service.dart';
import 'dart:async';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref);
});

final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

class AuthService {
  final FirebaseAuthService _firebaseAuthService;

  Stream<User?> get authStateChanges => _firebaseAuthService.authStateChanges;
  User? get currentUser => _firebaseAuthService.currentUser;

  AuthService(Ref ref)
    : _firebaseAuthService = ref.read(firebaseAuthServiceProvider);

  Future<AuthTokens> signInAnonymously() async {
    try {
      final authTokens = await _firebaseAuthService.signInAnonymously();
      print('Anonymous sign-in successful: ${authTokens.user.id}');
      return authTokens;
    } catch (e) {
      print('Anonymous sign-in failed: $e');
      rethrow;
    }
  }

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String examType,
    Map<String, dynamic>? profile,
  }) async {
    try {
      final user = await _firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        examType: examType,
        profile: profile,
      );
      print('Account creation successful: ${user.id}');
      return user;
    } catch (e) {
      print('Account creation failed: $e');
      rethrow;
    }
  }

  Future<AuthTokens> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authTokens = await _firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Sign in successful: ${authTokens.user.id}');
      return authTokens;
    } catch (e) {
      print('Sign in failed: $e');
      rethrow;
    }
  }

  Future<AuthTokens> signInWithGoogle({String? examType}) async {
    try {
      print('Starting Google Sign-In...');
      final authTokens = await _firebaseAuthService.signInWithGoogle(
        examType: examType,
      );
      print('Google sign in successful: ${authTokens.user.id}');
      return authTokens;
    } catch (e) {
      print('Google sign in failed: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuthService.signOut();
      print('Sign out successful');
    } catch (e) {
      print('Sign out failed: $e');
      rethrow;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      return await _firebaseAuthService.getCurrentUser();
    } catch (e) {
      print('Get current user failed: $e');
      return null;
    }
  }

  Future<String?> getIdToken() async {
    try {
      return await _firebaseAuthService.getIdToken();
    } catch (e) {
      print('Get ID token failed: $e');
      return null;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuthService.sendPasswordResetEmail(email);
      print('Password reset email sent to: $email');
    } catch (e) {
      print('Send password reset email failed: $e');
      rethrow;
    }
  }

  Future<bool> testConnection() async {
    try {
      return await _firebaseAuthService.testConnection();
    } catch (e) {
      print('Auth connection test failed: $e');
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    return await _firebaseAuthService.isLoggedIn();
  }

  void dispose() {
    _firebaseAuthService.dispose();
  }
}
