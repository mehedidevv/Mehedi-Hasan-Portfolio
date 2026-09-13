import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/responsive.dart';
import '../../common/widgets/section_container.dart';
import '../../core/controllers/nav_controller.dart';
import '../../core/utils/launcher_util.dart';

class HomeView extends StatelessWidget {
  final NavController controller;

  const HomeView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: controller.homeKey,
      extraPadding: const EdgeInsets.only(top: 40),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: isMobile ? 0 : 6,
            child: Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                _Badge(),
                const SizedBox(height: 22),
                Text(
                  'Hi, I\'m ${AppData.name}',
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: isMobile ? 32 : 48,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 12),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.heroGlow.createShader(bounds),
                  child: Text(
                    AppData.role,
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: isMobile ? 18 : 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isMobile ? 500 : 520),
                  child: Text(
                    AppData.tagline,
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15.5,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Wrap(
                  alignment:
                      isMobile ? WrapAlignment.center : WrapAlignment.start,
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.scrollTo(controller.contactKey),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 26, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Get in touch',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => controller.scrollTo(controller.projectsKey),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        foregroundColor: AppColors.textPrimary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 26, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('View Projects'),
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                Wrap(
                  alignment:
                      isMobile ? WrapAlignment.center : WrapAlignment.start,
                  spacing: 18,
                  runSpacing: 10,
                  children: [
                    _ContactChip(
                      icon: FontAwesomeIcons.envelope,
                      label: AppData.email,
                      onTap: () => LauncherUtil.sendEmail(AppData.email),
                    ),
                    _ContactChip(
                      icon: FontAwesomeIcons.phone,
                      label: AppData.phone,
                      onTap: () => LauncherUtil.callPhone(AppData.phone),
                    ),
                    _ContactChip(
                      icon: FontAwesomeIcons.locationDot,
                      label: AppData.location,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 48 : 0, width: isMobile ? 0 : 40),
          if (!isMobile) Expanded(flex: 4, child: _HeroAvatar()),
          if (isMobile) _HeroAvatar(size: 220),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.4)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Dot(),
          SizedBox(width: 8),
          Text(
            'Available for new opportunities',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _ContactChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ContactChip({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13.5),
          ),
        ],
      ),
    );
  }
}

class _HeroAvatar extends StatelessWidget {
  final double size;
  const _HeroAvatar({this.size = 300});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.heroGlow,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.35),
              blurRadius: 60,
              spreadRadius: 6,
            ),
          ],
        ),
        padding: const EdgeInsets.all(6),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surface,
          ),
          alignment: Alignment.center,
          child: Text(
            'MH',
            style: TextStyle(
              fontSize: size * 0.32,
              fontWeight: FontWeight.w800,
              foreground: Paint()
                ..shader = AppColors.heroGlow.createShader(
                  Rect.fromLTWH(0, 0, size, size),
                ),
            ),
          ),
        ),
      ),
    );
  }
}
