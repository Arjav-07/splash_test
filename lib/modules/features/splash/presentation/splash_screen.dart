import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splash_test/core/constant/app_typography.dart';

// 🚀 CLEANED PATHS: Targeting your feature structure exactly
import 'package:splash_test/modules/features/auth/presentaion/login_screen.dart';
import 'package:splash_test/routes/app_routes.dart'; 
final appInitializerProvider = FutureProvider<bool>((ref) async {
  await Future.delayed(const Duration(seconds: 2)); 
  return true;
});

class MultiStageSplashScreen extends ConsumerStatefulWidget {
  const MultiStageSplashScreen({super.key});

  @override
  ConsumerState<MultiStageSplashScreen> createState() => _MultiStageSplashScreenState();
}

class _MultiStageSplashScreenState extends ConsumerState<MultiStageSplashScreen>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _colorScreenOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3300), 
    );

    _logoOpacity = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 25, 
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
    ]).animate(_controller);

    _logoScale = Tween<double>(begin: 1.0, end: 16.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.65, 0.95, curve: Curves.easeInOutCubic),
      ),
    );

    _colorScreenOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.88, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(appInitializerProvider, (previous, next) {});

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.black),
          FadeTransition(
            opacity: _colorScreenOpacity,
            child: Container(color: Colors.white),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _logoScale.value,
                  child: Opacity(
                    opacity: _logoOpacity.value,
                    child: child,
                  ),
                );
              },
              child: const Text(
                "Sentimental",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppTypography.fontPoppins,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}