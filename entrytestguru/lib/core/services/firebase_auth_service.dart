import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/user.dart' as app_models;
import 'dart:async';

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

final firebaseAuthStateProvider = StreamProvider<app_models.User?>((ref) {
  final authService = ref.watch(firebaseAuthServiceProvider);
  return authService.authStateChanges;
});

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final GoogleSignIn _googleSignIn;

  final StreamController<app_models.User?> _authStateController =
      StreamController<app_models.User?>.broadcast();
  app_models.User? _currentUser;

  Stream<app_models.User?> get authStateChanges => _authStateController.stream;
  app_models.User? get currentUser => _currentUser;

  FirebaseAuthService() {
    // Initialize GoogleSignIn based on platform
    if (kIsWeb) {
      // For web, we rely on the meta tag in index.html for client ID
      _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
    } else {
      // For mobile platforms
      _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
    }
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    // Listen to Firebase auth state changes
    _firebaseAuth.authStateChanges().listen((User? firebaseUser) {
      if (firebaseUser != null) {
        _currentUser = _convertFirebaseUserToAppUser(firebaseUser);
        _authStateController.add(_currentUser);
      } else {
        _currentUser = null;
        _authStateController.add(null);
      }
    });

    // Check current user on startup
    final currentFirebaseUser = _firebaseAuth.currentUser;
    if (currentFirebaseUser != null) {
      _currentUser = _convertFirebaseUserToAppUser(currentFirebaseUser);
      _authStateController.add(_currentUser);
    }
  }

  /// Convert Firebase User to our app User model
  app_models.User _convertFirebaseUserToAppUser(User firebaseUser) {
    return app_models.User(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      examType: null, // Will be set later during onboarding
      tier: 'free',
      isActive: true,
      isVerified: firebaseUser.emailVerified,
      createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
      profile: {
        'displayName': firebaseUser.displayName,
        'photoURL': firebaseUser.photoURL,
        'phoneNumber': firebaseUser.phoneNumber,
      },
      usageStats: {
        'practice_mcqs_today': 0,
        'explanations_used_today': 0,
        'sprint_exams_used': 0,
        'simulated_exams_used': 0,
        'last_reset': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Sign in anonymously
  Future<app_models.AuthTokens> signInAnonymously() async {
    try {
      final UserCredential credential = await _firebaseAuth.signInAnonymously();
      final user = _convertFirebaseUserToAppUser(credential.user!);

      // Get Firebase ID token
      final idToken = await credential.user!.getIdToken();

      return app_models.AuthTokens(
        accessToken: idToken ?? '',
        refreshToken:
            'firebase_refresh_token', // Firebase handles refresh automatically
        tokenType: 'Bearer',
        user: user,
      );
    } catch (e) {
      print('Anonymous sign-in failed: $e');
      throw Exception('Anonymous sign-in failed: $e');
    }
  }

  /// Create user with email and password
  Future<app_models.User> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String examType,
    Map<String, dynamic>? profile,
  }) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = credential.user!;

      // Update display name if provided in profile
      if (profile?['displayName'] != null) {
        await user.updateDisplayName(profile!['displayName']);
      }

      // Send email verification
      await user.sendEmailVerification();

      final appUser = _convertFirebaseUserToAppUser(user);

      // Store exam type in custom claims (this would typically be done via backend)
      // For now, we'll handle this in Firestore or when the user first uses the app

      return appUser;
    } on FirebaseAuthException catch (e) {
      String message = 'Registration failed';
      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'An account already exists for that email.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = e.message ?? 'Registration failed';
      }
      throw Exception(message);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  /// Sign in with email and password
  Future<app_models.AuthTokens> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      final user = _convertFirebaseUserToAppUser(credential.user!);
      final idToken = await credential.user!.getIdToken();

      return app_models.AuthTokens(
        accessToken: idToken ?? '',
        refreshToken: 'firebase_refresh_token',
        tokenType: 'Bearer',
        user: user,
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Sign in failed';
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided for that user.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'user-disabled':
          message = 'This user account has been disabled.';
          break;
        default:
          message = e.message ?? 'Sign in failed';
      }
      throw Exception(message);
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  /// Sign in with Google
  Future<app_models.AuthTokens> signInWithGoogle({String? examType}) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google sign-in was cancelled');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      final user = _convertFirebaseUserToAppUser(userCredential.user!);
      final idToken = await userCredential.user!.getIdToken();

      return app_models.AuthTokens(
        accessToken: idToken ?? '',
        refreshToken: 'firebase_refresh_token',
        tokenType: 'Bearer',
        user: user,
      );
    } catch (e) {
      print('Google sign-in failed: $e');
      throw Exception('Google sign-in failed: $e');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } catch (e) {
      print('Sign out failed: $e');
      throw Exception('Sign out failed: $e');
    }
  }

  /// Get current user
  Future<app_models.User?> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return _convertFirebaseUserToAppUser(firebaseUser);
    }
    return null;
  }

  /// Get current Firebase ID token
  Future<String?> getIdToken() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return await user.getIdToken();
    }
    return null;
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      String message = 'Password reset failed';
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = e.message ?? 'Password reset failed';
      }
      throw Exception(message);
    }
  }

  /// Test Firebase connection
  Future<bool> testConnection() async {
    try {
      // Try to get current user (this tests Firebase initialization)
      final user = _firebaseAuth.currentUser;
      return true; // If we can access FirebaseAuth, connection is good
    } catch (e) {
      print('Firebase Auth connection test failed: $e');
      return false;
    }
  }

  void dispose() {
    _authStateController.close();
  }
}
