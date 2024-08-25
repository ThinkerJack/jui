import 'package:flutter/material.dart';

import 'common.dart';
import 'item_widget.dart';

/// 输入表单项组件
class CustomItem extends StatelessWidget {
  const CustomItem({
    super.key,
    required this.title,
    required this.contentWidget,
    this.titleStyle,
    this.isRequired = false,
    this.padding,
    this.isDisabled = false,
  });

  /// 标题文本
  final String title;

  /// 标题样式
  final TextStyle? titleStyle;

  /// 内容组件
  final Widget contentWidget;

  /// 是否为必填项
  final bool isRequired;

  /// 是否为禁用状态
  final bool isDisabled;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: padding ?? EdgeInsets.only(top: itemPaddingV, right: itemPaddingR, left: itemPaddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTitle(
                title: title,
                isRequired: isRequired,
                isDisabled: isDisabled,
              ),
              SizedBox(height: 4),
              contentWidget,
              SizedBox(height: itemPaddingV),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: itemPaddingL),
          child: const ItemDivider(),
        )
      ],
    );
  }
}
