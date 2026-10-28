import 'package:flutter/material.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/responsive.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../../core/controllers/nav_controller.dart';

class EducationView extends StatelessWidget {
  final NavController controller;
  const EducationView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const edu = AppData.education;
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: controller.educationKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            tag: 'Education',
            title: 'Academic Background',
          ),
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 20 : 26),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(AppColors.card, AppColors.surfaceLight, 0.45)!,
                  AppColors.card,
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.10),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.30),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.30),
                    ),
                  ),
                  child: const Icon(
                    Icons.school_rounded,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                SizedBox(width: isMobile ? 16 : 22),
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
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              letterSpacing: -0.2,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.35),
                              ),
                            ),
                            child: Text(
                              edu.duration,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        edu.institute,
                        style: const TextStyle(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 16),
                      for (int i = 0; i < edu.points.length; i++)
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: i == edu.points.length - 1 ? 0 : 10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 8, right: 12),
                                child: Icon(
                                  Icons.circle,
                                  size: 5,
                                  color: AppColors.primary,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  edu.points[i],
                                  style: const TextStyle(
                                    color: Color(0xFFE2E8F0),
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
