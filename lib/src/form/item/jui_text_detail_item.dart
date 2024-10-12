import 'package:flutter/material.dart';

import '../../utils/jui_theme.dart';
import 'jui_item.dart';
import 'jui_item_config.dart';

class JuiTextDetailItem extends StatelessWidget {
// 定义一个文本详情项的数据模型
  // title: 文本的标题
  final String title;

  // contentText: 文本的内容
  final String contentText;

  // maxLines: 文本显示的最大行数
  final int maxLines;

  // overflow: 当文本超过最大行数时的溢出处理方式
  final TextOverflow overflow;

  // textAlign: 文本的对齐方式
  final TextAlign textAlign;

  // config: 配置项，用于自定义文本详情项的外观和行为
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
