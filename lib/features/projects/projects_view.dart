import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/responsive.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../../core/controllers/nav_controller.dart';
import '../../core/models/project_model.dart';
import '../../core/utils/launcher_util.dart';

class ProjectsView extends StatelessWidget {
  final NavController controller;
  const ProjectsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    int columns = 1;
    if (Responsive.isDesktop(context)) {
      columns = 2;
    } else if (Responsive.isTablet(context)) {
      columns = 2;
    }

    return SectionContainer(
      sectionKey: controller.projectsKey,
      background: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SectionTitle(
            tag: 'Projects',
            title: 'Things I\'ve Built',
            subtitle:
                'A few apps I designed, developed and shipped end-to-end.',
            alignment: CrossAxisAlignment.center,
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: AppData.projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 22,
              mainAxisSpacing: 22,
              mainAxisExtent: 300,
            ),
            itemBuilder: (context, index) {
              return _ProjectCard(project: AppData.projects[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;
  const _ProjectCard({required this.project});

  IconData _iconFor(ProjectLinkType type) {
    switch (type) {
      case ProjectLinkType.playStore:
        return FontAwesomeIcons.googlePlay;
      case ProjectLinkType.appStore:
        return FontAwesomeIcons.appStoreIos;
      case ProjectLinkType.github:
        return FontAwesomeIcons.github;
      case ProjectLinkType.website:
        return FontAwesomeIcons.globe;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.smartphone_rounded,
                    color: AppColors.primary, size: 22),
              ),
              Row(
                children: [
                  for (final link in project.links)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InkWell(
                        onTap: () => LauncherUtil.openUrl(link.url),
                        borderRadius: BorderRadius.circular(20),
                        child: FaIcon(
                          _iconFor(link.type),
                          size: 17,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            project.title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              project.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.6,
              ),
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in project.tags)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
