import 'package:flutter/cupertino.dart';
import '../../utils/color.dart';
import 'common.dart';

/// 一个简单的对话框组件
class VVSimpleDialog extends StatelessWidget {
  const VVSimpleDialog({
    Key? key,
    required this.content,
    required this.onConfirmTap,
    required this.confirmButtonText,
    required this.showCancelButton,
    required this.width,
    required this.cancelButtonText,
  }) : super(key: key);

  final String content; // 对话框内容
  final String confirmButtonText; // 确认按钮文本
  final String cancelButtonText; // 确认按钮文本
  final DialogTapCallBack onConfirmTap; // 确认按钮点击回调
  final bool showCancelButton; // 是否显示取消按钮
  final double width; // 对话框宽度

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        padding: EdgeInsets.fromLTRB(24, dialogMarginTop, 24, 24),
        decoration: BoxDecoration(
          color: uiFFFFFF,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 对话框内容文本
            Text(
              content,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: dialogTitleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: dialogSpacer),
            // 确认和取消按钮
            buildDialogButton(context, () {
              onConfirmTap.call();
            },
                confirmButtonText: confirmButtonText,
                showCancelButton: showCancelButton,
                cancelButtonText: cancelButtonText),
          ],
        ),
      ),
    );
  }
}
