// screen_util.dart
import 'package:flutter/material.dart';

class UIScreenUtil {
  static double? _screenWidth;
  static double? _screenHeight;
  static double? _devicePixelRatio;
  static double? _statusBarHeight;
  static double? _bottomBarHeight;

  // 设计稿尺寸
  static const double _designWidth = 375;
  static const double _designHeight = 812;

  static void _initIfNeeded() {
    if (_screenWidth == null) {
      final window = WidgetsBinding.instance.window;
      final physicalSize = window.physicalSize;
      final ratio = window.devicePixelRatio;

      _devicePixelRatio = ratio;
      _screenWidth = physicalSize.width / ratio;
      _screenHeight = physicalSize.height / ratio;

      final padding = window.padding;
      _statusBarHeight = padding.top / ratio;
      _bottomBarHeight = padding.bottom / ratio;
    }
  }

  /// 获取屏幕宽度
  static double get screenWidth {
    _initIfNeeded();
    return _screenWidth!;
  }

  /// 获取屏幕高度
  static double get screenHeight {
    _initIfNeeded();
    return _screenHeight!;
  }

  /// 获取设备像素比
  static double get devicePixelRatio {
    _initIfNeeded();
    return _devicePixelRatio!;
  }

  /// 获取状态栏高度
  static double get statusBarHeight {
    _initIfNeeded();
    return _statusBarHeight!;
  }

  /// 获取底部安全区域高度
  static double get bottomBarHeight {
    _initIfNeeded();
    return _bottomBarHeight!;
  }

  /// 获取实际宽度
  static double setWidth(num width) {
    _initIfNeeded();
    return width * screenWidth / _designWidth;
  }

  /// 获取实际高度
  static double setHeight(num height) {
    _initIfNeeded();
    return height * screenHeight / _designHeight;
  }

  /// 获取字体大小
  static double setSp(num fontSize) {
    _initIfNeeded();
    return fontSize * screenWidth / _designWidth;
  }

  /// 获取宽度百分比
  static double setWp(num percentage) {
    _initIfNeeded();
    return percentage * screenWidth / 100;
  }

  /// 获取高度百分比
  static double setHp(num percentage) {
    _initIfNeeded();
    return percentage * screenHeight / 100;
  }
}

/// 数字扩展
extension NumExtension on num {
  double get w => UIScreenUtil.setWidth(this);

  double get h => UIScreenUtil.setHeight(this);

  double get sp => UIScreenUtil.setSp(this);

  double get wp => UIScreenUtil.setWp(this);

  double get hp => UIScreenUtil.setHp(this);

  EdgeInsets get spacing => EdgeInsets.all(w);

  EdgeInsets get spacingH => EdgeInsets.symmetric(horizontal: w);

  EdgeInsets get spacingV => EdgeInsets.symmetric(vertical: h);

  BorderRadius get radius => BorderRadius.circular(w);
}
