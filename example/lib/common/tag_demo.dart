import 'package:example/common/demo_base_page.dart';
import 'package:flutter/material.dart';
import 'package:jui/common.dart';
import 'package:jui/data_display.dart';

class TagDemo extends DemoBasePage {
  const TagDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return super.builder("标签组件", [
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          JUITag(
            text: "标签",
            tagColorType: JUITagColorType.blue,
          ),
          JUITag(
            text: "标签",
            tagColorType: JUITagColorType.black,
          ),
          JUITag(
            text: "标签",
            tagColorType: JUITagColorType.green,
          ),
          JUITag(
            text: "标签",
            tagColorType: JUITagColorType.yellow,
          ),
          JUITag(
            text: "标签",
            tagColorType: JUITagColorType.red,
          ),
          JUITag(
            text: "标签",
            tagColorType: JUITagColorType.gray,
          ),
        ],
      ),
      space,
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          JUITag(
            text: "半圆标签",
            tagColorType: JUITagColorType.blue,
            tagShapeType: JUITagShapeType.semicircle,
          ),
          JUITag(
            text: "胶囊标签",
            tagColorType: JUITagColorType.black,
            tagShapeType: JUITagShapeType.capsule,
          ),
          JUITag(
            text: "图标标签",
            icon: Icon(
              Icons.add,
              size: 12,
              color: Colors.blue,
            ),
            tagColorType: JUITagColorType.blue,
            tagShapeType: JUITagShapeType.capsule,
            tagType: JUITagType.icon,
          ),
        ],
      ),
      space,
    ]);
  }
}
