import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../data_display.dart';
import '../../../../data_entry.dart';
import '../common/jui_picker_widget.dart';
import 'jui_select_picker_config.dart';

abstract class JuiSelectPickerContentBuilder {
  Widget build({
    required BuildContext context,
    required List<JuiSelectPickerItemUI> items,
    required List<JuiSelectPickerItemData> selectedItems,
    required JuiSelectPickerConfig config,
    required JuiSelectItemCallback onItemTap,
    JuiSelectItemCallback? onImmediateConfirm,
  });
}

class JuiSelectPickerContentBuilderFactory {
  static JuiSelectPickerContentBuilder getBuilder(JuiSelectPickerLayout style) {
    switch (style) {
      case JuiSelectPickerLayout.wheel:
        return CupertinoPickerBuilder();
      case JuiSelectPickerLayout.list:
        return ListPickerBuilder();
      case JuiSelectPickerLayout.action:
        return ActionPickerBuilder();
      default:
        throw UnimplementedError('未实现的 PickerStyle: $style');
    }
  }
}

// Default implementations for different styles
class CupertinoItemBuilder implements JuiSelectPickerItemBuilder {
  @override
  Widget buildItem({
    required BuildContext context,
    required JuiSelectPickerItemUI item,
    required bool isSelected,
    required JuiSelectPickerConfig config,
  }) {
    return Center(
      child: Text(
        item.data.value,
        style: config.uiConfig.itemTextStyle ?? TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class ListItemBuilder implements JuiSelectPickerItemBuilder {
  @override
  Widget buildItem({
    required BuildContext context,
    required JuiSelectPickerItemUI item,
    required bool isSelected,
    required JuiSelectPickerConfig config,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 295,
                child: Text(
                  item.data.value,
                  style: config.uiConfig.itemTextStyle,
                  maxLines: config.uiConfig.maxLines,
                  overflow: config.uiConfig.maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
                ),
              ),
              if (isSelected)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.check,
                    color: config.uiConfig.selectedItemColor ?? Theme.of(context).primaryColor,
                    size: 20,
                  ),
                )
            ],
          ),
          const SizedBox(height: 16),
          const JuiPickerDivider()
        ],
      ),
    );
  }
}

class ActionItemBuilder implements JuiSelectPickerItemBuilder {
  @override
  Widget buildItem({
    required BuildContext context,
    required JuiSelectPickerItemUI item,
    required bool isSelected,
    required JuiSelectPickerConfig config,
  }) {
    return Center(
      child: Text(
        item.data.value,
        style: config.uiConfig.itemTextStyle,
      ),
    );
  }
}

// Update the builders to use the item builders
class CupertinoPickerBuilder implements JuiSelectPickerContentBuilder {
  @override
  Widget build({
    required BuildContext context,
    required List<JuiSelectPickerItemUI> items,
    required List<JuiSelectPickerItemData> selectedItems,
    required JuiSelectPickerConfig config,
    required JuiSelectItemCallback onItemTap,
    JuiSelectItemCallback? onImmediateConfirm,
  }) {
    int initialIndex =
        selectedItems.isNotEmpty ? items.indexWhere((item) => item.data.key == selectedItems.first.key) : 0;
    initialIndex = initialIndex != -1 ? initialIndex : 0;

    final itemBuilder = config.customItemBuilder ?? CupertinoItemBuilder();

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: JuiSelectPickerUIHelper.getMaxHeight(config.layout)),
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: initialIndex),
        itemExtent: JuiSelectPickerUIHelper.itemExtent,
        onSelectedItemChanged: (index) => onItemTap(items[index].data),
        children: items.map((item) {
          final isSelected = selectedItems.any((selected) => selected.key == item.data.key);
          return itemBuilder.buildItem(
            context: context,
            item: item,
            isSelected: isSelected,
            config: config,
          );
        }).toList(),
      ),
    );
  }
}

class ListPickerBuilder implements JuiSelectPickerContentBuilder {
  @override
  Widget build({
    required BuildContext context,
    required List<JuiSelectPickerItemUI> items,
    required List<JuiSelectPickerItemData> selectedItems,
    required JuiSelectPickerConfig config,
    required JuiSelectItemCallback onItemTap,
    JuiSelectItemCallback? onImmediateConfirm,
  }) {
    final itemBuilder = config.customItemBuilder ?? ListItemBuilder();

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: JuiSelectPickerUIHelper.getMaxHeight(config.layout)),
      child: (items.isEmpty)
          ? const JuiNoContent(
              type: JuiNoContentType.list,
              paddingTop: 30,
              paddingBottom: 30,
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = selectedItems.any((selected) => selected.key == item.data.key);
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    onItemTap(item.data);
                    if (config.selectionMode == SelectionMode.single && onImmediateConfirm != null) {
                      onImmediateConfirm(item.data);
                    }
                  },
                  child: itemBuilder.buildItem(
                    context: context,
                    item: item,
                    isSelected: isSelected,
                    config: config,
                  ),
                );
              },
            ),
    );
  }
}

class ActionPickerBuilder implements JuiSelectPickerContentBuilder {
  @override
  Widget build({
    required BuildContext context,
    required List<JuiSelectPickerItemUI> items,
    required List<JuiSelectPickerItemData> selectedItems,
    required JuiSelectPickerConfig config,
    required JuiSelectItemCallback onItemTap,
    JuiSelectItemCallback? onImmediateConfirm,
  }) {
    final itemBuilder = config.customItemBuilder ?? ActionItemBuilder();

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: JuiSelectPickerUIHelper.getMaxHeight(config.layout)),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: items.length,
        separatorBuilder: (context, index) => const JuiPickerDivider(),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = selectedItems.any((selected) => selected.key == item.data.key);
          return ListTile(
            title: itemBuilder.buildItem(
              context: context,
              item: item,
              isSelected: isSelected,
              config: config,
            ),
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
