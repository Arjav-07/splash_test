import 'package:flutter/material.dart';
import 'package:splash_test/core/constant/app_color.dart';
import 'package:splash_test/core/constant/app_typography.dart';
import 'package:splash_test/core/widgets/custom_text_field.dart';
import 'package:splash_test/routes/app_routes.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  late AnimationController _loginEntranceController;
  late Animation<double> _fadeForm;
  late Animation<Offset> _slideForm;

  @override
  void initState() {
    super.initState();

    _loginEntranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _fadeForm = CurvedAnimation(
      parent: _loginEntranceController,
      curve: const Interval(0.4545, 1.0, curve: Curves.easeIn),
    );

    _slideForm = Tween<Offset>(
      begin: const Offset(0.0, 0.06), 
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _loginEntranceController,
      curve: const Interval(0.4545, 1.0, curve: Curves.easeOutCubic),
    ));

    _loginEntranceController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginEntranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite, 
      body: SafeArea(
        top: true, 
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SlideTransition(
            position: _slideForm,
            child: FadeTransition(
              opacity: _fadeForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Center(child: Text("Sentimental", style: AppTypography.brandHeader)),
                  const SizedBox(height: 80),
                  const Text("Login to your\nAccount", style: AppTypography.screenHeader),
                  const SizedBox(height: 12),
                  const Text("Enter your email and password to log in", style: AppTypography.subtitle),
                  const SizedBox(height: 40),
                  CustomTextField(controller: _emailController, label: "Email Address", icon: Icons.email_outlined),
                  const SizedBox(height: 20),
                  CustomTextField(controller: _passwordController, label: "Password", icon: Icons.lock_outline_rounded, obscureText: true),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text("Forgot Password?", style: TextStyle(color: AppColors.textSubtle, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: AppTypography.fontPoppins)),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentBlack,
                      foregroundColor: AppColors.backgroundWhite,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
                    },
                    child: const Text("SIGN IN", style: AppTypography.actionButtonText),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ", style: TextStyle(color: AppColors.textSubtle, fontSize: 14, fontFamily: AppTypography.fontPoppins)),
                      GestureDetector(
                        onTap: () {},
                        child: const Text("Sign up", style: TextStyle(color: AppColors.accentBlack, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: AppTypography.fontPoppins)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}