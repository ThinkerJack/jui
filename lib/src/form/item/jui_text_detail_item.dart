import 'package:flutter/material.dart';

import '../../utils/jui_theme.dart';
import 'jui_item.dart';
import 'jui_item_config.dart';

class JuiTextDetailItem extends StatelessWidget {
  final String title;
  final String contentText;
  final int maxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final JuiItemConfig config;

  const JuiTextDetailItem({
    Key? key,
    required this.title,
    required this.contentText,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.config = const JuiItemConfig(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JuiItem(
      title: title,
      content: Text(
        contentText,
        style: JuiTheme.textStyles.itemContent,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
      ),
      config: config,
    );
  }
}
