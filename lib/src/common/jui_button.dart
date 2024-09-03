import 'package:flutter/material.dart';
import '../utils/jui_theme.dart';

enum JuiButtonSizeType { large, middle, small, ultraSmall }
enum JuiButtonColorType { blue, gray, white, blueBorder }

class JuiButton extends StatelessWidget {
  const JuiButton({
    Key? key,
    required this.colorType,
    required this.sizeType,
    required this.text,
    required this.onTap,
    this.visibility = true,
    this.width,
    this.fontSize,
    this.circular = 24,
    this.height,
    this.fontHeight = 1.0,
    this.disable = false,
    this.backGroundColor,
  }) : super(key: key);

  final VoidCallback onTap;
  final String text;
  final JuiButtonSizeType sizeType;
  final JuiButtonColorType colorType;
  final bool visibility;
  final bool disable;
  final double? width;
  final double? height;
  final double? fontSize;
  final double circular;
  final double fontHeight;
  final Color? backGroundColor;

  @override
  Widget build(BuildContext context) {
    if (!visibility) return const SizedBox.shrink();

    return InkWell(
      onTap: disable ? null : onTap,
      child: _buildButtonContainer(),
    );
  }

  Widget _buildButtonContainer() {
    final sizeConfig = JuiTheme.buttonConfig.sizeConfig[sizeType]!;
    final colorConfig = JuiTheme.buttonConfig.colorConfig[colorType]!;

    final buttonContent = Container(
      height: height ?? sizeConfig.height,
      width: width,
      padding: width == null ? EdgeInsets.symmetric(horizontal: sizeConfig.padding) : null,
      decoration: BoxDecoration(
        color: backGroundColor ?? colorConfig.getColor(disable),
        borderRadius: BorderRadius.circular(circular),
        border: colorConfig.border,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: colorConfig.getFontColor(disable),
          fontSize: fontSize ?? sizeConfig.fontSize,
          height: fontHeight,
        ),
      ),
    );

    return width == double.infinity ? buttonContent : UnconstrainedBox(child: buttonContent);
  }
}