// jui_picker_presenter.dart
import 'package:flutter/material.dart';
import 'package:jui/src/data_entry/picker_new/jui_picker.dart';
import 'package:jui/src/data_entry/picker_new/jui_picker_config.dart';

Future<void> showJuiPicker({
  required BuildContext context,
  required PickerConfig config,
  required List<PickerItemUI> items,
  required PickerCallback onSelect,
  List<PickerItemData> initialSelection = const [],
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
      return JuiPicker(
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