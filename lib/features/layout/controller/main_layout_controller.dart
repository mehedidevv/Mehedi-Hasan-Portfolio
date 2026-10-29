import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavItem {
  final String label;
  final GlobalKey key;
  NavItem(this.label, this.key);
}

/// GetX Controller responsible for layout navigation, scroll tracking,
/// section active spying, and scroll progress calculation.
class MainLayoutController extends GetxController {
  final ScrollController scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey faqKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  final RxInt activeIndex = 0.obs;
  final RxBool showScrollTop = false.obs;
  final RxDouble scrollProgress = 0.0.obs;

  List<NavItem> get navItems => [
        NavItem('Home', homeKey),
        NavItem('Skills', skillsKey),
        NavItem('Experience', experienceKey),
        NavItem('Education', educationKey),
        NavItem('Projects', projectsKey),
        NavItem('FAQ', faqKey),
        NavItem('Contact', contactKey),
      ];

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    final offset = scrollController.offset;
    final maxScroll = scrollController.position.maxScrollExtent;

    // Calculate real-time scroll progress (0.0 -> 1.0)
    final progress = maxScroll > 0 ? (offset / maxScroll).clamp(0.0, 1.0) : 0.0;
    if ((progress - scrollProgress.value).abs() > 0.003) {
      scrollProgress.value = progress;
    }

    // Toggle scroll-to-top button visibility
    final shouldShow = offset > 350;
    if (shouldShow != showScrollTop.value) {
      showScrollTop.value = shouldShow;
    }

    // Automatically sync active navigation item based on viewport position
    syncActiveSection();
  }

  void syncActiveSection() {
    if (Get.context == null) return;
    final screenMid = MediaQuery.of(Get.context!).size.height * 0.32;

    int newActive = 0;
    for (int i = 0; i < navItems.length; i++) {
      final ctx = navItems[i].key.currentContext;
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

    if (newActive != activeIndex.value) {
      activeIndex.value = newActive;
    }
  }

  void setActive(int index) {
    if (activeIndex.value != index) {
      activeIndex.value = index;
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
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }
}
