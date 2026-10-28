import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/utils/launcher_util.dart';
import '../constants/app_data.dart';
import '../theme/app_colors.dart';
import 'responsive.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 36),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.50),
        border: Border(
          top: BorderSide(
            color: AppColors.border.withValues(alpha: 0.60),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: Column(
            children: [
              // Top Specular Gradient Line Accent
              Container(
                height: 1,
                width: 160,
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
              ),
              const SizedBox(height: 24),
              isMobile
                  ? Column(
                      children: [
                        _socials(),
                        const SizedBox(height: 16),
                        _copyright(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [_copyright(), _socials()],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _copyright() {
    return Text(
      '© ${DateTime.now().year} ${AppData.name}. Crafted with Flutter & Liquid Glass aesthetics.',
      style: const TextStyle(
        color: AppColors.textMuted,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _socials() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialIconButton(
          icon: FontAwesomeIcons.github,
          onTap: () => LauncherUtil.openUrl(AppData.github),
        ),
        const SizedBox(width: 12),
        _SocialIconButton(
          icon: FontAwesomeIcons.linkedin,
          onTap: () => LauncherUtil.openUrl(AppData.linkedin),
        ),
        const SizedBox(width: 12),
        _SocialIconButton(
          icon: FontAwesomeIcons.envelope,
          onTap: () => LauncherUtil.sendEmail(AppData.email),
        ),
      ],
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.18)
                : AppColors.card,
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary
                  : AppColors.border,
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: FaIcon(
            widget.icon,
            size: 16,
            color: _isHovered ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
