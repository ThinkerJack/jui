import 'package:flutter/cupertino.dart';

import '../../utils/custom_color.dart';

//tag颜色类型
enum JacTagColorType { black, blue, green, yellow, red, gray }

//tag形状类型
enum JacTagShapeType {
  //半圆
  semicircle,
  //矩形
  rectangle,
  //胶囊
  capsule
}

//tag类型
enum JacTagType {
  //纯文字
  text,
  //icon+文字
  icon
}

class JacTag extends StatelessWidget {
  const JacTag(
      {super.key,
      required this.paddingVertical,
      required this.paddingHorizontal,
      required this.tagType,
      required this.tagShapeType,
      required this.tagColorType,
      required this.text,
      this.icon,
      required this.fontSize});

  final double paddingVertical; //垂直内边距
  final double paddingHorizontal; //水平内边距
  final JacTagType tagType; //tag类型
  final JacTagShapeType tagShapeType; //tag形状类型
  final JacTagColorType tagColorType; //tag颜色类型
  final String text; //文字内容
  final double fontSize; //字体大小
  final Widget? icon; //左侧图标

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
      decoration: BoxDecoration(borderRadius: getBorderRadius(), color: getColor(true)),
      child: buildContent(),
    );
  }

  Widget buildContent() {
    switch (tagType) {
      case JacTagType.text:
        return Text(
          text,
          style: TextStyle(color: getColor(false), fontSize: fontSize, height: 1.5),
        );
      case JacTagType.icon:
        return Row(
          children: [
            icon ?? const SizedBox(),
            const SizedBox(
              width: 4,
            ),
            Text(
              text,
              style: TextStyle(color: getColor(false), fontSize: fontSize, height: 1.5),
            ),
          ],
        );
    }
  }

  /// flag
  /// true container
  /// false text
  Color getColor(bool flag) {
    switch (tagColorType) {
      case JacTagColorType.black:
        return flag ? colorF6F7F8 : color2A2F3C;
      case JacTagColorType.blue:
        return flag ? color145590F6 : color5590F6;
      case JacTagColorType.green:
        return flag ? color1444C69D : color44C69D;
      case JacTagColorType.yellow:
        return flag ? color14FFA22D : colorFFA22D;
      case JacTagColorType.red:
        return flag ? color14F55656 : colorF55656;
      case JacTagColorType.gray:
        return flag ? colorF6F7F8 : color858B9B;
    }
  }

  BorderRadius getBorderRadius() {
    switch (tagShapeType) {
      case JacTagShapeType.semicircle:
        return const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16));
      case JacTagShapeType.rectangle:
        return const BorderRadius.all(Radius.circular(6));
      case JacTagShapeType.capsule:
        return const BorderRadius.all(Radius.circular(16));
    }
  }
}
