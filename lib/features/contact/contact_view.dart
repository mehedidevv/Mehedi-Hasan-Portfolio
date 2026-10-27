import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/responsive.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../../core/controllers/nav_controller.dart';
import '../../core/utils/launcher_util.dart';

class ContactView extends StatelessWidget {
  final NavController controller;
  const ContactView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: controller.contactKey,
      extraPadding: const EdgeInsets.symmetric(vertical: -10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Availability Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Available for New Opportunities',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionTitle(
            tag: 'Contact',
            title: 'Let\'s Work Together',
            subtitle:
                'Have a project in mind or an opening on your team? My inbox is always open.',
            alignment: CrossAxisAlignment.center,
          ),
          const SizedBox(height: 28),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: [
              _ContactCard(
                icon: FontAwesomeIcons.envelope,
                title: 'Email',
                value: AppData.email,
                actionLabel: 'Click to Send Email',
                onTap: () => LauncherUtil.sendEmail(AppData.email),
              ),
              _ContactCard(
                icon: FontAwesomeIcons.phone,
                title: 'Phone',
                value: AppData.phone,
                actionLabel: 'Click to Call',
                onTap: () => LauncherUtil.callPhone(AppData.phone),
              ),
              const _ContactCard(
                icon: FontAwesomeIcons.locationDot,
                title: 'Location',
                value: AppData.location,
                actionLabel: 'Based in Bangladesh',
                onTap: null,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 14,
            runSpacing: 14,
            children: [
              _ActionButton(
                icon: Icons.mail_outline_rounded,
                label: 'Say Hello',
                isPrimary: true,
                onTap: () => LauncherUtil.sendEmail(AppData.email),
              ),
              _ActionButton(
                icon: FontAwesomeIcons.github,
                label: 'GitHub',
                isPrimary: false,
                onTap: () => LauncherUtil.openUrl(AppData.github),
              ),
              _ActionButton(
                icon: FontAwesomeIcons.linkedin,
                label: 'LinkedIn',
                isPrimary: false,
                onTap: () => LauncherUtil.openUrl(AppData.linkedin),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final String actionLabel;
  final VoidCallback? onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.actionLabel,
    this.onTap,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _gradientAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);

    _gradientAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovered ? -5 : 0, 0),
          width: isMobile ? double.infinity : 270,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : AppColors.border,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.primary.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.12),
                blurRadius: _isHovered ? 20 : 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              children: [
                // Continuously Animated Top Gradient Line
                AnimatedBuilder(
                  animation: _gradientAnimation,
                  builder: (context, child) {
                    return Container(
                      height: 3.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: const [
                            AppColors.primary,
                            AppColors.secondary,
                            AppColors.primary,
                          ],
                          begin: Alignment(_gradientAnimation.value - 1.0, 0),
                          end: Alignment(_gradientAnimation.value + 1.0, 0),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _isHovered
                              ? AppColors.primary.withValues(alpha: 0.2)
                              : AppColors.primary.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: FaIcon(
                          widget.icon,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: _isHovered
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: _isHovered ? 1.0 : 0.6,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.actionLabel,
                              style: TextStyle(
                                color: _isHovered
                                    ? AppColors.primary
                                    : AppColors.textMuted,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (widget.onTap != null) ...[
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 12,
                                color: _isHovered
                                    ? AppColors.primary
                                    : AppColors.textMuted,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? AppColors.primary
                : _isHovered
                    ? AppColors.surfaceLight
                    : AppColors.card,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.isPrimary
                  ? AppColors.primary
                  : _isHovered
                      ? AppColors.primary.withValues(alpha: 0.5)
                      : AppColors.border,
            ),
            boxShadow: widget.isPrimary
                ? [
                    BoxShadow(
                      color: AppColors.primary
                          .withValues(alpha: _isHovered ? 0.35 : 0.2),
                      blurRadius: _isHovered ? 16 : 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                size: 16,
                color: widget.isPrimary ? Colors.black : AppColors.textPrimary,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  color:
                      widget.isPrimary ? Colors.black : AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
