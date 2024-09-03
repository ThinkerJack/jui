import 'package:example/common/demo_base_page.dart';
import 'package:flutter/material.dart';
import 'package:jui/data_display.dart';

class ExpandedTextDemo extends DemoBasePage {
  const ExpandedTextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return super.builder("展开收起文本", [
      JuiExpandableText(
        text: "这是一段超过最大行数的文本点击展开" * 30,
      )
    ]);
  }
}
