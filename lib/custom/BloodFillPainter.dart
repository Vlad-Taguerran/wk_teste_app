import 'dart:math';

import 'package:flutter/material.dart';

class BloodFillPainter extends CustomPainter {
  final double progress;

  String total;

  BloodFillPainter(this.progress, this.total);

  @override
  void paint(Canvas canvas, Size size) {
    Paint borderPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Paint waterPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.red,
          Colors.red[500]!.withOpacity(0.8),
          Colors.red[400]!.withOpacity(0.4)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    double waterLevel = size.height * (1 - (0.8 + (progress * 0.1)));

    Path circlePath = Path()
      ..addOval(Rect.fromLTWH(0, 0, size.width, size.height));

    // Criar onda  suave
    Path wavePath = Path();
    for (double i = 0; i < size.width; i++) {
      double waveHeight = 6 * sin((i / size.width) * 2 * pi + progress * pi);
      if (i == 0) {
        wavePath.moveTo(i, waterLevel + waveHeight);
      } else {
        wavePath.lineTo(i, waterLevel + waveHeight);
      }
    }
    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    canvas.clipPath(circlePath);
    canvas.drawPath(wavePath, waterPaint);

    // Aplicar máscara para manter a água dentro do círculo
    canvas.clipPath(circlePath);
    canvas.drawPath(wavePath, waterPaint);

    // Adicionar texto centralizado
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: total,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    Offset textPosition = Offset(
      size.width / 2 - textPainter.width / 2,
      size.height / 2 - textPainter.height / 2,
    );
    textPainter.paint(canvas, textPosition);

    // Desenhar o contorno do círculo
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
