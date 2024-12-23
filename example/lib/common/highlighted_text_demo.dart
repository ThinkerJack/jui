import 'package:flutter/material.dart';
import 'package:jui/data_display.dart';
import 'package:example/common/demo_base_page.dart';

class HighlightedTextDemo extends StatelessWidget {
  HighlightedTextDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoBasePage(
      title: "富文本组件",
      children: [
        JuiHighlightedText.buildNoTapHighlight(
            text: "这是一行文字",
            textStyle: const TextStyle(color: Colors.black),
            highlightStyle: const TextStyle(color: Colors.blue),
            highlightText: "文字"),
        DemoBasePage.space,
        JuiHighlightedText(
            text: "这是一行可点击的文字",
            textStyle: TextStyle(color: Colors.black),
            highlightStyle: TextStyle(color: Colors.blue),
            highlights: [
              HighlightWord("文", onTap: () {
                print("文");
              }, highlightStyle: TextStyle(color: Colors.red)),
              HighlightWord("字", onTap: () {
                print("字");
              }, highlightStyle: TextStyle(color: Colors.orange)),
              HighlightWord("行", onTap: () {
                print("行");
              }),
              HighlightWord("可点击", onTap: () {
                print("点击 ");
              }, highlightStyle: TextStyle(color: Colors.green)),
            ])
      ],
    );
  }
}