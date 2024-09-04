import 'package:flutter/material.dart';
import '../../../common.dart';
import '../../utils/jui_theme.dart';
import 'jui_dialog_config.dart';


class JuiBaseDialog extends StatelessWidget {
  final JuiDialogConfig config;
  final Widget? contentWidget;

  const JuiBaseDialog({
    Key? key,
    required this.config,
    this.contentWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
          width: JuiTheme.dimensions.dialogWidth,
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
                config.title,
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
      mainAxisAlignment: config.showCancelButton
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        if (config.showCancelButton)
          _buildButton(
            text: config.cancelButtonText,
            onTap: () {
              Navigator.pop(context);
              config.onCancel?.call();
            },
            colorType: JuiButtonColorType.gray,
          ),
        _buildButton(
          text: config.confirmButtonText,
          onTap: () {
            Navigator.pop(context);
            config.onConfirm?.call();
          },
          colorType: JuiButtonColorType.blue,
          width: config.showCancelButton
              ? JuiTheme.dimensions.dialogButtonWidth
              : JuiTheme.dimensions.dialogWideButtonWidth,
        ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onTap,
    required JuiButtonColorType colorType,
    double? width,
  }) {
    return JuiButton(
      onTap: onTap,
      text: text,
      colorType: colorType,
      sizeType: JuiButtonSizeType.middle,
      width: width ?? JuiTheme.dimensions.dialogButtonWidth,
    );
  }
}