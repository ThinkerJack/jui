import 'package:flutter/material.dart';
import 'package:jui/form.dart';
import 'package:example/common/demo_base_page.dart';

class ItemDemo extends StatefulWidget {
  const ItemDemo({Key? key}) : super(key: key);

  @override
  ItemDemoState createState() => ItemDemoState();
}

class ItemDemoState extends State<ItemDemo> {
  TextEditingController controller = TextEditingController()..text = "内容" * 30;

  @override
  Widget build(BuildContext context) {
    return DemoBasePage(
      title: "表单项",
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
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
        JuiCustomItem(
          title: 'Custom Item input',
          content: TextField(),
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
        JuiTextInputItem(
          title: "用户名",
          hintText: "请输入用户名",
          controller: TextEditingController(),
          showClearButton: false, // 不显示清除按钮
        ),
        JuiTextInputItem(
          title: "Text Input Item",
          controller: controller,
          hintText: "请输入",
          onChanged: (value) {
            print("change: $value");
          },
          config: const JuiItemConfig(
            isRequired: true,
          ),
        ),
        TextButton(
            onPressed: () {
              setState(() {
                controller.text = "change";
              });
            },
            child: Text("Text Button")),
      ],
    );
  }
}
