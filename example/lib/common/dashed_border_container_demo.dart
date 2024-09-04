import 'package:flutter/material.dart';
import 'package:jui/common.dart';
import 'package:example/common/demo_base_page.dart';

class DashedBorderContainerDemo extends StatelessWidget {
  DashedBorderContainerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoBasePage(
      title: "虚线边框组件",
      children: [
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
      ],
    );
  }
}