// jui_select_picker_config.dart

import 'package:flutter/material.dart';
import 'package:jui/src/utils/screen_util.dart';

import '../common/jui_picker_config.dart';

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
  // 使用 getter 替代常量以支持动态计算
  static double get itemExtent => 52.w;

  static double get maxHeight => 655.w;

  // UI Config 默认值
  static BorderRadius get defaultTopBorderRadius => BorderRadius.vertical(top: Radius.circular(12.w));
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
        return 225.w;
      case JuiSelectPickerLayout.list:
      case JuiSelectPickerLayout.action:
        return 590.w;
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

  // 设置列表高度是否根据内容自动适配
  final bool shrinkWrap;

  JuiSelectPickerUIConfig({
    BorderRadius? topBorderRadius,
    this.backgroundColor = JuiSelectPickerUIHelper.defaultBackgroundColor,
    double? maxHeight,
    this.barrierColor = JuiSelectPickerUIHelper.defaultBarrierColor,
    this.isScrollControlled = JuiSelectPickerUIHelper.defaultIsScrollControlled,
    this.enableDrag = JuiSelectPickerUIHelper.defaultEnableDrag,
    this.itemTextStyle,
    this.selectedItemColor,
    this.maxLines,
    this.shrinkWrap = true, // 默认为 false，保持原有行为
  })  : topBorderRadius = topBorderRadius ?? JuiSelectPickerUIHelper.defaultTopBorderRadius,
        maxHeight = maxHeight ?? JuiSelectPickerUIHelper.maxHeight;

  // 提供一个复制方法，创建配置的新实例
  JuiSelectPickerUIConfig copyWith({
    BorderRadius? topBorderRadius,
    Color? backgroundColor,
    double? maxHeight,
    Color? barrierColor,
    bool? isScrollControlled,
    bool? enableDrag,
    TextStyle? itemTextStyle,
    Color? selectedItemColor,
    int? maxLines,
    bool? shrinkWrap,
  }) {
    return JuiSelectPickerUIConfig(
      topBorderRadius: topBorderRadius ?? this.topBorderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      maxHeight: maxHeight ?? this.maxHeight,
      barrierColor: barrierColor ?? this.barrierColor,
      isScrollControlled: isScrollControlled ?? this.isScrollControlled,
      enableDrag: enableDrag ?? this.enableDrag,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      selectedItemColor: selectedItemColor ?? this.selectedItemColor,
      maxLines: maxLines ?? this.maxLines,
      shrinkWrap: shrinkWrap ?? this.shrinkWrap,
    );
  }
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

  // 自定义项目构建器
  final JuiSelectPickerItemBuilder? customItemBuilder;

  JuiSelectPickerConfig({
    required this.layout,
    required this.headerConfig,
    this.selectionMode = SelectionMode.single,
    JuiSelectPickerUIConfig? uiConfig,
    this.customItemBuilder,
  }) : uiConfig = uiConfig ?? JuiSelectPickerUIConfig();

  // 提供一个复制方法
  JuiSelectPickerConfig copyWith({
    JuiSelectPickerLayout? layout,
    SelectionMode? selectionMode,
    JuiSelectPickerUIConfig? uiConfig,
    JuiPickerHeaderConfig? headerConfig,
    JuiSelectPickerItemBuilder? customItemBuilder,
  }) {
    return JuiSelectPickerConfig(
      layout: layout ?? this.layout,
      selectionMode: selectionMode ?? this.selectionMode,
      uiConfig: uiConfig ?? this.uiConfig,
      headerConfig: headerConfig ?? this.headerConfig,
      customItemBuilder: customItemBuilder ?? this.customItemBuilder,
    );
  }
}

class JuiSelectPickerItemData {
  final String key;
  final String value;

  const JuiSelectPickerItemData({required this.key, required this.value});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JuiSelectPickerItemData && runtimeType == other.runtimeType && key == other.key && value == other.value;

  @override
  int get hashCode => key.hashCode ^ value.hashCode;
}

class JuiSelectPickerItemUI {
  final JuiSelectPickerItemData data;
  final Widget? icon;
  final VoidCallback? onTap;

  const JuiSelectPickerItemUI({
    required this.data,
    this.icon,
    this.onTap,
  });
}

typedef JuiSelectPickerCallback = void Function(List<String> selectedKeys, List<String> selectedValues);
typedef JuiSelectItemCallback = void Function(JuiSelectPickerItemData item);

// 统一的参数类
class JuiSelectPickerItemBuildParams {
  final BuildContext context;
  final JuiSelectPickerItemUI item;
  final bool isSelected;
  final JuiSelectPickerConfig config;
  final bool isLastItem;

  const JuiSelectPickerItemBuildParams({
    required this.context,
    required this.item,
    required this.isSelected,
    required this.config,
    this.isLastItem = false,
  });

  // 如果需要，可以添加便捷方法
  bool get showDivider => !isLastItem;

  // 可以添加复制方法，方便修改个别参数
  JuiSelectPickerItemBuildParams copyWith({
    BuildContext? context,
    JuiSelectPickerItemUI? item,
    bool? isSelected,
    JuiSelectPickerConfig? config,
    bool? isLastItem,
  }) {
    return JuiSelectPickerItemBuildParams(
      context: context ?? this.context,
      item: item ?? this.item,
      isSelected: isSelected ?? this.isSelected,
      config: config ?? this.config,
      isLastItem: isLastItem ?? this.isLastItem,
    );
  }
}

// Builder 接口
abstract class JuiSelectPickerItemBuilder {
  Widget buildItem(JuiSelectPickerItemBuildParams params);
}

// ContentBuilder 相关配置参数类
class JuiSelectPickerContentBuildParams {
  final BuildContext context;
  final List<JuiSelectPickerItemUI> items;
  final List<JuiSelectPickerItemData> selectedItems;
  final JuiSelectPickerConfig config;
  final JuiSelectItemCallback onItemTap;
  final JuiSelectItemCallback? onImmediateConfirm;

  const JuiSelectPickerContentBuildParams({
    required this.context,
    required this.items,
    required this.selectedItems,
    required this.config,
    required this.onItemTap,
    this.onImmediateConfirm,
  });

  bool isSelected(JuiSelectPickerItemUI item) {
    return selectedItems.any((selected) => selected.key == item.data.key);
  }
}

abstract class JuiSelectPickerContentBuilder {
  Widget build(JuiSelectPickerContentBuildParams params);
}
