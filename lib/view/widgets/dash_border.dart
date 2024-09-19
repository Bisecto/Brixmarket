import 'dart:math';

import 'package:flutter/material.dart';

class DashedBorder extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double padding;
  final Widget? child;
  final Alignment align;

  const DashedBorder({Key? key, this.color = Colors.black, this.strokeWidth = 1.0, this.gap = 4.0, this.padding = 1.0, this.child, this.align = Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: CustomPaint(
            painter: DashRectPainter(color: color, strokeWidth: strokeWidth, gap: gap),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(padding),
        child: Align(
          alignment: align,
          child: child ?? const SizedBox.shrink(),
        ),
      )
    ]);
  }
}

class DashRectPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;

  DashRectPainter({this.strokeWidth = 5.0, this.color = Colors.red, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(
      a: const Point(0, 0),
      b: Point(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(
      a: Point(x, 0),
      b: Point(x, y),
      gap: gap,
    );

    Path _bottomPath = getDashedPath(
      a: Point(0, y),
      b: Point(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: const Point(0, 0),
      b: Point(0.001, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    required Point<double> a,
    required Point<double> b,
    required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    Point currentPoint = Point(a.x, a.y);

    num radians = atan(size.height / size.width);

    num dx = cos(radians) * gap < 0 ? cos(radians) * gap * -1 : cos(radians) * gap;

    num dy = sin(radians) * gap < 0 ? sin(radians) * gap * -1 : sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw ? path.lineTo(currentPoint.x.toDouble(), currentPoint.y.toDouble()) : path.moveTo(currentPoint.x.toDouble(), currentPoint.y.toDouble());
      shouldDraw = !shouldDraw;
      currentPoint = Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
