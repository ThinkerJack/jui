import 'package:flutter/material.dart';

import '../../utils/custom_color.dart';


const double _defaultCircular = 24;

//大小
enum JacButtonSizeType { large, middle, small, ultraSmall }

//颜色
enum JacButtonColorType { blue, gray, white, blueBorder }

double _getHeight(JacButtonSizeType type) {
  switch (type) {
    case JacButtonSizeType.large:
      return 48;
    case JacButtonSizeType.middle:
      return 40;
    case JacButtonSizeType.small:
      return 32;
    case JacButtonSizeType.ultraSmall:
      return 24;
  }
}

double _getFontSize(JacButtonSizeType type) {
  switch (type) {
    case JacButtonSizeType.large:
      return 16;
    case JacButtonSizeType.middle:
      return 14;
    case JacButtonSizeType.small:
      return 14;
    case JacButtonSizeType.ultraSmall:
      return 12;
  }
}

double _getPadding(JacButtonSizeType type) {
  switch (type) {
    case JacButtonSizeType.large:
      return 32;
    case JacButtonSizeType.middle:
      return 24;
    case JacButtonSizeType.small:
      return 16;
    case JacButtonSizeType.ultraSmall:
      return 12;
  }
}

Color _getContainerColor(JacButtonColorType type, bool disable) {
  switch (type) {
    case JacButtonColorType.white:
      return colorFFFFFF;
    case JacButtonColorType.gray:
      return colorF6F7F8;
    case JacButtonColorType.blue:
      return disable ? colorC7DDFF : color5590F6;
    case JacButtonColorType.blueBorder:
      return colorFFFFFF;
  }
}

Color _getFontColor(JacButtonColorType type, bool disable) {
  switch (type) {
    case JacButtonColorType.white:
      return disable ? colorDCE0E8 : color2A2F3C;
    case JacButtonColorType.gray:
      return disable ? colorDCE0E8 : color2A2F3C;
    case JacButtonColorType.blue:
      return colorFFFFFF;
    case JacButtonColorType.blueBorder:
      return color5590F6;
  }
}

BoxBorder? _getBorder(JacButtonColorType type) {
  switch (type) {
    case JacButtonColorType.white:
      return Border.all(color: colorE8EAEF, width: 1);
    case JacButtonColorType.gray:
    case JacButtonColorType.blue:
      return null;
    case JacButtonColorType.blueBorder:
      return Border.all(color: color5590F6, width: 1);
  }
}

class JacButton extends StatelessWidget {
  const JacButton({
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
  }) : super(key: key);

  final Function onTap; //点击事件
  final String text; //文本内容
  final JacButtonSizeType sizeType; //大小类型
  final JacButtonColorType colorType; //颜色类型
  final bool? visibility; //是否展示
  final bool disable; //是否禁用
  final double? width; //宽度
  final double? height; //高度
  final double? fontSize; //文字大小
  final double? circular; //圆角度
  final double? fontHeight; //文字行高

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
                  color: _getContainerColor(colorType, disable),
                  borderRadius: BorderRadius.circular(circular ?? _defaultCircular),
                  border: _getBorder(colorType)),
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                    color: _getFontColor(colorType, disable),
                    fontSize: fontSize ?? _getFontSize(sizeType),
                    height: fontHeight ?? 1.0),
              ),
            ),
          )),
    );
  }

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

