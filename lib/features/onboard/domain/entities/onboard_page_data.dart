import 'package:flutter/material.dart';

class OnboardPageData {
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradientColors;

  const OnboardPageData({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradientColors,
  });
}
