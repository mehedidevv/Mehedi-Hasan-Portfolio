import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../theme/app_colors.dart';

class Star {
  double xRatio;
  double yRatio;
  double size;
  double baseOpacity;
  double speed;
  double twinkleSpeed;
  double phase;
  Color color;
  bool isSparkle;

  Star({
    required this.xRatio,
    required this.yRatio,
    required this.size,
    required this.baseOpacity,
    required this.speed,
    required this.twinkleSpeed,
    required this.phase,
    required this.color,
    this.isSparkle = false,
  });
}

class StarfieldWidget extends StatefulWidget {
  const StarfieldWidget({super.key});

  @override
  State<StarfieldWidget> createState() => _StarfieldWidgetState();
}

class _StarfieldWidgetState extends State<StarfieldWidget>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  double _elapsedSeconds = 0.0;
  final List<Star> _stars = [];
  final math.Random _random = math.Random(42); // Fixed seed for reproducible placement

  @override
  void initState() {
    super.initState();

    // Generate ~75 animated stars
    const starColors = [
      Colors.white,
      AppColors.primaryLight,
      AppColors.primary,
      AppColors.accentPurple,
    ];

    for (int i = 0; i < 75; i++) {
      final isSparkle = _random.nextDouble() > 0.85; // 15% sparkling stars
      _stars.add(
        Star(
          xRatio: _random.nextDouble(),
          yRatio: _random.nextDouble(),
          size: isSparkle
              ? 2.2 + _random.nextDouble() * 1.2
              : 0.8 + _random.nextDouble() * 1.4,
          baseOpacity: 0.25 + _random.nextDouble() * 0.45,
          speed: 0.015 + _random.nextDouble() * 0.025, // Gentle drift speed
          twinkleSpeed: 1.2 + _random.nextDouble() * 2.0,
          phase: _random.nextDouble() * math.pi * 2,
          color: starColors[_random.nextInt(starColors.length)],
          isSparkle: isSparkle,
        ),
      );
    }

    // Continuous ticker for frame-rate smooth, infinite time tracking
    _ticker = createTicker((elapsed) {
      if (!mounted) return;
      setState(() {
        _elapsedSeconds = elapsed.inMicroseconds / 1000000.0;
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StarfieldPainter(
        stars: _stars,
        elapsedSeconds: _elapsedSeconds,
      ),
    );
  }
}

class _StarfieldPainter extends CustomPainter {
  final List<Star> stars;
  final double elapsedSeconds;

  _StarfieldPainter({
    required this.stars,
    required this.elapsedSeconds,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      // 1. Continuous smooth modulo y-position calculation (no global loop reset jumps)
      var currentY = (star.yRatio - (elapsedSeconds * star.speed)) % 1.0;
      if (currentY < 0) currentY += 1.0;

      final actualY = currentY * size.height;
      final actualX = star.xRatio * size.width;

      // 2. Smooth Edge Fade: Stars fade out near top edge and fade in at bottom
      double edgeFade = 1.0;
      if (currentY < 0.08) {
        edgeFade = (currentY / 0.08).clamp(0.0, 1.0);
      } else if (currentY > 0.92) {
        edgeFade = ((1.0 - currentY) / 0.08).clamp(0.0, 1.0);
      }

      // 3. Twinkling Opacity using continuous sine wave
      final twinkle = math.sin((elapsedSeconds * star.twinkleSpeed) + star.phase);
      final rawOpacity = (star.baseOpacity + twinkle * 0.28).clamp(0.10, 0.95);
      final finalOpacity = rawOpacity * edgeFade;

      if (finalOpacity <= 0.02) continue; // Skip rendering fully invisible stars

      final center = Offset(actualX, actualY);

      // 4. Draw outer soft glowing aura
      final glowPaint = Paint()
        ..color = star.color.withValues(alpha: finalOpacity * 0.35)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, star.size * 2.2);
      canvas.drawCircle(center, star.size * 2.5, glowPaint);

      // 5. Draw solid star core
      final corePaint = Paint()
        ..color = star.color.withValues(alpha: finalOpacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, star.size, corePaint);

      // 6. Draw 4-point sparkle cross shine for prominent stars
      if (star.isSparkle && finalOpacity > 0.40) {
        final linePaint = Paint()
          ..color = star.color.withValues(alpha: finalOpacity * 0.65)
          ..strokeWidth = 0.8
          ..style = PaintingStyle.stroke;

        final len = star.size * 3.5;
        // Horizontal line
        canvas.drawLine(
          Offset(actualX - len, actualY),
          Offset(actualX + len, actualY),
          linePaint,
        );
        // Vertical line
        canvas.drawLine(
          Offset(actualX, actualY - len),
          Offset(actualX, actualY + len),
          linePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _StarfieldPainter oldDelegate) {
    return oldDelegate.elapsedSeconds != elapsedSeconds;
  }
}
