import 'package:flutter/material.dart';
import 'package:jui/src/data_entry/picker_new/jui_picker_config.dart';

abstract class PickerContentBuilder {
  Widget build(BuildContext context, List<PickerItem> items, Set<String> selectedKeys, PickerConfig config,
      Function(String) onItemTap, Function(String)? onImmediateConfirm);
}

// 内容构建器工厂
class PickerContentBuilderFactory {
  static PickerContentBuilder getBuilder(PickerLayout style) {
    switch (style) {
      case PickerLayout.list:
        return ListPickerContentBuilder();
      case PickerLayout.grid:
        return ListPickerContentBuilder();
      case PickerLayout.actionSheet:
        return ListPickerContentBuilder();
      default:
        throw UnimplementedError('未实现的 PickerStyle: $style');
    }
  }
}

class ListPickerContentBuilder implements PickerContentBuilder {
  @override
  Widget build(BuildContext context, List<PickerItem> items, Set<String> selectedKeys, PickerConfig config,
      Function(String) onItemTap, Function(String)? onImmediateConfirm) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 350),
      color: Colors.white,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = selectedKeys.contains(item.key);
          return ListTile(
            leading: item.icon,
            title: Text(item.value),
            trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).primaryColor) : null,
            selected: isSelected,
            onTap: () {
              onItemTap(item.key);
              if (config.selectionMode == SelectionMode.single && onImmediateConfirm != null) {
                onImmediateConfirm(item.key);
              }
            },
          );
        },
      ),
    );
  }
}
