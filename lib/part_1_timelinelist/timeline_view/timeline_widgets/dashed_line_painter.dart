import 'package:flutter/widgets.dart';

class DashedLinePainter extends CustomPainter  {
  Color lineColour;
  DashedLinePainter({required this.lineColour});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColour // Line color
      ..strokeWidth = 2 // Line thickness
      ..strokeCap = StrokeCap.round; // Smooth edges

    double dashHeight = 2, dashSpace = 5, startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}