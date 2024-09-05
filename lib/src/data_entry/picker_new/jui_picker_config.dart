// jui_picker_config.dart

import 'package:flutter/material.dart';

enum PickerLayout {
  list,
  action,
  wheel,
}

enum SelectionMode {
  single,
  multiple,
}

class PickerUIHelper {
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
  static double getMaxHeight(PickerLayout layout) {
    switch (layout) {
      case PickerLayout.wheel:
        return 225.0; // CupertinoPicker 的默认高度
      case PickerLayout.list:
      case PickerLayout.action:
        return 600.0;
    }
  }
}

class PickerUIConfig {
  final BorderRadius topBorderRadius;
  final Color backgroundColor;
  final double maxHeight;
  final Color barrierColor;
  final bool isScrollControlled;
  final bool enableDrag;
  final TextStyle? itemTextStyle;
  final Color? selectedItemColor;

  const PickerUIConfig({
    this.topBorderRadius = PickerUIHelper.defaultTopBorderRadius,
    this.backgroundColor = PickerUIHelper.defaultBackgroundColor,
    this.maxHeight = PickerUIHelper.maxHeight,
    this.barrierColor = PickerUIHelper.defaultBarrierColor,
    this.isScrollControlled = PickerUIHelper.defaultIsScrollControlled,
    this.enableDrag = PickerUIHelper.defaultEnableDrag,
    this.itemTextStyle,
    this.selectedItemColor,
  });
}

class PickerHeaderConfig {
  final String title;
  final Widget? customHeader;
  final String? cancelText;
  final String? confirmText;
  final TextStyle? cancelTextStyle;
  final TextStyle? confirmTextStyle;
  final bool? showHeader;
  final bool? showConfirmButton;

  const PickerHeaderConfig({
    required this.title,
    this.customHeader,
    this.cancelText = PickerUIHelper.defaultCancelText,
    this.confirmText = PickerUIHelper.defaultConfirmText,
    this.cancelTextStyle,
    this.confirmTextStyle,
    this.showHeader,
    this.showConfirmButton,
  });
}


class PickerConfig {
  final PickerLayout layout;
  final SelectionMode selectionMode;
  final PickerUIConfig uiConfig;
  final PickerHeaderConfig headerConfig;

  const PickerConfig({
    required this.layout,
    required this.headerConfig,
    this.selectionMode = SelectionMode.single,
    this.uiConfig = const PickerUIConfig(),
  });
}

class PickerItemData {
  final String key;
  final String value;

  const PickerItemData({required this.key, required this.value});
}

class PickerItemUI {
  final PickerItemData data;
  final Widget? icon;
  final VoidCallback? onTap;

  const PickerItemUI({required this.data, this.icon, this.onTap});
}

typedef PickerCallback = void Function(List<String> selectedKeys, List<String> selectedValues);
typedef ItemSelectionCallback = void Function(PickerItemData item);