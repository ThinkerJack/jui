import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_color.dart';

// 文字展开收起组件
class ExpandableText extends StatefulWidget {
  const ExpandableText({
    Key? key,
    required this.content,
    this.canCollapsed = true,
    this.maxLines = 6,
    this.contentTextStyle,
    this.expandTextStyle,
    this.expandText = "展开",
    this.collapsedText = "收起",
  }) : super(key: key);

  final String content;// 文本内容
  final String expandText;// 展开文字
  final String collapsedText; // 收起文字
  final int maxLines;// 最大行数
  final bool canCollapsed;// 是否支持收起
  final TextStyle? contentTextStyle;// 普通文本样式
  final TextStyle? expandTextStyle; // 展开收起文本样式

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool expandFlag = true;
  late TextStyle contextTextStyle;
  late TextStyle expandedTextStyle;
  final String ellipsis = "...";

  @override
  void initState() {
    super.initState();
    contextTextStyle = widget.contentTextStyle ?? const TextStyle(color: color2A2F3C, fontSize: 16, height: 1.5);
    expandedTextStyle = widget.expandTextStyle ?? const TextStyle(color: color5590F6, fontSize: 16, height: 1.5);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // 检查内容是否超过最大行数
      if (_isContentOverflowing(widget.content, constraints.maxWidth)) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: expandFlag
                        ? "${widget.content.substring(0, _getSubIndex(constraints))}$ellipsis"
                        : widget.content,
                    style: contextTextStyle,
                  ),
                  TextSpan(
                    text: expandFlag ? widget.expandText : "",
                    style: expandedTextStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          expandFlag = !expandFlag;
                        });
                      },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !expandFlag && widget.canCollapsed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        expandFlag = !expandFlag;
                      });
                    },
                    child: Text(
                      widget.collapsedText,
                      style: expandedTextStyle,
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
          ],
        );
      }
      return Text(
        widget.content,
        style: contextTextStyle,
      );
    });
  }

  // 获取截断文本的索引位置
  int _getSubIndex(BoxConstraints constraints) {
    int subIndex = widget.content.length;
    List<int> runes = widget.content.runes.toList().reversed.toList();
    for (var rune in runes) {
      String text = widget.content.substring(0, subIndex);
      final tp = _getTextPainter("$text$ellipsis${widget.expandText}", constraints.maxWidth);
      if (tp.didExceedMaxLines) {
        subIndex--;
      } else {
        return subIndex;
      }
    }
    return subIndex;
  }

  // 创建文本渲染对象
  TextPainter _getTextPainter(String text, double maxWidth) {
    return TextPainter(
      text: TextSpan(text: text, style: contextTextStyle),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
    )..layout(maxWidth: maxWidth);
  }

  // 检查文本是否超出最大行数
  bool _isContentOverflowing(String text, double maxWidth) {
    return _getTextPainter(text, maxWidth).didExceedMaxLines;
  }
}
