import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      color: AppTheme.bg,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: isMobile ? 24 : 80),
      child: Column(
        children: [
          Text(
            "GET IN TOUCH",
            style: TextStyle(fontSize: 12, letterSpacing: 3, color: AppTheme.accentLight, fontWeight: FontWeight.w600),
          ).animate().fadeIn(),
          const SizedBox(height: 8),
          ShaderMask(
            shaderCallback: (b) => AppTheme.accentGradient.createShader(b),
            child: const Text(
              "Let's Work Together",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 16),
          const Text(
            "I'm currently open to new opportunities.\nFeel free to reach out — I'll get back to you!",
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 16, height: 1.7),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _ContactCard(
                icon: Icons.email_outlined,
                label: "Email",
                value: PortfolioData.email,
                url: "mailto:${PortfolioData.email}",
                color: AppTheme.accentLight,
              ),
              _ContactCard(
                icon: FontAwesomeIcons.github,
                label: "GitHub",
                value: "Prasad-Zade",
                url: PortfolioData.github,
                color: AppTheme.textPrimary,
              ),
              _ContactCard(
                icon: FontAwesomeIcons.linkedin,
                label: "LinkedIn",
                value: "prasad-zade",
                url: PortfolioData.linkedin,
                color: AppTheme.cyan,
              ),
              _ContactCard(
                icon: Icons.phone_outlined,
                label: "Phone",
                value: PortfolioData.phone,
                url: "tel:${PortfolioData.phone}",
                color: AppTheme.pink,
              ),
            ],
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 60),
          Container(height: 1, color: AppTheme.border),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("© 2025 ", style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
              ShaderMask(
                shaderCallback: (b) => AppTheme.accentGradient.createShader(b),
                child: const Text(
                  "Prasad Zade",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const Text(
                " · Built with Flutter 💙",
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final String url;
  final Color color;
  const _ContactCard({required this.icon, required this.label, required this.value, required this.url, required this.color});

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 220,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.bgCardHover : AppTheme.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _hovered ? widget.color.withOpacity(0.5) : AppTheme.border),
            boxShadow: _hovered
                ? [BoxShadow(color: widget.color.withOpacity(0.15), blurRadius: 20)]
                : [],
          ),
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: widget.color.withOpacity(0.3)),
                ),
                child: Center(
                  child: FaIcon(widget.icon, size: 20, color: widget.color),
                ),
              ),
              const SizedBox(height: 12),
              Text(widget.label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary, letterSpacing: 1)),
              const SizedBox(height: 4),
              Text(
                widget.value,
                style: TextStyle(fontSize: 13, color: widget.color, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
