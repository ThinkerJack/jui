import 'package:flutter/material.dart';

class JuiExpandableText extends StatefulWidget {
  const JuiExpandableText({
    Key? key,
    required this.text,
    this.canPackUp = true,
    this.maxLines = 6,
    this.contentTextStyle,
    this.expandedTextStyle,
    this.expandText = '展开',
    this.collapseText = '收起',
  }) : super(key: key);

  // 文本内容
  final String text;

  // 最大行数
  final int maxLines;

  // 是否支持收起
  final bool canPackUp;

  // 文本样式
  final TextStyle? contentTextStyle;

  // 展开/收起按钮文本样式
  final TextStyle? expandedTextStyle;

  // 展开按钮文本
  final String expandText;

  // 收起按钮文本
  final String collapseText;

  @override
  State<JuiExpandableText> createState() => _JuiExpandableTextState();
}

class _JuiExpandableTextState extends State<JuiExpandableText> {
  late String _expandText;
  bool expandFlag = true; // 是否展开标志
  late TextStyle contextTextStyle =
      widget.contentTextStyle ?? const TextStyle(color: Color(0xff2A2F3C), fontSize: 16, height: 1.5);
  late TextStyle expandedTextStyle =
      widget.expandedTextStyle ?? const TextStyle(color: Color(0xff5590F6), fontSize: 16, height: 1.5);

  @override
  void initState() {
    super.initState();
    _expandText = "... ${widget.expandText}";
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      if (getContentTextPainter(widget.text, size.maxWidth).didExceedMaxLines) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 富文本组件
            Text.rich(
              TextSpan(
                text: expandFlag ? "${widget.text.substring(0, getSubIndex(size))}... " : widget.text,
                style: contextTextStyle,
                children: [
                  WidgetSpan(
                    child: Visibility(
                      visible: expandFlag,
                      child: buildExpandedWidget(),
                    ),
                  ),
                ],
              ),
            ),
            // 展开/收起按钮
            Visibility(
              visible: !expandFlag && widget.canPackUp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [buildExpandedWidget(), SizedBox(width: 5)],
              ),
            ),
          ],
        );
      }
      // 直接显示文本
      return Text(
        widget.text,
        style: contextTextStyle,
      );
    });
  }

  // 构建展开/收起按钮
  Widget buildExpandedWidget() {
    return GestureDetector(
      onTap: () {
        setState(() {
          expandFlag = !expandFlag;
        });
      },
      child: Text(
        expandFlag ? widget.expandText : widget.collapseText,
        textAlign: TextAlign.end,
        style: expandedTextStyle,
      ),
    );
  }

  // 获取截取文本的索引
  int getSubIndex(BoxConstraints size) {
    int subIndex = widget.text.length;
    List<int> runes = widget.text.runes.toList().reversed.toList();
    for (var rune in runes) {
      var character = String.fromCharCode(rune);
      String text = widget.text.substring(0, subIndex);
      final tp = getContentTextPainter("$text$_expandText", size.maxWidth);
      if (tp.didExceedMaxLines) {
        // 适配emoji
        subIndex = subIndex - character.length;
      } else {
        return subIndex;
      }
    }
    return subIndex;
  }

  // 获取文本绘制对象
  TextPainter getContentTextPainter(String text, double maxWidth) {
    return TextPainter(
        text: TextSpan(text: text, style: contextTextStyle),
        maxLines: widget.maxLines,
        textDirection: TextDirection.ltr,
        textScaleFactor: MediaQuery.of(context).textScaleFactor)
      ..layout(maxWidth: maxWidth);
  }
}
