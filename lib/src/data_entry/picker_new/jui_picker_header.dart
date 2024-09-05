import 'package:flutter/material.dart';
import 'package:jui/src/data_entry/picker_new/jui_picker_config.dart';

import '../../utils/jui_theme.dart';

class PickerHeaderHandler {
  final PickerConfig config;
  final VoidCallback? onCancel;
  final VoidCallback onConfirm;

  PickerHeaderHandler({
    required this.config,
    required this.onCancel,
    required this.onConfirm,
  });

  bool get shouldShowHeader {
    if (config.headerConfig.showHeader != null) {
      return config.headerConfig.showHeader!;
    }
    switch (config.layout) {
      case PickerLayout.list:
      case PickerLayout.iosWheel:
      case PickerLayout.multiWheel:
        return true;
      case PickerLayout.actionSheet:
        return false;
      default:
        return true;
    }
  }

  bool get shouldShowConfirmButton {
    if (config.headerConfig.showConfirmButton != null) {
      return config.headerConfig.showConfirmButton!;
    }
    if (config.selectionMode == SelectionMode.single && config.layout == PickerLayout.list) {
      return false;
    }
    return true; // 多选模式下默认显示确认按钮
  }

  Widget buildHeader() {
    if (!shouldShowHeader) {
      return const SizedBox.shrink();
    }

    if (config.headerConfig.customHeader != null) {
      return config.headerConfig.customHeader!;
    }

    return PickerHeader(
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

class PickerHeader extends StatelessWidget {
  const PickerHeader({
    Key? key,
    required this.title,
    this.titleLeftText,
    this.titleRightText,
    this.onConfirm,
    this.onCancel,
    this.rightTextStyle,
    this.leftTextStyle,
  }) : super(key: key);

  final String title;
  final String? titleLeftText;
  final String? titleRightText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final TextStyle? rightTextStyle;
  final TextStyle? leftTextStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DefaultTextStyle(
          style: JuiTheme.textStyles.pickerTitle,
          child: Row(
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
        ),
        Container(
          height: 0.5,
          color: const JuiColors().border,
        ),
      ],
    );
  }

  Widget _buildTextButton(VoidCallback? onTap, String text, TextStyle textStyle) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
