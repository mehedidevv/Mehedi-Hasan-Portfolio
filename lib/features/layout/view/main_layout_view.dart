import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/widgets/app_footer.dart';
import '../../../common/widgets/app_nav_bar.dart';
import '../../../common/widgets/responsive.dart';
import '../../../common/widgets/starfield_widget.dart';
import '../controller/main_layout_controller.dart';
import '../../contact/contact_view.dart';
import '../../education/education_view.dart';
import '../../experience/experience_view.dart';
import '../../faq/view/faq_view.dart';
import '../../home/view/home_view.dart';
import '../../projects/projects_view.dart';
import '../../skills/skills_view.dart';

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView>
    with SingleTickerProviderStateMixin {
  late final MainLayoutController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Breathing animation controller for background ambient auras
  late AnimationController _auraAnimController;
  late Animation<double> _auraPulse;

  @override
  void initState() {
    super.initState();
    controller = Get.put(MainLayoutController());

    _auraAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _auraPulse = CurvedAnimation(
      parent: _auraAnimController,
      curve: Curves.easeInOutSine,
    );
  }

  @override
  void dispose() {
    _auraAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: const AppNavDrawer(),
      body: Stack(
        children: [
          // 1. High-Tech Cyber Grid & Particle Intersections Canvas
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _ModernGridPainter(),
              ),
            ),
          ),

          // 2. Animated Floating & Twinkling Starfield Space Layer
          const Positioned.fill(
            child: IgnorePointer(
              child: StarfieldWidget(),
            ),
          ),

          // 3. Animated Breathing Ambient Glow Orbs (Fluid Atmosphere)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _auraPulse,
                builder: (context, _) => _buildAmbientAuras(_auraPulse.value),
              ),
            ),
          ),

          // 4. Main Scrollable Page Content
          SingleChildScrollView(
            controller: controller.scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 74), // Top clearance for fixed navbar
                HomeView(controller: controller),
                SkillsView(controller: controller),
                ExperienceView(controller: controller),
                EducationView(controller: controller),
                ProjectsView(controller: controller),
                FaqView(controller: controller),
                ContactView(controller: controller),
                const AppFooter(),
              ],
            ),
          ),

          // 5. Fixed Glassmorphism Top Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),

          // 6. Slim Cyber Scroll Progress Bar (Directly underneath NavBar)
          Positioned(
            top: 73,
            left: 0,
            right: 0,
            child: Obx(
              () => _TopScrollProgressBar(progress: controller.scrollProgress.value),
            ),
          ),

          // 7. Interactive Floating Side HUD Rail (Desktop View Only)
          if (isDesktop)
            Positioned(
              right: 24,
              top: 0,
              bottom: 0,
              child: Center(
                child: Obx(
                  () => _DesktopSideNavHUD(
                    controller: controller,
                    scrollProgress: controller.scrollProgress.value,
                  ),
                ),
              ),
            ),

          // 8. Circular Progress Scroll-To-Top Button
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              bottom: controller.showScrollTop.value ? 28 : -70,
              right: 28,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: controller.showScrollTop.value ? 1.0 : 0.0,
                child: _CircularScrollToTopButton(
                  progress: controller.scrollProgress.value,
                  onTap: () => controller.scrollTo(controller.homeKey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Generates the layered organic ambient orbs with breathing scale and opacity
  Widget _buildAmbientAuras(double pulse) {
    final scaleOffset = (pulse - 0.5) * 0.12; // -0.06 to +0.06

    return Stack(
      children: [
        // Hero Top Glow (Emerald & Cyber Cyan)
        Positioned(
          top: -220,
          left: 0,
          right: 0,
          child: Center(
            child: Transform.scale(
              scale: 1.0 + scaleOffset,
              child: Container(
                width: 950,
                height: 950,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.22 + pulse * 0.05),
                      AppColors.primaryLight.withValues(alpha: 0.12),
                      AppColors.secondary.withValues(alpha: 0.07),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.35, 0.65, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Skills Mid-Left Glow (Cyber Cyan & Neon Purple)
        Positioned(
          top: 600,
          left: -180,
          child: Transform.scale(
            scale: 1.0 - scaleOffset,
            child: Container(
              width: 700,
              height: 700,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryLight.withValues(alpha: 0.13),
                    AppColors.accentPurple.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),
        ),

        // Experience & Projects Mid-Right Glow (Emerald & Royal Blue)
        Positioned(
          top: 1550,
          right: -160,
          child: Transform.scale(
            scale: 1.0 + scaleOffset,
            child: Container(
              width: 750,
              height: 750,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.14),
                    AppColors.secondary.withValues(alpha: 0.09),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.50, 1.0],
                ),
              ),
            ),
          ),
        ),

        // Projects & Education Lower-Left Glow
        Positioned(
          top: 2450,
          left: -160,
          child: Transform.scale(
            scale: 1.0 - scaleOffset,
            child: Container(
              width: 750,
              height: 750,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: 0.11),
                    AppColors.accentPurple.withValues(alpha: 0.07),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.50, 1.0],
                ),
              ),
            ),
          ),
        ),

        // Contact & Footer Bottom Glow
        Positioned(
          bottom: -200,
          right: -80,
          child: Transform.scale(
            scale: 1.0 + scaleOffset,
            child: Container(
              width: 850,
              height: 850,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.18 + pulse * 0.04),
                    AppColors.primaryLight.withValues(alpha: 0.09),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Cybernetic Scroll Progress Bar pinned beneath the Navbar
class _TopScrollProgressBar extends StatelessWidget {
  final double progress;
  const _TopScrollProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 2.5,
      width: width,
      child: Stack(
        children: [
          // Underlying subtle track
          Container(
            color: Colors.white.withValues(alpha: 0.03),
          ),
          // Gradient progress line
          Container(
            width: width * progress,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primaryLight,
                  AppColors.secondary,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryLight.withValues(alpha: 0.65),
                  blurRadius: 8,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
          // Radiant glowing head dot at the tip of the progress bar
          if (progress > 0.01)
            Positioned(
              left: (width * progress) - 4,
              top: -1.5,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryLight,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Interactive side HUD navigation rail visible on large screens
class _DesktopSideNavHUD extends StatelessWidget {
  final MainLayoutController controller;
  final double scrollProgress;

  const _DesktopSideNavHUD({
    required this.controller,
    required this.scrollProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withValues(alpha: 0.60),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < controller.navItems.length; i++)
              _SideHUDDot(
                label: controller.navItems[i].label,
                isActive: controller.activeIndex.value == i,
                onTap: () {
                  controller.setActive(i);
                  controller.scrollTo(controller.navItems[i].key);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _SideHUDDot extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SideHUDDot({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_SideHUDDot> createState() => _SideHUDDotState();
}

class _SideHUDDotState extends State<_SideHUDDot> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isActive;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
          child: Stack(
            alignment: Alignment.centerRight,
            clipBehavior: Clip.none,
            children: [
              // Center Dot / Pill
              AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                width: active ? 10 : 8,
                height: active ? 22 : (_isHovered ? 14 : 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: active ? AppColors.primaryGradient : null,
                  color: active
                      ? null
                      : (_isHovered
                          ? AppColors.primaryLight
                          : Colors.white.withValues(alpha: 0.25)),
                  boxShadow: active
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.6),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ]
                      : (_isHovered
                          ? [
                              BoxShadow(
                                color: AppColors.primaryLight.withValues(alpha: 0.4),
                                blurRadius: 8,
                              ),
                            ]
                          : []),
                ),
              ),

              // Hover Tooltip Pill on the Left
              if (_isHovered)
                Positioned(
                  right: 22,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 180),
                    opacity: _isHovered ? 1.0 : 0.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.card.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.45),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Text(
                        widget.label,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Circular Progress Back-To-Top Button with hover glow and tooltip
class _CircularScrollToTopButton extends StatefulWidget {
  final double progress;
  final VoidCallback onTap;

  const _CircularScrollToTopButton({
    required this.progress,
    required this.onTap,
  });

  @override
  State<_CircularScrollToTopButton> createState() =>
      _CircularScrollToTopButtonState();
}

class _CircularScrollToTopButtonState extends State<_CircularScrollToTopButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final pct = (widget.progress * 100).toInt();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Hover Tooltip
            if (_isHovered)
              Positioned(
                bottom: 58,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.card.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    'Top • $pct%',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

            // Button Body with Radial Progress Ring
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              width: 50,
              height: 50,
              transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isHovered
                    ? AppColors.surfaceLight
                    : AppColors.surface.withValues(alpha: 0.90),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.12),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary
                        .withValues(alpha: _isHovered ? 0.45 : 0.20),
                    blurRadius: _isHovered ? 24 : 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  // Progress Ring Painter
                  CustomPaint(
                    painter: _ProgressRingPainter(
                      progress: widget.progress,
                      strokeColor: AppColors.primary,
                      trackColor: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),

                  // Center Icon
                  Icon(
                    Icons.arrow_upward_rounded,
                    color: _isHovered ? AppColors.primaryLight : AppColors.primary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for the circular progress ring
class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color strokeColor;
  final Color trackColor;

  const _ProgressRingPainter({
    required this.progress,
    required this.strokeColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 3.5;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    canvas.drawCircle(center, radius, trackPaint);

    // Progress Arc
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.8
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * math.pi * progress;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, // start from top
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeColor != strokeColor;
  }
}

/// High-tech cyber grid canvas painter with node dots and radial vignette
class _ModernGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.022)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    const double step = 48.0;

    // Subtle Grid Lines
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // Glowing Node Intersections
    for (double x = 0; x < size.width; x += step * 2) {
      for (double y = 0; y < size.height; y += step * 2) {
        canvas.drawCircle(Offset(x, y), 1.3, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
