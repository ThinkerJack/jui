import 'package:flutter/cupertino.dart';
import 'package:habit/habit.dart';

import '../../../utils.dart';
import 'common.dart';

/// 标题对话框组件
class VVTitleDialog extends StatelessWidget {
  const VVTitleDialog({
    Key? key,
    required this.content,
    required this.onConfirmTap,
    required this.title,
    required this.confirmButtonText,
    required this.showCancelButton,
    required this.cancelButtonText,
    required this.onCancelTap,
    required this.width,
  }) : super(key: key);

  final String content; // 对话框内容
  final String title; // 对话框标题
  final String confirmButtonText; // 确认按钮文本
  final String cancelButtonText; // 取消按钮文本
  final DialogTapCallBack onConfirmTap; // 确认按钮点击回调
  final DialogTapCallBack onCancelTap; // 取消按钮点击回调
  final bool showCancelButton; // 是否显示取消按钮
  final double width; // 对话框宽度

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        padding: EdgeInsets.fromLTRB(24.w, dialogMarginTop, 24.w, 24.w),
        decoration: BoxDecoration(
          color: uiFFFFFF,
          borderRadius: BorderRadius.all(Radius.circular(16.w)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 对话框标题
            Text(
              title,
              style: dialogTitleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 12.w,
            ),
            // 对话框内容
            Text(
              content,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: dialogContentStyle,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: dialogSpacer),
            // 确认和取消按钮
            buildDialogButton(
              context,
              onConfirmTap,
              cancelTap: onCancelTap,
              confirmButtonText: confirmButtonText,
              showCancelButton: showCancelButton,
              cancelButtonText: cancelButtonText,
            ),
          ],
        ),
      ),
    );
  }
}
