import 'package:flutter/cupertino.dart';
import 'package:jui/form.dart';

import 'demo_base_page.dart';

class ItemDemo extends DemoBasePage {
  const ItemDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return super.builder(
      "表单项",
      padding: const EdgeInsets.symmetric(vertical: 20),
      [
        JuiBaseItem(title: "表单项", content: Column(children: const [Text("data")])),
      ],
    );
  }
}
