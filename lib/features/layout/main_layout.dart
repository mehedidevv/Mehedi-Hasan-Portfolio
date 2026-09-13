import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/footer.dart';
import '../../common/widgets/nav_bar.dart';
import '../../core/controllers/nav_controller.dart';
import '../about/about_view.dart';
import '../contact/contact_view.dart';
import '../education/education_view.dart';
import '../experience/experience_view.dart';
import '../home/home_view.dart';
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
      appBar: NavBar(
        controller: _controller,
        onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      body: SingleChildScrollView(
        controller: _controller.scrollController,
        child: Column(
          children: [
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
    );
  }
}
