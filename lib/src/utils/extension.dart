import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension JuiPath on String {
  String get path => "packages/jui/$this";
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
