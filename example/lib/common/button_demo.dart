import 'package:flutter/material.dart';
import 'package:jui/common.dart';
import 'package:example/common/demo_base_page.dart';

class JuiButtonDemo extends StatelessWidget {
  const JuiButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoBasePage(
      title: "按钮组件",
      children: [
        JuiButton(colorType: JuiButtonColorType.blue, sizeType: JuiButtonSizeType.large, text: "大号蓝色按钮", onTap: () {}),
        DemoBasePage.space,
        JuiButton(colorType: JuiButtonColorType.blue, sizeType: JuiButtonSizeType.middle, text: "中号蓝色按钮", onTap: () {}),
        DemoBasePage.space,
        JuiButton(colorType: JuiButtonColorType.blue, sizeType: JuiButtonSizeType.small, text: "小号蓝色按钮", onTap: () {}),
        DemoBasePage.space,
        JuiButton(
            colorType: JuiButtonColorType.blue, sizeType: JuiButtonSizeType.ultraSmall, text: "超小蓝色按钮", onTap: () {}),
        DemoBasePage.space,
        JuiButton(
            colorType: JuiButtonColorType.blueBorder, sizeType: JuiButtonSizeType.small, text: "中号边框按钮", onTap: () {}),
        DemoBasePage.space,
        JuiButton(colorType: JuiButtonColorType.gray, sizeType: JuiButtonSizeType.small, text: "中号灰色按钮", onTap: () {}),
        DemoBasePage.space,
        JuiButton(colorType: JuiButtonColorType.white, sizeType: JuiButtonSizeType.small, text: "中号白色按钮", onTap: () {}),
      ],
    );
  }
}