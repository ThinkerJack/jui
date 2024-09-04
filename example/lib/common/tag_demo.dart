import 'package:flutter/material.dart';
import 'package:jui/data_display.dart';
import 'package:example/common/demo_base_page.dart';

class TagDemo extends StatelessWidget {
  TagDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoBasePage(
      title: "标签组件",
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            JuiTag(
              text: "标签",
              tagColorType: JuiTagColorType.blue,
            ),
            JuiTag(
              text: "标签",
              tagColorType: JuiTagColorType.black,
            ),
            JuiTag(
              text: "标签",
              tagColorType: JuiTagColorType.green,
            ),
            JuiTag(
              text: "标签",
              tagColorType: JuiTagColorType.yellow,
            ),
            JuiTag(
              text: "标签",
              tagColorType: JuiTagColorType.red,
            ),
            JuiTag(
              text: "标签",
              tagColorType: JuiTagColorType.gray,
            ),
          ],
        ),
        DemoBasePage.space,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            JuiTag(
              text: "半圆标签",
              tagColorType: JuiTagColorType.blue,
              tagShapeType: JuiTagShapeType.semicircle,
            ),
            JuiTag(
              text: "胶囊标签",
              tagColorType: JuiTagColorType.black,
              tagShapeType: JuiTagShapeType.capsule,
            ),
            JuiTag(
              text: "图标标签",
              icon: Icon(
                Icons.add,
                size: 12,
                color: Colors.blue,
              ),
              tagColorType: JuiTagColorType.blue,
              tagShapeType: JuiTagShapeType.capsule,
              tagType: JuiTagType.icon,
            ),
          ],
        ),
        DemoBasePage.space,
      ],
    );
  }
}