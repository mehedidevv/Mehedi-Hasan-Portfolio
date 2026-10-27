import 'package:flutter/material.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/responsive.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../../core/controllers/nav_controller.dart';

class AboutView extends StatelessWidget {
  final NavController controller;
  const AboutView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    const titleBlock = SectionTitle(
      tag: 'About Me',
      title: 'Turning ideas into\nreal mobile products.',
    );

    const detailsBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppData.summary,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15.5,
            height: 1.5,
          ),
        ),
        SizedBox(height: 18),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            _InfoStat(value: '3+', label: 'Year of\nExperience'),
            _InfoStat(value: '20+', label: 'Total\nProjects'),
            _InfoStat(value: '8+', label: 'Live\nProjects'),
            _InfoStat(value: '3.96', label: 'CGPA out\nof 4.00'),

          ],
        ),
      ],
    );

    return SectionContainer(
      sectionKey: controller.aboutKey,
      background: AppColors.surface,
      child: isMobile
          ? const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleBlock,
                SizedBox(height: 20),
                detailsBlock,
              ],
            )
          : const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: titleBlock),
                SizedBox(width: 40),
                Expanded(flex: 6, child: detailsBlock),
              ],
            ),
    );
  }
}

class _InfoStat extends StatefulWidget {
  final String value;
  final String label;
  const _InfoStat({required this.value, required this.label});

  @override
  State<_InfoStat> createState() => _InfoStatState();
}

class _InfoStatState extends State<_InfoStat> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final rawVal = double.tryParse(widget.value.replaceAll('+', '')) ?? 0.0;
    final isDecimal = widget.value.contains('.');
    final hasPlus = widget.value.contains('+');

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hover ? -4 : 0, 0),
        width: 135,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hover ? AppColors.primary : AppColors.border,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _hover
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : Colors.transparent,
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: rawVal),
              duration: const Duration(milliseconds: 1400),
              curve: Curves.easeOutCubic,
              builder: (context, val, child) {
                String formattedStr;
                if (isDecimal) {
                  formattedStr = val.toStringAsFixed(2);
                } else {
                  formattedStr = '${val.toInt()}${hasPlus ? '+' : ''}';
                }
                return Text(
                  formattedStr,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: TextStyle(
                color:
                    _hover ? AppColors.textPrimary : AppColors.textSecondary,
                fontSize: 12.5,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
