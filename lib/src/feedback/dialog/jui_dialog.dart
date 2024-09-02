import 'package:flutter/material.dart';
import 'standard_dialog.dart';
import 'custom_dialog.dart';
import 'input_dialog.dart';
import 'dialog_constants.dart';

enum JUIDialogType { standard, input, custom }

typedef OnDialogTapCallBack = void Function();
typedef ConfirmInputCallBack = void Function(String);

void showJUIDialog(
    BuildContext context, {
      required JUIDialogType type,
      String? title = "",
      String? content,
      String confirmButtonText = "确定",
      String cancelButtonText = "取消",
      bool showCancelButton = true,
      Widget contentWidget = const SizedBox(),
      double dialogWidth = DialogConstants.dialogWidth,
      OnDialogTapCallBack? onConfirmTap,
      OnDialogTapCallBack? onCancelTap,
      ConfirmInputCallBack? onConfirmTapWithInput,
      TextEditingController? textController,
      bool allowEmoji = true,
      int? maxLength,
      FocusNode? focusNode,
      ValueChanged<String>? onChange,
      String? hintText,
    }) {
  Widget dialog;
  switch (type) {
    case JUIDialogType.custom:
      dialog = _buildCustomDialog(
        title: title!,
        onConfirmTap: onConfirmTap,
        onCancelTap: onCancelTap,
        confirmButtonText: confirmButtonText,
        cancelButtonText: cancelButtonText,
        showCancelButton: showCancelButton,
        contentWidget: contentWidget,
        dialogWidth: dialogWidth,
      );
      break;
    case JUIDialogType.standard:
      dialog = _buildStandardDialog(
        title: title!,
        content: content??"",
        onConfirmTap: onConfirmTap,
        onCancelTap: onCancelTap,
        confirmButtonText: confirmButtonText,
        cancelButtonText: cancelButtonText,
        showCancelButton: showCancelButton,
        dialogWidth: dialogWidth,
      );
      break;
    case JUIDialogType.input:
      dialog = _buildInputDialog(
        title: title!,
        onConfirmTapWithInput: onConfirmTapWithInput,
        onCancelTap: onCancelTap,
        confirmButtonText: confirmButtonText,
        cancelButtonText: cancelButtonText,
        showCancelButton: showCancelButton,
        dialogWidth: dialogWidth,
        hintText: hintText ?? "请输入",
        maxLength: maxLength,
        textController: textController ?? TextEditingController(),
        focusNode: focusNode,
        allowEmoji: allowEmoji,
        onChange: onChange,
      );
      break;
    default:
      throw ArgumentError('Unknown dialog type: $type');
  }
  showDialog(context: context, builder: (context) => dialog);
}

Widget _buildCustomDialog({
  required String title,
  required OnDialogTapCallBack? onConfirmTap,
  required OnDialogTapCallBack? onCancelTap,
  required String confirmButtonText,
  required String cancelButtonText,
  required bool showCancelButton,
  required Widget contentWidget,
  required double dialogWidth,
}) {
  return JUICustomDialog(
    title: title,
    onConfirm: onConfirmTap ?? () {},
    onCancel: onCancelTap ?? () {},
    confirmButtonText: confirmButtonText,
    cancelButtonText: cancelButtonText,
    showCancelButton: showCancelButton,
    contentWidget: contentWidget,
    dialogWidth: dialogWidth,
  );
}

Widget _buildStandardDialog({
  required String title,
  required String content,
  required OnDialogTapCallBack? onConfirmTap,
  required OnDialogTapCallBack? onCancelTap,
  required String confirmButtonText,
  required String cancelButtonText,
  required bool showCancelButton,
  required double dialogWidth,
}) {
  return JUIStandardDialog(
    title: title,
    content: content,
    onConfirm: onConfirmTap ?? () {},
    onCancel: onCancelTap ?? () {},
    confirmButtonText: confirmButtonText,
    cancelButtonText: cancelButtonText,
    showCancelButton: showCancelButton,
    dialogWidth: dialogWidth,
  );
}

Widget _buildInputDialog({
  required String title,
  required ConfirmInputCallBack? onConfirmTapWithInput,
  required OnDialogTapCallBack? onCancelTap,
  required String confirmButtonText,
  required String cancelButtonText,
  required bool showCancelButton,
  required double dialogWidth,
  required String hintText,
  required TextEditingController textController,
  int? maxLength,
  FocusNode? focusNode,
  required bool allowEmoji,
  ValueChanged<String>? onChange,
}) {
  return JUIInputDialog(
    title: title,
    onConfirm: onConfirmTapWithInput ?? (_) {},
    onCancel: onCancelTap ?? () {},
    confirmButtonText: confirmButtonText,
    cancelButtonText: cancelButtonText,
    showCancelButton: showCancelButton,
    dialogWidth: dialogWidth,
    hintText: hintText,
    maxLength: maxLength,
    textController: textController,
    focusNode: focusNode,
    allowEmoji: allowEmoji,
    onChange: onChange,
  );
}