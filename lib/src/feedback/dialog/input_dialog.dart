import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/color.dart';
import 'common.dart';

// 正则表达式，用于过滤emoji表情
const String regexEmoji =
    "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";

// 输入对话框组件
class VVInputDialog extends StatefulWidget {
  const VVInputDialog({
    Key? key,
    required this.content,
    required this.onConfirmTap,
    required this.title,
    required this.maxLength,
    required this.hintText,
    this.enableEmoji = false,
    required this.confirmButtonText,
    required this.width,
  }) : super(key: key);

  final String content; // 初始内容
  final String title; // 对话框标题
  final int maxLength; // 最大输入长度
  final double width; // 对话框宽度
  final String hintText; // 提示文字
  final String confirmButtonText; // 确认按钮文本
  final InputConfirmTapCallBack onConfirmTap; // 确认按钮点击回调
  final bool enableEmoji; // 是否允许输入emoji

  @override
  State<VVInputDialog> createState() => _VVInputDialogState();
}

class _VVInputDialogState extends State<VVInputDialog> {
  // 文本控制器
  TextEditingController controller = TextEditingController();

  // 焦点节点
  final FocusNode _focusNode = FocusNode();

  // 输入格式化器，根据是否允许输入emoji决定是否添加过滤器
  List<TextInputFormatter>? inputFormatters() {
    List<TextInputFormatter> inputFormatterList = [];
    if (!widget.enableEmoji) {
      inputFormatterList.add(FilteringTextInputFormatter.deny(RegExp(regexEmoji)));
    }
    return inputFormatterList;
  }

  @override
  void initState() {
    controller.text = widget.content;
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width,
        padding: EdgeInsets.fromLTRB(24, dialogMarginTop, 24, 16),
        decoration: BoxDecoration(
          color: uiFFFFFF,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 对话框标题
            Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: dialogTitleStyle,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: dialogSpacer),
            // 输入框容器
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0XFF5590F6), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              // 输入框
              child: TextField(
                scrollPhysics: const ClampingScrollPhysics(),
                controller: controller,
                maxLength: widget.maxLength,
                maxLines: 1,
                style: TextStyle(
                  color: const Color(0XFF212123),
                  fontSize: 16,
                  height: 1.5,
                ),
                inputFormatters: inputFormatters(),
                focusNode: _focusNode,
                onChanged: (data) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                    left: 12,
                    right: 12,
                  ),
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: uiBCC1CD,
                    fontSize: 16,
                    height: 1.3,
                  ),
                  counterText: '',
                ),
              ),
            ),
            SizedBox(height: dialogSpacer),
            // 确认按钮
            buildDialogButton(
              context,
              () {
                widget.onConfirmTap(controller.text);
              },
              doneDisable: controller.text.isEmpty,
              confirmButtonText: widget.confirmButtonText,
            ),
          ],
        ),
      ),
    );
  }
}
