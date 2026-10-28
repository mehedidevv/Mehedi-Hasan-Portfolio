import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/theme/app_colors.dart';
import '../../../common/widgets/responsive.dart';
class ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final String actionLabel;
  final VoidCallback? onTap;

  const ContactCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.actionLabel,
    this.onTap,
  }) : super(key: key);

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard>
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
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovered ? -6 : 0, 0),
          width: isMobile ? double.infinity : 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(AppColors.card, Colors.white, 0.05)!,
                Color.lerp(
                  AppColors.card,
                  AppColors.primary,
                  _isHovered ? 0.08 : 0.02,
                )!,
              ],
            ),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.55)
                  : Colors.white.withValues(alpha: 0.08),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.30),
                blurRadius: _isHovered ? 30 : 20,
                offset: const Offset(0, 12),
              ),
              if (_isHovered)
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.20),
                  blurRadius: 36,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
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
                  padding: const EdgeInsets.fromLTRB(22, 26, 22, 24),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primary
                                  .withValues(alpha: _isHovered ? 0.34 : 0.22),
                              AppColors.primary
                                  .withValues(alpha: _isHovered ? 0.14 : 0.07),
                            ],
                          ),
                          border: Border.all(
                            color: AppColors.primary
                                .withValues(alpha: _isHovered ? 0.55 : 0.28),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary
                                  .withValues(alpha: _isHovered ? 0.35 : 0.12),
                              blurRadius: _isHovered ? 22 : 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: FaIcon(
                          widget.icon,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: _isHovered
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Action chip
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: _isHovered
                              ? AppColors.primary.withValues(alpha: 0.12)
                              : Colors.white.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _isHovered
                                ? AppColors.primary.withValues(alpha: 0.35)
                                : Colors.white.withValues(alpha: 0.06),
                          ),
                        ),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _isHovered ? 1.0 : 0.7,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.actionLabel,
                                style: TextStyle(
                                  color: _isHovered
                                      ? AppColors.primary
                                      : AppColors.textMuted,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (widget.onTap != null) ...[
                                const SizedBox(width: 4),
                                AnimatedSlide(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOutCubic,
                                  offset: Offset(_isHovered ? 0.25 : 0, 0),
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 12,
                                    color: _isHovered
                                        ? AppColors.primary
                                        : AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ],
                          ),
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
