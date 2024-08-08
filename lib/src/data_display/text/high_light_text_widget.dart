import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

/// 用于创建带有高亮文字的富文本组件
class HighlightedTextWidget {
  /// 构建带有高亮效果的富文本组件
  static Widget builder({
    required String text, // 全部文本内容
    List<HighlightWord> highlights = const [], // 高亮文字及其相关属性
    TextStyle? textStyle, // 默认文本样式
    TextStyle? highlightStyle, // 高亮文本样式
    int maxLines = 5, // 最大显示行数
    TextOverflow overflow = TextOverflow.ellipsis, // 文本溢出处理方式
  }) {
    var spans = _buildTextSpans(text, highlights, textStyle, highlightStyle);
    return RichText(
      maxLines: maxLines,
      overflow: overflow,
      text: TextSpan(children: spans),
    );
  }

  /// 构建文本与高亮文本的InlineSpan列表
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

  /// 查找下一个高亮文本的起始索引
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

/// 高亮文字类
class HighlightWord {
  final String word; // 高亮文字
  final VoidCallback onTap; // 点击事件回调
  final TextStyle? highlightStyle; // 高亮文字样式

  HighlightWord(this.word, this.onTap, {this.highlightStyle});
}
