import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 800;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 680),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A0A0F), Color(0xFF0F0A1E), Color(0xFF0A0A0F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Background glow blobs
          Positioned(top: -100, left: -100, child: _GlowBlob(color: AppTheme.accent.withOpacity(0.15), size: 400)),
          Positioned(bottom: -80, right: -80, child: _GlowBlob(color: AppTheme.cyan.withOpacity(0.1), size: 350)),
          // Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 80),
              child: isMobile
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _Avatar(),
                        const SizedBox(height: 40),
                        _HeroText(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 3, child: _HeroText()),
                        const SizedBox(width: 60),
                        _Avatar(),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final size = w < 600 ? 160.0 : w < 1000 ? 200.0 : 260.0;
    final borderWidth = size * 0.015;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppTheme.accent, AppTheme.cyan],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: AppTheme.accent.withOpacity(0.4), blurRadius: 40, spreadRadius: 5),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: ClipOval(
          child: Image.asset(
            'assets/images/img.png',
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Center(
              child: Text('Prasad Zade', textAlign: TextAlign.center,
                  style: GoogleFonts.firaCode(
                      fontSize: size * 0.25, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 400.ms).scale(begin: const Offset(0.8, 0.8));
  }
}

class _HeroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Hello, I'm",
          style: TextStyle(color: AppTheme.accentLight, fontSize: 18, letterSpacing: 2),
        ).animate().fadeIn(duration: 500.ms),
        const SizedBox(height: 8),
        Text(
          PortfolioData.name,
          style: GoogleFonts.firaCode(
            fontSize: 52,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
            height: 1.1,
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              "I'm a ",
              style: TextStyle(fontSize: 22, color: AppTheme.textSecondary),
            ),
            AnimatedTextKit(
              repeatForever: true,
              animatedTexts: PortfolioData.roles
                  .map((r) => TypewriterAnimatedText(
                        r,
                        textStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.accentLight,
                        ),
                        speed: const Duration(milliseconds: 80),
                      ))
                  .toList(),
            ),
          ],
        ).animate().fadeIn(delay: 400.ms),
        const SizedBox(height: 24),
        Text(
          PortfolioData.heroAbout,
          style: TextStyle(fontSize: 15, color: AppTheme.textSecondary, height: 1.8),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ).animate().fadeIn(delay: 600.ms),
        const SizedBox(height: 36),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _GradientButton(
              label: "View Projects",
              onTap: () {},
            ),
            _OutlineButton(
              label: "Download CV",
              icon: Icons.download_outlined,
              onTap: () => launchUrl(Uri.parse("resume.pdf"), mode: LaunchMode.externalApplication),
            ),
          ],
        ).animate().fadeIn(delay: 800.ms),
        const SizedBox(height: 32),
        Row(
          children: [
            _SocialIcon(icon: FontAwesomeIcons.github, url: PortfolioData.github),
            const SizedBox(width: 16),
            _SocialIcon(icon: FontAwesomeIcons.linkedin, url: PortfolioData.linkedin),
            const SizedBox(width: 16),
            _SocialIcon(icon: Icons.email_outlined, url: "mailto:${PortfolioData.email}"),
          ],
        ).animate().fadeIn(delay: 1000.ms),
      ],
    );
  }
}

class _GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _GradientButton({required this.label, required this.onTap});

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.accent, AppTheme.cyan],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovered
                ? [BoxShadow(color: AppTheme.accent.withOpacity(0.5), blurRadius: 20)]
                : [],
          ),
          child: Text(
            widget.label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _OutlineButton({required this.label, required this.icon, required this.onTap});

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.accent.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _hovered ? AppTheme.accentLight : AppTheme.textSecondary),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 16, color: _hovered ? AppTheme.accentLight : AppTheme.textSecondary),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: _hovered ? AppTheme.accentLight : AppTheme.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  const _SocialIcon({required this.icon, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.accent.withOpacity(0.15) : AppTheme.bgCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _hovered ? AppTheme.accent : AppTheme.border),
          ),
          child: Center(
            child: FaIcon(widget.icon, size: 18, color: _hovered ? AppTheme.accentLight : AppTheme.textSecondary),
          ),
        ),
      ),
    );
  }
}
