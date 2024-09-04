import 'dart:ui';

class JuiDialogConfig {
  final String title;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool showCancelButton;
  final double dialogWidth;

  JuiDialogConfig({
    this.title = "",
    this.confirmButtonText = "确定",
    this.cancelButtonText = "取消",
    this.onConfirm,
    this.onCancel,
    this.showCancelButton = true,
    this.dialogWidth = 327,
  });

  JuiDialogConfig copyWith({
    String? title,
    String? confirmButtonText,
    String? cancelButtonText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool? showCancelButton,
    double? dialogWidth,
  }) {
    return JuiDialogConfig(
      title: title ?? this.title,
      confirmButtonText: confirmButtonText ?? this.confirmButtonText,
      cancelButtonText: cancelButtonText ?? this.cancelButtonText,
      onConfirm: onConfirm ?? this.onConfirm,
      onCancel: onCancel ?? this.onCancel,
      showCancelButton: showCancelButton ?? this.showCancelButton,
      dialogWidth: dialogWidth ?? this.dialogWidth,
    );
  }
}
