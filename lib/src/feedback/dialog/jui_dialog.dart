import 'package:flutter/material.dart';

import '../../utils/jui_theme.dart';
import 'jui_custom_dialog.dart';
import 'jui_input_dialog.dart';
import 'jui_standard_dialog.dart';

enum JuiDialogType { standard, input, custom }

typedef OnDialogTapCallback = void Function();
typedef ConfirmInputCallback = void Function(String);

class JuiDialogConfig {
  final String title;
  final String content;
  final String confirmButtonText;
  final String cancelButtonText;
  final bool showCancelButton;
  final Widget contentWidget;
  final double dialogWidth;
  final OnDialogTapCallback onConfirmTap;
  final OnDialogTapCallback onCancelTap;
  final ConfirmInputCallback onConfirmTapWithInput;
  final TextEditingController textController;
  final bool allowEmoji;
  final int? maxLength;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChange;
  final String hintText;

  JuiDialogConfig({
    String? title,
    String? content,
    String? confirmButtonText,
    String? cancelButtonText,
    bool? showCancelButton,
    Widget? contentWidget,
    double? dialogWidth,
    OnDialogTapCallback? onConfirmTap,
    OnDialogTapCallback? onCancelTap,
    ConfirmInputCallback? onConfirmTapWithInput,
    TextEditingController? textController,
    bool? allowEmoji,
    this.maxLength,
    this.focusNode,
    this.onChange,
    String? hintText,
  }) :
        title = title ?? "",
        content = content ?? "",
        confirmButtonText = confirmButtonText ?? "确定",
        cancelButtonText = cancelButtonText ?? "取消",
        showCancelButton = showCancelButton ?? true,
        contentWidget = contentWidget ?? const SizedBox(),
        dialogWidth = dialogWidth ?? JuiTheme.dimensions.dialogWidth,
        onConfirmTap = onConfirmTap ?? (() {}),
        onCancelTap = onCancelTap ?? (() {}),
        onConfirmTapWithInput = onConfirmTapWithInput ?? ((_) {}),
        textController = textController ?? TextEditingController(),
        allowEmoji = allowEmoji ?? true,
        hintText = hintText ?? "请输入";
}

void showJuiDialog(
    BuildContext context,
    JuiDialogType type,
    JuiDialogConfig config,
    ) {
  Widget dialog;
  switch (type) {
    case JuiDialogType.custom:
      dialog = JuiCustomDialog(
        title: config.title,
        onConfirm: config.onConfirmTap,
        onCancel: config.onCancelTap,
        confirmButtonText: config.confirmButtonText,
        cancelButtonText: config.cancelButtonText,
        showCancelButton: config.showCancelButton,
        contentWidget: config.contentWidget,
        dialogWidth: config.dialogWidth,
      );
      break;
    case JuiDialogType.standard:
      dialog = JuiStandardDialog(
        title: config.title,
        content: config.content,
        onConfirm: config.onConfirmTap,
        onCancel: config.onCancelTap,
        confirmButtonText: config.confirmButtonText,
        cancelButtonText: config.cancelButtonText,
        showCancelButton: config.showCancelButton,
        dialogWidth: config.dialogWidth,
      );
      break;
    case JuiDialogType.input:
      dialog = JuiInputDialog(
        title: config.title,
        onConfirm: config.onConfirmTapWithInput,
        onCancel: config.onCancelTap,
        confirmButtonText: config.confirmButtonText,
        cancelButtonText: config.cancelButtonText,
        showCancelButton: config.showCancelButton,
        dialogWidth: config.dialogWidth,
        hintText: config.hintText,
        maxLength: config.maxLength,
        textController: config.textController,
        focusNode: config.focusNode,
        allowEmoji: config.allowEmoji,
        onChange: config.onChange,
      );
      break;
  }
  showDialog(context: context, builder: (context) => dialog);
}