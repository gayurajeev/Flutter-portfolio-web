import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';

class CapabilitiesSection extends StatefulWidget {
  const CapabilitiesSection({super.key});

  @override
  State<CapabilitiesSection> createState() => _CapabilitiesSectionState();
}

class _CapabilitiesSectionState extends State<CapabilitiesSection> {
  bool _visible = false;

  static const List<Map<String, String>> _skills = [
    {'name': 'SQL', 'number': '01'},
    {'name': 'Tableau', 'number': '02'},
    {'name': 'Excel', 'number': '03'},
    {'name': 'Python', 'number': '04'},
    {'name': 'R', 'number': '05'},
    {'name': 'Data Visualization', 'number': '06'},
    {'name': 'Operations Research', 'number': '07'},
    {'name': 'Flutter', 'number': '08'},
    {'name': 'Web Development', 'number': '09'},
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final hPad = isMobile ? 24.0 : 56.0;

    return VisibilityDetector(
      key: const Key('capabilities-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        color: AppColors.background,
        padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('(02)  CAPABILITIES', style: AppTextStyles.sectionLabel),
                      const SizedBox(height: 24),
                      _buildHeading(isMobile),
                      const SizedBox(height: 16),
                      Text(
                        'Languages, tools and disciplines I reach for first — picked up across coursework, projects, and a lot of late-night CSVs.',
                        style: AppTextStyles.body,
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('(02)  CAPABILITIES', style: AppTextStyles.sectionLabel),
                            const SizedBox(height: 24),
                            _buildHeading(isMobile),
                          ],
                        ),
                      ),
                      const SizedBox(width: 80),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Languages, tools and disciplines I reach for first — picked up across coursework, projects, and a lot of late-night CSVs.',
                            style: AppTextStyles.body,
                          ),
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 48),

            // Skills grid
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.cardBorder),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildSkillsGrid(isMobile),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading(bool isMobile) {
    final fontSize = isMobile ? 40.0 : 56.0;
    return RichText(
      text: TextSpan(
        style: AppTextStyles.sectionHeading.copyWith(fontSize: fontSize),
        children: [
          const TextSpan(text: 'The toolkit, '),
          TextSpan(
            text: 'honestly',
            style: AppTextStyles.sectionHeadingItalic.copyWith(fontSize: fontSize),
          ),
          const TextSpan(text: '.'),
        ],
      ),
    )
        .animate(target: _visible ? 1 : 0)
        .fadeIn(duration: 700.ms)
        .slideY(begin: 0.05, end: 0);
  }

  Widget _buildSkillsGrid(bool isMobile) {
    final cols = isMobile ? 2 : 3;
    final rows = (_skills.length / cols).ceil();

    return Column(
      children: List.generate(rows, (rowIdx) {
        final rowSkills = _skills.skip(rowIdx * cols).take(cols).toList();
        return Column(
          children: [
            if (rowIdx > 0)
              Container(height: 1, color: AppColors.cardBorder),
            Row(
              children: List.generate(rowSkills.length, (colIdx) {
                final skill = rowSkills[colIdx];
                return Expanded(
                  child: _SkillCell(
                    name: skill['name']!,
                    number: skill['number']!,
                    isLast: colIdx == rowSkills.length - 1,
                    visible: _visible,
                    delay: (rowIdx * cols + colIdx) * 60,
                  ),
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}

class _SkillCell extends StatefulWidget {
  final String name;
  final String number;
  final bool isLast;
  final bool visible;
  final int delay;

  const _SkillCell({
    required this.name,
    required this.number,
    required this.isLast,
    required this.visible,
    required this.delay,
  });

  @override
  State<_SkillCell> createState() => _SkillCellState();
}

class _SkillCellState extends State<_SkillCell> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.surface : Colors.transparent,
          border: Border(
            right: widget.isLast
                ? BorderSide.none
                : const BorderSide(color: AppColors.cardBorder),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.name, style: AppTextStyles.skillName),
            Text(widget.number, style: AppTextStyles.skillNumber),
          ],
        ),
      )
          .animate(target: widget.visible ? 1 : 0)
          .fadeIn(
            duration: 500.ms,
            delay: Duration(milliseconds: widget.delay),
          ),
    );
  }
}
