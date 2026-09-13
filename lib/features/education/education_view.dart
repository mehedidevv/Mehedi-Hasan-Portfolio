import 'package:flutter/material.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../../core/controllers/nav_controller.dart';

class EducationView extends StatelessWidget {
  final NavController controller;
  const EducationView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final edu = AppData.education;
    return SectionContainer(
      sectionKey: controller.educationKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            tag: 'Education',
            title: 'Academic Background',
          ),
          const SizedBox(height: 36),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.school_rounded,
                      color: AppColors.primary, size: 28),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12,
                        runSpacing: 6,
                        children: [
                          Text(
                            edu.degree,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              edu.duration,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        edu.institute,
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.5,
                        ),
                      ),
                      const SizedBox(height: 14),
                      for (final point in edu.points)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 6, right: 10),
                                child: Icon(Icons.circle,
                                    size: 5, color: AppColors.primary),
                              ),
                              Expanded(
                                child: Text(
                                  point,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    height: 1.6,
                                    fontSize: 14.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
