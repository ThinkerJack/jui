// jui_tap_item.dart
import 'package:flutter/material.dart';
import 'package:jui/src/utils/extension.dart';
import '../../../generated/assets.dart';
import '../../utils/jui_theme.dart';
import 'jui_item.dart';
import 'jui_item_config.dart';

class JuiTapItem extends StatelessWidget {
  final String title;
  final String contentText;
  final String hintText;
  final int maxLines;
  final Widget? trailing;
  final JuiItemConfig config;

  const JuiTapItem({
    Key? key,
    required this.title,
    required this.contentText,
    required this.hintText,
    this.maxLines = 1,
    this.trailing,
    this.config = const JuiItemConfig(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JuiItem(
      title: title,
      content: _buildTapContent(),
      config: config,
    );
  }

  Widget _buildTapContent() {
    return Row(
      children: [
        Expanded(
          child: Text(
            contentText.isEmpty ? hintText : contentText,
            style: _getTextStyle(),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing ?? Image.asset(
          config.isDisabled ? Assets.imagesMoreDisabled.path : Assets.imagesMore.path,
          height: 12,
        )
      ],
    );
  }

  TextStyle _getTextStyle() {
    if (contentText.isEmpty) {
      return config.isDisabled
          ? JuiTheme.textStyles.itemHintDisabled
          : JuiTheme.textStyles.itemHint;
    }
    return JuiTheme.textStyles.itemContent;
  }
}