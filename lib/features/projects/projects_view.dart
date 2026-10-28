import 'package:flutter/material.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/responsive.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../../core/controllers/nav_controller.dart';
import 'widget/project_card.dart';

class ProjectsView extends StatelessWidget {
  final NavController controller;
  const ProjectsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    int columns = 1;
    if (Responsive.isDesktop(context)) {
      columns = 3;
    } else if (Responsive.isTablet(context)) {
      columns = 2;
    }

    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: controller.projectsKey,
      background: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            tag: 'Projects',
            title: 'Things I\'ve Built',
            subtitle:
                'A few apps I designed, developed and shipped end-to-end.',
            alignment: CrossAxisAlignment.center,
          ),
          const SizedBox(height: 28),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: AppData.projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: isMobile ? 540 : 520, // Increased slightly to accommodate the animated line
            ),
            itemBuilder: (context, index) {
              return ProjectCard(project: AppData.projects[index]);
            },
          ),
        ],
      ),
    );
  }
}
