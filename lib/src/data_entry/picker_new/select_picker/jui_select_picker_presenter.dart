// jui_select_picker_presenter.dart
import 'package:flutter/material.dart';

import 'jui_select_picker.dart';
import 'jui_select_picker_config.dart';

Future<void> showJuiSelectPicker({
  required BuildContext context,
  required JuiSelectPickerConfig config,
  required List<JuiSelectPickerItemUI> items,
  required JuiSelectPickerCallback onSelect,
  List<JuiSelectPickerItemData> initialSelection = const [],
  VoidCallback? onCancel,
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