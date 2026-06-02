import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _visible = false;
  bool _emailHovered = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final hPad = isMobile ? 24.0 : 56.0;

    return VisibilityDetector(
      key: const Key('contact-section'),
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
            Container(height: 1, color: AppColors.divider),

            Padding(
              padding: EdgeInsets.fromLTRB(hPad, 64, hPad, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('(04)  GET IN TOUCH', style: AppTextStyles.sectionLabel)
                      .animate(target: _visible ? 1 : 0)
                      .fadeIn(duration: 600.ms),

                  const SizedBox(height: 32),

                  // Giant heading
                  _buildContactHeading(isMobile),

                  const SizedBox(height: 48),
                  Container(height: 1, color: AppColors.divider),
                  const SizedBox(height: 48),

                  // Contact content
                  isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildContactLeft(),
                            const SizedBox(height: 48),
                            _buildContactRight(),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: _buildContactLeft(),
                            ),
                            const SizedBox(width: 80),
                            Expanded(
                              flex: 5,
                              child: _buildContactRight(),
                            ),
                          ],
                        ),

                  const SizedBox(height: 80),
                ],
              ),
            ),

            // Footer
            Container(
              padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 28),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.divider)),
              ),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '© 2026 GAYATHRY RAJEEV  ·  BUILT WITH CARE_',
                          style: AppTextStyles.footerText,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'MADE WITH FLUTTER  ·  VOL. 01',
                          style: AppTextStyles.footerText,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          '© 2026 GAYATHRY RAJEEV  ·  BUILT WITH CARE_',
                          style: AppTextStyles.footerText,
                        ),
                        const Spacer(),
                        Text(
                          'MADE WITH FLUTTER  ·  VOL. 01',
                          style: AppTextStyles.footerText,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactHeading(bool isMobile) {
    final fontSize = isMobile ? 48.0 : 96.0;
    return RichText(
      text: TextSpan(
        style: AppTextStyles.contactHeading.copyWith(fontSize: fontSize),
        children: [
          const TextSpan(text: "Let's build a\n"),
          TextSpan(
            text: 'smarter ',
            style: AppTextStyles.contactHeadingItalic.copyWith(fontSize: fontSize),
          ),
          const TextSpan(text: 'decision.'),
        ],
      ),
    )
        .animate(target: _visible ? 1 : 0)
        .fadeIn(duration: 800.ms, delay: 100.ms)
        .slideY(begin: 0.05, end: 0);
  }

  Widget _buildContactLeft() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Looking for a data analyst / industrial engineering intern who can own a dataset end-to-end and ship dashboards that don't need a 30-page handover? I'd love to talk.",
          style: AppTextStyles.body,
        ),
        const SizedBox(height: 32),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _emailHovered = true),
          onExit: (_) => setState(() => _emailHovered = false),
          child: GestureDetector(
            onTap: () =>
                launchUrl(Uri.parse('mailto:gayathryrs.22@gmail.com')),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: AppTextStyles.emailLink.copyWith(
                    color: _emailHovered
                        ? AppColors.accent
                        : AppColors.textPrimary,
                    decorationColor: _emailHovered
                        ? AppColors.accent
                        : AppColors.textPrimary,
                  ),
                  child: const Text('gayathryrs.22@gmail.com'),
                ),
                const SizedBox(width: 12),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: AppTextStyles.emailLink.copyWith(
                    color: _emailHovered
                        ? AppColors.accent
                        : AppColors.textPrimary,
                    decoration: TextDecoration.none,
                  ),
                  child: const Text('→'),
                ),
              ],
            ),
          ),
        ),
      ],
    )
        .animate(target: _visible ? 1 : 0)
        .fadeIn(duration: 700.ms, delay: 200.ms);
  }

  Widget _buildContactRight() {
    return Column(
      children: [
        _ContactRow(
          label: 'LINKEDIN',
          value: 'IN/GAYATHRY-RAJEEV',
          url: 'https://www.linkedin.com/in/gayathry-rajeev/',
        ),
        _ContactRow(
          label: 'GITHUB',
          value: '@GAYURAJEEV',
          url: 'https://github.com/gayurajeev',
        ),
        _ContactRow(
          label: 'LOCATION',
          value: 'TRIVANDRUM, IN',
          url: null,
        ),
      ],
    )
        .animate(target: _visible ? 1 : 0)
        .fadeIn(duration: 700.ms, delay: 300.ms);
  }
}

class _ContactRow extends StatefulWidget {
  final String label;
  final String value;
  final String? url;

  const _ContactRow({
    required this.label,
    required this.value,
    required this.url,
  });

  @override
  State<_ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<_ContactRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.url != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.url != null
            ? () => launchUrl(Uri.parse(widget.url!))
            : null,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.divider)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.label, style: AppTextStyles.metaLabel),
              Row(
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: AppTextStyles.metaLabel.copyWith(
                      color: _hovered && widget.url != null
                          ? AppColors.accent
                          : AppColors.textSecondary,
                      letterSpacing: 1.5,
                      fontSize: 13,
                    ),
                    child: Text(widget.value),
                  ),
                  if (widget.url != null) ...[
                    const SizedBox(width: 6),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: AppTextStyles.metaLabel.copyWith(
                        color: _hovered
                            ? AppColors.accent
                            : AppColors.textSecondary,
                        fontSize: 13,
                      ),
                      child: const Text('↗'),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
