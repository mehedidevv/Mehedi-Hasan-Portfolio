import 'package:flutter/material.dart';

/// Breakpoints used across the whole app.
class Responsive {
  Responsive._();

  static const double mobileMax = 650;
  static const double tabletMax = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= mobileMax && w < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  /// Horizontal page padding that grows with screen size.
  static double pagePadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < mobileMax) return 20;
    if (w < tabletMax) return 48;
    if (w < 1440) return 96;
    return (w - 1240) / 2;
  }

  static double maxContentWidth = 1240;
}

/// Renders a different widget depending on the current breakpoint.
class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) return desktop;
    if (Responsive.isTablet(context)) return tablet ?? desktop;
    return mobile;
  }
}
