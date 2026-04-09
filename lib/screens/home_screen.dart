import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/projects_section.dart';
import '../sections/experience_section.dart';
import '../sections/achievements_section.dart';
import '../sections/contact_section.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());
  int _activeIndex = 0;
  bool _scrolled = false;

  static const _navItems = ["Home", "About", "Skills", "Projects", "Experience", "Achievements"];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    if (offset > 20 && !_scrolled) setState(() => _scrolled = true);
    if (offset <= 20 && _scrolled) setState(() => _scrolled = false);

    // Determine active section
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final pos = box.localToGlobal(Offset.zero);
      if (pos.dy <= 120) {
        if (_activeIndex != i) setState(() => _activeIndex = i);
        break;
      }
    }
  }

  void _scrollTo(int index) {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
    Navigator.of(context).maybePop(); // close drawer if open
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      backgroundColor: AppTheme.bg,
      drawer: isMobile ? _MobileDrawer(activeIndex: _activeIndex, onTap: _scrollTo) : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 64), // navbar height offset
                KeyedSubtree(key: _sectionKeys[0], child: const HeroSection()),
                KeyedSubtree(key: _sectionKeys[1], child: const AboutSection()),
                KeyedSubtree(key: _sectionKeys[2], child: const SkillsSection()),
                KeyedSubtree(key: _sectionKeys[3], child: const ProjectsSection()),
                KeyedSubtree(key: _sectionKeys[4], child: const ExperienceSection()),
                KeyedSubtree(key: _sectionKeys[5], child: const AchievementsSection()),
                const ContactSection(),
              ],
            ),
          ),
          // Sticky Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _Navbar(
              isMobile: isMobile,
              scrolled: _scrolled,
              activeIndex: _activeIndex,
              navItems: _navItems,
              onTap: _scrollTo,
            ),
          ),
        ],
      ),
    );
  }
}

class _Navbar extends StatelessWidget {
  final bool isMobile;
  final bool scrolled;
  final int activeIndex;
  final List<String> navItems;
  final void Function(int) onTap;

  const _Navbar({
    required this.isMobile,
    required this.scrolled,
    required this.activeIndex,
    required this.navItems,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 64,
      decoration: BoxDecoration(
        color: scrolled ? AppTheme.bg.withOpacity(0.92) : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: scrolled ? AppTheme.border : Colors.transparent,
            width: 1,
          ),
        ),
        boxShadow: scrolled
            ? [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20)]
            : [],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
        child: Row(
          children: [
            ShaderMask(
              shaderCallback: (b) => AppTheme.accentGradient.createShader(b),
              child: Text(
                "Prasad.",
                style: GoogleFonts.firaCode(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            if (isMobile)
              Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu_rounded, color: AppTheme.textPrimary),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              )
            else
              Row(
                children: navItems.asMap().entries.map((e) {
                  final isActive = e.key == activeIndex;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: TextButton(
                      onPressed: () => onTap(e.key),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        backgroundColor: isActive ? AppTheme.accent.withOpacity(0.1) : Colors.transparent,
                      ),
                      child: Text(
                        e.value,
                        style: TextStyle(
                          color: isActive ? AppTheme.accentLight : AppTheme.textSecondary,
                          fontSize: 14,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  final int activeIndex;
  final void Function(int) onTap;
  static const _navItems = ["Home", "About", "Skills", "Projects", "Experience", "Achievements"];

  const _MobileDrawer({required this.activeIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.bgCard,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: ShaderMask(
                shaderCallback: (b) => AppTheme.accentGradient.createShader(b),
                child: Text(
                  "Prasad Zade",
                  style: GoogleFonts.firaCode(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Divider(color: AppTheme.border),
            ..._navItems.asMap().entries.map((e) {
              final isActive = e.key == activeIndex;
              return ListTile(
                onTap: () => onTap(e.key),
                title: Text(
                  e.value,
                  style: TextStyle(
                    color: isActive ? AppTheme.accentLight : AppTheme.textSecondary,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                leading: Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isActive ? AppTheme.accent : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
