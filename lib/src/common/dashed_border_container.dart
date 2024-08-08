import 'package:flutter/cupertino.dart';
import 'package:vv_ui_kit/src/utils/color.dart';

/// 一个带虚线边框的容器组件
class DashedBorderContainer extends StatelessWidget {
  final Color dashColor; // 虚线颜色
  final double dashWidth; // 虚线宽度
  final double dashHeight; // 虚线高度
  final double dashSpace; // 虚线间距
  final double borderRadius; // 圆角半径
  final Widget child; // 子组件
  final VoidCallback? onTap; // 点击事件回调

  const DashedBorderContainer({
    Key? key,
    this.dashColor = ui5590F6,
    this.dashWidth = 2,
    this.dashHeight = 1,
    this.dashSpace = 2,
    this.borderRadius = 8,
    required this.child,
    this.onTap,
  }) : super(key: key);

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

/// 绘制虚线边框的画家类
class DashedBorderPainter extends CustomPainter {
  final Color dashColor; // 虚线颜色
  final double dashWidth; // 虚线宽度
  final double dashHeight; // 虚线高度
  final double dashSpace; // 虚线间距
  final double borderRadius; // 圆角半径

  DashedBorderPainter({
    required this.dashColor,
    required this.dashWidth,
    required this.dashHeight,
    required this.dashSpace,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 设置画笔
    final paint = Paint()
      ..color = dashColor
      ..strokeWidth = dashHeight;

    // 创建圆角矩形路径
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    // 获取路径的所有度量
    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        // 获取当前距离的切线
        final segment = metric.getTangentForOffset(distance);
        // 获取下一个虚线结束位置的切线
        final nextSegment = metric.getTangentForOffset(distance + dashWidth);

        // 如果切线不为空，绘制虚线
        if (segment != null && nextSegment != null) {
          canvas.drawLine(segment.position, nextSegment.position, paint);
        }

        // 增加距离以绘制下一个虚线段
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
