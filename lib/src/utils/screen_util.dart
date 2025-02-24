// screen_util.dart
import 'dart:ui';
import 'package:flutter/material.dart';

/// `UIScreenUtil` 用于屏幕适配，提供获取屏幕尺寸、状态栏高度、
/// 以及基于设计稿的尺寸计算方法。
class UIScreenUtil {
  static double? _screenWidth;
  static double? _screenHeight;
  static double? _devicePixelRatio;
  static double? _statusBarHeight;
  static double? _bottomBarHeight;

  /// 设计稿的标准宽度
  static const double _designWidth = 375;

  /// 设计稿的标准高度
  static const double _designHeight = 812;

  /// 初始化屏幕参数（如果未初始化）
  static void _initIfNeeded() {
    if (_screenWidth == null) {
      final FlutterView view = PlatformDispatcher.instance.views.first;
      final Size physicalSize = view.physicalSize;
      final double ratio = view.devicePixelRatio;

      _devicePixelRatio = ratio;
      _screenWidth = physicalSize.width / ratio;
      _screenHeight = physicalSize.height / ratio;

      final ViewPadding padding = view.viewInsets;
      _statusBarHeight = padding.top / ratio;
      _bottomBarHeight = padding.bottom / ratio;
    }
  }

  /// 获取屏幕宽度（逻辑像素）
  static double get screenWidth {
    _initIfNeeded();
    return _screenWidth!;
  }

  /// 获取屏幕高度（逻辑像素）
  static double get screenHeight {
    _initIfNeeded();
    return _screenHeight!;
  }

  /// 获取设备像素比（`devicePixelRatio`）
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

  /// 根据设计稿宽度计算实际宽度
  ///
  /// - [width]：设计稿上的宽度
  /// - 返回值：适配后的实际宽度（逻辑像素）
  static double setWidth(num width) {
    _initIfNeeded();
    return width * screenWidth / _designWidth;
  }

  /// 根据设计稿高度计算实际高度
  ///
  /// - [height]：设计稿上的高度
  /// - 返回值：适配后的实际高度（逻辑像素）
  static double setHeight(num height) {
    _initIfNeeded();
    return height * screenHeight / _designHeight;
  }

  /// 根据设计稿字体大小计算实际字体大小
  ///
  /// - [fontSize]：设计稿上的字体大小
  /// - 返回值：适配后的实际字体大小
  static double setSp(num fontSize) {
    _initIfNeeded();
    return fontSize * screenWidth / _designWidth;
  }

  /// 计算屏幕宽度的百分比
  ///
  /// - [percentage]：占屏幕宽度的百分比（0-100）
  /// - 返回值：计算后的宽度（逻辑像素）
  static double setWp(num percentage) {
    _initIfNeeded();
    return percentage * screenWidth / 100;
  }

  /// 计算屏幕高度的百分比
  ///
  /// - [percentage]：占屏幕高度的百分比（0-100）
  /// - 返回值：计算后的高度（逻辑像素）
  static double setHp(num percentage) {
    _initIfNeeded();
    return percentage * screenHeight / 100;
  }
}

/// `NumExtension` 为 `num` 类型提供屏幕适配的扩展方法
///
/// 这些方法允许开发者直接在数值上使用 `.w`、`.h` 等属性进行适配计算
extension NumExtension on num {
  /// 计算适配后的宽度（等同于 `UIScreenUtil.setWidth(this)`）
  double get w => UIScreenUtil.setWidth(this);

  /// 计算适配后的高度（等同于 `UIScreenUtil.setHeight(this)`）
  double get h => UIScreenUtil.setHeight(this);

  /// 计算适配后的字体大小（等同于 `UIScreenUtil.setSp(this)`）
  double get sp => UIScreenUtil.setSp(this);

  /// 计算适配后的宽度百分比（等同于 `UIScreenUtil.setWp(this)`）
  double get wp => UIScreenUtil.setWp(this);

  /// 计算适配后的高度百分比（等同于 `UIScreenUtil.setHp(this)`）
  double get hp => UIScreenUtil.setHp(this);

  /// 生成基于宽度的 `EdgeInsets`（等同于 `EdgeInsets.all(w)`）
  EdgeInsets get spacing => EdgeInsets.all(w);

  /// 生成基于宽度的水平 `EdgeInsets`（等同于 `EdgeInsets.symmetric(horizontal: w)`）
  EdgeInsets get spacingH => EdgeInsets.symmetric(horizontal: w);

  /// 生成基于高度的垂直 `EdgeInsets`（等同于 `EdgeInsets.symmetric(vertical: h)`）
  EdgeInsets get spacingV => EdgeInsets.symmetric(vertical: h);

  /// 生成基于宽度的 `BorderRadius`（等同于 `BorderRadius.circular(w)`）
  BorderRadius get radius => BorderRadius.circular(w);
}
