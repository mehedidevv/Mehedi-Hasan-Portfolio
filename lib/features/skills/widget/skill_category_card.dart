import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/widgets/responsive.dart';
import '../model/skill_category_model.dart';
import 'skill_chip.dart';

class SkillCategoryCard extends StatefulWidget {
  final SkillCategoryModel category;
  final dynamic icon;

  const SkillCategoryCard({
    super.key,
    required this.category,
    required this.icon,
  });

  @override
  State<SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<SkillCategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _gradientAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);

    _gradientAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.lerp(AppColors.card, AppColors.surfaceLight, 0.40)!,
              Color.lerp(
                AppColors.card,
                AppColors.primary,
                _isHovered ? 0.06 : 0.01,
              )!,
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.55)
                : Colors.white.withValues(alpha: 0.10),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: _isHovered ? 28 : 20,
              offset: const Offset(0, 8),
            ),
            if (_isHovered)
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.18),
                blurRadius: 30,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Continuously Animated Flowing Gradient Accent Line
                AnimatedBuilder(
                  animation: _gradientAnimation,
                  builder: (context, child) {
                    return Container(
                      height: 3.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: const [
                            AppColors.primary,
                            AppColors.secondary,
                            AppColors.primary,
                          ],
                          begin: Alignment(_gradientAnimation.value - 1.0, 0),
                          end: Alignment(_gradientAnimation.value + 1.0, 0),
                        ),
                      ),
                    );
                  },
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
                            child: widget.icon is IconData
                                ? Icon(
                                    widget.icon as IconData,
                                    size: 18,
                                    color: AppColors.primary,
                                  )
                                : FaIcon(
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
                            SkillChip(label: skill),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
