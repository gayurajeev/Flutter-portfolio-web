import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';
import '../models/project.dart';
import '../data/projects_data.dart';
import '../widgets/scroll_stack.dart';
import '../widgets/scroll_reveal.dart';

class WorkSection extends StatefulWidget {
  const WorkSection({super.key});

  @override
  State<WorkSection> createState() => _WorkSectionState();
}

class _WorkSectionState extends State<WorkSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final hPad = isMobile ? 24.0 : 56.0;

    return VisibilityDetector(
      key: const Key('work-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.05 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Padding(
              padding: EdgeInsets.fromLTRB(hPad, 80, hPad, 64),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('(03)  SELECTED WORK', style: AppTextStyles.sectionLabel),
                        const SizedBox(height: 24),
                        _buildHeading(isMobile),
                        const SizedBox(height: 16),
                        Text(
                          'Each project below started with a vague question and a tangled CSV.',
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
                              Text('(03)  SELECTED WORK', style: AppTextStyles.sectionLabel),
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
                              'Each project below started with a vague question and a tangled CSV.',
                              style: AppTextStyles.body,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),

            // Projects
            if (isMobile)
              Column(
                children: projects.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final project = entry.value;
                  return _ProjectEntry(
                    project: project,
                    isMobile: isMobile,
                    hPad: hPad,
                    visible: _visible,
                    delay: idx * 100,
                  );
                }).toList(),
              )
            else
              ScrollStack(
                itemDistance: 100,
                itemStackDistance: 30,
                stackPosition: 0.20,
                scaleEndPosition: 0.10,
                baseScale: 0.85,
                itemScale: 0.03,
                children: projects.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final project = entry.value;
                  return _ProjectEntry(
                    project: project,
                    isMobile: isMobile,
                    hPad: hPad,
                    visible: _visible,
                    delay: idx * 100,
                  );
                }).toList(),
              ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading(bool isMobile) {
    final fontSize = isMobile ? 48.0 : 72.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Five projects.',
          style: AppTextStyles.sectionHeading.copyWith(fontSize: fontSize),
        ),
        Text(
          'One mindset.',
          style: AppTextStyles.sectionHeadingItalic.copyWith(fontSize: fontSize),
        ),
      ],
    )
        .animate(target: _visible ? 1 : 0)
        .fadeIn(duration: 700.ms)
        .slideY(begin: 0.05, end: 0);
  }
}

class _ProjectEntry extends StatefulWidget {
  final Project project;
  final bool isMobile;
  final double hPad;
  final bool visible;
  final int delay;

  const _ProjectEntry({
    required this.project,
    required this.isMobile,
    required this.hPad,
    required this.visible,
    required this.delay,
  });

  @override
  State<_ProjectEntry> createState() => _ProjectEntryState();
}

class _ProjectEntryState extends State<_ProjectEntry> {
  bool _imageHovered = false;

  @override
  Widget build(BuildContext context) {
    final imageWidget = _buildImage();
    final textWidget = _buildText();

    // Alternating layout: even = image right, odd = image left
    // per screenshots: project 01 image left, 02 image right, etc.
    final imageLeft = widget.project.imageLeft;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.divider),
        ),
      ),
      padding: EdgeInsets.fromLTRB(widget.hPad, 64, widget.hPad, 64),
      child: widget.isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProjectNumber(),
                const SizedBox(height: 24),
                imageWidget,
                const SizedBox(height: 32),
                textWidget,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: imageLeft
                  ? [
                      Expanded(flex: 5, child: imageWidget),
                      const SizedBox(width: 64),
                      Expanded(flex: 4, child: textWidget),
                    ]
                  : [
                      Expanded(flex: 4, child: textWidget),
                      const SizedBox(width: 64),
                      Expanded(flex: 5, child: imageWidget),
                    ],
            ),
    )
        .animate(target: widget.visible ? 1 : 0)
        .fadeIn(
          duration: 700.ms,
          delay: Duration(milliseconds: widget.delay),
        )
        .slideY(begin: 0.05, end: 0);
  }

  Widget _buildProjectNumber() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          widget.project.number,
          style: AppTextStyles.projectNumber,
        ),
        const SizedBox(width: 12),
        Text(
          '/ ${widget.project.category}',
          style: AppTextStyles.projectCategory,
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _imageHovered = true),
          onExit: (_) => setState(() => _imageHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _imageHovered ? AppColors.accent : AppColors.cardBorder,
                width: _imageHovered ? 1.5 : 1,
              ),
            ),
            transform: _imageHovered
                ? (Matrix4.identity()..scale(1.01))
                : Matrix4.identity(),
            clipBehavior: Clip.antiAlias,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Stack(
                children: [
                  Image.asset(
                    widget.project.imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 320,
                      color: AppColors.surface,
                      child: Center(
                        child: Text(
                          'CASE · ${widget.project.number}',
                          style: AppTextStyles.tagText,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.background.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Text(
                        'CASE · ${widget.project.number}',
                        style: AppTextStyles.tagText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isMobile) ...[
          _buildProjectNumber(),
          const SizedBox(height: 24),
        ],
        Text(
          widget.project.title,
          style: AppTextStyles.projectTitle,
        ),
        const SizedBox(height: 12),
        Text(
          widget.project.subtitle,
          style: AppTextStyles.projectSubtitle,
        ),
        const SizedBox(height: 24),
        ScrollReveal(
          text: widget.project.description,
          style: AppTextStyles.body,
          baseOpacity: 0.1,
          blurStrength: 4.0,
        ),
        const SizedBox(height: 24),
        ...widget.project.bullets.map(
          (b) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.textSecondary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(b, style: AppTextStyles.bodySmall),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: widget.project.tags
              .map((tag) => _TagChip(label: tag))
              .toList(),
        ),
      ],
    );
  }
}

class _TagChip extends StatefulWidget {
  final String label;

  const _TagChip({required this.label});

  @override
  State<_TagChip> createState() => _TagChipState();
}

class _TagChipState extends State<_TagChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: _hovered ? AppColors.textSecondary : AppColors.tagBorder,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(widget.label, style: AppTextStyles.tagText),
      ),
    );
  }
}
