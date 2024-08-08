import 'package:flutter/material.dart';
import 'package:habit/habit.dart';

import '../../../generated/l10n.dart';
import '../../basic/picker_widget.dart';

typedef InputDoneCallBack = void Function(String contentText);

/// 显示底部输入弹窗
showInputBottomSheet(
  BuildContext context, {
  required String title, // 弹窗标题
  String contentText = "", // 输入框初始内容
  String hintText = "", // 输入框提示文字
  int maxLength = 50, // 输入框最大字符长度
  required InputDoneCallBack callback, // 输入完成后的回调函数
}) {
  showModalBottomSheet(
    context: context,
    constraints: BoxConstraints(
      maxHeight: ScreenUtil().screenHeight -
          MediaQuery.of(context).viewPadding.top -
          MediaQuery.of(context).viewPadding.bottom, // 最大高度设置
    ),
    barrierColor: const Color.fromRGBO(0, 0, 0, 0.7),
    // 背景遮罩颜色
    isScrollControlled: true,
    // 是否可以拖动滚动
    enableDrag: false,
    // 是否允许拖动关闭
    backgroundColor: Colors.transparent,
    // 弹窗背景颜色
    builder: (context) => _InputSheetWidget(
      title: title,
      topLeftText: getLanguage<S>().LMID_00002552,
      // 左侧按钮文本
      topRightText: getLanguage<S>().LMID_00013631,
      // 右侧按钮文本
      inputDoneCallBack: callback,
      // 输入完成后的回调
      contentText: contentText,
      // 输入框初始内容
      maxLength: maxLength,
      // 输入框最大字符长度
      hintText: hintText, // 输入框提示文字
    ),
  );
}

/// 底部输入弹窗的StatefulWidget
class _InputSheetWidget extends StatefulWidget {
  // 弹窗标题
  final String title;

  // 输入框初始内容
  final String contentText;

  // 输入框提示文字
  final String hintText;

  // 左侧按钮文本
  final String topLeftText;

  // 右侧按钮文本
  final String topRightText;

  // 输入框最大字符长度
  final int maxLength;

  // 输入完成后的回调函数
  final InputDoneCallBack inputDoneCallBack;

  const _InputSheetWidget({
    required this.title,
    required this.topLeftText,
    required this.topRightText,
    required this.inputDoneCallBack,
    required this.contentText,
    required this.maxLength,
    required this.hintText,
  });

  @override
  State<_InputSheetWidget> createState() => _InputSheetWidgetState();
}

class _InputSheetWidgetState extends State<_InputSheetWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.contentText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(24.w), topLeft: Radius.circular(24.w)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PickerTitle(
            leftText: widget.topLeftText,
            rightText: widget.topRightText,
            onCancel: () {
              Navigator.pop(context);
            },
            onConfirm: () {
              if (_controller.text.isEmpty) return;
              Navigator.pop(context);
              widget.inputDoneCallBack(_controller.text);
            },
            rightTextStyle: _controller.text.isEmpty
                ? TextStyle(fontSize: 16.sp, color: const Color(0xFFC7DDFF), height: 1.5.r, fontWeight: FontWeight.w500)
                : null,
            title: widget.title,
          ),
          Container(
            padding: EdgeInsets.only(left: 20.w, right: 36.w, bottom: 10.h, top: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300.w,
                  child: TextField(
                    controller: _controller,
                    maxLength: widget.maxLength,
                    maxLines: 5,
                    style: TextStyle(fontSize: 16.sp, height: 1.5),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: widget.hintText,
                      hintStyle: TextStyle(fontSize: 16.sp, color: const Color(0xFFBCC1CD)),
                      counter: Container(),
                    ),
                    onChanged: (data) {
                      setState(() {});
                    },
                  ),
                ),
                Visibility(
                  visible: _controller.text.isNotEmpty,
                  child: InkWell(
                    onTap: () {
                      _controller.text = '';
                      setState(() {});
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 4.w),
                      child: ClipOval(
                          child: Container(
                              width: 16.r,
                              height: 16.r,
                              color: const Color(0xFFBCC1CD),
                              child: Icon(
                                Icons.close,
                                size: 10.r,
                                color: Colors.white,
                              ))),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
