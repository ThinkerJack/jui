import 'package:flutter/material.dart';
import 'package:jui/data_display.dart';
import 'package:example/common/demo_base_page.dart';

class TitleDemo extends StatelessWidget {
  TitleDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoBasePage(
      title: "标题文本",
      children: [
        JuiTitle(title: "标题"),
        DemoBasePage.space,
        JuiTitle(title: "内容可折叠", expandFlag: ValueNotifier<bool>(false), expandedContent: Text("内容"),)
      ],
    );
  }
}