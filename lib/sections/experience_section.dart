import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'section_wrapper.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bg,
      child: SectionWrapper(
        title: "Experience",
        subtitle: "Where I've worked",
        child: Column(
          children: PortfolioData.experience
              .asMap()
              .entries
              .map((e) => _TimelineItem(
                    data: e.value,
                    index: e.key,
                    isLast: e.key == PortfolioData.experience.length - 1,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatefulWidget {
  final Map<String, String> data;
  final int index;
  final bool isLast;
  const _TimelineItem({required this.data, required this.index, required this.isLast});

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final typeColors = {
      "Internship": AppTheme.cyan,
      "Leadership": AppTheme.pink,
      "Academic": AppTheme.accentLight,
    };
    final typeColor = typeColors[widget.data["type"]] ?? AppTheme.accentLight;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line + dot
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: typeColor,
                    boxShadow: [BoxShadow(color: typeColor.withOpacity(0.5), blurRadius: 8, spreadRadius: 2)],
                  ),
                ),
                if (!widget.isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [typeColor.withOpacity(0.5), Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Card
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _hovered = true),
              onExit: (_) => setState(() => _hovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(24),
                decoration: AppTheme.glassCard(hovered: _hovered),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data["role"]!,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${widget.data["company"]} · ${widget.data["location"]}",
                                style: TextStyle(fontSize: 14, color: typeColor, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: typeColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: typeColor.withOpacity(0.3)),
                              ),
                              child: Text(
                                widget.data["type"]!,
                                style: TextStyle(fontSize: 11, color: typeColor, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              widget.data["period"]!,
                              style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.data["description"]!,
                      style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary, height: 1.7),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 150 * widget.index)).slideX(begin: -0.05);
  }
}
