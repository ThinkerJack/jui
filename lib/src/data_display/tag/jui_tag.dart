import 'package:flutter/material.dart';

import '../../utils/jui_theme.dart';

enum JuiTagColorType { black, blue, green, yellow, red, gray }

enum JuiTagShapeType { semicircle, rectangle, capsule }

enum JuiTagType { text, icon }

class JuiTag extends StatelessWidget {
  const JuiTag({
    Key? key,
    required this.text,
    this.paddingVertical = 2,
    this.paddingHorizontal = 10,
    this.tagType = JuiTagType.text,
    this.tagShapeType = JuiTagShapeType.rectangle,
    this.tagColorType = JuiTagColorType.blue,
    this.icon,
    this.fontSize = 12,
    this.alignment = Alignment.center,
  }) : super(key: key);

// 定义JuiTag组件的属性
  // paddingVertical: 标签的垂直内边距
  final double paddingVertical;

  // paddingHorizontal: 标签的水平内边距
  final double paddingHorizontal;

  // tagType: 标签的类型
  final JuiTagType tagType;

  // tagShapeType: 标签的形状类型
  final JuiTagShapeType tagShapeType;

  // tagColorType: 标签的颜色类型
  final JuiTagColorType tagColorType;

  // text: 标签显示的文本内容
  final String text;

  // fontSize: 文本的字体大小
  final double fontSize;

  // icon: 标签左侧的可选图标
  final Widget? icon;

  // alignment: 文本的对齐方式
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
        decoration: BoxDecoration(
          borderRadius: _getBorderRadius(),
          color: _getColor(true),
        ),
        alignment: alignment,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    final textWidget = Text(
      text,
      style: TextStyle(color: _getColor(false), fontSize: fontSize),
    );
    switch (tagType) {
      case JuiTagType.text:
        return textWidget;
      case JuiTagType.icon:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 4),
            ],
            textWidget,
          ],
        );
    }
  }

  Color _getColor(bool isBackground) {
    switch (tagColorType) {
      case JuiTagColorType.black:
        return isBackground ? const JuiColors().background : const JuiColors().text;
      case JuiTagColorType.blue:
        return isBackground ? const JuiColors().primaryWithOpacity : const JuiColors().primary;
      case JuiTagColorType.green:
        return isBackground ? const JuiColors().successWithOpacity : const JuiColors().success;
      case JuiTagColorType.yellow:
        return isBackground ? const JuiColors().secondaryWithOpacity : const JuiColors().secondary;
      case JuiTagColorType.red:
        return isBackground ? const JuiColors().errorWithOpacity : const JuiColors().error;
      case JuiTagColorType.gray:
        return isBackground ? const JuiColors().background : const JuiColors().textSecondary;
    }
  }

  BorderRadius _getBorderRadius() {
    switch (tagShapeType) {
      case JuiTagShapeType.semicircle:
        return const BorderRadius.horizontal(left: Radius.circular(16));
      case JuiTagShapeType.rectangle:
        return BorderRadius.circular(fontSize > 12 ? 6 : 4);
      case JuiTagShapeType.capsule:
        return BorderRadius.circular(16);
    }
  }
}
