import 'package:flutter/cupertino.dart';

class JuiItemConfig {
// 是否为必填项
  final bool isRequired;

  // 是否禁用
  final bool isDisabled;

  // 标题后缀小部件
  final Widget? titleSuffixWidget;

  // 标题前的必填标记小部件
  final Widget? titleBeforeRequiredWidget;

  // 必填标记小部件
  final Widget? requiredMarker;

  // 自定义标题样式
  final TextStyle? customTitleStyle;

  // 是否显示分隔线
  final bool showDivider;

  // 内边距
  final EdgeInsetsGeometry? padding;

  // 分隔线内边距
  final EdgeInsetsGeometry? dividerPadding;

  // 是否显示提示
  final bool showTips;

  // 提示文本
  final String tipText;

  // 点击回调
  final VoidCallback? onTap;

  // 语义标签
  final String? semanticsLabel;

  const JuiItemConfig({
    this.isRequired = false,
    this.isDisabled = false,
    this.titleSuffixWidget,
    this.titleBeforeRequiredWidget,
    this.requiredMarker,
    this.customTitleStyle,
    this.showDivider = true,
    this.padding,
    this.dividerPadding,
    this.showTips = false,
    this.tipText = '',
    this.onTap,
    this.semanticsLabel,
  });
}
