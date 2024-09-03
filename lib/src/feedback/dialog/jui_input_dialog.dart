import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/color.dart';
import 'jui_base_dialog.dart';
import 'dialog_constants.dart';

class JuiInputDialog extends JuiBaseDialog {
  JuiInputDialog({
    Key? key,
    required String title,
    required ValueChanged<String> onConfirm,
    required VoidCallback onCancel,
    required String confirmButtonText,
    required String cancelButtonText,
    required bool showCancelButton,
    required double dialogWidth,
    required String hintText,
    required TextEditingController textController,
    bool allowEmoji = true,
    int? maxLength,
    FocusNode? focusNode,
    ValueChanged<String>? onChange,
  }) : super(
    key: key,
    title: title,
    confirmButtonText: confirmButtonText,
    cancelButtonText: cancelButtonText,
    onConfirm: () => onConfirm(textController.text),
    onCancel: onCancel,
    showCancelButton: showCancelButton,
    contentWidget: _InputField(
      maxLength: maxLength,
      focusNode: focusNode,
      allowEmoji: allowEmoji,
      hintText: hintText,
      textController: textController,
      onChange: onChange,
    ),
    dialogWidth: dialogWidth,
  );
}

class _InputField extends StatelessWidget {
  const _InputField({
    Key? key,
    this.maxLength,
    this.focusNode,
    required this.allowEmoji,
    required this.hintText,
    required this.textController,
    this.onChange,
  }) : super(key: key);

  final int? maxLength;
  final FocusNode? focusNode;
  final bool allowEmoji;
  final String hintText;
  final TextEditingController textController;
  final ValueChanged<String>? onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: DialogConstants.borderColor, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        scrollPhysics: const ClampingScrollPhysics(),
        controller: textController,
        maxLength: maxLength,
        maxLines: 1,
        style: const TextStyle(
          color: DialogConstants.textColor,
          fontSize: 16,
          height: 1.5,
        ),
        inputFormatters: allowEmoji ? null : [FilteringTextInputFormatter.deny(RegExp(_regexEmoji))],
        focusNode: focusNode,
        onChanged: onChange,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: DialogConstants.hintTextStyle,
          counterText: '',
        ),
      ),
    );
  }

  static const String _regexEmoji =
      r'[^\u0020-\u007E\u00A0-\u00BE\u2E80-\uA4CF\uF900-\uFAFF\uFE30-\uFE4F\uFF00-\uFFEF\u0080-\u009F\u2000-\u201f\r\n]';
}