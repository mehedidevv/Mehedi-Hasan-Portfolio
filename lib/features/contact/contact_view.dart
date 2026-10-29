import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/constants/app_data.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/responsive.dart';
import '../../common/widgets/section_container.dart';
import '../layout/controller/main_layout_controller.dart';
import 'controller/contact_controller.dart';
import 'widget/contact_form_widget.dart';

class ContactView extends StatelessWidget {
  final MainLayoutController controller;
  const ContactView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final contactController = Get.put(ContactController());
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    // Left Column Content with Liquid Glass Contact Cards
    final leftSideContent = Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Pill Tag Badge: GET IN TOUCH
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.35),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.mail_outline_rounded,
                size: 14,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.primaryGradient.createShader(bounds),
                child: Text(
                  'GET IN TOUCH',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                    fontSize: 11.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Headline
        Text(
          'Have a good idea?',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: isMobile ? 32 : 46,
            height: 1.15,
            letterSpacing: -1.0,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => AppColors.cyberGlow.createShader(bounds),
          child: Text(
            "Let's make it real.",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 32 : 46,
              height: 1.15,
              letterSpacing: -1.0,
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Subtitle Text
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            'Whether you\'re building a product, exploring an app idea, or need a mobile engineering partner, I\'d love to hear from you.',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.inter(
              color: const Color(0xFFCBD5E1),
              fontSize: 15.5,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 28),

        // Subtle Divider Line
        Container(
          height: 1,
          width: isMobile ? double.infinity : 480,
          color: AppColors.border.withValues(alpha: 0.80),
        ),
        const SizedBox(height: 28),

        // Section Title: Direct Contact Channels
        Text(
          'Direct Contact Channels',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18.5,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 6),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            'Reach out directly for rapid technical consultations, timelines, and project estimates.',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.inter(
              color: const Color(0xFF94A3B8),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 22),

        // Liquid Glass Contact Channel Cards
        Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            _ContactChannelItem(
              icon: FontAwesomeIcons.envelope,
              title: 'Email',
              text: AppData.email,
              onTap: contactController.sendEmail,
            ),
            const SizedBox(height: 14),
            _ContactChannelItem(
              icon: FontAwesomeIcons.whatsapp,
              title: 'WhatsApp',
              text: 'WhatsApp: ${AppData.phone}',
              onTap: contactController.callPhone,
            ),
            const SizedBox(height: 14),
            _ContactChannelItem(
              icon: FontAwesomeIcons.github,
              title: 'GitHub',
              text: 'github.com/mehedidevv',
              onTap: contactController.openGithub,
            ),
            const SizedBox(height: 14),
            _ContactChannelItem(
              icon: FontAwesomeIcons.linkedin,
              title: 'LinkedIn',
              text: 'LinkedIn Profile',
              onTap: contactController.openLinkedin,
            ),
          ],
        ),
      ],
    );

    return SectionContainer(
      sectionKey: controller.contactKey,
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Direct Info & Liquid Glass Cards
                Expanded(
                  flex: 5,
                  child: leftSideContent,
                ),
                const SizedBox(width: 44),
                // Right Column: Professional Glass Contact Form
                Expanded(
                  flex: 7,
                  child: ContactFormWidget(controller: contactController),
                ),
              ],
            )
          : Column(
              children: [
                leftSideContent,
                const SizedBox(height: 44),
                ContactFormWidget(controller: contactController),
              ],
            ),
    );
  }
}

/// Liquid Glass Contact Channel Card with Backdrop Blur, Glowing Border & Hover FX
class _ContactChannelItem extends StatefulWidget {
  final dynamic icon;
  final String title;
  final String text;
  final VoidCallback onTap;

  const _ContactChannelItem({
    required this.icon,
    required this.title,
    required this.text,
    required this.onTap,
  });

  @override
  State<_ContactChannelItem> createState() => _ContactChannelItemState();
}

class _ContactChannelItemState extends State<_ContactChannelItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _isHovered
                    ? AppColors.primary.withValues(alpha: 0.16)
                    : Colors.white.withValues(alpha: 0.06),
                _isHovered
                    ? AppColors.primaryLight.withValues(alpha: 0.08)
                    : const Color(0xFF0F1A2E).withValues(alpha: 0.75),
              ],
            ),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.65)
                  : Colors.white.withValues(alpha: 0.16),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.30),
                blurRadius: _isHovered ? 20 : 12,
                offset: const Offset(0, 6),
              ),
              if (_isHovered)
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.20),
                  blurRadius: 24,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Row(
                  children: [
                    // Glowing Icon Container Badge
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _isHovered
                            ? AppColors.primary.withValues(alpha: 0.22)
                            : AppColors.primary.withValues(alpha: 0.14),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _isHovered
                              ? AppColors.primary.withValues(alpha: 0.50)
                              : AppColors.primary.withValues(alpha: 0.28),
                        ),
                        boxShadow: _isHovered
                            ? [
                                BoxShadow(
                                  color: AppColors.primary
                                      .withValues(alpha: 0.35),
                                  blurRadius: 12,
                                ),
                              ]
                            : [],
                      ),
                      child: FaIcon(
                        widget.icon,
                        size: 16,
                        color: _isHovered
                            ? AppColors.primaryLight
                            : AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Label & Value
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.spaceGrotesk(
                              color: _isHovered
                                  ? AppColors.primary
                                  : AppColors.primaryLight,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.text,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Hover Animated Arrow Indicator
                    AnimatedSlide(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      offset: Offset(_isHovered ? 0.2 : 0, 0),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: _isHovered
                            ? AppColors.primary
                            : AppColors.textMuted.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
