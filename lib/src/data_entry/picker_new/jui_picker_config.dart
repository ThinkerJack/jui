import 'package:flutter/material.dart';

enum PickerLayout {
  list,
  grid,
  actionSheet,
}

enum SelectionMode {
  single,
  multiple,
}

class PickerUIConfig {
  // 弹出框整体控制
  final BorderRadius? topBorderRadius;
  final Color backgroundColor;
  final double? maxHeight;
  final Color barrierColor;
  final bool isScrollControlled;
  final bool enableDrag;

  const PickerUIConfig({
    this.topBorderRadius = const BorderRadius.vertical(top: Radius.circular(12)),
    this.backgroundColor = Colors.white,
    this.maxHeight = 650,
    this.barrierColor = const Color.fromRGBO(0, 0, 0, 0.7),
    this.isScrollControlled = true,
    this.enableDrag = false,
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
    this.cancelText = '取消',
    this.confirmText = '确定',
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

class PickerItem {
  final String key;
  final String value;
  final Widget? icon;

  PickerItem({required this.key, required this.value, this.icon});
}

typedef PickerCallback = void Function(List<String> selectedKeys, List<String> selectedValues);
