import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onWorkTap;
  final VoidCallback? onContactTap;

  const HeroSection({
    super.key,
    this.onWorkTap,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 56,
        vertical: isMobile ? 40 : 56,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top meta row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'PORTFOLIO  ·  VOL. 01  ·  TRIVANDRUM, IN',
                          style: AppTextStyles.heroTagline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isMobile) ...[
                const SizedBox(width: 16),
                Text(
                  '52° 7\' N — DATA / DESIGN / DECISIONS',
                  style: AppTextStyles.heroTagline,
                ),
              ],
            ],
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(begin: -0.1, end: 0),

          SizedBox(height: isMobile ? 40 : 60),

          // Big name
          isMobile
              ? Center(
                  child: _buildHeroName(isMobile)
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 400.ms)
                      .slideY(begin: 0.05, end: 0),
                )
              : _buildHeroName(isMobile)
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 400.ms)
                  .slideY(begin: 0.05, end: 0),

          SizedBox(height: isMobile ? 32 : 48),

          // Horizontal divider
          Container(
            height: 1,
            color: AppColors.divider,
          ),

          SizedBox(height: isMobile ? 32 : 48),

          // Description row
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroTagline(isMobile),
                    const SizedBox(height: 32),
                    _buildHeroRight(isMobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: _buildHeroTagline(isMobile),
                    ),
                    const SizedBox(width: 80),
                    Expanded(
                      flex: 4,
                      child: _buildHeroRight(isMobile),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildHeroName(bool isMobile) {
    final fontSize = isMobile ? 64.0 : 120.0;
    return Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: isMobile ? 40 : 80,
      runSpacing: 24,
      children: [
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Gayathry\n',
                style: AppTextStyles.heroTitle.copyWith(fontSize: fontSize, height: 1.05),
              ),
              TextSpan(
                text: 'Rajeev.',
                style: AppTextStyles.heroTitleAccent.copyWith(fontSize: fontSize, height: 1.05),
              ),
            ],
          ),
        ),
        Container(
          width: isMobile ? 160 : 240,
          height: isMobile ? 160 : 240,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.cardBorder,
              width: isMobile ? 3 : 4,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              'assests/profile.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.surface,
                child: Icon(
                  Icons.person,
                  color: AppColors.textMuted,
                  size: isMobile ? 80 : 120,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroTagline(bool isMobile) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: AppTextStyles.bodyLarge.copyWith(
          fontSize: 22,
          color: AppColors.textPrimary,
        ),
        children: [
          TextSpan(text: isMobile ? 'Industrial engineering student turning ' : 'Industrial engineering student turning\n'),
          const TextSpan(
            text: 'messy spreadsheets ',
            style: TextStyle(
              color: AppColors.accent,
              fontStyle: FontStyle.italic,
            ),
          ),
          TextSpan(text: isMobile ? 'into the kind of dashboards that make a room of executives actually agree on something.' : 'into the kind\nof dashboards that make a room of\nexecutives actually agree on something.'),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 700.ms, delay: 700.ms)
        .slideY(begin: 0.05, end: 0);
  }

  Widget _buildHeroRight(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'I work where statistics meets data — SQL, Python and Tableau for the analysis, and optimization for the harder questions about why a process behaves the way it does.',
          style: AppTextStyles.heroDescription,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 32),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 16,
          runSpacing: 16,
          children: [
            _HeroButton(
              label: 'See selected work',
              isPrimary: true,
              onTap: onWorkTap ?? () {},
            ),
            _HeroButton(
              label: 'Get in touch',
              isPrimary: false,
              onTap: onContactTap ??
                  () => launchUrl(Uri.parse('mailto:gayathryrs.22@gmail.com')),
            ),
            _HeroButton(
              label: 'Resume',
              isPrimary: false,
              onTap: () => launchUrl(Uri.base.resolve('/resume')),
            ),
          ],
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 700.ms, delay: 900.ms)
        .slideY(begin: 0.05, end: 0);
  }
}

class _HeroButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _HeroButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (_hovered ? AppColors.accentLight : AppColors.accent)
                : Colors.transparent,
            border: Border.all(
              color: widget.isPrimary
                  ? Colors.transparent
                  : (_hovered ? AppColors.textPrimary : AppColors.textMuted),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.buttonText.copyWith(
                  fontSize: 14,
                  color: widget.isPrimary
                      ? AppColors.background
                      : AppColors.textSecondary,
                ),
              ),
              if (widget.isPrimary) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_downward,
                  size: 14,
                  color: AppColors.background,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
