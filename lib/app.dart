import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../theme/app_theme.dart';
import '../widgets/navbar.dart';
import '../widgets/skills_ticker.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/capabilities_section.dart';
import '../sections/work_section.dart';
import '../sections/contact_section.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _workKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  bool _navScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isScrolled = _scrollController.offset > 50;
    if (isScrolled != _navScrolled) {
      setState(() => _navScrolled = isScrolled);
    }
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Sticky Navbar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: AppColors.background.withOpacity(_navScrolled ? 0.97 : 1.0),
              border: Border(
                bottom: BorderSide(
                  color: _navScrolled ? AppColors.divider : Colors.transparent,
                ),
              ),
            ),
            child: NavBar(
              onWorkTap: () => _scrollTo(_workKey),
              onAboutTap: () => _scrollTo(_aboutKey),
              onSkillsTap: () => _scrollTo(_skillsKey),
              onContactTap: () => _scrollTo(_contactKey),
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero
                  const HeroSection(),

                  // Skills Ticker (between hero and about)
                  const SkillsTicker(),

                  // About
                  KeyedSubtree(
                    key: _aboutKey,
                    child: const AboutSection(),
                  ),

                  // Capabilities
                  KeyedSubtree(
                    key: _skillsKey,
                    child: const CapabilitiesSection(),
                  ),

                  // Work
                  KeyedSubtree(
                    key: _workKey,
                    child: const WorkSection(),
                  ),

                  // Contact
                  KeyedSubtree(
                    key: _contactKey,
                    child: const ContactSection(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
