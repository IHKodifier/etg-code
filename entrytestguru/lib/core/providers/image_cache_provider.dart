import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider that handles precaching of critical images
final imageCacheProvider = FutureProvider<void>((ref) async {
  // This provider can be used to trigger image caching
  // but the actual precaching needs to happen with a context
  return Future.value();
});

/// Provider for checking if hero image is cached
final heroImageCachedProvider = FutureProvider<bool>((ref) async {
  // In a real implementation, you might check if the image is cached
  // For now, we'll just return true after a short delay
  await Future.delayed(const Duration(milliseconds: 100));
  return true;
});

/// Function to precache the hero image
/// This should be called with a valid BuildContext
Future<void> precacheHeroImage(BuildContext context) async {
  await precacheImage(
    const AssetImage('assets/images/exam_hero_bg.webp'),
    context,
  );
}
