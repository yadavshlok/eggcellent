// lib/utils/colors.dart

import 'package:flutter/material.dart';

class AppColors {
  // Primary Yellow
  static const Color primary = Color(0xFFFFC107);
  static const Color primaryLight = Color(0xFFFFD54F);
  static const Color primaryDark = Color(0xFFFFA000);

  // Text Colors
  static const Color textDark = Color(0xFF1F1F1F);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);

  // Background & Borders
  static const Color background = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderGrey = Color(0xFFD1D5DB);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Greys
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFFC107), Color(0xFFFFB300)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
