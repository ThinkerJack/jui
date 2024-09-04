import 'package:flutter/material.dart';
import 'package:jui/data_display.dart';
import 'package:example/common/demo_base_page.dart';

class EmptyPlaceholderDemo extends StatelessWidget {
  EmptyPlaceholderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoBasePage(
      title: "空页面",
      children: [
        const JuiNoContent(
          type: JuiNoContentType.list,
        )
      ],
    );
  }
}