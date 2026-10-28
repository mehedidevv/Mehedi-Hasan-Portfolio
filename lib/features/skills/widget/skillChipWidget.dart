import 'package:flutter/material.dart';
import '../../../common/theme/app_colors.dart';

class SkillChip extends StatefulWidget {
  final String label;
  const SkillChip({super.key, required this.label});

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _hover
              ? AppColors.primary.withValues(alpha: 0.16)
              : AppColors.surfaceLight.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _hover
                ? AppColors.primary
                : AppColors.border.withValues(alpha: 0.90),
            width: 1.1,
          ),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.20),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _hover ? AppColors.primary : AppColors.primaryLight,
                boxShadow: _hover
                    ? [
                        const BoxShadow(
                          color: AppColors.primary,
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                widget.label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: _hover ? AppColors.primary : AppColors.textPrimary,
                ) ?? TextStyle(
                  fontFamily: 'JetBrains Mono',
                  color: _hover ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
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
