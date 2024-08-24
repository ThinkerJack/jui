import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utils/color.dart';

class ExpandableText extends StatefulWidget {
  /// 文本
  final String text;

  /// 最大行数
  final int maxLines;

  /// 文本样式
  final TextStyle? textStyle;

  /// 收起文本
  final String shrinkText;

  /// 展开文本
  final String expandText;

  /// 展开文本颜色
  final Color expandColor;

  const ExpandableText({
    super.key,
    this.text = '',
    this.maxLines = 1,
    this.textStyle = const TextStyle(color: ui2A2F3C, fontSize: 16, height: 1.5),
    this.shrinkText = '展开',
    this.expandText = '收起',
    this.expandColor = ui5590F6,
  });

  @override
  _RichTextState createState() => _RichTextState();
}

class _RichTextState extends State<ExpandableText> {
  bool _isExpand = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      TextPainter textPainter = TextPainter(
          maxLines: widget.maxLines + 1,
          textScaler: MediaQuery.textScalerOf(context),
          locale: Localizations.localeOf(context),
          textAlign: TextAlign.start,
          text: TextSpan(
            text: widget.text,
            style: widget.textStyle,
          ),
          textDirection: Directionality.of(context))
        ..layout(minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);
      // 判断是否已经超过最大行数
      if (textPainter.didExceedMaxLines) {
        final textSize = textPainter.size;
        final position = textPainter.getPositionForOffset(Offset(
          textSize.width - textPainter.width,
          textSize.height,
        ));
        final endOffset = textPainter.getOffsetBefore(position.offset - 1);
        return RichText(
            overflow: TextOverflow.clip,
            text: TextSpan(
                // 截取 0-endOffset 的字符串，再在后面拼接展开/收起
                text: !_isExpand ? widget.text : widget.text.substring(0, endOffset),
                style: widget.textStyle,
                children: [
                  TextSpan(
                      text: _isExpand ? widget.shrinkText : widget.expandText,
                      style: widget.textStyle?.copyWith(color: widget.expandColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            // 点击实现展开/收起的切换
                            _isExpand = !_isExpand;
                          });
                        })
                ]));
      } else {
        return Text.rich(TextSpan(text: widget.text));
      }
    });
  }
}
