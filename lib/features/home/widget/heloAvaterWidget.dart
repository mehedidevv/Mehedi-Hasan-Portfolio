
import 'package:flutter/cupertino.dart';

import '../../../common/theme/app_colors.dart';

class HeroAvatar extends StatelessWidget {
  final double size;
  const HeroAvatar({this.size = 300});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.heroGlow,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.35),
              blurRadius: 60,
              spreadRadius: 6,
            ),
          ],
        ),
        padding: const EdgeInsets.all(6),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surface,
          ),
          alignment: Alignment.center,
          child: Text(
            'MH',
            style: TextStyle(
              fontSize: size * 0.32,
              fontWeight: FontWeight.w800,
              foreground: Paint()
                ..shader = AppColors.heroGlow.createShader(
                  Rect.fromLTWH(0, 0, size, size),
                ),
            ),
          ),
        ),
      ),
    );
  }
}
