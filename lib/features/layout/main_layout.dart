import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/footer.dart';
import '../../common/widgets/nav_bar.dart';
import '../../common/widgets/responsive.dart';
import '../../core/controllers/nav_controller.dart';
import '../about/about_view.dart';
import '../contact/contact_view.dart';
import '../education/education_view.dart';
import '../experience/experience_view.dart';
import '../home/view/home_view.dart';
import '../projects/projects_view.dart';
import '../skills/skills_view.dart';
import 'widget/circular_scroll_to_top_button.dart';
import 'widget/desktop_side_nav_hud.dart';
import 'widget/modern_grid_painter.dart';
import 'widget/top_scroll_progress_bar.dart';

/// Modern, high-performance portfolio layout that orchestrates:
/// - Smooth scroll synchronization & active section spy
/// - Top cybernetic scroll progress indicator
/// - Living, breathing ambient mesh lighting
/// - Interactive desktop side HUD navigation rail
/// - Circular progress scroll-to-top button
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout>
    with SingleTickerProviderStateMixin {
  final NavController _controller = NavController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _showScrollTop = false;
  double _scrollProgress = 0.0;

  // Breathing animation controller for background ambient auras
  late AnimationController _auraAnimController;
  late Animation<double> _auraPulse;

  @override
  void initState() {
    super.initState();
    _auraAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _auraPulse = CurvedAnimation(
      parent: _auraAnimController,
      curve: Curves.easeInOutSine,
    );

    _controller.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted || !_controller.scrollController.hasClients) return;

    final offset = _controller.scrollController.offset;
    final maxScroll = _controller.scrollController.position.maxScrollExtent;

    // Calculate real-time scroll progress (0.0 -> 1.0)
    final progress = maxScroll > 0 ? (offset / maxScroll).clamp(0.0, 1.0) : 0.0;
    if ((progress - _scrollProgress).abs() > 0.003) {
      setState(() => _scrollProgress = progress);
    }

    // Toggle scroll-to-top button visibility
    final shouldShow = offset > 350;
    if (shouldShow != _showScrollTop) {
      setState(() => _showScrollTop = shouldShow);
    }

    // Automatically sync active navigation item based on viewport position
    _syncActiveSection();
  }

  void _syncActiveSection() {
    if (!mounted) return;
    final items = _controller.navItems;
    final screenMid = MediaQuery.of(context).size.height * 0.32;

    int newActive = 0;
    for (int i = 0; i < items.length; i++) {
      final ctx = items[i].key.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          final top = box.localToGlobal(Offset.zero).dy;
          if (top <= screenMid) {
            newActive = i;
          }
        }
      }
    }

    if (newActive != _controller.activeIndex) {
      _controller.setActive(newActive);
    }
  }

  @override
  void dispose() {
    _auraAnimController.dispose();
    _controller.scrollController.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: AppNavDrawer(controller: _controller),
      body: Stack(
        children: [
          // 1. High-Tech Cyber Grid & Particle Intersections Canvas
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: ModernGridPainter(),
              ),
            ),
          ),

          // 2. Animated Breathing Ambient Glow Orbs (Fluid Atmosphere)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _auraPulse,
                builder: (context, _) => _buildAmbientAuras(_auraPulse.value),
              ),
            ),
          ),

          // 3. Main Scrollable Page Content (All original sections preserved)
          SingleChildScrollView(
            controller: _controller.scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 74), // Top clearance for fixed navbar
                HomeView(controller: _controller),
                AboutView(controller: _controller),
                SkillsView(controller: _controller),
                ExperienceView(controller: _controller),
                EducationView(controller: _controller),
                ProjectsView(controller: _controller),
                ContactView(controller: _controller),
                const AppFooter(),
              ],
            ),
          ),

          // 4. Fixed Glassmorphism Top Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              controller: _controller,
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),

          // 5. Slim Cyber Scroll Progress Bar (Directly underneath NavBar)
          Positioned(
            top: 73,
            left: 0,
            right: 0,
            child: TopScrollProgressBar(progress: _scrollProgress),
          ),

          // 6. Interactive Floating Side HUD Rail (Desktop View Only)
          if (isDesktop)
            Positioned(
              right: 24,
              top: 0,
              bottom: 0,
              child: Center(
                child: DesktopSideNavHUD(
                  controller: _controller,
                  scrollProgress: _scrollProgress,
                ),
              ),
            ),

          // 7. Circular Progress Scroll-To-Top Button
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            bottom: _showScrollTop ? 28 : -70,
            right: 28,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _showScrollTop ? 1.0 : 0.0,
              child: CircularScrollToTopButton(
                progress: _scrollProgress,
                onTap: () => _controller.scrollTo(_controller.homeKey),
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

        // About & Skills Mid-Left Glow (Cyber Cyan & Neon Purple)
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

