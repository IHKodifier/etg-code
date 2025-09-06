import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  FirebaseStorage get storage => _storage;

  Future<String?> uploadFile({
    required String path,
    required Uint8List fileBytes,
    required String contentType,
  }) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = ref.putData(
        fileBytes,
        SettableMetadata(contentType: contentType),
      );
      
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('File upload failed: $e');
      return null;
    }
  }

  Future<Uint8List?> downloadFile(String path) async {
    try {
      final ref = _storage.ref().child(path);
      final data = await ref.getData();
      return data;
    } catch (e) {
      print('File download failed: $e');
      return null;
    }
  }

  Future<String?> getDownloadUrl(String path) async {
    try {
      final ref = _storage.ref().child(path);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Getting download URL failed: $e');
      return null;
    }
  }

  Future<bool> deleteFile(String path) async {
    try {
      final ref = _storage.ref().child(path);
      await ref.delete();
      return true;
    } catch (e) {
      print('File deletion failed: $e');
      return false;
    }
  }

  Future<List<Reference>> listFiles(String path) async {
    try {
      final ref = _storage.ref().child(path);
      final result = await ref.listAll();
      return result.items;
    } catch (e) {
      print('Listing files failed: $e');
      return [];
    }
  }

  Future<bool> testConnection() async {
    try {
      print('Testing Firebase Storage connection...');
      
      // Simple test - try to list files in root
      final ref = _storage.ref();
      final result = await ref.listAll().timeout(const Duration(seconds: 10));
      
      print('Storage connection successful. Found ${result.items.length} items in root.');
      return true;
    } catch (e) {
      print('Storage connection test failed: $e');
      return false;
    }
  }
}