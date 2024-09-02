import 'package:flutter/cupertino.dart';

import 'base_dialog.dart';
import 'dialog_constants.dart';

class JUIStandardDialog extends JUiBaseDialog {
  JUIStandardDialog({
    Key? key,
    required String title,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
    required String confirmButtonText,
    required String cancelButtonText,
    required bool showCancelButton,
    required String content,
    required double dialogWidth,
  }) : super(
          key: key,
          title: title,
          confirmButtonText: confirmButtonText,
          cancelButtonText: cancelButtonText,
          onConfirm: onConfirm,
          onCancel: onCancel,
          showCancelButton: showCancelButton,
          contentWidget: content.isEmpty
              ? null
              : Text(
                  content,
                  style: DialogConstants.dialogContentStyle,
                ),
          dialogWidth: dialogWidth,
        );
}
