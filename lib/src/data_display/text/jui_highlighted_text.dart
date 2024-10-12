import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class JuiHighlightedText extends StatelessWidget {
// 定义一个字符串变量text，用于存储要显示的文本内容
  final String text;

  // 定义一个HighlightWord类型的列表highlights，用于存储文本中需要高亮显示的部分
  final List<HighlightWord> highlights;

  // 定义一个TextStyle类型的可选变量textStyle，用于设置文本的样式
  final TextStyle? textStyle;

  // 定义一个TextStyle类型的可选变量highlightStyle，用于设置高亮文本的样式
  final TextStyle? highlightStyle;

  // 定义一个整型变量maxLines，用于限制文本显示的最大行数
  final int maxLines;

  // 定义一个TextOverflow枚举类型的变量overflow，用于处理文本溢出的情况
  final TextOverflow overflow;

  const JuiHighlightedText({
    Key? key,
    required this.text,
    this.highlights = const [],
    this.textStyle,
    this.highlightStyle,
    this.maxLines = 5,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines,
      overflow: overflow,
      text: TextSpan(children: _buildTextSpans()),
    );
  }

  List<InlineSpan> _buildTextSpans() {
    if (highlights.isEmpty) {
      return [TextSpan(text: text, style: textStyle)];
    }

    List<InlineSpan> spans = [];
    int currentIndex = 0;
    List<HighlightWord> sortedHighlights = List.from(highlights)
      ..sort((a, b) => text.indexOf(a.word).compareTo(text.indexOf(b.word)));

    for (var highlight in sortedHighlights) {
      int startIndex = text.indexOf(highlight.word, currentIndex);
      if (startIndex == -1) continue;

      if (startIndex > currentIndex) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, startIndex),
          style: textStyle,
        ));
      }

      spans.add(TextSpan(
        text: highlight.word,
        style: highlight.highlightStyle ?? highlightStyle,
        recognizer: highlight.onTap != null ? (TapGestureRecognizer()..onTap = highlight.onTap) : null,
      ));

      currentIndex = startIndex + highlight.word.length;
    }

    if (currentIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentIndex),
        style: textStyle,
      ));
    }

    return spans;
  }

  static Widget buildNoTapHighlight({
    required String text,
    String highlightText = "",
    required TextStyle textStyle,
    required TextStyle highlightStyle,
    int maxLines = 1,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    if (highlightText.isEmpty) {
      return Text(text, maxLines: maxLines, overflow: overflow, style: textStyle);
    }

    final lowercaseText = text.toLowerCase();
    final lowercaseHighlight = highlightText.toLowerCase();
    List<TextSpan> spans = [];
    int currentIndex = 0;

    while (currentIndex < text.length) {
      int highlightIndex = lowercaseText.indexOf(lowercaseHighlight, currentIndex);
      if (highlightIndex == -1) {
        spans.add(TextSpan(text: text.substring(currentIndex), style: textStyle));
        break;
      }

      if (highlightIndex > currentIndex) {
        spans.add(TextSpan(text: text.substring(currentIndex, highlightIndex), style: textStyle));
      }

      spans.add(TextSpan(
        text: text.substring(highlightIndex, highlightIndex + highlightText.length),
        style: highlightStyle,
      ));

      currentIndex = highlightIndex + highlightText.length;
    }

    return RichText(
      maxLines: maxLines,
      overflow: overflow,
      text: TextSpan(children: spans),
    );
  }
}

class HighlightWord {
  final String word;
  final VoidCallback? onTap;
  final TextStyle? highlightStyle;

  const HighlightWord(this.word, {this.onTap, this.highlightStyle});
}
