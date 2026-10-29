import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/constants/app_data.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/widgets/responsive.dart';
import '../../../common/widgets/section_container.dart';
import '../../layout/controller/main_layout_controller.dart';
import '../../../core/utils/launcher_util.dart';
import '../controller/home_controller.dart';
import '../widget/about_summary_card.dart';
import '../widget/contact_chip.dart';
import '../widget/hero_avatar.dart';
import '../widget/hero_button.dart';

class HomeView extends StatelessWidget {
  final MainLayoutController controller;

  const HomeView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: controller.homeKey,
      extraPadding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          // 1. Top Hero Header Row
          Flex(
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
                    Text(
                      'Hi, I\'m ${AppData.name}',
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: isMobile ? 32 : 48,
                        height: 1.2,
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
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        HeroButton.primary(
                          label: 'Get in touch',
                          icon: Icons.arrow_forward_rounded,
                          onTap: () => controller.scrollTo(controller.contactKey),
                        ),
                        HeroButton.secondary(
                          label: 'View Projects',
                          icon: Icons.grid_view_rounded,
                          onTap: () => controller.scrollTo(controller.projectsKey),
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

          const SizedBox(height: 48),

          // 2. Integrated About & Professional Summary Section
          AboutSummaryCard(controller: homeController),
        ],
      ),
    );
  }
}
