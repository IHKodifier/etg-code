import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'core/providers/image_cache_provider.dart';

import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TEMPORARY: Clear old tokens to force fresh authentication
  const storage = FlutterSecureStorage();
  await storage.deleteAll();
  print('Cleared all stored tokens');

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Handle Firebase initialization error
    print('Firebase initialization failed: $e');
  }

  runApp(const ProviderScope(child: EntryTestGuruApp()));
}
