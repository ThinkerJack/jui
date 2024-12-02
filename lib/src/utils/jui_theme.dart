import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jui/src/utils/screen_util.dart';

class JuiTheme {
  static JuiColors? _colors;
  static JuiTextStyles? _textStyles;
  static JuiDimensions? _dimensions;

  static JuiColors get colors => _colors ??= const JuiColors();

  static JuiTextStyles get textStyles => _textStyles ??= JuiTextStyles();

  static JuiDimensions get dimensions => _dimensions ??= JuiDimensions();

  // 私有构造函数，防止实例化
  JuiTheme._();

  static void initialize({
    JuiColors? colors,
    JuiTextStyles? textStyles,
    JuiDimensions? dimensions,
  }) {
    _colors = colors;
    _textStyles = textStyles;
    _dimensions = dimensions;
  }

  static void updateTheme({
    JuiColors? colors,
    JuiTextStyles? textStyles,
    JuiDimensions? dimensions,
  }) {
    if (colors != null) _colors = colors;
    if (textStyles != null) _textStyles = textStyles;
    if (dimensions != null) _dimensions = dimensions;
  }
}

class FontWeightUtil {
  static FontWeight get regular => FontWeight.w400;

  static FontWeight get medium => Platform.isIOS ? FontWeight.w500 : FontWeight.w600;

  static FontWeight get semiBold => Platform.isIOS ? FontWeight.w600 : FontWeight.w700;
}

class JuiTextStyles {
  JuiTextStyles({
    TextStyle? itemTitle,
    TextStyle? itemTitleDisabled,
    TextStyle? itemHint,
    TextStyle? itemHintDisabled,
    TextStyle? itemContent,
    TextStyle? dialogContent,
    TextStyle? dialogTitle,
    TextStyle? dialogHint,
    TextStyle? sectionTitle,
    TextStyle? noContent,
    TextStyle? pickerConfirm,
    TextStyle? pickerCancel,
    TextStyle? pickerTitle,
  })  : itemTitle = itemTitle ??
            TextStyle(
              color: const Color(0xFF858B9B),
              fontSize: 14.sp,
              fontWeight: FontWeightUtil.regular,
            ),
        itemTitleDisabled = itemTitleDisabled ??
            TextStyle(
              color: const Color(0xFFBCC1CD),
              fontSize: 14.sp,
              fontWeight: FontWeightUtil.regular,
            ),
        itemHint = itemHint ??
            TextStyle(
              color: const Color(0xFFBCC1CD),
              fontSize: 16.sp,
              fontWeight: FontWeightUtil.regular,
              height: 1.3,
            ),
        itemHintDisabled = itemHintDisabled ??
            TextStyle(
              color: const Color(0xFFDCE0E8),
              fontSize: 16.sp,
              fontWeight: FontWeightUtil.regular,
              height: 1.3,
            ),
        itemContent = itemContent ??
            TextStyle(
              color: const Color(0xFF2A2F3C),
              fontSize: 16.sp,
              fontWeight: FontWeightUtil.regular,
              height: 1.3,
            ),
        dialogContent = dialogContent ??
            TextStyle(
              decoration: TextDecoration.none,
              color: const Color(0xFF858B9B),
              fontSize: 14.sp,
              height: 1.3,
            ),
        dialogTitle = dialogTitle ??
            TextStyle(
              decoration: TextDecoration.none,
              color: const Color(0xFF2A2F3C),
              fontSize: 17.sp,
              height: 1.3,
              fontWeight: FontWeightUtil.medium,
            ),
        pickerTitle = pickerTitle ??
            TextStyle(
              decoration: TextDecoration.none,
              color: const Color(0xFF2A2F3C),
              fontSize: 16.sp,
              height: 1.3,
              fontWeight: FontWeightUtil.medium,
            ),
        pickerConfirm = pickerConfirm ??
            TextStyle(
              decoration: TextDecoration.none,
              color: const Color(0xFF5590F6),
              fontSize: 14.sp,
              height: 1.3,
              fontWeight: FontWeightUtil.medium,
            ),
        pickerCancel = pickerCancel ??
            TextStyle(
              decoration: TextDecoration.none,
              color: const Color(0xFF858B9B),
              fontSize: 14.sp,
              height: 1.3,
              fontWeight: FontWeightUtil.regular,
            ),
        dialogHint = dialogHint ??
            TextStyle(
              color: const Color(0xFFBCC1CD),
              fontSize: 16.sp,
              height: 1.3,
            ),
        sectionTitle = sectionTitle ??
            TextStyle(
              fontSize: 16.sp,
              color: const Color(0xFF2A2F3C),
              fontWeight: FontWeightUtil.medium,
            ),
        noContent = noContent ??
            TextStyle(
              color: const Color(0XFF858B9B),
              fontWeight: FontWeightUtil.medium,
              fontSize: 16.sp,
              height: 1.3,
            );

  final TextStyle itemTitle;
  final TextStyle itemTitleDisabled;
  final TextStyle itemHint;
  final TextStyle itemHintDisabled;
  final TextStyle itemContent;
  final TextStyle dialogContent;
  final TextStyle dialogTitle;
  final TextStyle dialogHint;
  final TextStyle sectionTitle;
  final TextStyle noContent;
  final TextStyle pickerConfirm;
  final TextStyle pickerCancel;
  final TextStyle pickerTitle;

  JuiTextStyles copyWith({
    TextStyle? itemTitle,
    TextStyle? itemTitleDisabled,
    TextStyle? itemHint,
    TextStyle? itemHintDisabled,
    TextStyle? itemContent,
    TextStyle? dialogContent,
    TextStyle? dialogTitle,
    TextStyle? dialogHint,
    TextStyle? sectionTitle,
    TextStyle? noContent,
    TextStyle? pickerConfirm,
    TextStyle? pickerCancel,
    TextStyle? pickerTitle,
  }) {
    return JuiTextStyles(
      itemTitle: itemTitle ?? this.itemTitle,
      itemTitleDisabled: itemTitleDisabled ?? this.itemTitleDisabled,
      itemHint: itemHint ?? this.itemHint,
      itemHintDisabled: itemHintDisabled ?? this.itemHintDisabled,
      itemContent: itemContent ?? this.itemContent,
      dialogContent: dialogContent ?? this.dialogContent,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      dialogHint: dialogHint ?? this.dialogHint,
      sectionTitle: sectionTitle ?? this.sectionTitle,
      noContent: noContent ?? this.noContent,
      pickerConfirm: pickerConfirm ?? this.pickerConfirm,
      pickerCancel: pickerCancel ?? this.pickerCancel,
      pickerTitle: pickerTitle ?? this.pickerTitle,
    );
  }
}

class JuiDimensions {
  final double itemPaddingL;
  final double itemPaddingR;
  final double itemPaddingV;
  final double itemSpace;
  final double dialogWidth;
  final double dialogSpace;
  final double dialogButtonWidth;
  final double dialogWideButtonWidth;

  JuiDimensions({
    double? itemPaddingL,
    double? itemPaddingR,
    double? itemPaddingV,
    double? itemSpace,
    double? dialogWidth,
    double? dialogSpace,
    double? dialogButtonWidth,
    double? dialogWideButtonWidth,
  })  : itemPaddingL = 20.w,
        itemPaddingR = 20.w,
        itemPaddingV = 16.w,
        itemSpace = 4.w,
        dialogWidth = 327.w,
        dialogSpace = 20.w,
        dialogButtonWidth = 138.w,
        dialogWideButtonWidth = 287.w;

  JuiDimensions copyWith({
    double? itemPaddingL,
    double? itemPaddingR,
    double? itemPaddingV,
    double? itemSpace,
    double? dialogWidth,
    double? dialogMarginTop,
    double? dialogSpace,
    double? dialogButtonWidth,
    double? dialogWideButtonWidth,
  }) {
    return JuiDimensions(
      itemPaddingL: itemPaddingL,
      itemPaddingR: itemPaddingR,
      itemPaddingV: itemPaddingV,
      itemSpace: itemSpace,
      dialogWidth: dialogWidth,
      dialogSpace: dialogSpace,
      dialogButtonWidth: dialogButtonWidth,
      dialogWideButtonWidth: dialogWideButtonWidth,
    );
  }
}

class JuiColors {
  final Color primary;
  final Color secondary;
  final Color success;
  final Color error;
  final Color text;
  final Color textSecondary;
  final Color background;
  final Color surface;
  final Color divider;
  final Color border;
  final Color disabled;
  final Color disabledLight;
  final Color tips;
  final Color dialogText;
  final Color lightBlue;
  final Color lighterBlue;
  final Color lightGray;

  const JuiColors({
    this.primary = const Color(0xFF5590F6),
    this.secondary = const Color(0xFFFFA22D),
    this.success = const Color(0xFF44C69D),
    this.error = const Color(0xFFF55656),
    this.text = const Color(0xFF2A2F3C),
    this.textSecondary = const Color(0xFF858B9B),
    this.background = const Color(0xFFF6F7F8),
    this.surface = Colors.white,
    this.divider = const Color(0xFFE8EAEF),
    this.border = const Color(0xFFE5E5E5),
    this.disabled = const Color(0xFFBCC1CD),
    this.disabledLight = const Color(0xFFDCE0E8),
    this.tips = const Color(0xFFF55656),
    this.dialogText = const Color(0xFF212123),
    this.lightBlue = const Color(0xFFC7DDFF),
    this.lighterBlue = const Color(0xFFEEF4FE),
    this.lightGray = const Color(0xFFFAFAFA),
  });

  Color get primaryWithOpacity => primary.withOpacity(0.08);

  Color get secondaryWithOpacity => secondary.withOpacity(0.08);

  Color get successWithOpacity => success.withOpacity(0.08);

  Color get errorWithOpacity => error.withOpacity(0.08);

  JuiColors copyWith({
    Color? primary,
    Color? secondary,
    Color? success,
    Color? error,
    Color? text,
    Color? textSecondary,
    Color? background,
    Color? surface,
    Color? divider,
    Color? border,
    Color? disabled,
    Color? disabledLight,
    Color? tips,
    Color? dialogText,
    Color? lightBlue,
    Color? lighterBlue,
    Color? lightGray,
  }) {
    return JuiColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      error: error ?? this.error,
      text: text ?? this.text,
      textSecondary: textSecondary ?? this.textSecondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      divider: divider ?? this.divider,
      border: border ?? this.border,
      disabled: disabled ?? this.disabled,
      disabledLight: disabledLight ?? this.disabledLight,
      tips: tips ?? this.tips,
      dialogText: dialogText ?? this.dialogText,
      lightBlue: lightBlue ?? this.lightBlue,
      lighterBlue: lighterBlue ?? this.lighterBlue,
      lightGray: lightGray ?? this.lightGray,
    );
  }
}
