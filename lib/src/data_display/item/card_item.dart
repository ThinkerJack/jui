import 'package:flutter/cupertino.dart';import 'package:jac_uikit/src/utils/color.dart';

/// 卡片项组件，显示一个标题和一个内容组件
class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.title,
    required this.contentWidget,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  final String title; // 标题文本
  final Widget contentWidget; // 内容组件

  // 内容和标题的对齐方式
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    //todo
    // bool isZh = LanguageHelper.instance.isZh; // 判断当前语言是否为中文
    bool isZh = true;
    if (isZh) {
      // 中文时，标题和内容组件横向排列
      return Row(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title,
            style: TextStyle(color: ui666F86, fontSize: 14, height: 1.5),
          ),
          Expanded(child: contentWidget)
        ],
      );
    }
    // 非中文时，标题和内容组件纵向排列
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: ui666F86, fontSize: 14, height: 1.5),
        ),
        contentWidget
      ],
    );
  }
}
