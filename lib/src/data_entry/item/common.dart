import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jac_uikit/src/utils/extension.dart';

import '../../../../generated/assets.dart';
import '../../utils/custom_color.dart';

class ItemTipsText extends StatelessWidget {
  const ItemTipsText({
    Key? key,
    required this.showTips,
    required this.tipText,
  }) : super(key: key);

  final bool showTips;
  final String tipText;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showTips,
      child: Column(
        children: [
          const SizedBox(
            height: 4,
          ),
          Text(
            tipText,
            style: const TextStyle(color: tipsColor, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class ItemTitle extends StatelessWidget {
  const ItemTitle({
    Key? key,
    required this.title,
    required this.isRequired,
  }) : super(key: key);

  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: itemTitleStyle,
          maxLines: 1,
        ),
        const SizedBox(width: 4),
        Visibility(
          visible: isRequired,
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Image.asset(
              Assets.imagesItemRequired.path,
              height: 10,
            ),
          ),
        )
      ],
    );
  }
}

const TextStyle itemTitleStyle =
    TextStyle(color: color858B9B, fontSize: 14, fontWeight: FontWeight.w400, height: 1.5);
const TextStyle itemHintStyle = TextStyle(color: colorBCC1CD, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5);
const TextStyle itemContentStyle =
    TextStyle(color: color2A2F3C, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5);
const Color tipsColor = colorF55656;

class ItemDivider extends StatelessWidget {
  const ItemDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color(0XFFE8EAEF),
      height: 1,
      thickness: 1,
    );
  }
}
//用于调用接口，判断输入内容是否涉及敏感词
//返回String 会用于输入框的提示文字
typedef CheckTextFunc = Future<String?> Function(String)?;

mixin InputCheckMixin {
  late FocusNode focusNode;
  late VoidCallback unFocus;
  String tipText = "";

  initFocus(String tipsText, FocusNode? focusNode, VoidCallback unFocusFunc) {
    tipText = tipsText;
    this.focusNode = focusNode ?? FocusNode();
    unFocus = unFocusFunc;
    this.focusNode.addListener(unFocus);
  }

  disposeFocus(bool needDispose) {
    focusNode.removeListener(unFocus);
    if(needDispose){
      focusNode.dispose();
    }
  }
}