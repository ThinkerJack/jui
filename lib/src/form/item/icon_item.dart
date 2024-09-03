import 'package:flutter/cupertino.dart';

import '../../utils/jui_theme.dart';

/// 图片文字表单项组件
class IconItem extends StatelessWidget {
  const IconItem({
    Key? key,
    required this.text,
    required this.iconWidget,
    this.endWidget,
    this.textStyle,
    this.widgetSpacing,
  }) : super(key: key);

  /// 标题文本
  final String text;

  /// 图标组件
  final Widget iconWidget;

  /// 尾部组件
  final Widget? endWidget;

  /// 标题文本样式
  final TextStyle? textStyle;

  /// 组件之间的间距
  final double? widgetSpacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 图标组件
            iconWidget,
            SizedBox(
              width: widgetSpacing ?? 8,
            ),
            // 标题文本和尾部组件
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: text,
                  children: [
                    WidgetSpan(
                      child: endWidget ?? SizedBox.shrink(),
                      alignment: PlaceholderAlignment.top,
                    ),
                  ],
                  style: textStyle ?? TextStyle(color: JUIColors().text, fontSize: 12, height: 1.5),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
