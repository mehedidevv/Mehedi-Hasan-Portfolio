import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Reusable, theme-aligned glowing bullet point widget used across
/// Experience, Education, Skills, and list items for 100% design consistency.
class AppBulletPoint extends StatelessWidget {
  final double size;
  final EdgeInsetsGeometry padding;
  final Color? color;

  const AppBulletPoint({
    super.key,
    this.size = 6.0,
    this.padding = const EdgeInsets.only(top: 8, right: 12),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final bulletColor = color ?? AppColors.primary;

    return Padding(
      padding: padding,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bulletColor,
          boxShadow: [
            BoxShadow(
              color: bulletColor.withValues(alpha: 0.65),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}
