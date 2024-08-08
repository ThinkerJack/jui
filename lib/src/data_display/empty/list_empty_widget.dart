import 'package:flutter/material.dart';
import 'package:jui/src/basic/extension.dart';

import '../../../generated/assets.dart';
import 'common.dart';

/// 列表空页面组件，用于显示没有数据时的提示
class ListEmptyWidget extends StatelessWidget {
  const ListEmptyWidget({
    Key? key,
    this.paddingTop = 130,
    this.emptyText,
  }) : super(key: key);

  /// 顶部内边距
  final double paddingTop;

  /// 空页面显示的文字，默认为空时显示默认提示语
  final String? emptyText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 背景颜色为白色
      resizeToAvoidBottomInset: false, // 防止键盘弹出时页面布局变化
      body: Container(
        alignment: Alignment.center, // 内容居中对齐
        padding: EdgeInsets.only(top: paddingTop), // 顶部内边距
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 主轴方向对齐方式
          crossAxisAlignment: CrossAxisAlignment.center, // 交叉轴方向对齐方式
          children: <Widget>[
            Image.asset(Assets.imagesListEmpty.path), // 显示列表为空的图片
            SizedBox(
              height: 8, // 图片和文字之间的间距
            ),
            noDataText(emptyText ?? "暂无数据"), // 显示空页面提示文字
          ],
        ),
      ),
    );
  }
}
