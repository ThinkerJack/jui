import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension Path on String {
  String get path => "packages/vv_ui_kit/${this}";
}

extension ValueListenableExtension<T> on ValueListenable<T> {
  ValueListenableBuilder<T> listen(Widget Function(T value) build) {
    return ValueListenableBuilder<T>(
      builder: (BuildContext context, T value, Widget? child) {
        return build.call(value);
      },
      valueListenable: this,
    );
  }
}
