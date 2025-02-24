import 'package:flutter/material.dart';
import '../../utils/jui_theme.dart';

/// `JuiTagColorType` 枚举，定义标签的颜色类型。
enum JuiTagColorType {
  /// 黑色标签
  black,

  /// 蓝色标签
  blue,

  /// 绿色标签
  green,

  /// 黄色标签
  yellow,

  /// 红色标签
  red,

  /// 灰色标签
  gray
}

/// `JuiTagShapeType` 枚举，定义标签的形状类型。
enum JuiTagShapeType {
  /// 半圆形（左侧圆角）
  semicircle,

  /// 矩形（带圆角）
  rectangle,

  /// 胶囊形（圆角较大）
  capsule
}

/// `JuiTagType` 枚举，定义标签的类型。
enum JuiTagType {
  /// 纯文本标签
  text,

  /// 带图标的标签
  icon
}

/// `JuiTag` 组件用于显示各种标签。
///
/// 该组件支持自定义文本、颜色、形状、字体大小，并可选择添加图标。
class JuiTag extends StatelessWidget {
  /// 创建一个 `JuiTag` 组件
  ///
  /// - [text]：标签显示的文本内容（必填）。
  /// - [paddingVertical]：垂直内边距，默认为 `2`。
  /// - [paddingHorizontal]：水平内边距，默认为 `10`。
  /// - [tagType]：标签类型（文本或带图标），默认为 `JuiTagType.text`。
  /// - [tagShapeType]：标签形状，默认为 `JuiTagShapeType.rectangle`。
  /// - [tagColorType]：标签颜色，默认为 `JuiTagColorType.blue`。
  /// - [icon]：可选的左侧图标，仅在 `tagType.icon` 下有效。
  /// - [fontSize]：文本字体大小，默认为 `12`。
  /// - [alignment]：文本对齐方式，默认为 `Alignment.center`。
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

  /// 标签的垂直内边距
  final double paddingVertical;

  /// 标签的水平内边距
  final double paddingHorizontal;

  /// 标签类型（文本或带图标）
  final JuiTagType tagType;

  /// 标签的形状类型
  final JuiTagShapeType tagShapeType;

  /// 标签的颜色类型
  final JuiTagColorType tagColorType;

  /// 标签显示的文本内容
  final String text;

  /// 文本的字体大小
  final double fontSize;

  /// 标签左侧的可选图标（仅在 `JuiTagType.icon` 下有效）
  final Widget? icon;

  /// 文本的对齐方式
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: paddingVertical, horizontal: paddingHorizontal),
        decoration: BoxDecoration(
          borderRadius: _getBorderRadius(),
          color: _getColor(isBackground: true),
        ),
        alignment: alignment,
        child: _buildContent(),
      ),
    );
  }

  /// 根据 `tagType` 构建标签内容
  Widget _buildContent() {
    final textWidget = Text(
      text,
      style:
          TextStyle(color: _getColor(isBackground: false), fontSize: fontSize),
    );

    if (tagType == JuiTagType.text) {
      return textWidget;
    } else {
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

  /// 获取标签的颜色
  ///
  /// - `isBackground = true` 表示获取背景颜色。
  /// - `isBackground = false` 表示获取文本颜色。
  Color _getColor({required bool isBackground}) {
    final colors = JuiTheme.colors;

    switch (tagColorType) {
      case JuiTagColorType.black:
        return isBackground ? colors.background : colors.text;
      case JuiTagColorType.blue:
        return isBackground ? colors.primaryWithOpacity : colors.primary;
      case JuiTagColorType.green:
        return isBackground ? colors.successWithOpacity : colors.success;
      case JuiTagColorType.yellow:
        return isBackground ? colors.secondaryWithOpacity : colors.secondary;
      case JuiTagColorType.red:
        return isBackground ? colors.errorWithOpacity : colors.error;
      case JuiTagColorType.gray:
        return isBackground ? colors.background : colors.textSecondary;
    }
  }

  /// 获取标签的圆角样式
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
