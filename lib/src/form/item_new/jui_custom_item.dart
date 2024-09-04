// jui_custom_item.dart
import 'package:flutter/material.dart';
import 'jui_item.dart';
import 'jui_item_config.dart';

class JuiCustomItem extends StatelessWidget {
  final String title;
  final Widget content;
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