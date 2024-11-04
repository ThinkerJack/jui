// jui_select_picker_config.dart

import 'package:flutter/material.dart';

import '../common/jui_picker_config.dart';
import 'jui_select_picker_content.dart';

enum JuiSelectPickerLayout {
  /// 列表布局，用于展示选项列表供用户选择。
  list,

  /// 动作布局，可能用于触发某些动作而非直接选择。
  action,

  /// 滚动布局，以轮盘形式展示选项，适用于有限的选项数量。
  wheel,
}

enum SelectionMode {
  single,
  multiple,
}

class JuiSelectPickerUIHelper {
  static const double itemExtent = 52.0;
  static const double maxHeight = 655.0;

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
  // 设置顶部边框的圆角半径
  final BorderRadius topBorderRadius;

  // 设置选择器的背景颜色
  final Color backgroundColor;

  // 设置选择器的最大高度
  final double maxHeight;

  // 设置选择器底部的屏障颜色
  final Color barrierColor;

  // 设置是否控制滚动
  final bool isScrollControlled;

  // 设置是否启用拖动功能
  final bool enableDrag;

  // 设置选项文本的样式
  final TextStyle? itemTextStyle;

  // 设置选中项的颜色
  final Color? selectedItemColor;

  // 设置选项文本的最大行数
  final int? maxLines;

  const JuiSelectPickerUIConfig({
    this.topBorderRadius = JuiSelectPickerUIHelper.defaultTopBorderRadius,
    this.backgroundColor = JuiSelectPickerUIHelper.defaultBackgroundColor,
    this.maxHeight = JuiSelectPickerUIHelper.maxHeight,
    this.barrierColor = JuiSelectPickerUIHelper.defaultBarrierColor,
    this.isScrollControlled = JuiSelectPickerUIHelper.defaultIsScrollControlled,
    this.enableDrag = JuiSelectPickerUIHelper.defaultEnableDrag,
    this.itemTextStyle,
    this.selectedItemColor,
    this.maxLines,
  });
}

class JuiSelectPickerConfig {
  // 选择器的布局配置
  final JuiSelectPickerLayout layout;

  // 选择模式，例如单选或多选
  final SelectionMode selectionMode;

  // 选择器的UI配置，包括颜色、字体等视觉元素
  final JuiSelectPickerUIConfig uiConfig;

  // 选择器头部配置，可能包括标题、按钮等
  final JuiPickerHeaderConfig headerConfig;

  final JuiSelectPickerItemBuilder? customItemBuilder; // Add this field

  const JuiSelectPickerConfig({
    required this.layout,
    required this.headerConfig,
    this.selectionMode = SelectionMode.single,
    this.uiConfig = const JuiSelectPickerUIConfig(),
    this.customItemBuilder
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

abstract class JuiSelectPickerItemBuilder {
  Widget buildItem({
    required BuildContext context,
    required JuiSelectPickerItemUI item,
    required bool isSelected,
    required JuiSelectPickerConfig config,
  });
}