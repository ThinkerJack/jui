// jui_theme.dart

import 'package:flutter/material.dart';

class JUITheme {
  JUITheme._();

  static const JUIColors colors = JUIColors();
  static const JUITextStyles textStyles = JUITextStyles();
  static const JUIDimensions dimensions = JUIDimensions();
}

class JUITextStyles {
  const JUITextStyles();

  TextStyle get itemTitle => const TextStyle(
        color: Color(0xFF858B9B),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  TextStyle get itemTitleDisabled => const TextStyle(
        color: Color(0xFFBCC1CD),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  TextStyle get itemHint => const TextStyle(
        color: Color(0xFFBCC1CD),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  TextStyle get itemHintDisabled => const TextStyle(
        color: Color(0xFFDCE0E8),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  TextStyle get itemContent => const TextStyle(
        color: Color(0xFF2A2F3C),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  TextStyle get dialogContent => const TextStyle(
        decoration: TextDecoration.none,
        color: Color(0xFF858B9B),
        fontSize: 14,
        height: 1.5,
      );

  TextStyle get dialogTitle => const TextStyle(
        decoration: TextDecoration.none,
        color: Color(0xFF2A2F3C),
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w500,
      );

  TextStyle get dialogHint => const TextStyle(
        color: Color(0xFFBCC1CD),
        fontSize: 16,
        height: 1.3,
      );

  TextStyle get sectionTitle => const TextStyle(
        fontSize: 16,
        color: Color(0xFF2A2F3C),
        fontWeight: FontWeight.w500,
      );

  TextStyle get noContent => const TextStyle(
        color: Color(0XFF858B9B),
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 1.5,
      );
}

class JUIDimensions {
  const JUIDimensions();

  static const double itemPaddingL = 20.0;
  static const double itemPaddingR = 20.0;
  static const double itemPaddingV = 16.0;

  // 新添加的尺寸
  static const double dialogWidth = 327.0;
  static const double dialogMarginTop = 24.0;
  static const double dialogSpacer = 20.0;
  static const double dialogButtonWidth = 130.0;
  static const double dialogWideButtonWidth = 270.0;
}

class JUIColors {
  const JUIColors();

  // 主要颜色
  final Color primary = const Color(0xFF5590F6);
  final Color secondary = const Color(0xFFFFA22D);
  final Color success = const Color(0xFF44C69D);
  final Color error = const Color(0xFFF55656);

  // 文本颜色
  final Color text = const Color(0xFF2A2F3C);
  final Color textSecondary = const Color(0xFF858B9B);

  // 背景颜色
  final Color background = const Color(0xFFF6F7F8);
  final Color surface = Colors.white;

  // 边框和分割线颜色
  final Color divider = const Color(0xFFE8EAEF);
  final Color border = const Color(0xFFE5E5E5);

  // 禁用状态颜色
  final Color disabled = const Color(0xFFBCC1CD);
  final Color disabledLight = const Color(0xFFDCE0E8);

  // 特殊用途颜色
  final Color tips = const Color(0xFFF55656);
  final Color dialogText = const Color(0xFF212123);

  // 其他颜色
  final Color lightBlue = const Color(0xFFC7DDFF);
  final Color lighterBlue = const Color(0xFFEEF4FE);
  final Color lightGray = const Color(0xFFFAFAFA);

  // 带透明度的颜色变体
  Color get primaryWithOpacity => const Color(0x145590F6);

  Color get secondaryWithOpacity => const Color(0x14FFA22D);

  Color get successWithOpacity => const Color(0x1444C69D);

  Color get errorWithOpacity => const Color(0x14F55656);

  // 保留原有的颜色常量名称，以确保向后兼容性
  Color get uiFFA22D => secondary;

  Color get ui5590F6 => primary;

  Color get uiC7DDFF => lightBlue;

  Color get uiEEF4FE => lighterBlue;

  Color get ui2A2F3C => text;

  Color get ui858B9B => textSecondary;

  Color get uiBCC1CD => disabled;

  Color get uiDCE0E8 => disabledLight;

  Color get uiE8EAEF => divider;

  Color get uiF6F7F8 => background;

  Color get uiFFFFFF => surface;

  Color get uiF55656 => error;

  Color get uiFAFAFA => lightGray;

  Color get uiE5E5E5 => border;

  Color get ui44C69D => success;

  Color get ui145590F6 => primaryWithOpacity;

  Color get ui1444C69D => successWithOpacity;

  Color get ui14FFA22D => secondaryWithOpacity;

  Color get ui14F55656 => errorWithOpacity;
}
