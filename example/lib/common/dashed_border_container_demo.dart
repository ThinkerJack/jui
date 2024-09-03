import 'package:example/common/demo_base_page.dart';
import 'package:flutter/material.dart';
import 'package:jui/common.dart';

class DashedBorderContainerDemo extends DemoBasePage {
  const DashedBorderContainerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return super.builder("虚线边框组件", [
      JuiDashedBorder(
        dashColor: Colors.blue,
        dashWidth: 3,
        dashHeight: 1,
        dashSpace: 3,
        borderRadius: 10,
        onTap: () {
          print('Container tapped!');
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('Hello, Dashed Border!'),
        ),
      )
    ]);
  }
}
