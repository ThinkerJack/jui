import 'package:example/common/demo_base_page.dart';
import 'package:flutter/material.dart';
import 'package:jui/common.dart';

class JUIButtonDemo extends DemoBasePage {
  const JUIButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return super.builder("按钮组件", [
      JUIButton(colorType: JUIButtonColorType.blue, sizeType: JUIButtonSizeType.large, text: "大号蓝色按钮", onTap: () {}),
      space,
      JUIButton(colorType: JUIButtonColorType.blue, sizeType: JUIButtonSizeType.middle, text: "中号蓝色按钮", onTap: () {}),
      space,
      JUIButton(colorType: JUIButtonColorType.blue, sizeType: JUIButtonSizeType.small, text: "小号蓝色按钮", onTap: () {}),
      space,
      JUIButton(
          colorType: JUIButtonColorType.blue, sizeType: JUIButtonSizeType.ultraSmall, text: "超小蓝色按钮", onTap: () {}),
      space,
      JUIButton(
          colorType: JUIButtonColorType.blueBorder, sizeType: JUIButtonSizeType.small, text: "中号边框按钮", onTap: () {}),
      space,
      JUIButton(colorType: JUIButtonColorType.gray, sizeType: JUIButtonSizeType.small, text: "中号灰色按钮", onTap: () {}),
      space,
      JUIButton(colorType: JUIButtonColorType.white, sizeType: JUIButtonSizeType.small, text: "中号白色按钮", onTap: () {}),
    ]);
  }
}
