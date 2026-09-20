import 'dart:math';

import 'package:flutter/material.dart';

/// L'icône de l'application (L20) : sur un carré arrondi de la couleur du thème, un dé à six
/// faces (face 5, légèrement incliné) et un pion d'échecs devant lui, en blanc. Tout est
/// exprimé en fraction du côté : le même dessin sert de 16 à 1024 px.
/// `tool/render_app_icon_test.dart` le rend en PNG et en `.ico`.
class AppIconPainter extends CustomPainter {
  static const Color background = Color(0xff0f6681);
  static const Color backgroundDark = Color(0xff0a4a5e);
  static const Color ink = Colors.white;
  static const Color pip = Color(0xff0a4a5e);
  static const Color shadow = Color(0x330a4a5e);

  const AppIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    _background(canvas, s);
    _die(canvas, s);
    _pawn(canvas, s);
  }

  void _background(Canvas canvas, double s) {
    final rect = RRect.fromRectAndRadius(Offset.zero & Size(s, s), Radius.circular(s * 0.22));
    canvas.drawRRect(rect, Paint()..shader = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [background, backgroundDark],
    ).createShader(Offset.zero & Size(s, s)));
  }

  // Le dé : un carré arrondi blanc, incliné de 12°, face 5. En haut à gauche, derrière le pion.
  void _die(Canvas canvas, double s) {
    final side = s * 0.50;
    final center = Offset(s * 0.42, s * 0.42);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-12 * pi / 180);
    final face = RRect.fromRectAndRadius(Rect.fromCenter(center: Offset.zero, width: side, height: side), Radius.circular(side * 0.18));
    canvas.drawRRect(face.shift(Offset(side * 0.04, side * 0.05)), Paint()..color = shadow);
    canvas.drawRRect(face, Paint()..color = ink);
    final pipPaint = Paint()..color = pip;
    final r = side * 0.085;
    final d = side * 0.27;
    for (final o in [Offset(-d, -d), Offset(d, -d), Offset.zero, Offset(-d, d), Offset(d, d)]) {
      canvas.drawCircle(o, r, pipPaint);
    }
    canvas.restore();
  }

  // Le pion : tête ronde, collerette, corps évasé, socle. En bas à droite, devant le dé, avec
  // un liseré sombre pour se détacher du dé — blanc sur blanc sinon.
  void _pawn(Canvas canvas, double s) {
    final cx = s * 0.67;
    final parts = <Path>[
      Path()..addRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(cx, s * 0.845), width: s * 0.36, height: s * 0.075), Radius.circular(s * 0.03))),
      Path()
        ..moveTo(cx - s * 0.07, s * 0.52)
        ..quadraticBezierTo(cx - s * 0.075, s * 0.68, cx - s * 0.14, s * 0.815)
        ..lineTo(cx + s * 0.14, s * 0.815)
        ..quadraticBezierTo(cx + s * 0.075, s * 0.68, cx + s * 0.07, s * 0.52)
        ..close(),
      Path()..addRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(cx, s * 0.52), width: s * 0.24, height: s * 0.055), Radius.circular(s * 0.025))),
      Path()..addOval(Rect.fromCircle(center: Offset(cx, s * 0.395), radius: s * 0.105)),
    ];
    final outline = Paint()
      ..color = pip
      ..style = PaintingStyle.stroke
      ..strokeWidth = s * 0.05
      ..strokeJoin = StrokeJoin.round;
    final fill = Paint()..color = ink;
    for (final part in parts) {
      canvas.drawPath(part, outline);
    }
    for (final part in parts) {
      canvas.drawPath(part, fill);
    }
  }

  @override
  bool shouldRepaint(AppIconPainter oldDelegate) => false;
}
