import 'package:flutter/material.dart';
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
    return Container(
      key: sectionKey,
      width: double.infinity,
      color: background,
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: isMobile ? 56 : 96,
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
