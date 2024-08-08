import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit/dependencies.dart';

import '../../utils.dart';

@Deprecated('Use VVButton instead')
enum VVButtonType { simple, middle }

final _defaultCircular = 24.w;

double _getDefaultWidth(VVButtonType type) {
  switch (type) {
    case VVButtonType.simple:
      return 133.5.w;
    case VVButtonType.middle:
      return 165.5.w;
  }
}

double _getDefaultHeight(VVButtonType type) {
  switch (type) {
    case VVButtonType.simple:
      return 40.w;
    case VVButtonType.middle:
      return 48.w;
  }
}

double _getDefaultFontSize(VVButtonType type) {
  switch (type) {
    case VVButtonType.simple:
      return 14.w;
    case VVButtonType.middle:
      return 16.w;
  }
}

@Deprecated('Use VVButton instead')

///蓝色按钮
class VVButtonBlue extends StatelessWidget {
  const VVButtonBlue({
    Key? key,
    this.visibility,
    required this.onTap,
    required this.text,
    this.width,
    this.fontSize,
    this.circular,
    this.height,
    this.type = VVButtonType.simple,
    this.disable = false,
    this.fontHeight,
  }) : super(key: key);

  final Function onTap;
  final VVButtonType type;
  final String text;
  final bool? visibility;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? circular;
  final double? fontHeight;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility ?? true,
      child: InkWell(
        onTap: () {
          if (!disable) onTap();
        },
        child: Container(
          width: width ?? _getDefaultWidth(type),
          height: height ?? _getDefaultHeight(type),
          decoration: BoxDecoration(
              color: disable ? const Color(0xFFC7DDFF) : ui5590F6,
              borderRadius: BorderRadius.circular(circular ?? _defaultCircular)),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
                color: uiFFFFFF,
                fontSize: fontSize ?? _getDefaultFontSize(type),
                fontWeight: FontWeight.w500,
                height: fontHeight),
          ),
        ),
      ),
    );
  }
}

@Deprecated('Use VVButton instead')

///灰色按钮
class VVButtonGray extends StatelessWidget {
  const VVButtonGray({
    Key? key,
    this.visibility,
    required this.text,
    required this.onTap,
    this.width,
    this.fontSize,
    this.circular,
    this.height,
    this.type = VVButtonType.simple,
    this.fontHeight,
  }) : super(key: key);

  final Function onTap;
  final String text;
  final VVButtonType type;
  final bool? visibility;
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
          onTap();
        },
        child: Container(
          width: width ?? _getDefaultWidth(type),
          height: height ?? _getDefaultHeight(type),
          decoration: BoxDecoration(color: uiF6F7F8, borderRadius: BorderRadius.circular(circular ?? _defaultCircular)),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: ui2A2F3C, fontSize: _getDefaultFontSize(type), height: fontHeight),
          ),
        ),
      ),
    );
  }
}