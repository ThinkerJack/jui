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
            HighlightedText.builder(
              text: "全部文案包含高亮文案测试用",
              highlights: [
                HighlightWord(
                  "文案",
                  () {
                    debugPrint("文案");
                  },
                  highlightStyle: const TextStyle(color: Colors.red),
                ),
                HighlightWord("含", () {
                  debugPrint("含");
                }),
                HighlightWord("测试", () {
                  debugPrint("测试");
                }),
              ],
              defaultTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
              defaultHighlightStyle: const TextStyle(color: Colors.cyanAccent, fontSize: 16),
            ),
            const SizedBox(height: 30),
            ExpandableText(
              content: '测试' * 50,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
