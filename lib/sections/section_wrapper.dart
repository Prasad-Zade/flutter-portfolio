import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SectionWrapper extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const SectionWrapper({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 24 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (subtitle != null)
            Text(
              subtitle!.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                letterSpacing: 3,
                color: AppTheme.accentLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          if (subtitle != null) const SizedBox(height: 8),
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.firaCode(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.accent, Colors.transparent],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          child,
        ],
      ),
    );
  }
}
