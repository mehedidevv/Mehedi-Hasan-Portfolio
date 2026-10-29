import 'package:flutter/material.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../layout/controller/main_layout_controller.dart';
import 'widget/experience_card.dart';

class ExperienceView extends StatelessWidget {
  final MainLayoutController controller;
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
          const SizedBox(height: 28),
          for (int i = 0; i < AppData.experience.length; i++)
            ExperienceCard(
              exp: AppData.experience[i],
              isLast: i == AppData.experience.length - 1,
            ),
        ],
      ),
    );
  }
}
