import 'package:flutter/material.dart';
import '../../utils/custom_color.dart';


const double _defaultCircular = 24;

//大小
enum CButtonSizeType { large, middle, small, ultraSmall }

//颜色
enum CButtonColorType { blue, gray, white, blueBorder }

double _getHeight(CButtonSizeType type) {
  switch (type) {
    case CButtonSizeType.large:
      return 48;
    case CButtonSizeType.middle:
      return 40;
    case CButtonSizeType.small:
      return 32;
    case CButtonSizeType.ultraSmall:
      return 24;
  }
}

double _getFontSize(CButtonSizeType type) {
  switch (type) {
    case CButtonSizeType.large:
      return 16;
    case CButtonSizeType.middle:
      return 14;
    case CButtonSizeType.small:
      return 14;
    case CButtonSizeType.ultraSmall:
      return 12;
  }
}

double _getPadding(CButtonSizeType type) {
  switch (type) {
    case CButtonSizeType.large:
      return 32;
    case CButtonSizeType.middle:
      return 24;
    case CButtonSizeType.small:
      return 16;
    case CButtonSizeType.ultraSmall:
      return 12;
  }
}

Color _getContainerColor(CButtonColorType type, bool disable) {
  switch (type) {
    case CButtonColorType.white:
      return colorFFFFFF;
    case CButtonColorType.gray:
      return colorF6F7F8;
    case CButtonColorType.blue:
      return disable ? colorC7DDFF : color5590F6;
    case CButtonColorType.blueBorder:
      return colorFFFFFF;
  }
}

Color _getFontColor(CButtonColorType type, bool disable) {
  switch (type) {
    case CButtonColorType.white:
      return disable ? colorDCE0E8 : color2A2F3C;
    case CButtonColorType.gray:
      return disable ? colorDCE0E8 : color2A2F3C;
    case CButtonColorType.blue:
      return colorFFFFFF;
    case CButtonColorType.blueBorder:
      return color5590F6;
  }
}

BoxBorder? _getBorder(CButtonColorType type) {
  switch (type) {
    case CButtonColorType.white:
      return Border.all(color: colorE8EAEF, width: 1);
    case CButtonColorType.gray:
    case CButtonColorType.blue:
      return null;
    case CButtonColorType.blueBorder:
      return Border.all(color: color5590F6, width: 1);
  }
}

class CButton extends StatelessWidget {
  const CButton({
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

  final Function onTap;
  final String text;
  final CButtonSizeType sizeType;
  final CButtonColorType colorType;
  final bool? visibility;
  final bool disable;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? circular;
  final double? fontHeight;

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

