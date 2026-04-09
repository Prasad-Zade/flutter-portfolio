import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'section_wrapper.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      color: AppTheme.bgSection,
      child: SectionWrapper(
        title: "About Me",
        subtitle: "Get to know me",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isMobile
                ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_AboutText(), const SizedBox(height: 32), _StatsRow()])
                : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(flex: 3, child: _AboutText()),
                    const SizedBox(width: 48),
                    Expanded(flex: 2, child: _StatsRow()),
                  ]),
            const SizedBox(height: 56),
            const Text(
              "Education",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
            ),
            const SizedBox(height: 24),
            ...PortfolioData.education.asMap().entries.map(
                  (e) => _EducationCard(data: e.value, index: e.key),
                ),
          ],
        ),
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioData.about,
          style: const TextStyle(fontSize: 16, color: AppTheme.textSecondary, height: 1.9),
        ).animate().fadeIn(duration: 600.ms),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            _InfoChip(icon: Icons.email_outlined, label: PortfolioData.email),
            _InfoChip(icon: Icons.phone_outlined, label: PortfolioData.phone),
            _InfoChip(icon: Icons.location_on_outlined, label: "Pune, India"),
          ],
        ).animate().fadeIn(delay: 300.ms),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.accentLight),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: PortfolioData.stats
          .map((s) => _StatCard(value: s["value"]!, label: s["label"]!))
          .toList(),
    ).animate().fadeIn(delay: 400.ms);
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final isCodeChef = label == "CodeChef Stars";
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: AppTheme.glassCard(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isCodeChef
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback: (b) => AppTheme.accentGradient.createShader(b),
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(Icons.star_rounded, color: AppTheme.cyan, size: 22),
                  ],
                )
              : ShaderMask(
                  shaderCallback: (b) => AppTheme.accentGradient.createShader(b),
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

class _EducationCard extends StatefulWidget {
  final Map<String, String> data;
  final int index;
  const _EducationCard({required this.data, required this.index});

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: AppTheme.glassCard(hovered: _hovered),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppTheme.accent, AppTheme.cyan]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.school_outlined, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.data["institution"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.textPrimary)),
                  const SizedBox(height: 4),
                  Text(widget.data["degree"]!,
                      style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.data["year"]!,
                    style: const TextStyle(fontSize: 13, color: AppTheme.accentLight, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
                  ),
                  child: Text(widget.data["detail"]!,
                      style: const TextStyle(fontSize: 12, color: AppTheme.accentLight)),
                ),
              ],
            ),
          ],
        ),
      ).animate().fadeIn(delay: Duration(milliseconds: 200 * widget.index)).slideY(begin: 0.1),
    );
  }
}
