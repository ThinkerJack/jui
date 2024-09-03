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

  final double paddingVertical;
  final double paddingHorizontal;
  final JuiTagType tagType;
  final JuiTagShapeType tagShapeType;
  final JuiTagColorType tagColorType;
  final String text;
  final double fontSize;
  final Widget? icon;
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
        return isBackground ? JuiColors().background : JuiColors().text;
      case JuiTagColorType.blue:
        return isBackground ? JuiColors().primaryWithOpacity : JuiColors().primary;
      case JuiTagColorType.green:
        return isBackground ? JuiColors().successWithOpacity : JuiColors().success;
      case JuiTagColorType.yellow:
        return isBackground ? JuiColors().secondaryWithOpacity : JuiColors().secondary;
      case JuiTagColorType.red:
        return isBackground ? JuiColors().errorWithOpacity : JuiColors().error;
      case JuiTagColorType.gray:
        return isBackground ? JuiColors().background : JuiColors().textSecondary;
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
