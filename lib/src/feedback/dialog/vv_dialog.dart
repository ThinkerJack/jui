import 'package:flutter/material.dart';
import 'package:jui/src/feedback/dialog/simple_dialog.dart';
import 'package:jui/src/feedback/dialog/title_dialog.dart';

import 'common.dart';
import 'custom_dialog.dart';
import 'input_dialog.dart';

/// 弹出框类型枚举
/// 常规对话框，带标题的对话框，带输入框的对话框，自定义对话框
enum VVDialogType { simple, title, input, custom, info }

/// 显示对话框的方法
/// 根据不同的类型展示相应的对话框
void showVVDialog(BuildContext context,
    {String? content,
    String? title,
    String? hintText,
    Widget? contentWidget,
    int? maxLength,
    double? width,
    bool? enableEmoji,
    String? confirmButtonText,
    String? cancelButtonText,
    required VVDialogType type,
    DialogTapCallBack? onConfirmTap,
    DialogTapCallBack? onCancelTap,
    InputConfirmTapCallBack? onConfirmTapWithInput,
    bool? showCancelButton}) {
  showDialog(
      context: context,
      builder: (context) => Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: _getDialogWidget(
            type: type,
            title: title ?? "",
            content: content ?? "",
            hintText: hintText ?? "",
            maxLength: maxLength ?? 20,
            confirmButtonText: confirmButtonText ?? "",
            cancelButtonText: cancelButtonText ?? "",
            onConfirmTap: onConfirmTap ?? () {},
            onCancelTap: onCancelTap ?? () {},
            onConfirmTapWithInput: onConfirmTapWithInput ?? (String data) {},
            enableEmoji: enableEmoji ?? false,
            showCancelButton: showCancelButton ?? true,
            contentWidget: contentWidget ?? Container(),
            width: width ?? dialogWidth,
          )));
}

/// 获取对应类型的对话框组件
Widget _getDialogWidget(
    {required String content,
    required String title,
    required String hintText,
    required Widget contentWidget,
    required String confirmButtonText,
    required String cancelButtonText,
    required int maxLength,
    required double width,
    required VVDialogType type,
    required DialogTapCallBack onConfirmTap,
    required DialogTapCallBack onCancelTap,
    required bool enableEmoji,
    required bool showCancelButton,
    required InputConfirmTapCallBack onConfirmTapWithInput}) {
  switch (type) {
    case VVDialogType.simple:
      return VVSimpleDialog(
        content: content,
        onConfirmTap: onConfirmTap,
        confirmButtonText: confirmButtonText,
        showCancelButton: showCancelButton,
        cancelButtonText: cancelButtonText,
        width: width,
      );
    case VVDialogType.title:
    case VVDialogType.info:
      return VVTitleDialog(
        content: content,
        onConfirmTap: onConfirmTap,
        onCancelTap: onCancelTap,
        title: title,
        confirmButtonText: confirmButtonText,
        showCancelButton: showCancelButton,
        cancelButtonText: cancelButtonText,
        width: width,
      );
    case VVDialogType.input:
      return VVInputDialog(
        content: content,
        onConfirmTap: onConfirmTapWithInput,
        title: title,
        maxLength: maxLength,
        enableEmoji: enableEmoji,
        confirmButtonText: confirmButtonText,
        width: width,
        hintText: hintText,
      );
    case VVDialogType.custom:
      return VVCustomDialog(
        title: title,
        onConfirmTap: onConfirmTap,
        confirmButtonText: confirmButtonText,
        showCancelButton: showCancelButton,
        contentWidget: contentWidget,
        cancelButtonText: cancelButtonText,
        width: width,
      );
  }
}
