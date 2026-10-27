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
              return _ProjectCard(project: AppData.projects[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  static IconData _iconFor(ProjectLinkType type) {
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

  void _showDetailsModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                            child: widget.project.image != null &&
                                    widget.project.image!.isNotEmpty
                                ? Image.asset(
                                    widget.project.image!,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
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
                                      color:
                                          Colors.white.withValues(alpha: 0.2),
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
                              widget.project.title,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w800,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.project.description,
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
                                for (final tag in widget.project.tags)
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
                            if (widget.project.links.isNotEmpty) ...[
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
                                  for (final link in widget.project.links)
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      icon: FaIcon(
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _showDetailsModal(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovered ? -6 : 0, 0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : AppColors.border,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.primary.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.2),
                blurRadius: _isHovered ? 24 : 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Image Mockup Container
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: widget.project.image != null &&
                              widget.project.image!.isNotEmpty
                          ? AnimatedScale(
                              scale: _isHovered ? 1.04 : 1.0,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOutCubic,
                              child: Image.asset(
                                widget.project.image!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildFallbackMockup(),
                              ),
                            )
                          : _buildFallbackMockup(),
                    ),

                    // Top-Right Expand Action Button
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.open_in_full_rounded,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Project Title
              Text(
                widget.project.title,
                style: TextStyle(
                  color:
                      _isHovered ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              // Project Description (Max 3 Lines with Ellipsis)
              Expanded(
                child: Text(
                  widget.project.description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13.5,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 12),

              // Rounded Pill Tags
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final tag in widget.project.tags)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _isHovered
                              ? AppColors.primary.withValues(alpha: 0.3)
                              : AppColors.border.withValues(alpha: 0.5),
                        ),
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

              const SizedBox(height: 12),

              // Subtle Horizontal Line
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors.border.withValues(alpha: 0.7),
              ),

              const SizedBox(height: 12),

              // Bottom Links Buttons Row (App Store, Google Play, GitHub, etc.)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final link in widget.project.links)
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => LauncherUtil.openUrl(link.url),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: link.url.isNotEmpty
                                  ? AppColors.primary.withValues(alpha: 0.4)
                                  : AppColors.border,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(
                                _iconFor(link.type),
                                size: 13,
                                color: AppColors.textPrimary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _labelFor(link.type, link.label),
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.north_east_rounded,
                                size: 13,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fallback Mockup UI
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
              widget.project.title,
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
}
