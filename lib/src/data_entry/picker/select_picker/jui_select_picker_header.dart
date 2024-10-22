import 'package:flutter/material.dart';

import '../../../../data_entry.dart';
import '../common/jui_picker_header.dart';
import 'jui_select_picker_config.dart';

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
        JuiPickerHeader(
          title: config.headerConfig.title,
          titleLeftText: config.headerConfig.cancelText,
          titleRightText: shouldShowConfirmButton ? config.headerConfig.confirmText : null,
          onCancel: onCancel,
          onConfirm: shouldShowConfirmButton ?( config.headerConfig.tapConfirm ?? onConfirm) : null,
          leftTextStyle: config.headerConfig.cancelTextStyle,
          rightTextStyle: config.headerConfig.confirmTextStyle,
        );
  }
}
