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
    final buttonContent = Container(
      height: height ?? _sizeConfig[sizeType]!.height,
      width: width,
      padding: width == null ? EdgeInsets.symmetric(horizontal: _sizeConfig[sizeType]!.padding) : null,
      decoration: BoxDecoration(
        color: backGroundColor ?? _colorConfig[colorType]!.getColor(disable),
        borderRadius: BorderRadius.circular(circular),
        border: _colorConfig[colorType]!.border,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: _colorConfig[colorType]!.getFontColor(disable),
          fontSize: fontSize ?? _sizeConfig[sizeType]!.fontSize,
          height: fontHeight,
        ),
      ),
    );

    return width == double.infinity ? buttonContent : UnconstrainedBox(child: buttonContent);
  }

  static final Map<JuiButtonSizeType, _ButtonSizeConfig> _sizeConfig = {
    JuiButtonSizeType.large: _ButtonSizeConfig(height: 48, fontSize: 16, padding: 32),
    JuiButtonSizeType.middle: _ButtonSizeConfig(height: 40, fontSize: 14, padding: 24),
    JuiButtonSizeType.small: _ButtonSizeConfig(height: 32, fontSize: 14, padding: 16),
    JuiButtonSizeType.ultraSmall: _ButtonSizeConfig(height: 24, fontSize: 12, padding: 12),
  };

  static final Map<JuiButtonColorType, _ButtonColorConfig> _colorConfig = {
    JuiButtonColorType.white: _ButtonColorConfig(
      getColor: (_) => JuiColors().surface,
      getFontColor: (disable) => disable ? JuiColors().disabledLight : JuiColors().text,
      border: Border.all(color: JuiColors().divider, width: 1),
    ),
    JuiButtonColorType.gray: _ButtonColorConfig(
      getColor: (_) => JuiColors().background,
      getFontColor: (disable) => disable ? JuiColors().disabledLight : JuiColors().text,
    ),
    JuiButtonColorType.blue: _ButtonColorConfig(
      getColor: (disable) => disable ? JuiColors().lightBlue : JuiColors().primary,
      getFontColor: (_) => JuiColors().surface,
    ),
    JuiButtonColorType.blueBorder: _ButtonColorConfig(
      getColor: (_) => JuiColors().surface,
      getFontColor: (_) => JuiColors().primary,
      border: Border.all(color: JuiColors().primary, width: 1),
    ),
  };
}

class _ButtonSizeConfig {
  final double height;
  final double fontSize;
  final double padding;

  _ButtonSizeConfig({required this.height, required this.fontSize, required this.padding});
}

class _ButtonColorConfig {
  final Color Function(bool disable) getColor;
  final Color Function(bool disable) getFontColor;
  final BoxBorder? border;

  _ButtonColorConfig({required this.getColor, required this.getFontColor, this.border});
}