import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final hPad = isMobile ? 24.0 : 56.0;

    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // About text + metadata
            Padding(
              padding: EdgeInsets.fromLTRB(hPad, 80, hPad, 80),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(),
                        const SizedBox(height: 24),
                        _buildHeading(isMobile),
                        const SizedBox(height: 40),
                        _buildAboutText(),
                        const SizedBox(height: 48),
                        _buildMetaGrid(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel(),
                              const SizedBox(height: 24),
                              _buildHeading(isMobile),
                            ],
                          ),
                        ),
                        const SizedBox(width: 80),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 48),
                              _buildAboutText(),
                              const SizedBox(height: 56),
                              _buildMetaGrid(),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Text(
      '(01)  ABOUT',
      style: AppTextStyles.sectionLabel,
    )
        .animate(target: _visible ? 1 : 0)
        .fadeIn(duration: 600.ms)
        .slideX(begin: -0.05, end: 0);
  }

  Widget _buildHeading(bool isMobile) {
    final fontSize = isMobile ? 56.0 : 80.0;
    return RichText(
      text: TextSpan(
        style: AppTextStyles.aboutHeadingLarge.copyWith(fontSize: fontSize),
        children: [
          const TextSpan(text: 'Analyst by\ntraining,\n'),
          TextSpan(
            text: 'engineer ',
            style: AppTextStyles.aboutHeadingItalic.copyWith(fontSize: fontSize),
          ),
          const TextSpan(text: 'by\ninstinct.'),
        ],
      ),
    )
        .animate(target: _visible ? 1 : 0)
        .fadeIn(duration: 700.ms, delay: 100.ms)
        .slideY(begin: 0.05, end: 0);
  }

  Widget _buildAboutText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "I'm an industrial engineering student who fell in love with the moment a messy dataset suddenly tells you the truth. I build dashboards that respect the audience: clean numbers, clear hierarchies, no chart-junk.",
          style: AppTextStyles.body,
        ),
        const SizedBox(height: 24),
        Text(
          'My toolkit lives between two worlds — Python & R for the analytical heavy lifting, Tableau & Excel for stakeholder-ready stories, and a foundation in data analysis for the complex logistics and optimization problems most people would rather not touch.',
          style: AppTextStyles.body,
        ),
      ],
    )
        .animate(target: _visible ? 1 : 0)
        .fadeIn(duration: 700.ms, delay: 200.ms);
  }

  Widget _buildMetaGrid() {
    return Wrap(
      spacing: 48,
      runSpacing: 32,
      children: [
        _MetaItem(label: 'ROLE', value: 'Data Analyst'),
        _MetaItem(label: 'DISCIPLINE', value: 'Industrial Eng.'),
        _MetaItem(label: 'BASED IN', value: 'Kerala, India'),
        _MetaItem(label: 'STACK', value: 'SQL · Py · R · Tableau'),
        _MetaItem(label: 'FOCUS', value: 'Data Analytics'),
        _MetaItem(label: 'OPEN TO', value: 'Internships & Roles'),
      ],
    )
        .animate(target: _visible ? 1 : 0)
        .fadeIn(duration: 700.ms, delay: 300.ms);
  }
}

class _MetaItem extends StatelessWidget {
  final String label;
  final String value;

  const _MetaItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.metaLabel),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.metaValue),
        ],
      ),
    );
  }
}
