import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splash_test/core/constant/app_color.dart';
import '../logic/dashboard_notifier.dart';

class AnimatedDashboardScreen extends ConsumerStatefulWidget {
  const AnimatedDashboardScreen({super.key});

  @override
  ConsumerState<AnimatedDashboardScreen> createState() => _AnimatedDashboardScreenState();
}

class _AnimatedDashboardScreenState extends ConsumerState<AnimatedDashboardScreen> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardProvider);

    return Scaffold(
      backgroundColor: AppColors.dashboardBg,
      body: dashboardState.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.accentCyan)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
        data: (data) {
          _animationController.forward();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      data.title,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                  WidgetItemsList(animationController: _animationController, dataItems: data.items),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class WidgetItemsList extends StatelessWidget {
  const WidgetItemsList({
    super.key,
    required this.animationController,
    required this.dataItems,
  });

  final AnimationController animationController;
  final List<String> dataItems;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: dataItems.length,
        itemBuilder: (context, index) {
          final itemProgress = CurvedAnimation(
            parent: animationController,
            curve: Interval((index * 0.1).clamp(0.0, 1.0), 1.0, curve: Curves.easeOutCubic),
          );

          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(0.5, 0.0), end: Offset.zero).animate(itemProgress),
            child: FadeTransition(
              opacity: itemProgress,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.dashboardCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.accentCyan.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dataItems[index], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                    const Icon(Icons.arrow_forward_ios, color: AppColors.accentCyan, size: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}