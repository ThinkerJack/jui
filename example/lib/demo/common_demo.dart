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
            CButton(
              colorType: CButtonColorType.blue,
              sizeType: CButtonSizeType.ultraSmall,
              text: "最小号蓝色按钮",
              onTap: () {},
            ),
            space,
            CButton(
              colorType: CButtonColorType.blue,
              sizeType: CButtonSizeType.small,
              text: "小号蓝色按钮",
              onTap: () {},
            ),
            space,
            CButton(
              colorType: CButtonColorType.blue,
              sizeType: CButtonSizeType.middle,
              text: "中号蓝色按钮",
              onTap: () {},
            ),
            space,
            CButton(
              colorType: CButtonColorType.blue,
              sizeType: CButtonSizeType.large,
              text: "大号蓝色按钮",
              onTap: () {},
            ),
            space,
            CButton(
              colorType: CButtonColorType.white,
              sizeType: CButtonSizeType.large,
              text: "大号白色按钮",
              onTap: () {},
            ),
            space,
            CButton(
              colorType: CButtonColorType.gray,
              sizeType: CButtonSizeType.large,
              text: "大号灰色按钮",
              onTap: () {},
            ),
            space,
            CButton(
              colorType: CButtonColorType.blueBorder,
              sizeType: CButtonSizeType.large,
              text: "大号蓝边按钮",
              onTap: () {},
            ),
            space,
            CButton(
              colorType: CButtonColorType.blueBorder,
              sizeType: CButtonSizeType.large,
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
