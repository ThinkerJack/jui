import 'package:example/common/demo_base_page.dart';
import 'package:flutter/material.dart';
import 'package:jui/common.dart';

class JuiButtonDemo extends DemoBasePage {
   JuiButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return super.builder("按钮组件", [
      JuiButton(colorType: JuiButtonColorType.blue, sizeType: JuiButtonSizeType.large, text: "大号蓝色按钮", onTap: () {}),
      space,
      JuiButton(colorType: JuiButtonColorType.blue, sizeType: JuiButtonSizeType.middle, text: "中号蓝色按钮", onTap: () {}),
      space,
      JuiButton(colorType: JuiButtonColorType.blue, sizeType: JuiButtonSizeType.small, text: "小号蓝色按钮", onTap: () {}),
      space,
      JuiButton(
          colorType: JuiButtonColorType.blue, sizeType: JuiButtonSizeType.ultraSmall, text: "超小蓝色按钮", onTap: () {}),
      space,
      JuiButton(
          colorType: JuiButtonColorType.blueBorder, sizeType: JuiButtonSizeType.small, text: "中号边框按钮", onTap: () {}),
      space,
      JuiButton(colorType: JuiButtonColorType.gray, sizeType: JuiButtonSizeType.small, text: "中号灰色按钮", onTap: () {}),
      space,
      JuiButton(colorType: JuiButtonColorType.white, sizeType: JuiButtonSizeType.small, text: "中号白色按钮", onTap: () {}),
    ]);
  }
}
