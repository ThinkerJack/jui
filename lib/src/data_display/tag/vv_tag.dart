import 'package:flutter/cupertino.dart';
import 'package:habit/dependencies.dart';
import 'package:vv_ui_kit/src/utils/color.dart';

// Tag 颜色类型枚举
enum VVTagColorType { black, blue, green, yellow, red, gray }

// Tag 形状类型枚举
enum VVTagShapeType {
  // 半圆
  semicircle,
  // 矩形
  rectangle,
  // 胶囊
  capsule
}

// Tag 类型枚举
enum VVTagType {
  // 纯文字
  text,
  // 图标+文字
  icon
}

// VVTag 组件
class VVTag extends StatelessWidget {
  const VVTag({
    super.key,
    required this.paddingVertical,
    required this.paddingHorizontal,
    required this.tagType,
    required this.tagShapeType,
    required this.tagColorType,
    required this.text,
    this.icon,
    required this.fontSize,
    this.alignment = Alignment.center,
  });

  // 垂直内边距
  final double paddingVertical;

  // 水平内边距
  final double paddingHorizontal;

  // Tag 类型
  final VVTagType tagType;

  // Tag 形状类型
  final VVTagShapeType tagShapeType;

  // Tag 颜色类型
  final VVTagColorType tagColorType;

  // Tag 文本
  final String text;

  // 字体大小
  final double fontSize;

  // 图标组件
  final Widget? icon;

  // 对齐方式
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
      decoration: BoxDecoration(borderRadius: getBorderRadius(), color: getColor(true)),
      alignment: alignment,
      child: buildContent(),
    );
  }

  // 构建内容组件
  Widget buildContent() {
    switch (tagType) {
      case VVTagType.text:
        return Text(
          text,
          style: TextStyle(color: getColor(false), fontSize: fontSize),
          textAlign: TextAlign.start,
        );
      case VVTagType.icon:
        return Row(
          children: [
            icon ?? const SizedBox(),
            SizedBox(
              width: 4.w,
            ),
            Text(
              text,
              style: TextStyle(color: getColor(false), fontSize: fontSize),
            ),
          ],
        );
    }
  }

  // 获取颜色，flag为true表示容器颜色，false表示文本颜色
  Color getColor(bool flag) {
    switch (tagColorType) {
      case VVTagColorType.black:
        return flag ? uiF6F7F8 : ui2A2F3C;
      case VVTagColorType.blue:
        return flag ? ui145590F6 : ui5590F6;
      case VVTagColorType.green:
        return flag ? ui1444C69D : ui44C69D;
      case VVTagColorType.yellow:
        return flag ? ui14FFA22D : uiFFA22D;
      case VVTagColorType.red:
        return flag ? ui14F55656 : uiF55656;
      case VVTagColorType.gray:
        return flag ? uiF6F7F8 : ui858B9B;
    }
  }

  // 获取圆角半径
  BorderRadius getBorderRadius() {
    switch (tagShapeType) {
      case VVTagShapeType.semicircle:
        return BorderRadius.only(topLeft: Radius.circular(16.w), bottomLeft: Radius.circular(16.w));
      case VVTagShapeType.rectangle:
        return fontSize > 12.sp ? BorderRadius.all(Radius.circular(6.w)) : BorderRadius.all(Radius.circular(4.w));
      case VVTagShapeType.capsule:
        return BorderRadius.all(Radius.circular(16.w));
    }
  }
}
