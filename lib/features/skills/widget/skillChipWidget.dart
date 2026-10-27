import 'package:flutter/material.dart';

import '../../../common/theme/app_colors.dart';

class SkillChip extends StatefulWidget {
  final String label;
  const SkillChip({required this.label});

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
          color: _hover
              ? AppColors.primary.withValues(alpha: 0.15)
              : AppColors.surfaceLight.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hover
                ? AppColors.primary
                : AppColors.border.withValues(alpha: 0.8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _hover ? AppColors.primary : AppColors.textMuted,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: _hover ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: _hover ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 12.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
