import 'package:example/common/demo_base_page.dart';
import 'package:flutter/material.dart';
import 'package:jui/data_display.dart';

class EmptyPlaceholderDemo extends DemoBasePage {
  const EmptyPlaceholderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return super.builder("空页面", [
      const JuiNoContent(
        type: JuiNoContentType.list,
      )
    ]);
  }
}
