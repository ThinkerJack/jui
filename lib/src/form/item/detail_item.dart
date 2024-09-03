import 'package:flutter/material.dart';

import 'common.dart';

/// 详情表单项类型：simple, custom 均为多行，singleLine 为单行
enum DetailItemType { simple, custom, singleLine }

/// 详情表单项组件
class DetailItem extends StatelessWidget {
  const DetailItem({
    Key? key,
    required this.title,
    this.contentText,
    this.contentWidget,
    this.type = DetailItemType.simple,
    this.titleEndWidget,
    this.titleRightWidget,
    this.titleStyle,
    this.contentStyle,
    this.padding,
  }) : super(key: key);

  final DetailItemType type; // 类型
  final String title; // 标题
  final TextStyle? titleStyle; // 标题样式
  final Widget? titleEndWidget; // 标题尾部组件
  final String? contentText; // 内容文本
  final TextStyle? contentStyle; // 内容样式
  final Widget? contentWidget; // 内容组件
  final Widget? titleRightWidget; // 标题右侧组件
  final EdgeInsets? padding; // 内边距

  @override
  Widget build(BuildContext context) {
    // 多行类型处理
    if (type == DetailItemType.simple || type == DetailItemType.custom) {
      return Padding(
        padding: padding ?? EdgeInsets.only(left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20, right: 20, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text.rich(
                          softWrap: false,
                          TextSpan(
                            children: [
                              WidgetSpan(
                                child: Text(
                                  title,
                                  style: titleStyle ?? _defaultTitleStyle,
                                ),
                                alignment: PlaceholderAlignment.middle,
                              ),
                              WidgetSpan(
                                child: titleEndWidget ?? SizedBox.shrink(),
                                alignment: PlaceholderAlignment.middle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: titleRightWidget != null,
                        child: titleRightWidget ?? SizedBox.shrink(),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  if (type == DetailItemType.custom) contentWidget ?? SizedBox.shrink(),
                  if (type == DetailItemType.simple)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(contentText ?? "", style: contentStyle ?? _defaultContentStyle),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const ItemDivider(),
          ],
        ),
      );
    }

    // 单行类型处理
    if (type == DetailItemType.singleLine) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: padding ?? EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //todo
                // if (LanguageHelper.instance.isZh)
                if (true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 190,
                        child: Text(
                          title,
                          style: titleStyle ?? _defaultTitleStyle,
                        ),
                      ),
                      SizedBox(
                        width: 127,
                        child: contentWidget ??
                            Text(
                              contentText ?? "",
                              style: contentStyle ?? _defaultContentStyle,
                              textAlign: TextAlign.end,
                            ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text.rich(
                              softWrap: false,
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Text(
                                      title,
                                      style: titleStyle ?? _defaultTitleStyle,
                                    ),
                                    alignment: PlaceholderAlignment.middle,
                                  ),
                                  WidgetSpan(
                                    child: titleEndWidget ?? SizedBox.shrink(),
                                    alignment: PlaceholderAlignment.middle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: titleRightWidget != null,
                            child: titleRightWidget ?? SizedBox.shrink(),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      contentWidget ??
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Text(contentText ?? "", style: contentStyle ?? _defaultContentStyle),
                              ),
                            ],
                          ),
                    ],
                  ),
                SizedBox(height: 16),
                const ItemDivider(),
              ],
            ),
          ),
        ],
      );
    }

    return SizedBox.shrink();
  }
}

final TextStyle _defaultContentStyle = TextStyle(color: const Color(0xFF2A2F3C), fontSize: 16, height: 1.5);
final TextStyle _defaultTitleStyle = TextStyle(color: const Color(0XFF858B9B), fontSize: 14, height: 1.5);
