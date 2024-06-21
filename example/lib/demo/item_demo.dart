import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jac_uikit/data_entry.dart';

Widget space = const SizedBox(
  height: 30,
);

class ItemDemo extends StatelessWidget {
  const ItemDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("按钮示例")),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              TapItem(
                title: '标题',
                content: '内容',
                tipText: "请输入",
                onTap: () {
                  debugPrint("点击");
                },
              ),
              space,
              TapItem(
                title: '标题',
                content: '内容',
                tipText: "请输入",
                isRequired: true,
                maxLine: 1,
                hintText: '请选择',
                showTips: true,
                onTap: () {
                  debugPrint("点击");
                },
              ),
              space,
            ],
          )),
    );
  }
}
