import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatefulWidget {
  final VoidCallback? onWorkTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onSkillsTap;
  final VoidCallback? onContactTap;

  const NavBar({
    super.key,
    this.onWorkTap,
    this.onAboutTap,
    this.onSkillsTap,
    this.onContactTap,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String? _hoveredLink;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      color: AppColors.background.withOpacity(0.95),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 56,
        vertical: 20,
      ),
      child: Row(
        children: [
          // Logo
          Text('Gayathry.', style: AppTextStyles.navBrand),
          const Spacer(),
          if (!isMobile) ...[
            _NavLink(
              label: 'WORK',
              isHovered: _hoveredLink == 'WORK',
              onTap: widget.onWorkTap,
              onHover: (h) => setState(() => _hoveredLink = h ? 'WORK' : null),
            ),
            const SizedBox(width: 40),
            _NavLink(
              label: 'ABOUT',
              isHovered: _hoveredLink == 'ABOUT',
              onTap: widget.onAboutTap,
              onHover: (h) => setState(() => _hoveredLink = h ? 'ABOUT' : null),
            ),
            const SizedBox(width: 40),
            _NavLink(
              label: 'SKILLS',
              isHovered: _hoveredLink == 'SKILLS',
              onTap: widget.onSkillsTap,
              onHover: (h) => setState(() => _hoveredLink = h ? 'SKILLS' : null),
            ),
            const SizedBox(width: 40),
            _NavLink(
              label: 'CONTACT',
              isHovered: _hoveredLink == 'CONTACT',
              onTap: widget.onContactTap,
              onHover: (h) =>
                  setState(() => _hoveredLink = h ? 'CONTACT' : null),
            ),
            const SizedBox(width: 48),
            _SocialButton(
              label: 'LINKEDIN',
              url: 'https://linkedin.com/in/gayathry-rajeev',
              isOutlined: true,
            ),
            const SizedBox(width: 12),
            _SocialButton(
              label: 'GITHUB',
              url: 'https://github.com/gayurajeev',
              isOutlined: false,
            ),
          ] else ...[
            _SocialButton(
              label: 'LINKEDIN',
              url: 'https://linkedin.com/in/gayathry-rajeev',
              isOutlined: true,
            ),
            const SizedBox(width: 8),
            _SocialButton(
              label: 'GITHUB',
              url: 'https://github.com/gayurajeev',
              isOutlined: false,
            ),
          ],
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final bool isHovered;
  final VoidCallback? onTap;
  final ValueChanged<bool> onHover;

  const _NavLink({
    required this.label,
    required this.isHovered,
    required this.onTap,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTextStyles.navLink.copyWith(
            color: isHovered ? AppColors.textPrimary : AppColors.textSecondary,
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final String label;
  final String url;
  final bool isOutlined;

  const _SocialButton({
    required this.label,
    required this.url,
    required this.isOutlined,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isOutlined
                ? Colors.transparent
                : (_hovered
                    ? AppColors.accentLight
                    : AppColors.accent),
            border: Border.all(
              color: widget.isOutlined
                  ? (_hovered ? AppColors.textPrimary : AppColors.textMuted)
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: widget.isOutlined
                      ? AppColors.textSecondary
                      : AppColors.background,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: AppTextStyles.buttonText.copyWith(
                  color: widget.isOutlined
                      ? AppColors.textSecondary
                      : AppColors.background,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
