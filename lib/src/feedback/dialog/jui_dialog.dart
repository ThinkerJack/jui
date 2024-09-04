import 'package:flutter/material.dart';

import 'jui_custom_dialog.dart';
import 'jui_dialog_config.dart';
import 'jui_input_dialog.dart';
import 'jui_standard_dialog.dart';

enum JuiDialogType { standard, input, custom }

void showJuiDialog(
  BuildContext context,
  JuiDialogType type,
  JuiDialogConfig config, {
  String? content,
  Widget? customContent,
  String? hintText,
  TextEditingController? textController,
  bool allowEmoji = true,
  int? maxLength,
  FocusNode? focusNode,
  ValueChanged<String>? onChange,
  ConfirmInputCallback? onConfirmInput,
}) {
  Widget dialog;
  switch (type) {
    case JuiDialogType.standard:
      dialog = JuiStandardDialog(
        config: config,
        content: content ?? "",
      );
      break;
    case JuiDialogType.input:
      dialog = JuiInputDialog(
        config: config,
        hintText: hintText ?? "请输入",
        textController: textController ?? TextEditingController(),
        allowEmoji: allowEmoji,
        maxLength: maxLength,
        focusNode: focusNode,
        onChange: onChange,
        onConfirmInput: onConfirmInput,
      );
      break;
    case JuiDialogType.custom:
      dialog = JuiCustomDialog(
        config: config,
        contentWidget: customContent ?? const SizedBox(),
      );
      break;
  }
  showDialog(context: context, builder: (context) => dialog);
}
