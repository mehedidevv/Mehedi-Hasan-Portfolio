import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'responsive.dart';

/// Wraps every page section with consistent max-width + padding so the
/// whole site stays aligned and responsive on web & mobile.
class SectionContainer extends StatelessWidget {
  final Widget child;
  final Color? background;
  final EdgeInsets? extraPadding;
  final Key? sectionKey;

  const SectionContainer({
    super.key,
    this.sectionKey,
    required this.child,
    this.background,
    this.extraPadding,
  });

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);
    
    // Translucent glass surface tint if background is provided
    final effectiveBg = background != null
        ? (background == AppColors.surface
            ? AppColors.surface.withValues(alpha: 0.55)
            : background!)
        : Colors.transparent;

    return Container(
      key: sectionKey,
      width: double.infinity,
      decoration: BoxDecoration(
        color: effectiveBg,
        border: background != null
            ? Border.symmetric(
                horizontal: BorderSide(
                  color: AppColors.border.withValues(alpha: 0.35),
                  width: 1,
                ),
              )
            : null,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: isMobile ? 42 : 64,
      ).add(extraPadding ?? EdgeInsets.zero),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: child,
        ),
      ),
    );
  }
}
