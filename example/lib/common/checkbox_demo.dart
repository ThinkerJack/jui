import 'package:flutter/material.dart';
import 'package:jui/data_entry.dart';
import 'package:example/common/demo_base_page.dart';

class CheckBoxDemo extends StatelessWidget {
  const CheckBoxDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoBasePage(
      title: "复选框",
      children: [
        JuiCheckBox(
          type: JuiCheckBoxType.square, flag: ValueNotifier<bool>(true),
        ),
        DemoBasePage.space,
        JuiCheckBox(
          type: JuiCheckBoxType.circle, flag: ValueNotifier<bool>(true),
        ),
      ],
    );
  }
}