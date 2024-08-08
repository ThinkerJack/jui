import 'package:flutter/material.dart';


import '../../utils.dart';


final double _defaultCircular = 24;

/// 按钮尺寸类型
enum VVButtonSizeType { large, middle, small, ultraSmall }

/// 按钮颜色类型
enum VVButtonColorType { blue, gray, white, blueBorder }

/// 获取按钮高度
double _getHeight(VVButtonSizeType type) {
  switch (type) {
    case VVButtonSizeType.large:
      return 48;
    case VVButtonSizeType.middle:
      return 40;
    case VVButtonSizeType.small:
      return 32;
    case VVButtonSizeType.ultraSmall:
      return 24;
  }
}

/// 获取按钮字体大小
double _getFontSize(VVButtonSizeType type) {
  switch (type) {
    case VVButtonSizeType.large:
      return 16;
    case VVButtonSizeType.middle:
      return 14;
    case VVButtonSizeType.small:
      return 14;
    case VVButtonSizeType.ultraSmall:
      return 12;
  }
}

/// 获取按钮内边距
double _getPadding(VVButtonSizeType type) {
  switch (type) {
    case VVButtonSizeType.large:
      return 32;
    case VVButtonSizeType.middle:
      return 24;
    case VVButtonSizeType.small:
      return 16;
    case VVButtonSizeType.ultraSmall:
      return 12;
  }
}

/// 获取按钮背景颜色
Color _getContainerColor(VVButtonColorType type, bool disable) {
  switch (type) {
    case VVButtonColorType.white:
      return uiFFFFFF;
    case VVButtonColorType.gray:
      return uiF6F7F8;
    case VVButtonColorType.blue:
      return disable ? uiC7DDFF : ui5590F6;
    case VVButtonColorType.blueBorder:
      return uiFFFFFF;
  }
}

/// 获取按钮字体颜色
Color _getFontColor(VVButtonColorType type, bool disable) {
  switch (type) {
    case VVButtonColorType.white:
      return disable ? uiDCE0E8 : ui2A2F3C;
    case VVButtonColorType.gray:
      return disable ? uiDCE0E8 : ui2A2F3C;
    case VVButtonColorType.blue:
      return uiFFFFFF;
    case VVButtonColorType.blueBorder:
      return ui5590F6;
  }
}

/// 获取按钮边框
BoxBorder? _getBorder(VVButtonColorType type) {
  switch (type) {
    case VVButtonColorType.white:
      return Border.all(color: uiE8EAEF, width: 1);
    case VVButtonColorType.gray:
    case VVButtonColorType.blue:
      return null;
    case VVButtonColorType.blueBorder:
      return Border.all(color: ui5590F6, width: 1);
  }
}

/// 可编辑输入框组件，包含标题、提示信息、输入框及清除按钮
class VVButton extends StatelessWidget {
  const VVButton({
    Key? key,
    required this.colorType,
    required this.type,
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
  final VVButtonSizeType type; // 按钮尺寸类型
  final VVButtonColorType colorType; // 按钮颜色类型
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
            height: height ?? _getHeight(type),
            width: width,
            padding: width == null ? EdgeInsets.symmetric(horizontal: _getPadding(type)) : null,
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
                fontSize: fontSize ?? _getFontSize(type),
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
