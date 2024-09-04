import 'package:flutter/material.dart';
import '../../../common.dart';
import '../../utils/jui_theme.dart';

/// 自定义对话框组件基类
class JuiBaseDialog extends StatelessWidget {
  const JuiBaseDialog({
    Key? key,
    required this.title,
    required this.onConfirm,
    required this.confirmButtonText,
    required this.showCancelButton,
    required this.contentWidget,
    required this.dialogWidth,
    required this.cancelButtonText,
    required this.onCancel,
  }) : super(key: key);

  final String title;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final bool showCancelButton;
  final Widget? contentWidget;
  final double dialogWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
          width: dialogWidth,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: JuiTheme.colors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: JuiTheme.textStyles.dialogTitle,
                textAlign: TextAlign.center,
              ),
              if (contentWidget != null) ...[
                const SizedBox(height: 12),
                contentWidget!,
              ],
              SizedBox(height: JuiTheme.dimensions.dialogSpace),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: showCancelButton ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
      children: [
        if (showCancelButton)
          _buildButton(
            text: cancelButtonText,
            onTap: () {
              Navigator.pop(context);
              onCancel();
            },
            colorType: JuiButtonColorType.gray,
          ),
        _buildButton(
          text: confirmButtonText,
          onTap: () {
            Navigator.pop(context);
            onConfirm();
          },
          colorType: JuiButtonColorType.blue,
          width: showCancelButton ? JuiTheme.dimensions.dialogButtonWidth : JuiTheme.dimensions.dialogWideButtonWidth,
        ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onTap,
    required JuiButtonColorType colorType,
    double? width ,
  }) {
    return JuiButton(
      onTap: onTap,
      text: text,
      colorType: colorType,
      sizeType: JuiButtonSizeType.middle,
      width: width ??JuiTheme.dimensions.dialogButtonWidth ,
    );
  }
}