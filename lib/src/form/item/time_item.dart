import 'package:flutter/material.dart';
import 'package:jui/src/utils/extension.dart';

import '../../../generated/assets.dart';
import '../../utils/color.dart';
import 'common.dart';

/// 时间选择项组件
class TimeItem extends StatelessWidget {
  const TimeItem({
    Key? key,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.onTap,
    this.showTips,
    required this.startHintText,
    required this.endHintText,
    this.tipText = "",
    this.padding,
  }) : super(key: key);

  final String title; // 标题
  final String startDate; // 开始日期
  final String startHintText; // 开始日期提示文字
  final String endDate; // 结束日期
  final String endHintText; // 结束日期提示文字
  final String tipText; // 提示文字
  final Function onTap; // 点击事件回调函数
  final bool? showTips; // 是否显示提示信息
  final EdgeInsets? padding; // 内边距

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: padding ?? EdgeInsets.only(top: itemPaddingV, left: itemPaddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainContent(),
            const ItemDivider(),
            if (showTips ?? false) _buildTips(),
          ],
        ),
      ),
    );
  }

  /// 构建主要内容
  Widget _buildMainContent() {
    return Padding(
      padding: EdgeInsets.only(right: itemPaddingR),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: ui858B9B,
              height: 1.5,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              _buildDateText(startDate, startHintText),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset(Assets.imagesItemInterval.path),
              ),
              _buildDateText(endDate, endHintText),
            ],
          ),
          SizedBox(height: itemPaddingV),
        ],
      ),
    );
  }

  /// 构建日期文本
  Widget _buildDateText(String date, String hintText) {
    return Expanded(
      child: Text(
        date.isNotEmpty ? date : hintText,
        style: TextStyle(
          color: date.isNotEmpty ? ui2A2F3C : uiBCC1CD,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        maxLines: 1,
      ),
    );
  }

  /// 构建提示信息
  Widget _buildTips() {
    return Column(
      children: [
        SizedBox(height: 4),
        Text(
          tipText,
          style: TextStyle(
            color: uiF55656,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
