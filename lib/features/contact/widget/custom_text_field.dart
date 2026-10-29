import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isRequired;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.isRequired = true,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // High-contrast Header Label (e.g. NAME *)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.label.toUpperCase(),
                  style: GoogleFonts.spaceGrotesk(
                    color: _isFocused
                        ? AppColors.primary
                        : (_isHovered
                            ? AppColors.primaryLight
                            : const Color(0xFFCBD5E1)), // Very bright slate-white
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                if (widget.isRequired)
                  TextSpan(
                    text: ' *',
                    style: GoogleFonts.inter(
                      color: AppColors.primaryLight,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // High-contrast Glassy Input Box
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: _isFocused
                  ? const Color(0xFF0F1A2E)
                  : (_isHovered
                      ? const Color(0xFF0D1728)
                      : const Color(0xFF0B1220)),
              border: Border.all(
                color: _isFocused
                    ? AppColors.primary
                    : (_isHovered
                        ? AppColors.primaryLight.withValues(alpha: 0.60)
                        : Colors.white.withValues(alpha: 0.18)),
                width: 1.3,
              ),
              boxShadow: [
                if (_isFocused)
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.28),
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  )
                else if (_isHovered)
                  BoxShadow(
                    color: AppColors.primaryLight.withValues(alpha: 0.15),
                    blurRadius: 12,
                  ),
              ],
            ),
            child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              maxLines: widget.maxLines,
              keyboardType: widget.keyboardType,
              style: GoogleFonts.inter(
                color: Colors.white, // Crisp pure white input text
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              validator: widget.validator,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF64748B), // Clear readable slate
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
