import 'package:flutter/material.dart';
import '../utils/jui_theme.dart';

/// `JuiDashedBorder` 组件用于创建带有虚线边框的容器。
///
/// 该组件支持自定义虚线的颜色、宽度、高度、间距以及圆角半径，并且可以包含子组件。
/// 用户还可以设置 `onTap` 回调，使整个边框区域可点击。
class JuiDashedBorder extends StatelessWidget {
  /// 虚线的颜色，默认为主题色 `primary`
  final Color? dashColor;

  /// 虚线的宽度
  final double dashWidth;

  /// 虚线的高度
  final double dashHeight;

  /// 虚线之间的间距
  final double dashSpace;

  /// 边框的圆角半径
  final double borderRadius;

  /// 虚线边框内部包含的子组件
  final Widget child;

  /// 当用户点击虚线边框时触发的回调函数（可选）
  final VoidCallback? onTap;

  /// 创建一个 `JuiDashedBorder` 组件
  ///
  /// - [dashColor]：虚线颜色，默认为 `JuiTheme.colors.primary`。
  /// - [dashWidth]：虚线的宽度，默认为 `2`。
  /// - [dashHeight]：虚线的高度，默认为 `1`。
  /// - [dashSpace]：虚线之间的间距，默认为 `2`。
  /// - [borderRadius]：边框的圆角半径，默认为 `8`。
  /// - [child]：需要包裹的子组件，必填。
  /// - [onTap]：点击边框时的回调（可选）。
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
        painter: _DashedBorderPainter(
          dashColor: dashColor ?? JuiTheme.colors.primary, // 确保有默认颜色
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

/// `_DashedBorderPainter` 是 `JuiDashedBorder` 的私有绘制类，
/// 负责绘制带有虚线的边框。
class _DashedBorderPainter extends CustomPainter {
  final Color dashColor;
  final double dashWidth;
  final double dashHeight;
  final double dashSpace;
  final double borderRadius;

  /// 创建 `_DashedBorderPainter`
  ///
  /// - [dashColor]：虚线颜色
  /// - [dashWidth]：虚线的宽度
  /// - [dashHeight]：虚线的高度
  /// - [dashSpace]：虚线之间的间距
  /// - [borderRadius]：边框的圆角半径
  _DashedBorderPainter({
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
    final dashArray = _CircularIntervalList<double>([dashWidth, dashSpace]);

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
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      dashColor != oldDelegate.dashColor ||
      dashWidth != oldDelegate.dashWidth ||
      dashHeight != oldDelegate.dashHeight ||
      dashSpace != oldDelegate.dashSpace ||
      borderRadius != oldDelegate.borderRadius;
}

/// `_CircularIntervalList<T>` 是一个私有的循环间隔列表工具类。
///
/// 该类用于在 `_DashedBorderPainter` 内部，循环交替返回列表中的元素。
class _CircularIntervalList<T> {
  final List<T> _items;
  int _index = 0;

  /// 创建一个 `_CircularIntervalList`
  ///
  /// - [items]：循环使用的元素列表
  _CircularIntervalList(this._items);

  /// 获取下一个元素，并自动循环
  T get next {
    if (_index >= _items.length) {
      _index = 0;
    }
    return _items[_index++];
  }
}
