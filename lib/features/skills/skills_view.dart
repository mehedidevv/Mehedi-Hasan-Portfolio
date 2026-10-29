import 'package:flutter/material.dart';
import '../../common/constants/app_data.dart';
import '../../common/widgets/responsive.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../layout/controller/main_layout_controller.dart';
import 'widget/skill_category_card.dart';

class SkillsView extends StatelessWidget {
  final MainLayoutController controller;
  const SkillsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: controller.skillsKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            tag: 'Skills',
            title: 'My Technical Toolbox',
            subtitle:
                'Technologies, frameworks, systems and engineering principles I use to craft high-performance applications.',
            alignment: CrossAxisAlignment.center,
          ),
          const SizedBox(height: 36),
          if (isMobile)
            Column(
              children: [
                for (int i = 0; i < AppData.skillCategories.length; i++) ...[
                  if (i > 0) const SizedBox(height: 20),
                  SkillCategoryCard(
                    category: AppData.skillCategories[i],
                    icon: _getCategoryIcon(i),
                  ),
                ],
              ],
            )
          else
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < AppData.skillCategories.length; i++) ...[
                    if (i > 0) const SizedBox(width: 20),
                    Expanded(
                      child: SkillCategoryCard(
                        category: AppData.skillCategories[i],
                        icon: _getCategoryIcon(i),
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  dynamic _getCategoryIcon(int index) {
    switch (index) {
      case 0:
        return Icons.smartphone_rounded;
      case 1:
        return Icons.dns_rounded;
      case 2:
      default:
        return Icons.code_rounded;
    }
  }
}
