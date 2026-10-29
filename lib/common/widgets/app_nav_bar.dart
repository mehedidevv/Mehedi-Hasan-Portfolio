import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../features/layout/controller/main_layout_controller.dart';
import '../../core/utils/launcher_util.dart';
import '../constants/app_data.dart';
import '../theme/app_colors.dart';
import 'responsive.dart';

class NavBar extends GetView<MainLayoutController> implements PreferredSizeWidget {
  final VoidCallback onMenuTap;

  const NavBar({super.key, required this.onMenuTap});

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
              // Specular Top Border Highlight Accent
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
                            Text(
                              'Mehedi',
                              style: GoogleFonts.spaceGrotesk(
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
                              child: Text(
                                'dev',
                                style: GoogleFonts.spaceGrotesk(
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
                      Obx(
                        () => Row(
                          children: [
                            for (int i = 0; i < controller.navItems.length; i++)
                              _NavButton(
                                label: controller.navItems[i].label,
                                isActive: controller.activeIndex.value == i,
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
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(0, _isHovered ? -1.5 : 0, 0),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              gradient: active
                  ? LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.20),
                        AppColors.primaryLight.withValues(alpha: 0.08),
                      ],
                    )
                  : _isHovered
                      ? LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.10),
                            AppColors.primaryLight.withValues(alpha: 0.05),
                          ],
                        )
                      : null,
              color: active || _isHovered ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: active
                    ? AppColors.primary.withValues(alpha: 0.50)
                    : _isHovered
                        ? AppColors.primaryLight.withValues(alpha: 0.35)
                        : Colors.transparent,
                width: 1.2,
              ),
              boxShadow: active
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : (_isHovered
                      ? [
                          BoxShadow(
                            color: AppColors.primaryLight.withValues(alpha: 0.20),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : []),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (active) ...[
                  Container(
                    width: 6,
                    height: 6,
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
                  const SizedBox(width: 7),
                ] else if (_isHovered) ...[
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryLight,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 7),
                ],
                Text(
                  widget.label,
                  style: GoogleFonts.spaceGrotesk(
                    color: active
                        ? AppColors.primary
                        : _isHovered
                            ? AppColors.primaryLight
                            : AppColors.textSecondary,
                    fontWeight: active || _isHovered
                        ? FontWeight.w700
                        : FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: -0.2,
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
          transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
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
                    .withValues(alpha: _isHovered ? 0.45 : 0.15),
                blurRadius: _isHovered ? 18 : 8,
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
                style: GoogleFonts.spaceGrotesk(
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
class AppNavDrawer extends GetView<MainLayoutController> {
  const AppNavDrawer({super.key});

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
                  Text(
                    AppData.name,
                    style: GoogleFonts.spaceGrotesk(
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
            Obx(
              () => Column(
                children: [
                  for (int i = 0; i < controller.navItems.length; i++)
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                      title: Text(
                        controller.navItems[i].label,
                        style: GoogleFonts.spaceGrotesk(
                          color: controller.activeIndex.value == i
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          fontWeight: controller.activeIndex.value == i
                              ? FontWeight.w700
                              : FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      leading: Icon(
                        Icons.arrow_right_rounded,
                        color: controller.activeIndex.value == i
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
                ],
              ),
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
