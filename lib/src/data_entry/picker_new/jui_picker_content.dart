// jui_picker_content.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jui/src/data_entry/picker_new/jui_picker_config.dart';

import '../../utils/jui_theme.dart';

abstract class PickerContentBuilder {
  Widget build(BuildContext context, List<PickerItemUI> items, List<PickerItemData> selectedItems, PickerConfig config,
      Function(PickerItemData) onItemTap, Function(PickerItemData)? onImmediateConfirm);
}

class PickerContentBuilderFactory {
  static PickerContentBuilder getBuilder(PickerLayout style) {
    switch (style) {
      case PickerLayout.wheel:
        return CupertinoPickerBuilder();
      case PickerLayout.list:
        return ListPickerBuilder();
      case PickerLayout.action:
        return ActionPickerBuilder();
      default:
        throw UnimplementedError('未实现的 PickerStyle: $style');
    }
  }
}

class CupertinoPickerBuilder implements PickerContentBuilder {
  final key = GlobalKey();

  @override
  Widget build(BuildContext context, List<PickerItemUI> items, List<PickerItemData> selectedItems, PickerConfig config,
      Function(PickerItemData) onItemTap, Function(PickerItemData)? onImmediateConfirm) {
    int initialIndex =
        selectedItems.isNotEmpty ? items.indexWhere((item) => item.data.key == selectedItems.first.key) : 0;
    initialIndex = initialIndex != -1 ? initialIndex : 0;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 225),
      child: CupertinoPicker(
        key: key,
        scrollController: FixedExtentScrollController(initialItem: initialIndex),
        itemExtent: 52,
        squeeze: 1.2,
        onSelectedItemChanged: (index) {
          onItemTap(items[index].data);
        },
        selectionOverlay: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            ///透明颜色
            color: CupertinoDynamicColor(
              color: Color.fromARGB(15, 118, 118, 128),
              darkColor: Color.fromARGB(15, 118, 118, 128),
              highContrastColor: Color.fromARGB(15, 118, 118, 128),
              darkHighContrastColor: Color.fromARGB(15, 118, 118, 128),
              elevatedColor: Color.fromARGB(15, 118, 118, 128),
              darkElevatedColor: Color.fromARGB(15, 118, 118, 128),
              highContrastElevatedColor: Color.fromARGB(15, 118, 118, 128),
              darkHighContrastElevatedColor: Color.fromARGB(15, 118, 118, 128),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: JuiColors().divider, width: 0.5),
          ),
        ),
        children: items
            .map((item) => Center(
                  child: Text(
                    item.data.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2A2F3C),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class ListPickerBuilder implements PickerContentBuilder {
  @override
  Widget build(BuildContext context, List<PickerItemUI> items, List<PickerItemData> selectedItems, PickerConfig config,
      Function(PickerItemData) onItemTap, Function(PickerItemData)? onImmediateConfirm) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 500), // Adjust the height as needed
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = selectedItems.any((selected) => selected.key == item.data.key);

          return ListTile(
            title: Text(item.data.value),
            trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).primaryColor) : null,
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

class ActionPickerBuilder implements PickerContentBuilder {
  @override
  Widget build(BuildContext context, List<PickerItemUI> items, List<PickerItemData> selectedItems, PickerConfig config,
      Function(PickerItemData) onItemTap, Function(PickerItemData)? onImmediateConfirm) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 500), // Adjust the height as needed
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Column(
            children: [
              ListTile(
                title: Center(child: Text(item.data.value)),
                onTap: () {
                  if (item.onTap != null) {
                    item.onTap!();
                  } else {
                    onItemTap(item.data);
                    if (onImmediateConfirm != null) {
                      onImmediateConfirm(item.data);
                    }
                  }
                },
              ),
              Divider(
                color: const Color(0X14000000),
                height: 0.5,
              )
            ],
          );
        },
      ),
    );
  }
}
