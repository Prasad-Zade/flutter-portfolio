import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'section_wrapper.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _categoryIcons = {
    "Languages":     FontAwesomeIcons.code,
    "Frameworks":    FontAwesomeIcons.mobileScreen,
    "Databases":     FontAwesomeIcons.database,
    "Tools & DevOps": FontAwesomeIcons.codeBranch,
    "AI / ML":       FontAwesomeIcons.brain,
  };

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final categories = PortfolioData.skillCategories;
    return Container(
      color: AppTheme.bg,
      child: SectionWrapper(
        title: "Skills",
        subtitle: "What I work with",
        child: isMobile
            ? Column(
                children: categories
                    .asMap()
                    .entries
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _SkillCard(data: e.value, index: e.key, icon: _categoryIcons[e.value["title"]] ?? FontAwesomeIcons.code),
                        ))
                    .toList(),
              )
            : LayoutBuilder(builder: (context, constraints) {
                const cols = 3;
                const spacing = 20.0;
                final rows = <Widget>[];
                for (var i = 0; i < categories.length; i += cols) {
                  final rowItems = categories.sublist(i, (i + cols).clamp(0, categories.length));
                  rows.add(
                    Padding(
                      padding: const EdgeInsets.only(bottom: spacing),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: rowItems.asMap().entries.map((e) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: e.key < rowItems.length - 1 ? spacing : 0),
                              child: _SkillCard(data: e.value, index: i + e.key, icon: _categoryIcons[e.value["title"]] ?? FontAwesomeIcons.code),
                            ),
                          )).toList(),
                        ),
                      ),
                    ),
                  );
                }
                return Column(children: rows);
              }),
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;
  final IconData icon;
  const _SkillCard({required this.data, required this.index, required this.icon});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final skills = widget.data["skills"] as List<String>;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: AppTheme.glassCard(hovered: _hovered),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppTheme.accent, AppTheme.cyan]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: FaIcon(widget.icon, size: 18, color: Colors.white)),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.data["title"],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills.map((s) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
                ),
                child: Text(s, style: const TextStyle(fontSize: 12, color: AppTheme.accentLight)),
              )).toList(),
            ),
          ],
        ),
      ).animate().fadeIn(delay: Duration(milliseconds: 100 * widget.index)).slideY(begin: 0.1),
    );
  }
}
