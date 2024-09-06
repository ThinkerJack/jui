// jui_select_picker_config.dart

import 'package:flutter/material.dart';

enum JuiSelectPickerLayout {
  list,
  action,
  wheel,
}

enum SelectionMode {
  single,
  multiple,
}

class JuiSelectPickerUIHelper {
  static const double itemExtent = 52.0;
  static const double maxHeight = 650.0;
  static const double headerFontSize = 16.0;
  static const EdgeInsets headerPadding = EdgeInsets.all(16.0);

  // UI Config 默认值
  static const BorderRadius defaultTopBorderRadius = BorderRadius.vertical(top: Radius.circular(12));
  static const Color defaultBackgroundColor = Colors.white;
  static const Color defaultBarrierColor = Color.fromRGBO(0, 0, 0, 0.7);
  static const bool defaultIsScrollControlled = true;
  static const bool defaultEnableDrag = false;

  // Header Config 默认值
  static const String defaultCancelText = '取消';
  static const String defaultConfirmText = '确定';

  // 动态获取最大高度的方法
  static double getMaxHeight(JuiSelectPickerLayout layout) {
    switch (layout) {
      case JuiSelectPickerLayout.wheel:
        return 225.0; // CupertinoPicker 的默认高度
      case JuiSelectPickerLayout.list:
      case JuiSelectPickerLayout.action:
        return 600.0;
    }
  }
}

class JuiSelectPickerUIConfig {
  final BorderRadius topBorderRadius;
  final Color backgroundColor;
  final double maxHeight;
  final Color barrierColor;
  final bool isScrollControlled;
  final bool enableDrag;
  final TextStyle? itemTextStyle;
  final Color? selectedItemColor;

  const JuiSelectPickerUIConfig({
    this.topBorderRadius = JuiSelectPickerUIHelper.defaultTopBorderRadius,
    this.backgroundColor = JuiSelectPickerUIHelper.defaultBackgroundColor,
    this.maxHeight = JuiSelectPickerUIHelper.maxHeight,
    this.barrierColor = JuiSelectPickerUIHelper.defaultBarrierColor,
    this.isScrollControlled = JuiSelectPickerUIHelper.defaultIsScrollControlled,
    this.enableDrag = JuiSelectPickerUIHelper.defaultEnableDrag,
    this.itemTextStyle,
    this.selectedItemColor,
  });
}

class JuiSelectPickerHeaderConfig {
  final String title;
  final Widget? customHeader;
  final String? cancelText;
  final String? confirmText;
  final TextStyle? cancelTextStyle;
  final TextStyle? confirmTextStyle;
  final bool? showHeader;
  final bool? showConfirmButton;

  const JuiSelectPickerHeaderConfig({
    required this.title,
    this.customHeader,
    this.cancelText = JuiSelectPickerUIHelper.defaultCancelText,
    this.confirmText = JuiSelectPickerUIHelper.defaultConfirmText,
    this.cancelTextStyle,
    this.confirmTextStyle,
    this.showHeader,
    this.showConfirmButton,
  });
}


class JuiSelectPickerConfig {
  final JuiSelectPickerLayout layout;
  final SelectionMode selectionMode;
  final JuiSelectPickerUIConfig uiConfig;
  final JuiSelectPickerHeaderConfig headerConfig;

  const JuiSelectPickerConfig({
    required this.layout,
    required this.headerConfig,
    this.selectionMode = SelectionMode.single,
    this.uiConfig = const JuiSelectPickerUIConfig(),
  });
}

class JuiSelectPickerItemData {
  final String key;
  final String value;

  const JuiSelectPickerItemData({required this.key, required this.value});
}

class JuiSelectPickerItemUI {
  final JuiSelectPickerItemData data;
  final Widget? icon;
  final VoidCallback? onTap;

  const JuiSelectPickerItemUI({required this.data, this.icon, this.onTap});
}

typedef JuiSelectPickerCallback = void Function(List<String> selectedKeys, List<String> selectedValues);
typedef JuiSelectItemCallback = void Function(JuiSelectPickerItemData item);