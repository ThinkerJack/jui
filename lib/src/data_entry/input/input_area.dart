import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jui/src/utils/extension.dart';

import '../../form/item/common.dart';
import '../../utils/jui_theme.dart';

/// 文本输入区域组件
class InputArea extends StatefulWidget {
  const InputArea({
    Key? key,
    required this.textEditingController,
    required this.tipsFlag,
    this.focusNode,
    this.maxLength = 500,
    required this.hintText,
    this.tipsText = "",
    this.marginLeft = 20,
    this.marginRight = 20,
    this.height,
    this.onUnFocus,
    this.backgroundColor,
    this.maxLine = 5,
    this.padding,
    this.contentPadding,
    this.fontHeight,
    this.showScrollbar = false,
  }) : super(key: key);

  final TextEditingController textEditingController; // 文本控制器
  final ValueNotifier<bool> tipsFlag; // 是否显示提示信息
  final FocusNode? focusNode; // 焦点节点
  final int maxLength; // 最大输入长度
  final String hintText; // 输入框提示文字
  final String tipsText; // 提示文字
  final double marginLeft; // 左侧边距
  final double marginRight; // 右侧边距
  final double? height; // 高度
  final CheckTextFunc onUnFocus; // 失去焦点时的回调函数
  final Color? backgroundColor; // 背景颜色
  final int maxLine; // 最大行数
  final EdgeInsets? padding; // 内边距
  final EdgeInsets? contentPadding; // 内容内边距
  final double? fontHeight; // 字体高度
  final bool showScrollbar; // 是否显示滚动条

  @override
  State<InputArea> createState() => _InputAreaState();
}

class _InputAreaState extends State<InputArea> with InputCheckMixin {
  @override
  void initState() {
    initFocus(widget.tipsText, widget.focusNode, () async {
      if (!focusNode.hasFocus) {
        final hintText = await widget.onUnFocus?.call(widget.textEditingController.text);
        if (hintText != null && hintText.isNotEmpty) {
          tipText = hintText;
          widget.tipsFlag.value = true;
        } else {
          widget.tipsFlag.value = false;
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    disposeFocus(widget.focusNode == null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.tipsFlag.listen((value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: widget.backgroundColor ?? JuiColors().lightGray, borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(left: widget.marginLeft, right: widget.marginRight),
              height: widget.height ?? 120,
              padding: widget.padding ?? EdgeInsets.only(left: 12, right: 10, top: 0, bottom: 6),
              child: _buildScrollbar(
                TextField(
                  onChanged: (text) {},
                  inputFormatters: [FilteringTextInputFormatter(" ", allow: false)],
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLine,
                  focusNode: focusNode,
                  controller: widget.textEditingController,
                  style: TextStyle(fontSize: 16, color: JuiColors().text, height: widget.fontHeight),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: widget.contentPadding ?? EdgeInsets.only(top: 12),
                    fillColor: Colors.transparent,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(fontSize: 16, height: widget.fontHeight, color: JuiColors().disabled),
                    helperStyle: TextStyle(color: JuiColors().disabled, fontSize: 12, height: 1.5),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.only(left: widget.marginLeft),
              child: ItemTipsText(
                showTips: widget.tipsFlag.value,
                tipText: tipText,
              ),
            ),
          ],
        ));
  }

  /// 根据是否需要显示滚动条返回对应的组件
  Widget _buildScrollbar(Widget child) {
    if (widget.showScrollbar) {
      return RawScrollbar(
        // 滚动条的宽度
        thickness: 4,
        // 滚动条的圆角
        radius: const Radius.circular(5),
        thumbColor: JuiColors().divider,
        child: child,
      );
    }
    return child;
  }
}
