import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jui/src/basic/extension.dart';

import '../../../generated/assets.dart';
import '../../../utils.dart';

/// 提示文本组件
class ItemTipsText extends StatelessWidget {
  const ItemTipsText({
    Key? key,
    required this.showTips,
    required this.tipText,
  }) : super(key: key);

  /// 是否显示提示信息
  final bool showTips;

  /// 提示文本内容
  final String tipText;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showTips,
      child: Column(
        children: [
          SizedBox(
            height: 4,
          ),
          Text(
            tipText,
            style: TextStyle(color: tipsColor, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }
}

/// 标题组件
class ItemTitle extends StatelessWidget {
  const ItemTitle({
    Key? key,
    required this.title,
    required this.isRequired,
    this.isDisabled = false,
  }) : super(key: key);

  /// 标题文本
  final String title;

  /// 是否为必填项
  final bool isRequired;

  /// 是否禁用
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: isDisabled ? itemTitleDisabledStyle : itemTitleStyle,
          maxLines: 1,
        ),
        SizedBox(width: 4),
        Visibility(
          visible: !isDisabled && isRequired,
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Image.asset(
              Assets.imagesItemRequired.path,
            ),
          ),
        )
      ],
    );
  }
}

/// 全局样式定义
final TextStyle itemTitleStyle =
    TextStyle(color: const Color(0XFF858B9B), fontSize: 14, fontWeight: FontWeight.w400, height: 1.5);
final TextStyle itemTitleDisabledStyle =
    TextStyle(color: uiBCC1CD, fontSize: 14, fontWeight: FontWeight.w400, height: 1.5);
final TextStyle itemHintStyle = TextStyle(color: uiBCC1CD, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5);
final TextStyle itemHintDisabledStyle =
    TextStyle(color: uiDCE0E8, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5);

final TextStyle itemContentStyle = TextStyle(color: ui2A2F3C, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5);
const Color tipsColor = uiF55656;

/// 用于调用接口，判断输入内容是否涉及敏感词
/// 返回String 会用于输入框的提示文字
typedef CheckTextFunc = Future<String?> Function(String)?;

/// 输入检查功能混入
mixin InputCheckMixin {
  late FocusNode focusNode;
  late VoidCallback unFocus;
  String tipText = "";

  /// 初始化焦点
  initFocus(String tipsText, FocusNode? focusNode, VoidCallback unFocusFunc) {
    tipText = tipsText;
    this.focusNode = focusNode ?? FocusNode();
    unFocus = unFocusFunc;
    this.focusNode.addListener(unFocus);
  }

  /// 处理焦点移除
  disposeFocus(bool needDispose) {
    focusNode.removeListener(unFocus);
    if (needDispose) {
      focusNode.dispose();
    }
  }
}

/// 全局边距定义
final double itemPaddingL = 20;
final double itemPaddingR = 20;
final double itemPaddingV = 16;
