import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HighlightedTextWidget extends StatelessWidget {
  /// 文字
  final String text;
  /// 高亮文字
  final List<HighlightWord> highlights;
  /// 文本样式
  final TextStyle? textStyle;
  /// 高亮样式
  final TextStyle? highlightStyle;
  /// 最大行数
  final int maxLines;
  /// 文本溢出处理
  final TextOverflow overflow;

  const HighlightedTextWidget({
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
    List<InlineSpan> spans = [];
    int currentIndex = 0;

    while (currentIndex < text.length) {
      HighlightWord? matchedHighlight = _findMatchingHighlight(currentIndex);

      if (matchedHighlight != null) {
        spans.add(TextSpan(
          text: matchedHighlight.word,
          style: matchedHighlight.highlightStyle ?? highlightStyle,
          recognizer: TapGestureRecognizer()..onTap = matchedHighlight.onTap,
        ));
        currentIndex += matchedHighlight.word.length;
      } else {
        int endIndex = _findNextHighlightIndex(currentIndex);
        spans.add(TextSpan(
          text: text.substring(currentIndex, endIndex),
          style: textStyle,
        ));
        currentIndex = endIndex;
      }
    }

    return spans;
  }

  HighlightWord? _findMatchingHighlight(int startIndex) {
    for (var highlight in highlights) {
      if (text.startsWith(highlight.word, startIndex)) {
        return highlight;
      }
    }
    return null;
  }

  int _findNextHighlightIndex(int startIndex) {
    return highlights.fold<int>(
      text.length,
          (minIndex, highlight) {
        int index = text.indexOf(highlight.word, startIndex);
        return index != -1 && index < minIndex ? index : minIndex;
      },
    );
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

    List<TextSpan> spans = text.characters.map((char) {
      bool isHighlighted = highlightText.toLowerCase().contains(char.toLowerCase());
      return TextSpan(text: char, style: isHighlighted ? highlightStyle : textStyle);
    }).toList();

    return RichText(
      maxLines: maxLines,
      overflow: overflow,
      text: TextSpan(children: spans),
    );
  }
}

class HighlightWord {
  /// 高亮文字
  final String word;
  /// 点击事件
  final VoidCallback? onTap;
  /// 高亮样式
  final TextStyle? highlightStyle;

  const HighlightWord(this.word,  {this.onTap,this.highlightStyle});
}