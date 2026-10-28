import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common/theme/app_colors.dart';

class ContactChip extends StatefulWidget {
  final dynamic icon;
  final String label;
  final VoidCallback? onTap;

  const ContactChip({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  State<ContactChip> createState() => _ContactChipState();
}

class _ContactChipState extends State<ContactChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hover
                ? AppColors.primary.withValues(alpha: 0.16)
                : AppColors.surfaceLight.withValues(alpha: 0.70),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hover
                  ? AppColors.primary
                  : Colors.white.withValues(alpha: 0.10),
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
              FaIcon(
                widget.icon,
                size: 13,
                color: _hover ? AppColors.primary : AppColors.primaryLight,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: _hover ? AppColors.primary : AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}