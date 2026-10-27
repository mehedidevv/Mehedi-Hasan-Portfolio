import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common/constants/app_data.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/widgets/responsive.dart';
import '../../../common/widgets/section_container.dart';
import '../../../core/controllers/nav_controller.dart';
import '../../../core/utils/launcher_util.dart';
import '../widget/contactChipWidget.dart';
import '../widget/heloAvaterWidget.dart';

class HomeView extends StatelessWidget {
  final NavController controller;

  const HomeView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: controller.homeKey,
      extraPadding: const EdgeInsets.only(top: 10),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
        isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: isMobile ? 0 : 6,
            child: Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [


                Text(
                  'Hi, I\'m ${AppData.name}',
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: isMobile ? 32 : 48,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 12),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.heroGlow.createShader(bounds),
                  child: Text(
                    AppData.role,
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: isMobile ? 18 : 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isMobile ? 500 : 520),
                  child: Text(
                    AppData.tagline,
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15.5,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Wrap(
                  alignment:
                  isMobile ? WrapAlignment.center : WrapAlignment.start,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    HeroButton.primary(
                      label: 'Get in touch',
                      icon: Icons.arrow_forward_rounded,
                      onTap: () => controller.scrollTo(controller.contactKey),
                    ),
                    HeroButton.secondary(
                      label: 'View Projects',
                      icon: Icons.grid_view_rounded,
                      onTap: () => controller.scrollTo(controller.projectsKey),
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                Wrap(
                  alignment:
                  isMobile ? WrapAlignment.center : WrapAlignment.start,
                  spacing: 18,
                  runSpacing: 10,
                  children: [
                    ContactChip(
                      icon: FontAwesomeIcons.envelope,
                      label: AppData.email,
                      onTap: () => LauncherUtil.sendEmail(AppData.email),
                    ),
                    ContactChip(
                      icon: FontAwesomeIcons.phone,
                      label: AppData.phone,
                      onTap: () => LauncherUtil.callPhone(AppData.phone),
                    ),
                    const ContactChip(
                      icon: FontAwesomeIcons.locationDot,
                      label: AppData.location,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 48 : 0, width: isMobile ? 0 : 40),
          if (!isMobile) ...[
            const Expanded(
              flex: 4,
              child: HeroAvatar(
                alignment: Alignment.centerRight,
              ),
            ),
          ] else ...[
            const HeroAvatar(
              size: 220,
              alignment: Alignment.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// Modern hero call-to-action button with glow, shadow and hover/press effects.
class HeroButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const HeroButton.primary({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  }) : isPrimary = true;

  const HeroButton.secondary({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  }) : isPrimary = false;

  @override
  State<HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<HeroButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final primary = widget.isPrimary;
    final lift = _pressed ? 0.0 : (_hovered ? -3.0 : 0.0);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, lift, 0),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: primary
                ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(AppColors.primary, Colors.white, 0.28)!,
                AppColors.primary,
              ],
            )
                : LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: _hovered ? 0.14 : 0.09),
                Colors.white.withValues(alpha: _hovered ? 0.06 : 0.03),
              ],
            ),
            border: Border.all(
              color: primary
                  ? Colors.white.withValues(alpha: 0.35)
                  : _hovered
                  ? AppColors.primary.withValues(alpha: 0.8)
                  : Colors.white.withValues(alpha: 0.20),
              width: 1.2,
            ),
            boxShadow: primary
                ? [
              // Coloured glow
              BoxShadow(
                color: AppColors.primary
                    .withValues(alpha: _hovered ? 0.55 : 0.38),
                blurRadius: _hovered ? 32 : 24,
                spreadRadius: _hovered ? 1 : 0,
                offset: const Offset(0, 10),
              ),
              // Grounding shadow
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ]
                : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.40),
                blurRadius: _hovered ? 28 : 20,
                offset: const Offset(0, 8),
              ),
              if (_hovered)
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  blurRadius: 24,
                  offset: const Offset(0, 6),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: primary ? Colors.black : AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  letterSpacing: 0.3,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 10),
                AnimatedSlide(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  offset: Offset(_hovered ? 0.25 : 0, 0),
                  child: Icon(
                    widget.icon,
                    size: 18,
                    color: primary ? Colors.black : AppColors.primary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}