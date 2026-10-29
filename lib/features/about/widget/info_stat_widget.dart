import 'package:flutter/material.dart';
import '../../../common/theme/app_colors.dart';

class InfoStatWidget extends StatefulWidget {
  final String value;
  final String label;

  const InfoStatWidget({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  State<InfoStatWidget> createState() => _InfoStatWidgetState();
}

class _InfoStatWidgetState extends State<InfoStatWidget> {
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.lerp(AppColors.card, AppColors.surfaceLight, 0.45)!,
              Color.lerp(
                AppColors.card,
                AppColors.primary,
                _hover ? 0.08 : 0.02,
              )!,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hover
                ? AppColors.primary
                : Colors.white.withValues(alpha: 0.12),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.30),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
            if (_hover)
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.22),
                blurRadius: 20,
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
                color: _hover ? AppColors.primary : AppColors.textPrimary,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
