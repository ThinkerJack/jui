import 'package:flutter/material.dart';
import 'package:jui/data_display.dart';
import 'package:example/common/demo_base_page.dart';

class ExpandedTextDemo extends StatelessWidget {
  ExpandedTextDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoBasePage(
      title: "展开收起文本",
      children: [
        JuiExpandableText(
          text: "这是一段超过最大行数的文本点击展开" * 30,
        )
      ],
    );
  }
}