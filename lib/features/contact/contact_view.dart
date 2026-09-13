import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final isMobile = Responsive.isMobile(context);

    return SectionContainer(
      sectionKey: controller.contactKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SectionTitle(
            tag: 'Contact',
            title: 'Let\'s Work Together',
            subtitle:
                'Have a project in mind or an opening on your team? '
                'My inbox is always open.',
            alignment: CrossAxisAlignment.center,
          ),
          const SizedBox(height: 40),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: [
              _ContactCard(
                icon: FontAwesomeIcons.envelope,
                title: 'Email',
                value: AppData.email,
                onTap: () => LauncherUtil.sendEmail(AppData.email),
              ),
              _ContactCard(
                icon: FontAwesomeIcons.phone,
                title: 'Phone',
                value: AppData.phone,
                onTap: () => LauncherUtil.callPhone(AppData.phone),
              ),
              _ContactCard(
                icon: FontAwesomeIcons.locationDot,
                title: 'Location',
                value: AppData.location,
              ),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () => LauncherUtil.sendEmail(AppData.email),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 28 : 36,
                vertical: 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.mail_outline_rounded),
            label: const Text(
              'Say Hello',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: FaIcon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
