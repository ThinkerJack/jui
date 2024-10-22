// jui_select_picker_presenter.dart
import 'package:flutter/material.dart';

import 'jui_select_picker.dart';
import 'jui_select_picker_config.dart';

Future<void> showJuiSelectPicker({
// 构造函数参数说明
  // context: 构建上下文，用于构建UI组件
  // config: JuiSelectPicker的配置信息
  // items: 选择器中显示的项目列表
  // onSelect: 当用户选择一个项目时调用的回调函数
  // initialSelection: 初始选中的项目列表，默认为空
  // onCancel: 当用户取消选择时调用的回调函数，默认为null
  required BuildContext context,
  required JuiSelectPickerConfig config,
  required List<JuiSelectPickerItemUI> items,
  required JuiSelectPickerCallback onSelect,
  List<JuiSelectPickerItemData> initialSelection = const [],
  VoidCallback? onCancel,
  Key? key
}) {
  return showModalBottomSheet(
    context: context,
    constraints: BoxConstraints(maxHeight: config.uiConfig.maxHeight),
    backgroundColor: Colors.transparent,
    barrierColor: config.uiConfig.barrierColor,
    isScrollControlled: config.uiConfig.isScrollControlled,
    enableDrag: config.uiConfig.enableDrag,
    shape: RoundedRectangleBorder(
      borderRadius: config.uiConfig.topBorderRadius,
    ),
    builder: (BuildContext context) {
      return JuiSelectPicker(
        config: config,
        items: items,
        key: key,
        initialSelection: initialSelection,
        onSelect: (selectedKeys, selectedValues) {
          onSelect(selectedKeys, selectedValues);
          Navigator.pop(context);
        },
        onCancel: () {
          if (onCancel != null) {
            onCancel();
          }
          Navigator.pop(context);
        },
      );
    },
  );
}
