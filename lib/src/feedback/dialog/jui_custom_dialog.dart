import 'package:flutter/cupertino.dart';
import 'package:jui/src/feedback/dialog/jui_base_dialog.dart';

typedef OnDialogTapCallBack = void Function();
typedef ConfirmInputCallBack = void Function(String);

/// 自定义对话框组件
class JuiCustomDialog extends JuiBaseDialog {
  const JuiCustomDialog({
    Key? key,
    required String title,
    required OnDialogTapCallBack onConfirm,
    required OnDialogTapCallBack onCancel,
    required String confirmButtonText,
    required String cancelButtonText,
    required bool showCancelButton,
    required Widget contentWidget,
    required double dialogWidth,
  }) : super(
          key: key,
          title: title,
          confirmButtonText: confirmButtonText,
          cancelButtonText: cancelButtonText,
          onConfirm: onConfirm,
          onCancel: onCancel,
          showCancelButton: showCancelButton,
          contentWidget: contentWidget,
          dialogWidth: dialogWidth,
        );
}
