import 'package:flutter/cupertino.dart';
import 'package:jui/src/utils/jui_theme.dart';

import 'jui_base_dialog.dart';

class JuiStandardDialog extends JuiBaseDialog {
  JuiStandardDialog({
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
                  style: JuiTheme.textStyles.dialogContent,
                ),
          dialogWidth: dialogWidth,
        );
}
