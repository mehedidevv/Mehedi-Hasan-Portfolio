import 'package:flutter/material.dart';

/// Controller responsible for page-level navigation state:
/// scroll position, section keys and the currently active nav item.
/// (Acts as the "Controller" in the MVC structure for the layout/view.)
class NavController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  int activeIndex = 0;

  List<NavItem> get navItems => [
        NavItem('Home', homeKey),
        NavItem('About', aboutKey),
        NavItem('Skills', skillsKey),
        NavItem('Experience', experienceKey),
        NavItem('Education', educationKey),
        NavItem('Projects', projectsKey),
        NavItem('Contact', contactKey),
      ];

  void setActive(int index) {
    if (activeIndex != index) {
      activeIndex = index;
      notifyListeners();
    }
  }

  void scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

class NavItem {
  final String label;
  final GlobalKey key;
  NavItem(this.label, this.key);
}
