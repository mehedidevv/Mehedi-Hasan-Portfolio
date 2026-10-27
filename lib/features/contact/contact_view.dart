import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mehedi_portfolio/features/contact/widget/actionButtonWidget.dart';
import 'package:mehedi_portfolio/features/contact/widget/availableBadgeWidget.dart';
import 'package:mehedi_portfolio/features/contact/widget/contactCardWidget.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/responsive.dart';
import '../../common/widgets/section_container.dart';
import '../../common/widgets/section_title.dart';
import '../../core/controllers/nav_controller.dart';
import '../../core/utils/launcher_util.dart';

class ContactView extends StatelessWidget {
  final NavController controller;
  const ContactView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: controller.contactKey,
      extraPadding: const EdgeInsets.symmetric(vertical: -10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Availability Badge
          const AvailabilityBadge(),
          const SizedBox(height: 16),
          const SectionTitle(
            tag: 'Contact',
            title: 'Let\'s Work Together',
            subtitle:
            'Have a project in mind or an opening on your team? My inbox is always open.',
            alignment: CrossAxisAlignment.center,
          ),
          const SizedBox(height: 28),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: [
              ContactCard(
                icon: FontAwesomeIcons.envelope,
                title: 'Email',
                value: AppData.email,
                actionLabel: 'Click to Send Email',
                onTap: () => LauncherUtil.sendEmail(AppData.email),
              ),
              ContactCard(
                icon: FontAwesomeIcons.phone,
                title: 'Phone',
                value: AppData.phone,
                actionLabel: 'Click to Call',
                onTap: () => LauncherUtil.callPhone(AppData.phone),
              ),
              const ContactCard(
                icon: FontAwesomeIcons.locationDot,
                title: 'Location',
                value: AppData.location,
                actionLabel: 'Based in Bangladesh',
                onTap: null,
              ),
            ],
          ),
          const SizedBox(height: 36),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              ActionButton(
                icon: Icons.mail_outline_rounded,
                label: 'Say Hello',
                isPrimary: true,
                onTap: () => LauncherUtil.sendEmail(AppData.email),
              ),
              ActionButton(
                icon: FontAwesomeIcons.github,
                label: 'GitHub',
                isPrimary: false,
                onTap: () => LauncherUtil.openUrl(AppData.github),
              ),
              ActionButton(
                icon: FontAwesomeIcons.linkedin,
                label: 'LinkedIn',
                isPrimary: false,
                onTap: () => LauncherUtil.openUrl(AppData.linkedin),
              ),
            ],
          ),
        ],
      ),
    );
  }
}