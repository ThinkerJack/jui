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
        JuiCustomItem(
          title: 'Custom Item',
          content: const Text('This is a custom item'),
          config: JuiItemConfig(
            isRequired: true,
            showTips: true,
            tipText: '提示',
            onTap: () {
              debugPrint('onTap');
            },
          ),
        ),
        JuiTextDetailItem(
          title: "Text Detail Item",
          contentText: 'This is a text detail item',
          config: JuiItemConfig(
            onTap: () {
              debugPrint('onTap');
            },
          ),
        ),
        JuiTapItem(
          title: "Tap Item",
          contentText: 'This is a detail item',
          hintText: '请输入',
          config: JuiItemConfig(
            onTap: () {
              debugPrint('onTap');
            },
            isRequired: true,
          ),
        ),
        JuiTapItem(
          title: "Tap Item",
          contentText: '',
          hintText: '请输入',
          config: JuiItemConfig(
            onTap: () {
              debugPrint('onTap');
            },
            isRequired: true,
          ),
        ),
        JuiTapItem(
          title: "Tap Item",
          contentText: '',
          hintText: '请输入',
          config: JuiItemConfig(
            onTap: () {
              debugPrint('onTap');
            },
            isRequired: true,
          ),
        ),
        const JuiRangeItem(
          title: "Range Item",
          minValue: "1",
          maxValue: "10",
          maxHintText: "最大信息",
          minHintText: "最小信息",
        ),
        const JuiRangeItem(
          title: "Range Item",
          maxHintText: "最大信息",
          minHintText: "最小信息",
        ),
        const JuiRangeItem(
          title: "Range Item",
          minValue: "1",
          maxHintText: "最大信息",
          config: JuiItemConfig(
            tipText: '提示',
            showTips: true,
          ),
        ),
      ],
    );
  }
}
