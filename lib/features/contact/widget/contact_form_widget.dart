import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/widgets/responsive.dart';
import '../controller/contact_controller.dart';
import 'custom_text_field.dart';

class ContactFormWidget extends StatefulWidget {
  final ContactController controller;

  const ContactFormWidget({super.key, required this.controller});

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  bool _isSubmitHovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.controller;
    final isMobile = Responsive.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.08),
            AppColors.surface.withValues(alpha: 0.35),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.16),
          width: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 36,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Specular Gradient Highlight Line Accent
              Container(
                height: 3.5,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(isMobile ? 20 : 32),
                child: Form(
                  key: c.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Row for Name & Mail on Desktop/Tablet
                      if (isMobile) ...[
                        CustomTextField(
                          controller: c.nameController,
                          label: 'Name',
                          hint: 'Jane Smith',
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: c.emailController,
                          label: 'Mail',
                          hint: 'jane@company.com',
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!GetUtils.isEmail(v.trim())) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      ] else ...[
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: c.nameController,
                                label: 'Name',
                                hint: 'Jane Smith',
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: CustomTextField(
                                controller: c.emailController,
                                label: 'Mail',
                                hint: 'jane@company.com',
                                keyboardType: TextInputType.emailAddress,
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!GetUtils.isEmail(v.trim())) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 22),

                      // Subject Field
                      CustomTextField(
                        controller: c.subjectController,
                        label: 'Subject',
                        hint: 'Project inquiry / Mobile app development',
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Please enter a subject';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 22),

                      // Details / Message Field
                      CustomTextField(
                        controller: c.messageController,
                        label: 'Details',
                        hint:
                            'Tell me about your project, goals, key requirements, or questions...',
                        maxLines: 5,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Please enter your message details';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 28),

                      // Full Width Glowing Send Button
                      Obx(() {
                        final sending = c.isSending.value;

                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => setState(() => _isSubmitHovered = true),
                          onExit: (_) => setState(() => _isSubmitHovered = false),
                          child: GestureDetector(
                            onTap: sending ? null : c.submitForm,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeOutCubic,
                              width: double.infinity,
                              transform: Matrix4.translationValues(
                                0,
                                _isSubmitHovered && !sending ? -3 : 0,
                                0,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: _isSubmitHovered
                                    ? const LinearGradient(
                                        colors: [
                                          Color(0xFF00E5FF),
                                          Color(0xFF16C784),
                                        ],
                                      )
                                    : AppColors.primaryGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: _isSubmitHovered ? 0.65 : 0.45,
                                    ),
                                    blurRadius: _isSubmitHovered ? 32 : 22,
                                    offset: const Offset(0, 8),
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.35),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (sending) ...[
                                    const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xFF080C14),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Sending message...',
                                      style: GoogleFonts.spaceGrotesk(
                                        color: const Color(0xFF080C14),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ] else ...[
                                    Text(
                                      'Send Message',
                                      style: GoogleFonts.spaceGrotesk(
                                        color: const Color(0xFF080C14),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
