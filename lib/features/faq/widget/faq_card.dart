import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/theme/app_colors.dart';
import '../model/faq_model.dart';

class FaqCard extends StatefulWidget {
  final FaqModel faq;
  final bool isExpanded;
  final VoidCallback onTap;

  const FaqCard({
    super.key,
    required this.faq,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  State<FaqCard> createState() => _FaqCardState();
}

class _FaqCardState extends State<FaqCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final expanded = widget.isExpanded;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                expanded
                    ? AppColors.primary.withValues(alpha: 0.12)
                    : _isHovered
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.white.withValues(alpha: 0.04),
                expanded
                    ? AppColors.primaryLight.withValues(alpha: 0.06)
                    : _isHovered
                        ? AppColors.surfaceLight.withValues(alpha: 0.70)
                        : AppColors.surface.withValues(alpha: 0.55),
              ],
            ),
            border: Border.all(
              color: expanded
                  ? AppColors.primary.withValues(alpha: 0.60)
                  : (_isHovered
                      ? AppColors.primaryLight.withValues(alpha: 0.40)
                      : Colors.white.withValues(alpha: 0.10)),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: _isHovered || expanded ? 24 : 14,
                offset: const Offset(0, 8),
              ),
              if (expanded || _isHovered)
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  blurRadius: 28,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header Question Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            widget.faq.question,
                            style: GoogleFonts.spaceGrotesk(
                              color: expanded || _isHovered
                                  ? AppColors.textPrimary
                                  : AppColors.textPrimary.withValues(alpha: 0.92),
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              height: 1.35,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Animated Liquid Glass Circular Chevron Icon
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: expanded
                                ? AppColors.primary.withValues(alpha: 0.22)
                                : (_isHovered
                                    ? AppColors.primary.withValues(alpha: 0.12)
                                    : Colors.white.withValues(alpha: 0.06)),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: expanded
                                  ? AppColors.primary.withValues(alpha: 0.50)
                                  : Colors.white.withValues(alpha: 0.14),
                            ),
                            boxShadow: expanded
                                ? [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(alpha: 0.30),
                                      blurRadius: 10,
                                    ),
                                  ]
                                : [],
                          ),
                          child: AnimatedRotation(
                            turns: expanded ? 0.5 : 0.0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 20,
                              color: expanded
                                  ? AppColors.primary
                                  : (_isHovered
                                      ? AppColors.primaryLight
                                      : AppColors.textSecondary),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Expandable Answer Section with Glass Divider
                    AnimatedCrossFade(
                      firstChild: const SizedBox(width: double.infinity, height: 0),
                      secondChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            height: 1,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary.withValues(alpha: 0.40),
                                  AppColors.primaryLight.withValues(alpha: 0.15),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.faq.answer,
                            style: GoogleFonts.inter(
                              color: AppColors.textSecondary,
                              fontSize: 14.5,
                              height: 1.65,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      crossFadeState: expanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 280),
                      sizeCurve: Curves.easeOutCubic,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
