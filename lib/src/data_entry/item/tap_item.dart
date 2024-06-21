import 'package:flutter/material.dart';
import 'package:jac_uikit/src/utils/extension.dart';

import '../../../generated/assets.dart';
import 'common.dart';

///点击表单项
class TapItem extends StatelessWidget {
  const TapItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.content = "",
    this.tipText = "",
    this.hintText = "",
    this.maxLine = 1,
    this.isRequired = false,
    this.showTips = false,
  }) : super(key: key);

  final String title; //标题
  final String hintText; //输入框底文
  final String content; //输入框内容
  final Function onTap; //点击事件
  final bool showTips; //是否报错
  final String tipText; //错误文案
  final int maxLine; //文本内容最大行数
  final bool isRequired; //是否是必填

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap();
      },
      child: Container(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        ItemTitle(title: title, isRequired: isRequired),
                        const SizedBox(
                          height: 6,
                        ),
                        content.isNotEmpty
                            ? Text(
                                content,
                                style: itemContentStyle,
                                maxLines: maxLine,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Text(
                                hintText,
                                style: itemHintStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                        ItemTipsText(showTips: showTips, tipText: tipText),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 18, right: 16),
                    child: Image.asset(
                      Assets.imagesIconRight.path,
                      height: 20,
                    ),
                  )
                ],
              ),
              const ItemDivider(),
            ],
          )),
    );
  }
}
