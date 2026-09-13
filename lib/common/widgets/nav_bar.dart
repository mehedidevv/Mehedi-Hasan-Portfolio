import 'package:flutter/material.dart';
import '../../core/controllers/nav_controller.dart';
import '../constants/app_data.dart';
import '../theme/app_colors.dart';
import 'responsive.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final NavController controller;
  final VoidCallback onMenuTap;

  const NavBar({super.key, required this.controller, required this.onMenuTap});

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final hPad = Responsive.pagePadding(context);

    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.92),
        border: const Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.scrollTo(controller.homeKey),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
                children: [
                  TextSpan(text: 'Mehedi'),
                  TextSpan(
                    text: '.',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  TextSpan(text: 'dev'),
                ],
              ),
            ),
          ),
          const Spacer(),
          if (isDesktop)
            AnimatedBuilder(
              animation: controller,
              builder: (context, _) => Row(
                children: [
                  for (int i = 0; i < controller.navItems.length; i++)
                    _NavButton(
                      label: controller.navItems[i].label,
                      isActive: controller.activeIndex == i,
                      onTap: () {
                        controller.setActive(i);
                        controller.scrollTo(controller.navItems[i].key);
                      },
                    ),
                  const SizedBox(width: 8),
                  _ResumeButton(),
                ],
              ),
            )
          else
            IconButton(
              onPressed: onMenuTap,
              icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
            ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor:
              isActive ? AppColors.primary : AppColors.textSecondary,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ResumeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primary),
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text('Resume'),
      ),
    );
  }
}

/// Drawer used on mobile / tablet widths.
class AppNavDrawer extends StatelessWidget {
  final NavController controller;

  const AppNavDrawer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: Text(
                AppData.name,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Divider(color: AppColors.border),
            for (int i = 0; i < controller.navItems.length; i++)
              ListTile(
                title: Text(
                  controller.navItems[i].label,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  controller.setActive(i);
                  Future.delayed(const Duration(milliseconds: 250), () {
                    controller.scrollTo(controller.navItems[i].key);
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
