import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/theme/app_colors.dart';


class ActionButton extends StatefulWidget {
  final dynamic icon;
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const ActionButton({
    required this.icon,
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primary = widget.isPrimary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          decoration: BoxDecoration(
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
                Colors.white.withValues(alpha: _isHovered ? 0.14 : 0.08),
                Colors.white.withValues(alpha: _isHovered ? 0.06 : 0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: primary
                  ? Colors.white.withValues(alpha: 0.35)
                  : _isHovered
                  ? AppColors.primary.withValues(alpha: 0.7)
                  : Colors.white.withValues(alpha: 0.18),
              width: 1.2,
            ),
            boxShadow: primary
                ? [
              BoxShadow(
                color: AppColors.primary
                    .withValues(alpha: _isHovered ? 0.55 : 0.35),
                blurRadius: _isHovered ? 30 : 22,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.30),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ]
                : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: _isHovered ? 26 : 18,
                offset: const Offset(0, 8),
              ),
              if (_isHovered)
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 22,
                  offset: const Offset(0, 6),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon is IconData)
              Icon(
                widget.icon as IconData,
                size: 16,
                color: primary
                    ? Colors.black
                    : _isHovered
                    ? AppColors.primary
                    : AppColors.textPrimary,
              )
            else
              FaIcon(
                widget.icon,
                size: 16,
                color: primary
                    ? Colors.black
                    : _isHovered
                    ? AppColors.primary
                    : AppColors.textPrimary,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: TextStyle(
                  color: primary ? Colors.black : AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.5,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}