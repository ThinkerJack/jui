import 'package:flutter/cupertino.dart';

class JuiItemConfig {
  final bool isRequired;
  final bool isDisabled;
  final Widget? titleSuffixWidget;
  final Widget? titleBeforeRequiredWidget;
  final Widget? requiredMarker;
  final TextStyle? customTitleStyle;
  final bool showDivider;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? dividerPadding;
  final bool showTips;
  final String tipText;
  final VoidCallback? onTap;
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
