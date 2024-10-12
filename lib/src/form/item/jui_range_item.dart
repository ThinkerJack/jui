// jui_range_item.dart
import 'package:flutter/material.dart';

import '../../utils/jui_theme.dart';
import 'jui_item.dart';
import 'jui_item_config.dart';

class JuiRangeItem extends StatelessWidget {
  // 标题，用于显示在界面上
  final String title;

  // 最小值，可选参数，表示范围选择的最小值
  final String? minValue;

  // 最大值，可选参数，表示范围选择的最大值
  final String? maxValue;

  // 最小值提示文本，用于提示用户输入最小值
  final String minHintText;

  // 最大值提示文本，用于提示用户输入最大值
  final String maxHintText;

  // 分隔符，可选参数，用于在界面上分隔不同的输入区域
  final Widget? separator;

  // 配置项，用于设置JuiRangeItem的各种配置，如样式、行为等
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
