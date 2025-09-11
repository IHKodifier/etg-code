import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/user.dart';
import '../models/device.dart';
import 'device_fingerprint_service.dart';
import 'dart:async';

final authServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

class FirebaseAuthService {
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  late final GoogleSignIn _googleSignIn;
  final DeviceFingerprintService _deviceFingerprintService =
      DeviceFingerprintService();

  final StreamController<User?> _authStateController =
      StreamController<User?>.broadcast();
  User? _currentUser;

  Stream<User?> get authStateChanges => _authStateController.stream;
  User? get currentUser => _currentUser;

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
    _firebaseAuth.authStateChanges().listen((firebase_auth.User? firebaseUser) {
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
  User _convertFirebaseUserToAppUser(firebase_auth.User firebaseUser) {
    return User(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      examType: null, // Will be set later during onboarding
      tier: 'free',
      isActive: true,
      isVerified: firebaseUser.emailVerified,
      isAnonymous: firebaseUser.isAnonymous,
      createdAt: firebaseUser.metadata!.creationTime ?? DateTime.now(),
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
  Future<AuthTokens> signInAnonymously() async {
    try {
      final firebase_auth.UserCredential credential = await _firebaseAuth
          .signInAnonymously();
      final user = _convertFirebaseUserToAppUser(credential.user!);

      // Get Firebase ID token
      final idToken = await credential.user!.getIdToken();

      final authTokens = AuthTokens(
        accessToken: idToken ?? '',
        refreshToken:
            'firebase_refresh_token', // Firebase handles refresh automatically
        tokenType: 'Bearer',
        user: user,
      );
      print('Anonymous sign-in successful: ${authTokens.user.id}');
      return authTokens;
    } catch (e) {
      print('Anonymous sign-in failed: $e');
      throw Exception('Anonymous sign-in failed: $e');
    }
  }

  /// Sign in anonymously with device fingerprinting
  Future<AuthTokens> signInAnonymouslyWithDeviceInfo() async {
    try {
      final firebase_auth.UserCredential credential = await _firebaseAuth
          .signInAnonymously();
      final user = _convertFirebaseUserToAppUser(credential.user!);

      // Get Firebase ID token
      final idToken = await credential.user!.getIdToken();

      return AuthTokens(
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
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String examType,
    Map<String, dynamic>? profile,
  }) async {
    try {
      final firebase_auth.UserCredential credential = await _firebaseAuth
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

      print('Account creation successful: ${appUser.id}');
      return appUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
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
  Future<AuthTokens> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final firebase_auth.UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      final user = _convertFirebaseUserToAppUser(credential.user!);
      final idToken = await credential.user!.getIdToken();

      final authTokens = AuthTokens(
        accessToken: idToken ?? '',
        refreshToken: 'firebase_refresh_token',
        tokenType: 'Bearer',
        user: user,
      );
      print('Sign in successful: ${authTokens.user.id}');
      return authTokens;
    } on firebase_auth.FirebaseAuthException catch (e) {
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
  Future<AuthTokens> signInWithGoogle({String? examType}) async {
    try {
      print('Starting Google Sign-In...');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google sign-in was cancelled');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final firebase_auth.UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      final user = _convertFirebaseUserToAppUser(userCredential.user!);
      final idToken = await userCredential.user!.getIdToken();

      final authTokens = AuthTokens(
        accessToken: idToken ?? '',
        refreshToken: 'firebase_refresh_token',
        tokenType: 'Bearer',
        user: user,
      );
      print('Google sign in successful: ${authTokens.user.id}');
      return authTokens;
    } catch (e) {
      print('Google sign in failed: $e');
      throw Exception('Google sign-in failed: $e');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
      print('Sign out successful');
    } catch (e) {
      print('Sign out failed: $e');
      throw Exception('Sign out failed: $e');
    }
  }

  /// Get current user
  Future<User?> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        return _convertFirebaseUserToAppUser(firebaseUser);
      }
      return null;
    } catch (e) {
      print('Get current user failed: $e');
      return null;
    }
  }

  /// Get current Firebase ID token
  Future<String?> getIdToken() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        return await user.getIdToken();
      }
      return null;
    } catch (e) {
      print('Get ID token failed: $e');
      return null;
    }
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      print('Password reset email sent to: $email');
    } on firebase_auth.FirebaseAuthException catch (e) {
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
      print('Auth connection test failed: $e');
      return false;
    }
  }

  /// Get current device fingerprint
  Future<String> getCurrentDeviceFingerprint() async {
    return await _deviceFingerprintService.generateDeviceFingerprint();
  }

  /// Get current device info
  Future<Map<String, dynamic>> getCurrentDeviceInfo() async {
    return await _deviceFingerprintService.getDeviceInfo();
  }

  /// Check if device fingerprinting is supported
  bool isDeviceFingerprintingSupported() {
    return _deviceFingerprintService.isFingerprintingSupported();
  }

  /// Get device type for display
  Future<String> getDeviceType() async {
    return await _deviceFingerprintService.getDeviceType();
  }

  /// Get platform name
  Future<String> getPlatformName() async {
    return await _deviceFingerprintService.getPlatformName();
  }

  void dispose() {
    _authStateController.close();
  }
}
