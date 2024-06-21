import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jac_uikit/common.dart';

Widget space = const SizedBox(
  height: 30,
);

class CommonDemo extends StatelessWidget {
  const CommonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("数据展示")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            JacButton(
              colorType: JacButtonColorType.blue,
              sizeType: JacButtonSizeType.ultraSmall,
              text: "最小号蓝色按钮",
              onTap: () {},
            ),
            space,
            JacButton(
              colorType: JacButtonColorType.blue,
              sizeType: JacButtonSizeType.small,
              text: "小号蓝色按钮",
              onTap: () {},
            ),
            space,
            JacButton(
              colorType: JacButtonColorType.blue,
              sizeType: JacButtonSizeType.middle,
              text: "中号蓝色按钮",
              onTap: () {},
            ),
            space,
            JacButton(
              colorType: JacButtonColorType.blue,
              sizeType: JacButtonSizeType.large,
              text: "大号蓝色按钮",
              onTap: () {},
            ),
            space,
            JacButton(
              colorType: JacButtonColorType.white,
              sizeType: JacButtonSizeType.large,
              text: "大号白色按钮",
              onTap: () {},
            ),
            space,
            JacButton(
              colorType: JacButtonColorType.gray,
              sizeType: JacButtonSizeType.large,
              text: "大号灰色按钮",
              onTap: () {},
            ),
            space,
            JacButton(
              colorType: JacButtonColorType.blueBorder,
              sizeType: JacButtonSizeType.large,
              text: "大号蓝边按钮",
              onTap: () {},
            ),
            space,
            JacButton(
              colorType: JacButtonColorType.blueBorder,
              sizeType: JacButtonSizeType.large,
              width: 230,
              height: 80,
              text: "自定义宽高按钮",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
