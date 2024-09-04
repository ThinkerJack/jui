import 'package:flutter/cupertino.dart';

enum PickerStyle {
  list,
  grid,
  actionSheet,
  singleColumn,
  multiColumn,
}

// 选择模式枚举
enum SelectionMode {
  single,
  multiple,
}

// 选择项位置枚举
enum CheckPosition {
  left,
  right,
}

// 布局配置
class LayoutConfig {
  final bool showIcon;
  final int maxLines;
  final double itemHeight;

  const LayoutConfig({
    this.showIcon = false,
    this.maxLines = 1,
    this.itemHeight = 48.0,
  });
}

// 选择器回调
typedef PickerCallback = void Function(List<String> selectedKeys, List<String> selectedValues);

// 选择器配置
class PickerConfig {
  final String title;
  final PickerStyle style;
  final SelectionMode selectionMode;
  final CheckPosition checkPosition;
  final LayoutConfig layoutConfig;

  PickerConfig({
    required this.title,
    required this.style,
    this.selectionMode = SelectionMode.single,
    this.checkPosition = CheckPosition.right,
    this.layoutConfig = const LayoutConfig(),
  });
}

class PickerItem {
  final String key;
  final String value;
  final Widget? icon;

  PickerItem({required this.key, required this.value, this.icon});
}
