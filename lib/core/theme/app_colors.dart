import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF6366F1); // Modern Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4338CA);

  // Surface & Background (Dark Mode)
  static const Color background = Color(0xFF0F1219); // Very dark slate/blue
  static const Color surface = Color(0xFF1E2128); // Slightly lighter for cards
  static const Color surfaceVariant = Color(0xFF2B303B); // For text fields, subtle backgrounds
  static const Color surfaceHighlight = Color(0xFF374151);

  // Text
  static const Color textMain = Color(0xFFF9FAFB); // Off-white
  static const Color textSubtle = Color(0xFF9CA3AF); // Gray
  static const Color textInverse = Color(0xFF111827); // Very dark for buttons with primary color

  // Status
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Border & Divider
  static const Color border = Color(0xFF374151); // Dark border
  static const Color divider = Color(0xFF2B303B); // Dark divider
}
