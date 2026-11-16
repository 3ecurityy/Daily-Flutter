import 'package:flutter/material.dart';

abstract final class AppColors {
  static const background = Color(0xFF0B0B12);
  static const surface = Color(0xFF1A1A24);

  static const primary = Color(0xFF7C5CFF);
  static const secondary = Color(0xFF00C2FF);
  static const pink = Color(0xFFFF5C8A);

  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFF9A9AB0);
  static const border = Color(0x1FFFFFFF);

  static const error = Color(0xFFFF5C6C);
  static const warning = Color(0xFFFFB547);
  static const success = Color(0xFF3DDC97);

  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );
}
