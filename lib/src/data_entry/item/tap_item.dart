import 'package:flutter/material.dart';
import 'package:jui/generated/assets.dart';
import 'package:jui/src/utils/extension.dart';

import 'item_widget.dart';
import 'common.dart';

/// 点击表单项组件
class TapItem extends StatelessWidget {
  const TapItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.content = "",
    this.tipText = "",
    this.hintText = "",
    this.maxLine = 1,
    this.isRequired = false,
    this.showTips = false,
    this.isDisabled = false,
    this.padding,
    this.widgetAfterTitle,
  }) : super(key: key);

  final String title; // 标题
  final String hintText; // 提示文字
  final String content; // 内容
  final Function onTap; // 点击回调函数
  final bool showTips; // 是否显示提示信息
  final String tipText; // 提示文字
  final int maxLine; // 最大行数
  final bool isRequired; // 是否为必填项
  final bool isDisabled; // 是否禁用
  final EdgeInsets? padding; // 内边距
  final Widget? widgetAfterTitle; // 标题后面的组件

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!isDisabled) onTap();
      },
      child: Container(
        padding: padding ?? EdgeInsets.only(left: itemPaddingL),
        child: Column(
          children: [
            _buildContent(),
            const ItemDivider(),
          ],
        ),
      ),
    );
  }

  /// 构建内容区域
  Widget _buildContent() {
    return Column(
      children: [
        SizedBox(height: itemPaddingV),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ItemTitle(title: title, isRequired: isRequired, isDisabled: isDisabled)),
            widgetAfterTitle ?? const SizedBox(),
          ],
        ),
        SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText(),
                  ItemTipsText(showTips: showTips, tipText: tipText),
                  SizedBox(height: itemPaddingV),
                ],
              ),
            ),
            _buildIcon(),
          ],
        ),
      ],
    );
  }

  /// 构建文本区域
  Widget _buildText() {
    return Text(
      content.isEmpty ? hintText : content,
      style: isDisabled ? itemHintDisabledStyle : (content.isNotEmpty ? itemContentStyle : itemHintStyle),
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// 构建右侧图标
  Widget _buildIcon() {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 16, top: 9),
      child: Image.asset(isDisabled ? Assets.imagesIconMoreDisabled.path : Assets.imagesIconMore.path, height: 12),
    );
  }
}
