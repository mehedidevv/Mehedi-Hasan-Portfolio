import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common/theme/app_colors.dart';
import '../../../core/utils/launcher_util.dart';
import '../model/project_model.dart';

class ProjectDetailsDialog extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailsDialog({super.key, required this.project});

  static dynamic _iconFor(ProjectLinkType type) {
    switch (type) {
      case ProjectLinkType.playStore:
        return FontAwesomeIcons.googlePlay;
      case ProjectLinkType.appStore:
        return FontAwesomeIcons.apple;
      case ProjectLinkType.github:
        return FontAwesomeIcons.github;
      case ProjectLinkType.website:
        return FontAwesomeIcons.globe;
    }
  }

  static String _labelFor(ProjectLinkType type, String customLabel) {
    if (customLabel.isNotEmpty) return customLabel;
    switch (type) {
      case ProjectLinkType.playStore:
        return 'Google Play';
      case ProjectLinkType.appStore:
        return 'App Store';
      case ProjectLinkType.github:
        return 'GitHub';
      case ProjectLinkType.website:
        return 'Live Demo';
    }
  }

  Widget _buildFallbackMockup() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF131A26), Color(0xFF1C2536)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.25),
                ),
              ),
              child: const Icon(
                Icons.smartphone_rounded,
                color: AppColors.primary,
                size: 26,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              project.title,
              style: TextStyle(
                color: AppColors.textSecondary.withValues(alpha: 0.7),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 680),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.35),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mockup Header Area
                  Stack(
                    children: [
                      Container(
                        height: 280,
                        width: double.infinity,
                        color: AppColors.surfaceLight,
                        child: project.image != null && project.image!.isNotEmpty
                            ? Image.asset(
                                project.image!,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildFallbackMockup(),
                              )
                            : _buildFallbackMockup(),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.65),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                ),
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Details Content Body
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          project.description,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14.5,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final tag in project.tags)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceLight,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Text(
                                  tag,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (project.links.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          Divider(
                            height: 1,
                            color: AppColors.border.withValues(alpha: 0.8),
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 12,
                            runSpacing: 10,
                            children: [
                              for (final link in project.links)
                                ElevatedButton.icon(
                                  onPressed: () {
                                    LauncherUtil.openUrl(link.url);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  icon: _iconFor(link.type) is IconData
                                      ? Icon(
                                          _iconFor(link.type) as IconData,
                                          size: 16,
                                        )
                                      : FaIcon(
                                          _iconFor(link.type),
                                          size: 16,
                                        ),
                                  label: Text(
                                    _labelFor(link.type, link.label),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
