import 'package:flutter/material.dart';
import 'package:splash_test/modules/features/auth/presentaion/login_screen.dart';
import 'package:splash_test/modules/features/dashboard/presentation/dashboard_screen.dart';
import 'package:splash_test/modules/features/splash/presentation/splash_screen.dart'; // Make sure to import your splash file here!

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // 🚀 THE FIX: Added handler for the initial root launch route
      case splash:
        return MaterialPageRoute(
          builder: (_) => const MultiStageSplashScreen(),
        );

      case login:
        return PageRouteBuilder(
          pageBuilder: (context, anim, secondaryAnim) => const LoginScreen(),
          transitionsBuilder: (context, anim, secondaryAnim, child) {
            return FadeTransition(
              opacity: CurvedAnimation(parent: anim, curve: Curves.easeIn),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.06), 
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 700),
        );

      case dashboard:
        return MaterialPageRoute(builder: (_) => const AnimatedDashboardScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route found for ${settings.name}')),
          ),
        );
    }
  }
}