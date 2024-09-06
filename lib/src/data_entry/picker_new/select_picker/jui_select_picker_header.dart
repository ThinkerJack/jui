import 'package:flutter/material.dart';
import 'package:jui/src/utils/jui_theme.dart';

import '../../../../data_entry.dart';

class JuiSelectPickerHeaderHandler {
  final JuiSelectPickerConfig config;
  final VoidCallback? onCancel;
  final VoidCallback onConfirm;

  JuiSelectPickerHeaderHandler({
    required this.config,
    required this.onCancel,
    required this.onConfirm,
  });

  bool get shouldShowHeader => config.headerConfig.showHeader ?? _shouldShowHeaderByDefault();

  bool get shouldShowConfirmButton => config.headerConfig.showConfirmButton ?? _shouldShowConfirmButtonByDefault();

  bool _shouldShowHeaderByDefault() {
    switch (config.layout) {
      case JuiSelectPickerLayout.list:
      case JuiSelectPickerLayout.wheel:
        return true;
      case JuiSelectPickerLayout.action:
        return false;
    }
  }

  bool _shouldShowConfirmButtonByDefault() {
    if (config.selectionMode == SelectionMode.single && config.layout == JuiSelectPickerLayout.list) {
      return false;
    }
    return true;
  }

  Widget buildHeader() {
    if (!shouldShowHeader) {
      return const SizedBox.shrink();
    }

    return config.headerConfig.customHeader ??
        JuiSelectPickerHeader(
          title: config.headerConfig.title,
          titleLeftText: config.headerConfig.cancelText,
          titleRightText: shouldShowConfirmButton ? config.headerConfig.confirmText : null,
          onCancel: onCancel,
          onConfirm: shouldShowConfirmButton ? onConfirm : null,
          leftTextStyle: config.headerConfig.cancelTextStyle,
          rightTextStyle: config.headerConfig.confirmTextStyle,
        );
  }
}

class JuiSelectPickerHeader extends StatelessWidget {
  final String title;
  final String? titleLeftText;
  final String? titleRightText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final TextStyle? rightTextStyle;
  final TextStyle? leftTextStyle;

  const JuiSelectPickerHeader({
    Key? key,
    required this.title,
    this.titleLeftText,
    this.titleRightText,
    this.onCancel,
    this.onConfirm,
    this.rightTextStyle,
    this.leftTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTextButton(onCancel, titleLeftText ?? '', leftTextStyle ?? JuiTheme.textStyles.pickerCancel),
            Expanded(
              child: Text(
                title,
                style: JuiTheme.textStyles.pickerTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            _buildTextButton(onConfirm, titleRightText ?? '', rightTextStyle ?? JuiTheme.textStyles.pickerConfirm),
          ],
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }

  Widget _buildTextButton(VoidCallback? onTap, String text, TextStyle? textStyle) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: JuiSelectPickerUIHelper.headerPadding,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(text, style: textStyle),
    );
  }
}
