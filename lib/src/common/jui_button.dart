import 'package:flutter/material.dart';
import '../utils/jui_theme.dart';

enum JuiButtonSizeType { large, middle, small, ultraSmall }
enum JuiButtonColorType { blue, gray, white, blueBorder }

class JuiButtonSizeConfig {
  final double height;
  final double fontSize;
  final double padding;

  const JuiButtonSizeConfig({required this.height, required this.fontSize, required this.padding});
}

class JuiButtonColorConfig {
  final Color Function(bool disable) getColor;
  final Color Function(bool disable) getFontColor;
  final BoxBorder? border;

  const JuiButtonColorConfig({required this.getColor, required this.getFontColor, this.border});
}

class JuiButton extends StatelessWidget {
  static final Map<JuiButtonSizeType, JuiButtonSizeConfig> _sizeConfig = {
    JuiButtonSizeType.large: const JuiButtonSizeConfig(height: 48, fontSize: 16, padding: 32),
    JuiButtonSizeType.middle: const JuiButtonSizeConfig(height: 40, fontSize: 14, padding: 24),
    JuiButtonSizeType.small: const JuiButtonSizeConfig(height: 32, fontSize: 14, padding: 16),
    JuiButtonSizeType.ultraSmall: const JuiButtonSizeConfig(height: 24, fontSize: 12, padding: 12),
  };

  static Map<JuiButtonColorType, JuiButtonColorConfig> get _colorConfig => {
    JuiButtonColorType.white: JuiButtonColorConfig(
      getColor: (_) => JuiTheme.colors.surface,
      getFontColor: (disable) => disable ? JuiTheme.colors.disabledLight : JuiTheme.colors.text,
      border: Border.all(color: JuiTheme.colors.divider, width: 1),
    ),
    JuiButtonColorType.gray: JuiButtonColorConfig(
      getColor: (_) => JuiTheme.colors.background,
      getFontColor: (disable) => disable ? JuiTheme.colors.disabledLight : JuiTheme.colors.text,
    ),
    JuiButtonColorType.blue: JuiButtonColorConfig(
      getColor: (disable) => disable ? JuiTheme.colors.lightBlue : JuiTheme.colors.primary,
      getFontColor: (_) => JuiTheme.colors.surface,
    ),
    JuiButtonColorType.blueBorder: JuiButtonColorConfig(
      getColor: (_) => JuiTheme.colors.surface,
      getFontColor: (_) => JuiTheme.colors.primary,
      border: Border.all(color: JuiTheme.colors.primary, width: 1),
    ),
  };

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

  static void updateSizeConfig(JuiButtonSizeType type, JuiButtonSizeConfig config) {
    _sizeConfig[type] = config;
  }

  @override
  Widget build(BuildContext context) {
    if (!visibility) return const SizedBox.shrink();

    return InkWell(
      onTap: disable ? null : onTap,
      child: _buildButtonContainer(),
    );
  }

  Widget _buildButtonContainer() {
    final sizeConfig = _sizeConfig[sizeType]!;
    final colorConfig = _colorConfig[colorType]!;

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