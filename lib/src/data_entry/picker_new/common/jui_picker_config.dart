import 'package:flutter/cupertino.dart';

import '../select_picker/jui_select_picker_config.dart';


class JuiPickerHeaderConfig {
  final String? title;
  final Widget? customHeader;
  final String? cancelText;
  final String? confirmText;
  final TextStyle? cancelTextStyle;
  final TextStyle? confirmTextStyle;
  final bool? showHeader;
  final bool? showConfirmButton;

  const JuiPickerHeaderConfig({
    this.title,
    this.customHeader,
    this.cancelText = JuiSelectPickerUIHelper.defaultCancelText,
    this.confirmText = JuiSelectPickerUIHelper.defaultConfirmText,
    this.cancelTextStyle,
    this.confirmTextStyle,
    this.showHeader,
    this.showConfirmButton,
  });
}