import 'package:flutter/material.dart';

class VerticalDottedDivider extends StatelessWidget {
  final double height;
  final double dotWidth;
  final double dotHeight;
  final Color color;

  const VerticalDottedDivider({
    super.key,
    this.height = 100,
    this.dotWidth = 2,
    this.dotHeight = 8,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _DottedLinePainter(
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          color: color,
        ),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final double dotWidth;
  final double dotHeight;
  final Color color;

  _DottedLinePainter({
    required this.dotWidth,
    required this.dotHeight,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = dotWidth
      ..style = PaintingStyle.fill;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            (size.width - dotWidth) / 2,
            startY,
            dotWidth,
            dotHeight,
          ),
          const Radius.circular(2), // Rounded edges for dots
        ),
        paint,
      );
      startY += dotHeight * 2; // Adjust spacing between dots
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
