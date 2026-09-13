import 'package:flutter/material.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../../core/controllers/nav_controller.dart';
import '../../core/models/experience_model.dart';

class ExperienceView extends StatelessWidget {
  final NavController controller;
  const ExperienceView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: controller.experienceKey,
      background: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            tag: 'Experience',
            title: 'Where I\'ve Worked',
          ),
          const SizedBox(height: 40),
          for (final exp in AppData.experience) _ExperienceCard(exp: exp),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final ExperienceModel exp;
  const _ExperienceCard({required this.exp});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                margin: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: AppColors.border,
                ),
              ),
            ],
          ),
          const SizedBox(width: 22),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 6,
                      children: [
                        Text(
                          exp.role,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
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
                            exp.duration,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exp.company,
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    for (final point in exp.points)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
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
            ),
          ),
        ],
      ),
    );
  }
}
