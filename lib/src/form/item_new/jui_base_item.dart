import 'package:flutter/material.dart';

import '../../../generated/assets.dart';
import '../../utils/jui_theme.dart';

class ItemTipsText extends StatelessWidget {
  const ItemTipsText({
    Key? key,
    required this.showTips,
    required this.tipText,
  }) : super(key: key);

  final bool showTips;
  final String tipText;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showTips,
      child: Column(
        children: [
          const SizedBox(height: 4),
          Text(
            tipText,
            style: TextStyle(color: JuiTheme.colors.tips, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class ItemTitle extends StatelessWidget {
  const ItemTitle({
    Key? key,
    required this.title,
    required this.isRequired,
    this.isDisabled = false,
    this.requiredMarker,
    this.customTitleStyle,
    this.suffixWidget,
    this.beforeRequiredWidget,
  }) : super(key: key);

  final String title;
  final bool isRequired;
  final bool isDisabled;
  final Widget? requiredMarker;
  final TextStyle? customTitleStyle;
  final Widget? suffixWidget;
  final Widget? beforeRequiredWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            title,
            style: customTitleStyle ??
                (isDisabled ? JuiTheme.textStyles.itemTitleDisabled : JuiTheme.textStyles.itemTitle),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (beforeRequiredWidget != null)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: beforeRequiredWidget!,
          ),
        if (!isDisabled && isRequired)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 5),
            child: requiredMarker ?? Image.asset(Assets.imagesItemRequired),
          ),
        if (suffixWidget != null)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: suffixWidget!,
          ),
      ],
    );
  }
}

class ItemDivider extends StatelessWidget {
  const ItemDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: JuiTheme.colors.divider,
      height: 0.5,
    );
  }
}

class JuiBaseItem extends StatelessWidget {
  const JuiBaseItem({
    Key? key,
    required this.title,
    required this.content,
    this.isRequired = false,
    this.isDisabled = false,
    this.titleSuffixWidget,
    this.titleBeforeRequiredWidget,
    this.requiredMarker,
    this.customTitleStyle,
    this.spacing = 8.0,
    this.padding,
    this.showDivider = true,
    this.dividerPadding,
  }) : super(key: key);

  final String title;
  final Widget content;
  final bool isRequired;
  final bool isDisabled;
  final Widget? titleSuffixWidget;
  final Widget? titleBeforeRequiredWidget;
  final Widget? requiredMarker;
  final TextStyle? customTitleStyle;
  final double spacing;
  final bool showDivider;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? dividerPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
              top: JuiTheme.dimensions.itemPaddingV,
              right: JuiTheme.dimensions.itemPaddingR,
              left: JuiTheme.dimensions.itemPaddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemTitle(
            title: title,
            isRequired: isRequired,
            isDisabled: isDisabled,
            suffixWidget: titleSuffixWidget,
            beforeRequiredWidget: titleBeforeRequiredWidget,
            requiredMarker: requiredMarker,
            customTitleStyle: customTitleStyle,
          ),
          SizedBox(height: JuiTheme.dimensions.itemSpace),
          content,
          if (showDivider)
            Padding(
              padding: dividerPadding ?? EdgeInsets.only(left: JuiTheme.dimensions.itemPaddingL),
              child: const ItemDivider(),
            ),
        ],
      ),
    );
  }
}
