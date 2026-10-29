import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/responsive.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../layout/controller/main_layout_controller.dart';
import 'controller/projects_controller.dart';
import 'widget/project_card.dart';

class ProjectsView extends StatelessWidget {
  final MainLayoutController controller;
  const ProjectsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final projectsController = Get.put(ProjectsController());

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
              mainAxisExtent: isMobile ? 530 : 510,
            ),
            itemBuilder: (context, index) {
              final project = AppData.projects[index];
              return ProjectCard(
                project: project,
                onTap: () => projectsController.showProjectDetails(context, project),
              );
            },
          ),
        ],
      ),
    );
  }
}
