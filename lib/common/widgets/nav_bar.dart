import 'dart:ui';
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
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final hPad = Responsive.pagePadding(context);

    return ClipRect(
      child: BackdropFilter(
        /// Stronger blur + saturation-friendly: content behind looks frosted
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: Container(
          width: double.infinity,
          height: preferredSize.height,
          decoration: BoxDecoration(
            /// Liquid glass tint: light catches the top-left, fades toward bottom-right
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.16),
                AppColors.background.withValues(alpha: 0.35),
                Colors.white.withValues(alpha: 0.06),
              ],
              stops: const [0.0, 0.55, 1.0],
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.18),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.30),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              /// Specular highlight along the top edge
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.0),
                        Colors.white.withValues(alpha: 0.55),
                        Colors.white.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              /// Soft inner glow under the highlight
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 24,
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.10),
                          Colors.white.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: Row(
                  children: [
                    // Logo
                    GestureDetector(
                      onTap: () => controller.scrollTo(controller.homeKey),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                              letterSpacing: 0.5,
                            ),
                            children: [
                              TextSpan(text: 'Mehedi'),
                              TextSpan(
                                text: '.',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(text: 'dev'),
                            ],
                          ),
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
                            const SizedBox(width: 12),
                            ResumeButton(),
                          ],
                        ),
                      )
                    else
                      IconButton(
                        onPressed: onMenuTap,
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: AppColors.textPrimary,
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
      padding: const EdgeInsets.symmetric(horizontal: 3),
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
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : _isHovered
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: active
                    ? AppColors.primary.withValues(alpha: 0.4)
                    : _isHovered
                    ? Colors.white.withValues(alpha: 0.15)
                    : Colors.transparent,
              ),
            ),
            child: Text(
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
          ),
        ),
      ),
    );
  }
}

class ResumeButton extends StatefulWidget {
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
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.primary,
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ]
                : [],
          ),
          child: Text(
            'Resume',
            style: TextStyle(
              color: _isHovered ? Colors.black : AppColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: 13.5,
            ),
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