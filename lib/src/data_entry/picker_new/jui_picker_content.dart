// jui_picker_content.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'jui_picker_config.dart';

abstract class PickerContentBuilder {
  Widget build({
    required BuildContext context,
    required List<PickerItemUI> items,
    required List<PickerItemData> selectedItems,
    required PickerConfig config,
    required ItemSelectionCallback onItemTap,
    ItemSelectionCallback? onImmediateConfirm,
  });
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
  @override
  Widget build({
    required BuildContext context,
    required List<PickerItemUI> items,
    required List<PickerItemData> selectedItems,
    required PickerConfig config,
    required ItemSelectionCallback onItemTap,
    ItemSelectionCallback? onImmediateConfirm,
  }) {
    int initialIndex =
        selectedItems.isNotEmpty ? items.indexWhere((item) => item.data.key == selectedItems.first.key) : 0;
    initialIndex = initialIndex != -1 ? initialIndex : 0;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: PickerUIHelper.getMaxHeight(config.layout)),
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: initialIndex),
        itemExtent: PickerUIHelper.itemExtent,
        onSelectedItemChanged: (index) => onItemTap(items[index].data),
        children: items
            .map((item) => Center(
                  child: Text(
                    item.data.value,
                    style: config.uiConfig.itemTextStyle ?? TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class ListPickerBuilder implements PickerContentBuilder {
  @override
  Widget build({
    required BuildContext context,
    required List<PickerItemUI> items,
    required List<PickerItemData> selectedItems,
    required PickerConfig config,
    required ItemSelectionCallback onItemTap,
    ItemSelectionCallback? onImmediateConfirm,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: PickerUIHelper.getMaxHeight(config.layout)),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = selectedItems.any((selected) => selected.key == item.data.key);

          return ListTile(
            title: Text(
              item.data.value,
              style: config.uiConfig.itemTextStyle,
            ),
            trailing: isSelected
                ? Icon(Icons.check, color: config.uiConfig.selectedItemColor ?? Theme.of(context).primaryColor)
                : null,
            onTap: () {
              onItemTap(item.data);
              if (config.selectionMode == SelectionMode.single && onImmediateConfirm != null) {
                onImmediateConfirm(item.data);
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
  Widget build({
    required BuildContext context,
    required List<PickerItemUI> items,
    required List<PickerItemData> selectedItems,
    required PickerConfig config,
    required ItemSelectionCallback onItemTap,
    ItemSelectionCallback? onImmediateConfirm,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: PickerUIHelper.getMaxHeight(config.layout)),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: items.length,
        separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey[300]),
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Center(child: Text(item.data.value, style: config.uiConfig.itemTextStyle)),
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
          );
        },
      ),
    );
  }
}
