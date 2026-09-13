import 'package:flutter/material.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/responsive.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../../core/controllers/nav_controller.dart';

class AboutView extends StatelessWidget {
  final NavController controller;
  const AboutView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: controller.aboutKey,
      background: AppColors.surface,
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: SectionTitle(
              tag: 'About Me',
              title: 'Turning ideas into\nreal mobile products.',
            ),
          ),
          SizedBox(width: isMobile ? 0 : 60, height: isMobile ? 32 : 0),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppData.summary,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 15.5,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 28),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: const [
                    _InfoStat(value: '1+', label: 'Year of\nExperience'),
                    _InfoStat(value: '4', label: 'Live\nProjects'),
                    _InfoStat(value: '3.96', label: 'CGPA out\nof 4.00'),
                    _InfoStat(value: '2', label: 'Platforms\n(Android/iOS)'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoStat extends StatelessWidget {
  final String value;
  final String label;
  const _InfoStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.5,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
