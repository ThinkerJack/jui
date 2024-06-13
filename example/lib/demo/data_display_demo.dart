import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jac_uikit/data_display.dart';

class DataDisplayDemo extends StatelessWidget {
  const DataDisplayDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("数据展示")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            HighlightedTextWidget.builder(
              text: "全部文案包含高亮文案测试用",
              highlights: [
                HighlightWord(
                  "文案",
                  () {
                    print("文案");
                  },
                  highlightStyle: TextStyle(color: Colors.red),
                ),
                HighlightWord("含", () {
                  print("含");
                }),
                HighlightWord("测试", () {
                  print("测试");
                }),
              ],
              defaultTextStyle: TextStyle(color: Colors.black, fontSize: 16),
              defaultHighlightStyle: TextStyle(color: Colors.cyanAccent, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
