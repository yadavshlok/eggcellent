// lib/utils/constants.dart

import 'package:flutter/material.dart';

class AppConstants {
  // Shadows
  static const List<BoxShadow> lightShadow = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 4,
      offset: Offset(0, 1),
    ),
  ];

  // Radius
  static const double buttonRadius = 8.0;
}
