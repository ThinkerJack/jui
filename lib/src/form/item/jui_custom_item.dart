// jui_custom_item.dart
import 'package:flutter/material.dart';

import 'jui_item.dart';
import 'jui_item_config.dart';

class JuiCustomItem extends StatelessWidget {
  // title: 自定义UI项的标题，类型为String
  final String title;

  // content: 自定义UI项的内容，类型为Widget
  final Widget content;

  // config: 自定义UI项的配置信息，类型为JuiItemConfig
  final JuiItemConfig config;

  const JuiCustomItem({
    Key? key,
    required this.title,
    required this.content,
    this.config = const JuiItemConfig(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JuiItem(
      title: title,
      content: content,
      config: config,
    );
  }
}
