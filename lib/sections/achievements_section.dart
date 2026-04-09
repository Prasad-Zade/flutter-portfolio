import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'section_wrapper.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  static const _icons = [
    FontAwesomeIcons.trophy,       // 3rd Place Core2Web
    FontAwesomeIcons.rankingStar,  // Top Rank ERP
    FontAwesomeIcons.code,         // CodeChef
    FontAwesomeIcons.google,       // Google Solution Challenge
    FontAwesomeIcons.indianRupeeSign, // Smart India Hackathon
  ];

  static const _colors = [
    Color(0xFFCD7F32), // bronze
    Color(0xFFFFD700), // gold
    Color(0xFF00BFA5), // teal
    Color(0xFF4285F4), // google blue
    Color(0xFFFF9800), // orange
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      color: AppTheme.bgSection,
      child: SectionWrapper(
        title: "Achievements",
        subtitle: "Milestones & recognition",
        child: isMobile
            ? Column(
                children: PortfolioData.achievements
                    .asMap()
                    .entries
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _AchievementCard(
                            data: e.value,
                            index: e.key,
                            icon: _icons[e.key % _icons.length],
                            color: _colors[e.key % _colors.length],
                          ),
                        ))
                    .toList(),
              )
            : GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 3.2,
                children: PortfolioData.achievements
                    .asMap()
                    .entries
                    .map((e) => _AchievementCard(
                          data: e.value,
                          index: e.key,
                          icon: _icons[e.key % _icons.length],
                          color: _colors[e.key % _colors.length],
                        ))
                    .toList(),
              ),
      ),
    );
  }
}

class _AchievementCard extends StatefulWidget {
  final Map<String, String> data;
  final int index;
  final IconData icon;
  final Color color;
  const _AchievementCard({required this.data, required this.index, required this.icon, required this.color});

  @override
  State<_AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends State<_AchievementCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: AppTheme.glassCard(hovered: _hovered),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: widget.color.withOpacity(0.3)),
              ),
              child: Center(child: FaIcon(widget.icon, size: 20, color: widget.color)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.data["title"]!,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.data["desc"]!,
                    style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary, height: 1.5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: Duration(milliseconds: 150 * widget.index)).slideY(begin: 0.1),
    );
  }
}
