import 'package:flutter/material.dart';
import 'package:jui/src/data_entry/picker_new/picker_config.dart';
import 'package:jui/src/data_entry/picker_new/picker_widget.dart';

Future<void> showJuiPicker({
  required BuildContext context,
  required PickerConfig config,
  required List<PickerItem> items,
  required PickerCallback onSelect,
  List<String> initialSelection = const [],
  VoidCallback? onCancel,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Picker(
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
