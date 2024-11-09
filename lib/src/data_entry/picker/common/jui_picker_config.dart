import 'package:flutter/cupertino.dart';

import '../select_picker/jui_select_picker_config.dart';

class JuiPickerHeaderConfig {
// 定义一个可选的标题字符串
  final String? title;

  // 定义一个可选的自定义头部小部件
  final Widget? customHeader;

  // 定义一个可选的取消按钮文本
  final String? cancelText;

  // 定义一个可选的确认按钮文本
  final String? confirmText;

  // 定义一个可选的取消按钮文本样式
  final TextStyle? cancelTextStyle;

  // 定义一个可选的确认按钮文本样式
  final TextStyle? confirmTextStyle;

  // 定义一个可选的布尔值，用于控制是否显示头部
  final bool? showHeader;

  // 定义一个可选的布尔值，用于控制是否显示确认按钮
  final bool? showConfirmButton;

  final VoidCallback? tapConfirm;

  const JuiPickerHeaderConfig({
    this.title,
    this.customHeader,
    this.cancelText = JuiSelectPickerUIHelper.defaultCancelText,
    this.confirmText = JuiSelectPickerUIHelper.defaultConfirmText,
    this.cancelTextStyle,
    this.confirmTextStyle,
    this.showHeader,
    this.showConfirmButton,
    this.tapConfirm,
  });
}
