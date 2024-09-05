// jui_picker_content.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jui/src/data_entry/picker_new/jui_picker_config.dart';

abstract class PickerContentBuilder {
  Widget build(
      BuildContext context,
      List<PickerItemUI> items,
      List<PickerItemData> selectedItems,
      PickerConfig config,
      Function(PickerItemData) onItemTap,
      Function(PickerItemData)? onImmediateConfirm
      );
}

class PickerContentBuilderFactory {
  static PickerContentBuilder getBuilder(PickerLayout style) {
    switch (style) {
      case PickerLayout.iosWheel:
        return CupertinoPickerBuilder();
      case PickerLayout.list:
        return ListPickerBuilder();
      case PickerLayout.multiWheel:
        return MultiCupertinoPickerBuilder();
      case PickerLayout.actionSheet:
        throw UnimplementedError('未实现的 PickerStyle: $style');
      default:
        throw UnimplementedError('未实现的 PickerStyle: $style');
    }
  }
}
class CupertinoPickerBuilder implements PickerContentBuilder {
  @override
  Widget build(
      BuildContext context,
      List<PickerItemUI> items,
      List<PickerItemData> selectedItems,
      PickerConfig config,
      Function(PickerItemData) onItemTap,
      Function(PickerItemData)? onImmediateConfirm
      ) {
    int initialIndex = selectedItems.isNotEmpty
        ? items.indexWhere((item) => item.data.key == selectedItems.first.key)
        : 0;
    initialIndex = initialIndex != -1 ? initialIndex : 0;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 225),
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: initialIndex),
        itemExtent: 32,
        onSelectedItemChanged: (index) {
          onItemTap(items[index].data);
        },
        children: items.map((item) => Center(
          child: Text(item.data.value),
        )).toList(),
      ),
    );
  }
}

class ListPickerBuilder implements PickerContentBuilder {
  @override
  Widget build(
      BuildContext context,
      List<PickerItemUI> items,
      List<PickerItemData> selectedItems,
      PickerConfig config,
      Function(PickerItemData) onItemTap,
      Function(PickerItemData)? onImmediateConfirm
      ) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300), // Adjust the height as needed
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = selectedItems.any((selected) => selected.key == item.data.key);

          return ListTile(
            title: Text(item.data.value),
            trailing: isSelected
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : null,
            onTap: () {
              if (config.selectionMode == SelectionMode.single) {
                if (!isSelected) {
                  onItemTap(item.data);
                  if (onImmediateConfirm != null) {
                    onImmediateConfirm(item.data);
                  }
                }
              } else {
                // For multiple selection, toggle the selection
                onItemTap(item.data);
              }
            },
            selected: isSelected,
          );
        },
      ),
    );
  }
}

class MultiCupertinoPickerBuilder implements PickerContentBuilder {
  @override
  Widget build(
      BuildContext context,
      List<PickerItemUI> items,
      List<PickerItemData> selectedItems,
      PickerConfig config,
      Function(PickerItemData) onItemTap,
      Function(PickerItemData)? onImmediateConfirm
      ) {
    List<List<PickerItemUI>> columns = items.map((item) => item.data.value as List<PickerItemUI>).toList();

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 225),
      child: Row(
        children: [
          for (int i = 0; i < columns.length; i++)
            Expanded(
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                  initialItem: selectedItems.isNotEmpty && i < selectedItems.length
                      ? columns[i].indexWhere((item) => item.data.key == selectedItems[i].key)
                      : 0,
                ),
                itemExtent: 32,
                onSelectedItemChanged: (index) {
                  onItemTap(columns[i][index].data);
                },
                children: columns[i].map((item) => Center(
                  child: Text(item.data.value),
                )).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
