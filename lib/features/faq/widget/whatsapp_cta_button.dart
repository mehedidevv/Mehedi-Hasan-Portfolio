import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/theme/app_colors.dart';

class WhatsAppCtaButton extends StatefulWidget {
  final VoidCallback onTap;

  const WhatsAppCtaButton({
    super.key,
    required this.onTap,
  });

  @override
  State<WhatsAppCtaButton> createState() => _WhatsAppCtaButtonState();
}

class _WhatsAppCtaButtonState extends State<WhatsAppCtaButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const whatsAppGreen = Color(0xFF25D366);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                whatsAppGreen.withValues(alpha: _isHovered ? 0.32 : 0.18),
                whatsAppGreen.withValues(alpha: _isHovered ? 0.14 : 0.06),
              ],
            ),
            border: Border.all(
              color: whatsAppGreen.withValues(alpha: _isHovered ? 0.80 : 0.45),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: whatsAppGreen.withValues(alpha: _isHovered ? 0.40 : 0.18),
                blurRadius: _isHovered ? 26 : 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: whatsAppGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: whatsAppGreen,
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.whatsapp,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Have a question?',
                          style: GoogleFonts.inter(
                            color: AppColors.textMuted,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Chat on WhatsApp',
                          style: GoogleFonts.spaceGrotesk(
                            color: AppColors.textPrimary,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    AnimatedSlide(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      offset: Offset(_isHovered ? 0.25 : 0, 0),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: whatsAppGreen,
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
