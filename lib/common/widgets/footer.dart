import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/utils/launcher_util.dart';
import '../constants/app_data.dart';
import '../theme/app_colors.dart';
import 'responsive.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 32),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: isMobile
              ? Column(
                  children: [
                    _socials(),
                    const SizedBox(height: 16),
                    _copyright(),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_copyright(), _socials()],
                ),
        ),
      ),
    );
  }

  Widget _copyright() {
    return Text(
      '© ${DateTime.now().year} ${AppData.name}. All rights reserved.',
      style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
    );
  }

  Widget _socials() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _iconBtn(FontAwesomeIcons.github, () => LauncherUtil.openUrl(AppData.github)),
        const SizedBox(width: 14),
        _iconBtn(FontAwesomeIcons.linkedin, () => LauncherUtil.openUrl(AppData.linkedin)),
        const SizedBox(width: 14),
        _iconBtn(FontAwesomeIcons.envelope, () => LauncherUtil.sendEmail(AppData.email)),
      ],
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: FaIcon(icon, size: 18, color: AppColors.textSecondary),
      ),
    );
  }
}
