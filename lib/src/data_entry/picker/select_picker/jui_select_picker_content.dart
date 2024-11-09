import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jui/src/utils/extension.dart';
import 'package:jui/src/utils/screen_util.dart';

import '../../../../data_display.dart';
import '../../../../data_entry.dart';
import '../../../../generated/assets.dart';
import '../common/jui_picker_widget.dart';
import 'jui_select_picker_config.dart';

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

class CupertinoItemBuilder implements JuiSelectPickerItemBuilder {
  @override
  Widget buildItem(JuiSelectPickerItemBuildParams params) {
    return Center(
      child: Text(
        params.item.data.value,
        style: params.config.uiConfig.itemTextStyle ?? TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class ListItemBuilder implements JuiSelectPickerItemBuilder {
  @override
  Widget buildItem(JuiSelectPickerItemBuildParams params) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 320.w,
                child: Text(
                  params.item.data.value,
                  style: params.config.uiConfig.itemTextStyle,
                  maxLines: params.config.uiConfig.maxLines,
                  overflow: params.config.uiConfig.maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
                ),
              ),
              if (params.isSelected)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.asset(
                    Assets.imagesTick.path,
                    width: 20,
                  ),
                )
            ],
          ),
          const SizedBox(height: 16),
          const JuiPickerDivider(),
        ],
      ),
    );
  }
}

class ActionItemBuilder implements JuiSelectPickerItemBuilder {
  @override
  Widget buildItem(JuiSelectPickerItemBuildParams params) {
    return Center(
      child: Text(
        params.item.data.value,
        style: params.config.uiConfig.itemTextStyle,
      ),
    );
  }
}

class CupertinoPickerBuilder implements JuiSelectPickerContentBuilder {
  @override
  Widget build(JuiSelectPickerContentBuildParams params) {
    int initialIndex = params.selectedItems.isNotEmpty
        ? params.items.indexWhere((item) => item.data.key == params.selectedItems.first.key)
        : 0;
    initialIndex = initialIndex != -1 ? initialIndex : 0;

    final itemBuilder = params.config.customItemBuilder ?? CupertinoItemBuilder();

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: JuiSelectPickerUIHelper.getMaxHeight(params.config.layout)),
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: initialIndex),
        itemExtent: JuiSelectPickerUIHelper.itemExtent,
        onSelectedItemChanged: (index) => params.onItemTap(params.items[index].data),
        children: params.items.map((item) {
          return itemBuilder.buildItem(
            JuiSelectPickerItemBuildParams(
              context: params.context,
              item: item,
              isSelected: params.isSelected(item),
              config: params.config,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ListPickerBuilder implements JuiSelectPickerContentBuilder {
  @override
  Widget build(JuiSelectPickerContentBuildParams params) {
    final itemBuilder = params.config.customItemBuilder ?? ListItemBuilder();
    final headerHeight = 53.w;
    final contentMaxHeight = params.config.uiConfig.maxHeight - headerHeight;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: contentMaxHeight),
      child: (params.items.isEmpty)
          ? const JuiNoContent(
              type: JuiNoContentType.list,
              paddingTop: 30,
              paddingBottom: 30,
            )
          : ListView.builder(
              shrinkWrap: params.config.uiConfig.shrinkWrap,
              itemCount: params.items.length,
              itemBuilder: (context, index) {
                final item = params.items[index];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    params.onItemTap(item.data);
                    if (params.config.selectionMode == SelectionMode.single && params.onImmediateConfirm != null) {
                      params.onImmediateConfirm!(item.data);
                    }
                  },
                  child: itemBuilder.buildItem(
                    JuiSelectPickerItemBuildParams(
                      context: params.context,
                      item: item,
                      isSelected: params.isSelected(item),
                      config: params.config,
                      isLastItem: index == params.items.length - 1,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ActionPickerBuilder implements JuiSelectPickerContentBuilder {
  @override
  Widget build(JuiSelectPickerContentBuildParams params) {
    final itemBuilder = params.config.customItemBuilder ?? ActionItemBuilder();

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: JuiSelectPickerUIHelper.getMaxHeight(params.config.layout)),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: params.items.length,
        separatorBuilder: (context, index) => const JuiPickerDivider(),
        itemBuilder: (context, index) {
          final item = params.items[index];
          return ListTile(
            title: itemBuilder.buildItem(
              JuiSelectPickerItemBuildParams(
                context: params.context,
                item: item,
                isSelected: params.isSelected(item),
                config: params.config,
                isLastItem: index == params.items.length - 1,
              ),
            ),
            onTap: () {
              if (item.onTap != null) {
                item.onTap!();
              } else {
                params.onItemTap(item.data);
                if (params.onImmediateConfirm != null) {
                  params.onImmediateConfirm!(item.data);
                }
              }
            },
          );
        },
      ),
    );
  }
}
