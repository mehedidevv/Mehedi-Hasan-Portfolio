import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/theme/app_colors.dart';
import '../model/stat_item_model.dart';

class InfoStatCard extends StatefulWidget {
  final StatItemModel stat;

  const InfoStatCard({
    super.key,
    required this.stat,
  });

  @override
  State<InfoStatCard> createState() => _InfoStatCardState();
}

class _InfoStatCardState extends State<InfoStatCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final rawVal = double.tryParse(widget.stat.value.replaceAll('+', '')) ?? 0.0;
    final isDecimal = widget.stat.value.contains('.');
    final hasPlus = widget.stat.value.contains('+');

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hover ? -4 : 0, 0),
        width: 145,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _hover
                  ? AppColors.primary.withValues(alpha: 0.22)
                  : Colors.white.withValues(alpha: 0.08),
              _hover
                  ? AppColors.primaryLight.withValues(alpha: 0.12)
                  : AppColors.surface.withValues(alpha: 0.35),
            ],
          ),
          border: Border.all(
            color: _hover
                ? AppColors.primary
                : Colors.white.withValues(alpha: 0.18),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.30),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
            if (_hover)
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.30),
                blurRadius: 22,
                offset: const Offset(0, 6),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Specular Accent Bar
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  height: 3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: _hover
                        ? AppColors.primaryGradient
                        : LinearGradient(
                            colors: [
                              AppColors.primary.withValues(alpha: 0.5),
                              Colors.transparent,
                            ],
                          ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                            style: GoogleFonts.spaceGrotesk(
                              color: AppColors.primary,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.stat.label,
                        style: GoogleFonts.inter(
                          color: _hover
                              ? Colors.white
                              : const Color(0xFFCBD5E1),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
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
