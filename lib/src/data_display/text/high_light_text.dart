import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class HighlightedText {
  static Widget builder({
    required String text,//全部文本内容
    List<HighlightWord> highlights = const [],//高亮数据集合
    TextStyle? defaultTextStyle,//默认文本样式
    TextStyle? defaultHighlightStyle,//高亮文本样式
    int maxLines = 5,//最大行数
    TextOverflow overflow = TextOverflow.ellipsis,//文本超出样式
  }) {
    var spans = _buildTextSpans(text, highlights, defaultTextStyle, defaultHighlightStyle);
    return RichText(
      maxLines: maxLines,
      overflow: overflow,
      text: TextSpan(children: spans),
    );
  }

  static List<InlineSpan> _buildTextSpans(
      String input,
      List<HighlightWord> highlights,
      TextStyle? textStyle,
      TextStyle? highlightStyle,
      ) {
    List<InlineSpan> spans = [];
    int currentIndex = 0;

    while (currentIndex < input.length) {
      bool matched = false;
      for (var highlight in highlights) {
        final startIndex = input.indexOf(highlight.word, currentIndex);
        if (startIndex != -1 && startIndex == currentIndex) {
          spans.add(TextSpan(
            text: highlight.word,
            style: highlight.highlightStyle ?? highlightStyle,
            recognizer: TapGestureRecognizer()..onTap = highlight.onTap,
          ));
          currentIndex += highlight.word.length;
          matched = true;
          highlights.remove(highlight);
          break;
        }
      }

      if (!matched) {
        final endIndex = _findNextHighlight(input, highlights, currentIndex);
        spans.add(TextSpan(
          text: input.substring(currentIndex, endIndex),
          style: textStyle,
        ));
        currentIndex = endIndex;
      }
    }

    return spans;
  }

  static int _findNextHighlight(String input, List<HighlightWord> highlights, int startIndex) {
    int nextIndex = input.length;
    for (var highlight in highlights) {
      final index = input.indexOf(highlight.word, startIndex);
      if (index != -1 && index < nextIndex) {
        nextIndex = index;
      }
    }
    return nextIndex;
  }
}

class HighlightWord {
  final String word;
  final VoidCallback onTap;
  final TextStyle? highlightStyle;

  HighlightWord(this.word, this.onTap,{ this.highlightStyle});
}