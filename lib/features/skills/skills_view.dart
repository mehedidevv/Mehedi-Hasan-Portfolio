import 'package:flutter/material.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/responsive.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../../core/controllers/nav_controller.dart';

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
          SectionTitle(
            tag: 'Skills',
            title: 'My Technical Toolbox',
            subtitle:
                'Technologies, patterns and tools I use to build reliable, '
                'production-ready apps.',
            alignment: CrossAxisAlignment.center,
          ),
          const SizedBox(height: 40),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final skill in AppData.skills) _SkillChip(label: skill),
            ],
          ),
        ],
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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: _hover ? AppColors.primary.withOpacity(0.12) : AppColors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _hover ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: _hover ? AppColors.primary : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 13.5,
          ),
        ),
      ),
    );
  }
}
