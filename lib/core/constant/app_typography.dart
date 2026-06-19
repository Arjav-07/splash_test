import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static const String fontPoppins = 'Poppins';

  static const TextStyle brandHeader = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: fontPoppins,
    letterSpacing: 1,
  );

  static const TextStyle screenHeader = TextStyle(
    color: Colors.black,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    fontFamily: fontPoppins,
    height: 1.15,
  );

  static const TextStyle subtitle = TextStyle(
    color: Colors.black54,
    fontSize: 13,
    fontFamily: fontPoppins,
  );

  static const TextStyle actionButtonText = TextStyle(
    letterSpacing: 2, 
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
}