import 'package:flutter/material.dart';

import 'jui_custom_dialog.dart';
import 'jui_dialog_config.dart';
import 'jui_input_dialog.dart';
import 'jui_standard_dialog.dart';

enum JuiDialogType { standard, input, custom }

void showJuiDialog(
  BuildContext context, // 上下文环境，用于构建对话框
  JuiDialogType type, // 对话框类型，定义对话框的样式和行为
  JuiDialogConfig config, {
  // 对话框配置，包含对话框的设置选项
  String? content, // 对话框内容，可选字符串
  Widget? customContent, // 自定义对话框内容，可选的Widget
  String? hintText, // 提示文本，用于指导用户输入
  TextEditingController? textController, // 文本控制器，用于管理文本输入
  bool allowEmoji = true, // 是否允许输入表情，默认为true
  int? maxLength, // 输入内容的最大长度，可选
  FocusNode? focusNode, // 焦点节点，用于控制文本输入框的焦点
  ValueChanged<String>? onChange, // 文本变化回调函数，当文本改变时调用
  ConfirmInputCallback? onConfirmInput, // 确认输入回调函数，当用户确认输入时调用
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
