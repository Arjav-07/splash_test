import 'package:flutter_riverpod/flutter_riverpod.dart';

// A simple provider to track if the app is fully ready/initialized
final appInitializerProvider = FutureProvider<bool>((ref) async {
  // Simulate loading configurations, fonts, or local storage
  await Future.delayed(const Duration(seconds: 3)); 
  return true;
});