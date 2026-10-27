import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/responsive.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../../core/controllers/nav_controller.dart';
import '../../core/models/skill_category_model.dart';

class SkillsView extends StatelessWidget {
  final NavController controller;
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
                  _SkillCategoryCard(
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
                      child: _SkillCategoryCard(
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

  IconData _getCategoryIcon(int index) {
    switch (index) {
      case 0:
        return FontAwesomeIcons.mobileScreenButton;
      case 1:
        return FontAwesomeIcons.server;
      case 2:
      default:
        return FontAwesomeIcons.laptopCode;
    }
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final SkillCategoryModel category;
  final IconData icon;

  const _SkillCategoryCard({
    required this.category,
    required this.icon,
  });

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
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
                  : Colors.black.withValues(alpha: 0.15),
              blurRadius: _isHovered ? 28 : 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Accent Line
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                height: 3,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: _isHovered
                      ? AppColors.heroGlow
                      : AppColors.primaryGradient,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Responsive.isMobile(context) ? 16 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.2),
                            ),
                          ),
                          child: FaIcon(
                            widget.icon,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.category.title,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${widget.category.skills.length}',
                            style: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: AppColors.border.withValues(alpha: 0.6),
                    ),
                    const SizedBox(height: 18),
                    // Skill Chips Wrap
                    Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: [
                        for (final skill in widget.category.skills)
                          _SkillChip(label: skill),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
          color: _hover
              ? AppColors.primary.withValues(alpha: 0.15)
              : AppColors.surfaceLight.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hover
                ? AppColors.primary
                : AppColors.border.withValues(alpha: 0.8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _hover ? AppColors.primary : AppColors.textMuted,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: _hover ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: _hover ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 12.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
