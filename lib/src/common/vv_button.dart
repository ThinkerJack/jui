import 'package:flutter/material.dart';

import '../utils/color.dart';

const double _defaultCircular = 24;

/// 按钮尺寸类型
enum JUIButtonSizeType { large, middle, small, ultraSmall }

/// 按钮颜色类型
enum JUIButtonColorType { blue, gray, white, blueBorder }

/// 按钮
class JUIButton extends StatelessWidget {
  const JUIButton({
    Key? key,
    required this.colorType,
    required this.sizeType,
    required this.text,
    required this.onTap,
    this.visibility,
    this.width,
    this.fontSize,
    this.circular,
    this.height,
    this.fontHeight,
    this.disable = false,
    this.backGroundColor,
  }) : super(key: key);

  final Function onTap; // 按钮点击事件
  final String text; // 按钮文本
  final JUIButtonSizeType sizeType; // 按钮尺寸类型
  final JUIButtonColorType colorType; // 按钮颜色类型
  final bool? visibility; // 按钮是否可见
  final bool disable; // 按钮是否禁用
  final double? width; // 按钮宽度
  final double? height; // 按钮高度
  final double? fontSize; // 按钮字体大小
  final double? circular; // 按钮圆角半径
  final double? fontHeight; // 按钮字体高度
  final Color? backGroundColor; // 按钮背景颜色

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility ?? true,
      child: InkWell(
        onTap: () {
          if (!disable) onTap();
        },
        child: hasUnconstrainedBox(
          Container(
            height: height ?? _getHeight(sizeType),
            width: width,
            padding: width == null ? EdgeInsets.symmetric(horizontal: _getPadding(sizeType)) : null,
            decoration: BoxDecoration(
              color: backGroundColor ?? _getContainerColor(colorType, disable),
              borderRadius: BorderRadius.circular(circular ?? _defaultCircular),
              border: _getBorder(colorType),
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                color: _getFontColor(colorType, disable),
                fontSize: fontSize ?? _getFontSize(sizeType),
                height: fontHeight ?? 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 判断是否需要使用 UnconstrainedBox 包装组件
  Widget hasUnconstrainedBox(Widget widget) {
    if (width == double.infinity) {
      return widget;
    } else {
      return UnconstrainedBox(
        child: widget,
      );
    }
  }
}

/// 获取按钮高度
double _getHeight(JUIButtonSizeType type) {
  switch (type) {
    case JUIButtonSizeType.large:
      return 48;
    case JUIButtonSizeType.middle:
      return 40;
    case JUIButtonSizeType.small:
      return 32;
    case JUIButtonSizeType.ultraSmall:
      return 24;
  }
}

/// 获取按钮字体大小
double _getFontSize(JUIButtonSizeType type) {
  switch (type) {
    case JUIButtonSizeType.large:
      return 16;
    case JUIButtonSizeType.middle:
      return 14;
    case JUIButtonSizeType.small:
      return 14;
    case JUIButtonSizeType.ultraSmall:
      return 12;
  }
}

/// 获取按钮内边距
double _getPadding(JUIButtonSizeType type) {
  switch (type) {
    case JUIButtonSizeType.large:
      return 32;
    case JUIButtonSizeType.middle:
      return 24;
    case JUIButtonSizeType.small:
      return 16;
    case JUIButtonSizeType.ultraSmall:
      return 12;
  }
}

/// 获取按钮背景颜色
Color _getContainerColor(JUIButtonColorType type, bool disable) {
  switch (type) {
    case JUIButtonColorType.white:
      return uiFFFFFF;
    case JUIButtonColorType.gray:
      return uiF6F7F8;
    case JUIButtonColorType.blue:
      return disable ? uiC7DDFF : ui5590F6;
    case JUIButtonColorType.blueBorder:
      return uiFFFFFF;
  }
}

/// 获取按钮字体颜色
Color _getFontColor(JUIButtonColorType type, bool disable) {
  switch (type) {
    case JUIButtonColorType.white:
      return disable ? uiDCE0E8 : ui2A2F3C;
    case JUIButtonColorType.gray:
      return disable ? uiDCE0E8 : ui2A2F3C;
    case JUIButtonColorType.blue:
      return uiFFFFFF;
    case JUIButtonColorType.blueBorder:
      return ui5590F6;
  }
}

/// 获取按钮边框
BoxBorder? _getBorder(JUIButtonColorType type) {
  switch (type) {
    case JUIButtonColorType.white:
      return Border.all(color: uiE8EAEF, width: 1);
    case JUIButtonColorType.gray:
    case JUIButtonColorType.blue:
      return null;
    case JUIButtonColorType.blueBorder:
      return Border.all(color: ui5590F6, width: 1);
  }
}
