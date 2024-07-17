import 'package:flutter/cupertino.dart';

import '../../utils/custom_color.dart';

/// 自定义虚线边框容器组件
class DashedBorderContainer extends StatelessWidget {
  const DashedBorderContainer({
    Key? key,
    this.dashColor = color5590F6,
    this.dashWidth = 2,
    this.dashHeight = 1,
    this.dashSpace = 2,
    this.borderRadius = 8,
    required this.child,
    this.onTap,
  }) : super(key: key);

  final Color dashColor; // 虚线颜色
  final double dashWidth; // 虚线宽度
  final double dashHeight; // 虚线高度
  final double dashSpace; // 虚线间距
  final double borderRadius; // 边框圆角半径
  final Widget child; // 子组件
  final VoidCallback? onTap; // 点击事件回调
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: GestureDetector(
        onTap: onTap,
        child: CustomPaint(
          painter: DashedBorderPainter(
            dashColor: dashColor,
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
      ),
    );
  }
}

/// 自定义虚线边框画家
class DashedBorderPainter extends CustomPainter {
  final Color dashColor; // 虚线颜色
  final double dashWidth; // 虚线宽度
  final double dashHeight; // 虚线高度
  final double dashSpace; // 虚线间距
  final double borderRadius; // 边框圆角半径

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
      ..strokeWidth = dashHeight;

    // 创建圆角矩形路径
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    // 计算路径的度量
    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final segment = metric.getTangentForOffset(distance);
        final nextSegment = metric.getTangentForOffset(distance + dashWidth);

        if (segment != null && nextSegment != null) {
          canvas.drawLine(segment.position, nextSegment.position, paint);
        }

        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
