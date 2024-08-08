import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 高亮文字组件
class LightTextWidget extends StatelessWidget {
  /// 要显示的内容
  final String text;

  /// 要显示的内容中，需要高亮显示的文字(默认为空字符串，即不高亮显示文本)
  final String lightText;

  /// 要显示的内容的文本风格
  final TextStyle textStyle;

  /// 要显示的内容中，需要高亮显示的文字的文本风格
  final TextStyle lightStyle;

  /// 最大行数
  final int maxLines;

  /// 文本溢出处理方式
  final TextOverflow textOverflow;

  const LightTextWidget({
    super.key,
    required this.text,
    this.lightText = "",
    required this.textStyle,
    required this.lightStyle,
    this.maxLines = 1,
    this.textOverflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    // 如果不需要高亮显示，直接返回普通文本
    if (lightText.isEmpty) {
      return Text(text, maxLines: maxLines, overflow: textOverflow, style: textStyle);
    }
    // 否则返回高亮显示的文本
    return _lightView();
  }

  /// 构建带有高亮显示的文本
  Widget _lightView() {
    Characters lightList = lightText.characters;
    List<TextSpan> spans = [];

    // 遍历每一个字符，如果需要高亮，则应用高亮样式
    for (var data in text.characters) {
      bool needLight = lightList.contains(data.toLowerCase()) || lightList.contains(data.toUpperCase());
      spans.add(TextSpan(text: data, style: needLight ? lightStyle : textStyle));
    }

    // 返回带有高亮效果的富文本
    return RichText(
      maxLines: maxLines,
      overflow: textOverflow,
      text: TextSpan(children: spans),
    );
  }
}
