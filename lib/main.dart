import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🚀 CRITICAL IMPORTS: Link your new route config location here!
import 'package:splash_test/routes/app_routes.dart'; // Adjust if your file is located elsewhere

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light, // Syncs light-canvas parameters across inputs
      ),
      
      // 🚀 THE FIX: Registers the global custom route handler engine!
      onGenerateRoute: AppRoutes.onGenerateRoute,
      
      // Sets the initial launch endpoint safely using your AppRoutes parameters
      initialRoute: AppRoutes.splash, 
    );
  }
}