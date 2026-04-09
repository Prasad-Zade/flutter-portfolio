import 'package:flutter/material.dart';

class AppTheme {
  static const Color bg = Color(0xFF0A0A0F);
  static const Color bgSection = Color(0xFF0D0D15);
  static const Color bgCard = Color(0xFF13131E);
  static const Color bgCardHover = Color(0xFF1A1A2E);
  static const Color accent = Color(0xFF7C3AED);
  static const Color accentLight = Color(0xFFA78BFA);
  static const Color cyan = Color(0xFF06B6D4);
  static const Color pink = Color(0xFFEC4899);
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color border = Color(0xFF1E1E2E);

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFF06B6D4)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static BoxDecoration glassCard({bool hovered = false}) => BoxDecoration(
        color: hovered ? bgCardHover : bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hovered ? accent.withOpacity(0.6) : border,
          width: 1,
        ),
        boxShadow: hovered
            ? [BoxShadow(color: accent.withOpacity(0.15), blurRadius: 24)]
            : [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 12)],
      );
}
