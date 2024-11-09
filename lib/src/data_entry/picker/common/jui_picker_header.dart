import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../utils/jui_theme.dart';
import 'jui_picker_widget.dart';

class JuiPickerHeader extends StatelessWidget {
  final String? title;
  final String? titleLeftText;
  final String? titleRightText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final TextStyle? rightTextStyle;
  final TextStyle? leftTextStyle;

  const JuiPickerHeader({
    Key? key,
    this.title,
    this.titleLeftText,
    this.titleRightText,
    this.onCancel,
    this.onConfirm,
    this.rightTextStyle,
    this.leftTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTextButton(onCancel, titleLeftText ?? '', leftTextStyle ?? JuiTheme.textStyles.pickerCancel),
            Expanded(
              child: Text(
                title ?? '',
                style: JuiTheme.textStyles.pickerTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            _buildTextButton(onConfirm, titleRightText ?? '', rightTextStyle ?? JuiTheme.textStyles.pickerConfirm),
          ],
        ),
        const JuiPickerDivider()
      ],
    );
  }

  Widget _buildTextButton(VoidCallback? onTap, String text, TextStyle? textStyle) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(text, style: textStyle),
    );
  }
}
