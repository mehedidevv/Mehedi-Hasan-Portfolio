import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherUtil {
  LauncherUtil._();

  static Future<void> openUrl(String url) async {
    final trimmed = url.trim();
    if (trimmed.isEmpty) return;

    try {
      final uri = Uri.parse(trimmed);
      if (kIsWeb) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          await launchUrl(uri);
        }
      }
    } catch (e) {
      debugPrint('Error launching URL ($trimmed): $e');
    }
  }

  static Future<void> sendEmail(String email) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty) return;

    try {
      final uri = Uri(scheme: 'mailto', path: trimmed);
      await launchUrl(uri);
    } catch (e) {
      debugPrint('Error launching email ($trimmed): $e');
    }
  }

  static Future<void> callPhone(String phone) async {
    final trimmed = phone.trim();
    if (trimmed.isEmpty) return;

    try {
      final uri = Uri(scheme: 'tel', path: trimmed);
      await launchUrl(uri);
    } catch (e) {
      debugPrint('Error launching phone ($trimmed): $e');
    }
  }
}
