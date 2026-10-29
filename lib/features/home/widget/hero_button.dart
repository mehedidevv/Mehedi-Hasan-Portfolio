import 'package:flutter/material.dart';
import '../../../common/theme/app_colors.dart';

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
                    BoxShadow(
                      color: AppColors.primary
                          .withValues(alpha: _hovered ? 0.55 : 0.38),
                      blurRadius: _hovered ? 32 : 24,
                      spreadRadius: _hovered ? 1 : 0,
                      offset: const Offset(0, 10),
                    ),
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
