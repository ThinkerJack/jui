import 'package:example/common/demo_base_page.dart';
import 'package:flutter/material.dart';
import 'package:jui/data_display.dart';

class TitleDemo extends DemoBasePage {
  const TitleDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return super.builder("标题文本", [
      JuiTitle(title: "标题"),
      space,
      JuiTitle(title: "内容可折叠",expandFlag: ValueNotifier<bool>(false),expandedContent: Text("内容"),)
    ]);
  }
}
