import 'package:flutter/material.dart';
import 'package:jui/src/data_entry/picker_new/picker_config.dart';

abstract class PickerContentBuilder {
  Widget build(BuildContext context, List<PickerItem> items, Set<String> selectedKeys, PickerConfig config,
      Function(String) onItemTap, Function(String)? onImmediateConfirm);
}

// 内容构建器工厂
class PickerContentBuilderFactory {
  static PickerContentBuilder getBuilder(PickerStyle style) {
    switch (style) {
      case PickerStyle.list:
      case PickerStyle.grid:
      case PickerStyle.singleColumn:
      // 添加其他样式的构建器...
      default:
        throw UnimplementedError('未实现的 PickerStyle: $style');
    }
  }
}
