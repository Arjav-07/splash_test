import 'package:flutter_riverpod/flutter_riverpod.dart';

// Simple model for our screen content
class DashboardData {
  final String title;
  final List<String> items;
  DashboardData({required this.title, required this.items});
}

// Async notifier to simulate fetching data
class DashboardNotifier extends AsyncNotifier<DashboardData> {
  @override
  Future<DashboardData> build() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 1500));
    return DashboardData(
      title: "Welcome Back",
      items: ["Analytics Card", "Recent Activity", "System Health"],
    );
  }
}

// The Provider
final dashboardProvider = AsyncNotifierProvider<DashboardNotifier, DashboardData>(() {
  return DashboardNotifier();
});