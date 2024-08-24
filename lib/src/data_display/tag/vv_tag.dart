import 'package:flutter/cupertino.dart';
import 'package:jui/src/utils/color.dart';

// Tag 颜色类型枚举
enum JUITagColorType { black, blue, green, yellow, red, gray }

// Tag 形状类型枚举
enum JUITagShapeType {
  // 半圆
  semicircle,
  // 矩形
  rectangle,
  // 胶囊
  capsule
}

// Tag 类型枚举
enum JUITagType {
  // 纯文字
  text,
  // 图标+文字
  icon
}

// VVTag 组件
class JUITag extends StatelessWidget {
  const JUITag({
    super.key,
    required this.text,
    this.paddingVertical = 2,
    this.paddingHorizontal = 10,
    this.tagType = JUITagType.text,
    this.tagShapeType = JUITagShapeType.rectangle,
    this.tagColorType = JUITagColorType.blue,
    this.icon,
    this.fontSize = 12,
    this.alignment = Alignment.center,
  });

  // 垂直内边距
  final double paddingVertical;

  // 水平内边距
  final double paddingHorizontal;

  // Tag 类型
  final JUITagType tagType;

  // Tag 形状类型
  final JUITagShapeType tagShapeType;

  // Tag 颜色类型
  final JUITagColorType tagColorType;

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
    return UnconstrainedBox(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
        decoration: BoxDecoration(borderRadius: getBorderRadius(), color: getColor(true)),
        alignment: alignment,
        child: buildContent(),
      ),
    );
  }

  // 构建内容组件
  Widget buildContent() {
    switch (tagType) {
      case JUITagType.text:
        return Text(
          text,
          style: TextStyle(color: getColor(false), fontSize: fontSize),
          textAlign: TextAlign.start,
        );
      case JUITagType.icon:
        return Row(
          children: [
            icon ?? const SizedBox(),
            const SizedBox(
              width: 4,
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
      case JUITagColorType.black:
        return flag ? uiF6F7F8 : ui2A2F3C;
      case JUITagColorType.blue:
        return flag ? ui145590F6 : ui5590F6;
      case JUITagColorType.green:
        return flag ? ui1444C69D : ui44C69D;
      case JUITagColorType.yellow:
        return flag ? ui14FFA22D : uiFFA22D;
      case JUITagColorType.red:
        return flag ? ui14F55656 : uiF55656;
      case JUITagColorType.gray:
        return flag ? uiF6F7F8 : ui858B9B;
    }
  }

  // 获取圆角半径
  BorderRadius getBorderRadius() {
    switch (tagShapeType) {
      case JUITagShapeType.semicircle:
        return const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16));
      case JUITagShapeType.rectangle:
        return fontSize > 12 ? const BorderRadius.all(Radius.circular(6)) : const BorderRadius.all(Radius.circular(4));
      case JUITagShapeType.capsule:
        return const BorderRadius.all(Radius.circular(16));
    }
  }
}
