import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/controllers/nav_controller.dart';
import '../../core/utils/launcher_util.dart';
import '../constants/app_data.dart';
import '../theme/app_colors.dart';
import 'responsive.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final NavController controller;
  final VoidCallback onMenuTap;

  const NavBar({super.key, required this.controller, required this.onMenuTap});

  @override
  Size get preferredSize => const Size.fromHeight(74);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final hPad = Responsive.pagePadding(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: Container(
          width: double.infinity,
          height: preferredSize.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.12),
                AppColors.background.withValues(alpha: 0.45),
                AppColors.primary.withValues(alpha: 0.05),
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.12),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 28,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Specular Top Border Highlight
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 1.2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.0),
                        AppColors.primary.withValues(alpha: 0.70),
                        AppColors.primaryLight.withValues(alpha: 0.50),
                        Colors.white.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: Row(
                  children: [
                    // Brand Logo with Neon Glow
                    GestureDetector(
                      onTap: () => controller.scrollTo(controller.homeKey),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Mehedi',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textPrimary,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary,
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                ),
                              ),
                              child: const Text(
                                'dev',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
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
                            const SizedBox(width: 14),
                            const ResumeButton(),
                          ],
                        ),
                      )
                    else
                      IconButton(
                        onPressed: onMenuTap,
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: AppColors.textPrimary,
                          size: 26,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isActive;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: active
                  ? AppColors.primary.withValues(alpha: 0.16)
                  : _isHovered
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: active
                    ? AppColors.primary.withValues(alpha: 0.45)
                    : _isHovered
                        ? Colors.white.withValues(alpha: 0.18)
                        : Colors.transparent,
              ),
              boxShadow: active
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.20),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (active) ...[
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  widget.label,
                  style: TextStyle(
                    color: active
                        ? AppColors.primary
                        : _isHovered
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                    fontWeight: active || _isHovered
                        ? FontWeight.w700
                        : FontWeight.w500,
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResumeButton extends StatefulWidget {
  const ResumeButton({super.key});

  @override
  State<ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<ResumeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (AppData.resumeUrl.isNotEmpty) {
            LauncherUtil.openUrl(AppData.resumeUrl);
          } else {
            LauncherUtil.sendEmail(AppData.email);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
          decoration: BoxDecoration(
            gradient: _isHovered
                ? AppColors.primaryGradient
                : LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.15),
                      AppColors.primaryLight.withValues(alpha: 0.08),
                    ],
                  ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary
                    .withValues(alpha: _isHovered ? 0.40 : 0.15),
                blurRadius: _isHovered ? 16 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.file_download_outlined,
                size: 16,
                color: _isHovered ? Colors.black : AppColors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                'Resume',
                style: TextStyle(
                  color: _isHovered ? Colors.black : AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Row(
                children: [
                  const Text(
                    AppData.name,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.border, height: 1),
            const SizedBox(height: 12),
            for (int i = 0; i < controller.navItems.length; i++)
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                title: Text(
                  controller.navItems[i].label,
                  style: TextStyle(
                    color: controller.activeIndex == i
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    fontWeight: controller.activeIndex == i
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
                leading: Icon(
                  Icons.arrow_right_rounded,
                  color: controller.activeIndex == i
                      ? AppColors.primary
                      : AppColors.textMuted,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  controller.setActive(i);
                  Future.delayed(const Duration(milliseconds: 250), () {
                    controller.scrollTo(controller.navItems[i].key);
                  });
                },
              ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ResumeButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}