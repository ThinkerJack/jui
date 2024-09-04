import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../feedback.dart';
import '../../utils/jui_theme.dart';
import 'jui_base_dialog.dart';
import 'jui_dialog_config.dart';

typedef ConfirmInputCallback = void Function(String);

class JuiInputDialog extends StatelessWidget {
  final JuiDialogConfig config;
  final String hintText;
  final TextEditingController textController;
  final bool allowEmoji;
  final int? maxLength;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChange;
  final ConfirmInputCallback? onConfirmInput;

  const JuiInputDialog({
    Key? key,
    required this.config,
    required this.hintText,
    required this.textController,
    this.allowEmoji = true,
    this.maxLength,
    this.focusNode,
    this.onChange,
    this.onConfirmInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JuiBaseDialog(
      config: config.copyWith(
        onConfirm: () {
          onConfirmInput?.call(textController.text);
          config.onConfirm?.call();
        },
      ),
      contentWidget: _InputField(
        maxLength: maxLength,
        focusNode: focusNode,
        allowEmoji: allowEmoji,
        hintText: hintText,
        textController: textController,
        onChange: onChange,
      ),
    );
  }
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
        border: Border.all(color: JuiTheme.colors.primary, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        scrollPhysics: const ClampingScrollPhysics(),
        controller: textController,
        maxLength: maxLength,
        maxLines: 1,
        style: TextStyle(
          color: JuiTheme.colors.dialogText,
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
          hintStyle: JuiTheme.textStyles.dialogHint,
          counterText: '',
        ),
      ),
    );
  }

  static const String _regexEmoji =
      r'[^\u0020-\u007E\u00A0-\u00BE\u2E80-\uA4CF\uF900-\uFAFF\uFE30-\uFE4F\uFF00-\uFFEF\u0080-\u009F\u2000-\u201f\r\n]';
}
