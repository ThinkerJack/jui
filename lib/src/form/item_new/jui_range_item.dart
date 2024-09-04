// jui_range_item.dart
import 'package:flutter/material.dart';

import '../../utils/jui_theme.dart';
import 'jui_item.dart';
import 'jui_item_config.dart';

class JuiRangeItem extends StatelessWidget {
  final String title;
  final String? minValue;
  final String? maxValue;
  final String minHintText;
  final String maxHintText;
  final Widget? separator;
  final JuiItemConfig config;

  const JuiRangeItem({
    Key? key,
    required this.title,
    this.minValue,
    this.maxValue,
    this.minHintText = '',
    this.maxHintText = '',
    this.separator,
    this.config = const JuiItemConfig(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JuiItem(
      title: title,
      content: _buildRangeContent(),
      config: config,
    );
  }

  Widget _buildRangeContent() {
    return Row(
      children: [
        Expanded(
          child: Text(
            minValue ?? minHintText,
            style: minValue != null ? JuiTheme.textStyles.itemContent : _getHintStyle(),
          ),
        ),
        separator ?? _defaultSeparator(),
        Expanded(
          child: Text(
            maxValue ?? maxHintText,
            style: maxValue != null ? JuiTheme.textStyles.itemContent : _getHintStyle(),
          ),
        ),
      ],
    );
  }

  Widget _defaultSeparator() {
    return Container(
      width: 14,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 13),
      decoration: BoxDecoration(
        color: JuiTheme.colors.disabledLight,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  TextStyle _getHintStyle() {
    return config.isDisabled ? JuiTheme.textStyles.itemHintDisabled : JuiTheme.textStyles.itemHint;
  }
}
