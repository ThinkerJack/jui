import 'package:flutter/cupertino.dart';


import '../../../common.dart';
import '../../../utils.dart';

typedef DialogTapCallBack = void Function();
typedef InputConfirmTapCallBack = void Function(String);

/// 构建对话框按钮
Row buildDialogButton(BuildContext context, Function confirmTap,
    {bool doneDisable = false,
    String confirmButtonText = "",
    String cancelButtonText = "",
    bool showCancelButton = true,
    Function? cancelTap}) {
  return Row(
    mainAxisAlignment: showCancelButton ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
    children: [
      /// 取消按钮
      VVButtonGray(
        visibility: showCancelButton,
        onTap: () {
          Navigator.pop(context);
          cancelTap?.call();
        },
        text: cancelButtonText.isNotEmpty ? cancelButtonText : "取消",
      ),

      /// 确认按钮
      VVButtonBlue(
        visibility: true,
        onTap: () {
          Navigator.pop(context);
          confirmTap.call();
        },
        disable: doneDisable,
        width: !showCancelButton ? 279 : null,
        text: confirmButtonText.isNotEmpty ? confirmButtonText : "确定",
      ),
    ],
  );
}

/// 对话框内容文本样式
TextStyle dialogContentStyle = TextStyle(
  decoration: TextDecoration.none,
  color: ui858B9B,
  fontSize: 14,
  height: 1.5,
);

/// 对话框标题文本样式
TextStyle dialogTitleStyle = TextStyle(
  decoration: TextDecoration.none,
  color: ui2A2F3C,
  fontSize: 16,
  height: 1.5,
  fontWeight: FontWeight.w500,
);

/// 对话框顶部间距
double dialogMarginTop = 24;

/// 对话框内部元素间隔
double dialogSpacer = 20;

/// 对话框宽度
double dialogWidth = 327;
