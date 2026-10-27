import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common/constants/app_data.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/widgets/responsive.dart';
import '../../../common/widgets/section_container.dart';
import '../../../core/controllers/nav_controller.dart';
import '../../../core/utils/launcher_util.dart';
import '../widget/contactChipWidget.dart';
import '../widget/heloAvaterWidget.dart';

class HomeView extends StatelessWidget {
  final NavController controller;

  const HomeView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: controller.homeKey,
      extraPadding: const EdgeInsets.only(top: 10),
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
                // Top Status Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'SOFTWARE ENGINEER & FLUTTER DEVELOPER',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

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
                      onPressed: () =>
                          controller.scrollTo(controller.contactKey),
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
                      onPressed: () =>
                          controller.scrollTo(controller.projectsKey),
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
                    ContactChip(
                      icon: FontAwesomeIcons.envelope,
                      label: AppData.email,
                      onTap: () => LauncherUtil.sendEmail(AppData.email),
                    ),
                    ContactChip(
                      icon: FontAwesomeIcons.phone,
                      label: AppData.phone,
                      onTap: () => LauncherUtil.callPhone(AppData.phone),
                    ),
                    const ContactChip(
                      icon: FontAwesomeIcons.locationDot,
                      label: AppData.location,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 48 : 0, width: isMobile ? 0 : 40),
          if (!isMobile) ...[
            const Expanded(
              flex: 4,
              child: HeroAvatar(
                alignment: Alignment.centerRight,
              ),
            ),
          ] else ...[
            const HeroAvatar(
              size: 220,
              alignment: Alignment.center,
            ),
          ],
        ],
      ),
    );
  }
}
