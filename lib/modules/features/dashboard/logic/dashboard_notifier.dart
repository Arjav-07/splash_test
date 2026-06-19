import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splash_test/core/controllers/dashboard_notifieer.dart';


class DashboardNotifier extends AsyncNotifier<DashboardData> {
  @override
  Future<DashboardData> build() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return DashboardData(
      title: "Welcome Back",
      items: ["Analytics Card", "Recent Activity", "System Health"],
    );
  }
}

final dashboardProvider = AsyncNotifierProvider<DashboardNotifier, DashboardData>(() {
  return DashboardNotifier();
});