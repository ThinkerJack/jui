import 'package:flutter/cupertino.dart';
import '../../utils/custom_color.dart';

// Tag颜色类型
enum JacTagColorType { black, blue, green, yellow, red, gray }

// Tag形状类型
enum JacTagShapeType {
  semicircle, // 半圆
  rectangle, // 矩形
  capsule // 胶囊
}

// Tag类型
enum JacTagType {
  text, // 纯文字
  icon // 图标 + 文字
}

class JacTag extends StatelessWidget {
  const JacTag({
    Key? key,
    required this.paddingVertical,
    required this.paddingHorizontal,
    required this.tagType,
    required this.tagShapeType,
    required this.tagColorType,
    required this.text,
    this.icon,
    required this.fontSize,
  }) : super(key: key);

  final double paddingVertical;// 垂直内边距
  final double paddingHorizontal;// 水平内边距
  final JacTagType tagType; // Tag类型
  final JacTagShapeType tagShapeType;// Tag形状类型
  final JacTagColorType tagColorType;// Tag颜色类型
  final String text;// 文字内容
  final double fontSize;// 左侧图标
  final Widget? icon;// 字体大小

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
      decoration: BoxDecoration(
        borderRadius: _getBorderRadius(),
        color: _getColor(isContainer: true),
      ),
      child: _buildContent(),
    );
  }

  // 构建内容
  Widget _buildContent() {
    switch (tagType) {
      case JacTagType.text:
        return Text(
          text,
          style: TextStyle(color: _getColor(isContainer: false), fontSize: fontSize, height: 1.5),
        );
      case JacTagType.icon:
        return Row(
          children: [
            icon ?? const SizedBox(),
            const SizedBox(width: 4),
            Text(
              text,
              style: TextStyle(color: _getColor(isContainer: false), fontSize: fontSize, height: 1.5),
            ),
          ],
        );
    }
  }

  // 获取颜色
  Color _getColor({required bool isContainer}) {
    switch (tagColorType) {
      case JacTagColorType.black:
        return isContainer ? colorF6F7F8 : color2A2F3C;
      case JacTagColorType.blue:
        return isContainer ? color145590F6 : color5590F6;
      case JacTagColorType.green:
        return isContainer ? color1444C69D : color44C69D;
      case JacTagColorType.yellow:
        return isContainer ? color14FFA22D : colorFFA22D;
      case JacTagColorType.red:
        return isContainer ? color14F55656 : colorF55656;
      case JacTagColorType.gray:
        return isContainer ? colorF6F7F8 : color858B9B;
    }
  }

  // 获取圆角
  BorderRadius _getBorderRadius() {
    switch (tagShapeType) {
      case JacTagShapeType.semicircle:
        return const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16));
      case JacTagShapeType.rectangle:
        return const BorderRadius.all(Radius.circular(6));
      case JacTagShapeType.capsule:
        return const BorderRadius.all(Radius.circular(16));
    }
  }
}
