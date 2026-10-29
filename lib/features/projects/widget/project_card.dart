import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/theme/app_colors.dart';
import '../../../core/utils/launcher_util.dart';
import '../model/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final VoidCallback onTap;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovered ? -6 : 0, 0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(AppColors.card, AppColors.surfaceLight, 0.45)!,
                Color.lerp(
                  AppColors.card,
                  AppColors.primary,
                  _isHovered ? 0.08 : 0.02,
                )!,
              ],
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.60)
                  : Colors.white.withValues(alpha: 0.10),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: _isHovered ? 28 : 18,
                offset: const Offset(0, 8),
              ),
              if (_isHovered)
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  blurRadius: 28,
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
                        horizontal: 11,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: _isHovered
                            ? AppColors.primary.withValues(alpha: 0.14)
                            : AppColors.surfaceLight.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _isHovered
                              ? AppColors.primary.withValues(alpha: 0.35)
                              : Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      child: Text(
                        tag,
                        style: GoogleFonts.jetBrainsMono(
                          color: _isHovered
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w400,
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

              // Bottom Links Buttons Row
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
                              _iconFor(link.type) is IconData
                                  ? Icon(
                                      _iconFor(link.type) as IconData,
                                      size: 13,
                                      color: AppColors.textPrimary,
                                    )
                                  : FaIcon(
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
}
