import 'package:flutter/material.dart';

import '../utils/jui_theme.dart';

class JuiDashedBorder extends StatelessWidget {
// dashColor: 虚线的颜色，可选参数，默认为null
  final Color? dashColor;

// dashWidth: 虚线的宽度
  final double dashWidth;

// dashHeight: 虚线的高度
  final double dashHeight;

// dashSpace: 虚线之间的间距
  final double dashSpace;

// borderRadius: 边框的圆角半径
  final double borderRadius;

// child: 虚线边框内部包含的子组件
  final Widget child;

// onTap: 当用户点击虚线边框时触发的回调函数，可选参数，默认为null
  final VoidCallback? onTap;

  const JuiDashedBorder({
    Key? key,
    this.dashColor,
    this.dashWidth = 2,
    this.dashHeight = 1,
    this.dashSpace = 2,
    this.borderRadius = 8,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: DashedBorderPainter(
          dashColor: dashColor ?? const JuiColors().primary,
          dashWidth: dashWidth,
          dashHeight: dashHeight,
          dashSpace: dashSpace,
          borderRadius: borderRadius,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: child,
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color dashColor;
  final double dashWidth;
  final double dashHeight;
  final double dashSpace;
  final double borderRadius;

  DashedBorderPainter({
    required this.dashColor,
    required this.dashWidth,
    required this.dashHeight,
    required this.dashSpace,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dashColor
      ..strokeWidth = dashHeight
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final dashPath = Path();
    final dashArray = CircularIntervalList<double>([dashWidth, dashSpace]);

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      var draw = true;
      while (distance < metric.length) {
        final length = dashArray.next;
        if (draw) {
          dashPath.addPath(
            metric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) =>
      dashColor != oldDelegate.dashColor ||
      dashWidth != oldDelegate.dashWidth ||
      dashHeight != oldDelegate.dashHeight ||
      dashSpace != oldDelegate.dashSpace ||
      borderRadius != oldDelegate.borderRadius;
}

class CircularIntervalList<T> {
  final List<T> _items;
  int _index = 0;

  CircularIntervalList(this._items);

  T get next {
    if (_index >= _items.length) {
      _index = 0;
    }
    return _items[_index++];
  }
}
