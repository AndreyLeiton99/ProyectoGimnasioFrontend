import 'dart:math' as math;
import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  final double progress; // Valor de progreso entre 0 y 1
  final List<Color>? gradientColors; // Colores del gradiente

  ProgressPainter({
    required this.progress,
    this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 5;
    final double radius = size.width / 2 - (strokeWidth / 2);
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Dibujar el medidor principal (con el gradiente)
    _drawProgressArc(canvas, center, radius, degreeToRadians(278), degreeToRadians(360 * progress), gradientColors ?? [Colors.blue, Colors.blueAccent]);

    // Dibujar un círculo indicador al final del medidor
    _drawIndicatorCircle(canvas, center, radius, degreeToRadians(360 * progress), strokeWidth);
  }

  void _drawProgressArc(Canvas canvas, Offset center, double radius, double startAngle, double sweepAngle, List<Color> colors) {
    final Rect rect = Rect.fromCircle(center: center, radius: radius);
    final SweepGradient gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      tileMode: TileMode.repeated,
      colors: colors,
    );

    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  void _drawIndicatorCircle(Canvas canvas, Offset center, double radius, double angle, double strokeWidth) {
    const double indicatorRadius = 14 / 5; // Tamaño del círculo indicador
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.translate(0.0, -radius + (strokeWidth / 2));
    canvas.drawCircle(Offset(0, 0), indicatorRadius, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    return (degree * math.pi / 180);
  }
}
