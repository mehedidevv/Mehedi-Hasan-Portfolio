import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'responsive.dart';

class SectionTitle extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;

  const SectionTitle({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 3,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              tag.toUpperCase(),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          title,
          textAlign: alignment == CrossAxisAlignment.center
              ? TextAlign.center
              : TextAlign.start,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
            fontSize: isMobile ? 28 : 36,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          SizedBox(
            width: isMobile ? double.infinity : 560,
            child: Text(
              subtitle!,
              textAlign: alignment == CrossAxisAlignment.center
                  ? TextAlign.center
                  : TextAlign.start,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15.5,
                height: 1.6,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
