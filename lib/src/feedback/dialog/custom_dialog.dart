import 'package:flutter/cupertino.dart';
import '../../../utils.dart';
import 'common.dart';

/// 自定义对话框组件
class VVCustomDialog extends StatelessWidget {
  const VVCustomDialog({
    Key? key,
    required this.title,
    required this.onConfirmTap,
    required this.confirmButtonText,
    required this.showCancelButton,
    required this.contentWidget,
    required this.width,
    required this.cancelButtonText,
  }) : super(key: key);

  /// 对话框标题
  final String title;

  /// 确认按钮文本
  final String confirmButtonText;

  /// 取消按钮文本
  final String cancelButtonText;

  /// 确认按钮点击回调
  final DialogTapCallBack onConfirmTap;

  /// 是否显示取消按钮
  final bool showCancelButton;

  /// 对话框内容组件
  final Widget contentWidget;

  /// 对话框宽度
  final double width;

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
            // 对话框标题
            Text(
              title,
              style: dialogTitleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),

            // 对话框内容组件
            contentWidget,
            SizedBox(height: dialogSpacer),

            // 确认和取消按钮
            buildDialogButton(context, () {
              onConfirmTap.call();
            },
                confirmButtonText: confirmButtonText,
                showCancelButton: showCancelButton,
                cancelButtonText: cancelButtonText)
          ],
        ),
      ),
    );
  }
}
