import 'package:flutter/material.dart';
import 'package:splash_test/core/constant/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.textSubtle),
        prefixIcon: Icon(icon, color: AppColors.textSubtle),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderSubtle),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.accentBlack),
        ),
      ),
    );
  }
}