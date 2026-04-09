import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'section_wrapper.dart';

// Maps project title to a FontAwesome icon
IconData _projectIcon(String title) {
  switch (title) {
    case "Smart Samadhan":                return FontAwesomeIcons.city;
    case "Bhavishya":                     return FontAwesomeIcons.heartPulse;
    case "Prarabdha":                     return FontAwesomeIcons.buildingUser;
    case "Eric":                          return FontAwesomeIcons.microphone;
    case "AI Resume Analyzer":            return FontAwesomeIcons.magnifyingGlassChart;
    case "PII Detection & Privacy System": return FontAwesomeIcons.userShield;
    case "AI Virtual Mouse":              return FontAwesomeIcons.eye;
    default:                              return FontAwesomeIcons.code;
  }
}

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _filter = "All";

  static const _filters = ["All", "Featured", "Flutter", "AI / ML", "IoT"];

  List<Map<String, dynamic>> get _filtered {
    if (_filter == "All") return PortfolioData.projects;
    if (_filter == "Featured") {
      return PortfolioData.projects.where((p) => p["featured"] == true).toList();
    }
    final tagMap = {
      "Flutter": ["Flutter", "Dart", "ZEGO SDK", "Razorpay", "SQLite"],
      "AI / ML": ["Python", "NLP", "Gemini API", "Gemini AI", "spaCy", "Transformers", "MediaPipe", "OpenCV", "Speech Recognition"],
      "IoT": ["IoT", "Machine Learning", "EEG/EMG"],
    };
    final tags = tagMap[_filter] ?? [];
    return PortfolioData.projects
        .where((p) => (p["tags"] as List).any((t) => tags.contains(t)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final projects = _filtered;

    return Container(
      color: AppTheme.bgSection,
      child: SectionWrapper(
        title: "Projects",
        subtitle: "20+ things I've built",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter chips
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _filters.map((f) => _FilterChip(
                label: f,
                selected: _filter == f,
                onTap: () => setState(() => _filter = f),
              )).toList(),
            ).animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 36),
            // Grid
            _ProjectGrid(projects: projects, isMobile: isMobile),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: selected
              ? const LinearGradient(colors: [AppTheme.accent, AppTheme.cyan])
              : null,
          color: selected ? null : AppTheme.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.transparent : AppTheme.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _ProjectGrid extends StatelessWidget {
  final List<Map<String, dynamic>> projects;
  final bool isMobile;
  const _ProjectGrid({required this.projects, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text("No projects found.", style: TextStyle(color: AppTheme.textSecondary)),
        ),
      );
    }

    if (isMobile) {
      return Column(
        children: projects.asMap().entries.map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _ProjectCard(project: e.value, index: e.key),
        )).toList(),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      final cols = constraints.maxWidth > 1100 ? 3 : 2;
      final rows = <Widget>[];
      for (var i = 0; i < projects.length; i += cols) {
        final rowItems = projects.sublist(i, (i + cols).clamp(0, projects.length));
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: rowItems.asMap().entries.map((e) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: e.key < rowItems.length - 1 ? 20 : 0),
                    child: _ProjectCard(project: e.value, index: i + e.key),
                  ),
                )).toList(),
              ),
            ),
          ),
        );
      }
      return Column(children: rows);
    });
  }
}

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final int index;
  const _ProjectCard({required this.project, required this.index});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = Color(widget.project["color"] as int);
    final tags = widget.project["tags"] as List;
    final isFeatured = widget.project["featured"] == true;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(24),
        decoration: AppTheme.glassCard(hovered: _hovered),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Center(
                    child: FaIcon(_projectIcon(widget.project["title"]), size: 20, color: color),
                  ),
                ),
                const Spacer(),
                if (isFeatured)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppTheme.accent, AppTheme.cyan]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("Featured", style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.project["title"],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
            ),
            const SizedBox(height: 3),
            Text(
              widget.project["subtitle"],
              style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Text(
                widget.project["description"],
                style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary, height: 1.7),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: tags.map((t) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withOpacity(0.25)),
                ),
                child: Text(t, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
              )).toList(),
            ),
            if ((widget.project["achievement"] as String).isNotEmpty) ...[  
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.3)),
                ),
                child: Text(
                  widget.project["achievement"],
                  style: const TextStyle(fontSize: 12, color: Color(0xFFFFD700), fontWeight: FontWeight.w600),
                ),
              ),
            ],
            if ((widget.project["github"] as String).isNotEmpty) ...[  
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => launchUrl(Uri.parse(widget.project["github"]), mode: LaunchMode.externalApplication),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.bgCard,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(FontAwesomeIcons.github, size: 14, color: AppTheme.textSecondary),
                      const SizedBox(width: 8),
                      const Text("View Code", style: TextStyle(fontSize: 12, color: AppTheme.textSecondary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ).animate().fadeIn(delay: Duration(milliseconds: 60 * (widget.index % 6))).slideY(begin: 0.1),
    );
  }
}
