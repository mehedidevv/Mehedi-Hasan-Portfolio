import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/footer.dart';
import '../../common/widgets/nav_bar.dart';
import '../../core/controllers/nav_controller.dart';
import '../about/about_view.dart';
import '../contact/contact_view.dart';
import '../education/education_view.dart';
import '../experience/experience_view.dart';
import '../home/view/home_view.dart';
import '../projects/projects_view.dart';
import '../skills/skills_view.dart';

/// The top-level "View" that composes every section together and wires
/// them to the shared [NavController].
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final NavController _controller = NavController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: AppNavDrawer(controller: _controller),
      body: Stack(
        children: [
          // 1. Top Center Ambient Background Gradient Lighting Orb
          Positioned(
            top: -220,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 850,
                height: 850,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.18),
                      AppColors.secondary.withValues(alpha: 0.10),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // Mid-page Ambient Glow Orbs
          Positioned(
            top: 450,
            left: -180,
            child: Container(
              width: 550,
              height: 550,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: 0.10),
                    AppColors.primary.withValues(alpha: 0.04),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            top: 1200,
            right: -150,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.7],
                ),
              ),
            ),
          ),

          // 2. Scrollable Page Content
          SingleChildScrollView(
            controller: _controller.scrollController,
            child: Column(
              children: [
                const SizedBox(height: 70), // Top spacing for navbar
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

          // 3. Floating Liquid Glass Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              controller: _controller,
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}
