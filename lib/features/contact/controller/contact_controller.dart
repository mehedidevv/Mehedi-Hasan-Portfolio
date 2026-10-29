import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../common/constants/app_data.dart';
import '../../../core/utils/launcher_util.dart';

class ContactController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final RxBool isSending = false.obs;

  void sendEmail() => LauncherUtil.sendEmail(AppData.email);
  void callPhone() => LauncherUtil.callPhone(AppData.phone);
  void openGithub() => LauncherUtil.openUrl(AppData.github);
  void openLinkedin() => LauncherUtil.openUrl(AppData.linkedin);

  /// Submits the contact form to Web3Forms endpoint
  Future<void> submitForm() async {
    // 1. Validate Form
    if (!(formKey.currentState?.validate() ?? false)) return;

    // 2. Prevent duplicate submission while in progress
    if (isSending.value) return;

    isSending.value = true;

    try {
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final subject = subjectController.text.trim();
      final message = messageController.text.trim();

      // Web3Forms API Endpoint
      final uri = Uri.parse('https://api.web3forms.com/submit');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'access_key': AppData.web3FormsAccessKey,
          'name': name,
          'email': email,
          'subject': subject,
          'message': message,
          'from_name': '$name (Portfolio Contact Form)',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        if (data['success'] == true) {
          // Success Feedback
          Get.snackbar(
            'Message Sent',
            'Thank you! Your message has been sent successfully.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF16C784),
            colorText: Colors.black,
            margin: const EdgeInsets.all(16),
            borderRadius: 12,
            duration: const Duration(seconds: 4),
          );

          // Clear form fields on successful delivery
          nameController.clear();
          emailController.clear();
          subjectController.clear();
          messageController.clear();
        } else {
          // Failure response from Web3Forms
          Get.snackbar(
            'Submission Failed',
            data['message'] ?? 'Unable to send message. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            margin: const EdgeInsets.all(16),
            borderRadius: 12,
            duration: const Duration(seconds: 4),
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Server returned code ${response.statusCode}. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Network Error',
        'Unable to connect to the server. Please check your internet connection.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isSending.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
