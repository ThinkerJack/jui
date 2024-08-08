import 'package:flutter/cupertino.dart';
import 'package:habit/habit.dart';
import 'package:vv_ui_kit/src/basic/extension.dart';

import '../../../generated/assets.dart';
import '../../../utils.dart';

/// 显示标题文本的组件
class _Text extends StatelessWidget {
  const _Text({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title; // 标题文本

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: ui2A2F3C,
          fontWeight: FontWeight.w500,
        ),
      ).paddingLeft(16.r),
    );
  }
}

/// 显示蓝色区块的组件
class _BlueBlock extends StatelessWidget {
  const _BlueBlock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4.r,
      height: 16.r,
      decoration: BoxDecoration(
          color: ui5590F6,
          borderRadius: BorderRadius.only(topRight: Radius.circular(2.w), bottomRight: Radius.circular(2.w))),
    );
  }
}

/// 构建 EdgeInsets 用于设置 padding
EdgeInsets _buildEdgeInsets() => EdgeInsets.only(right: 20.w, top: 11.w, bottom: 11.w);

/// 详情页标题组件
class DetailTitle extends StatelessWidget {
  const DetailTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title; // 标题文本

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: _buildEdgeInsets(),
      child: Row(
        children: [
          const _BlueBlock(),
          _Text(title: title),
        ],
      ),
    );
  }
}

/// 详情页标题组件，支持展开收起功能
class DetailTitleFlex extends StatelessWidget {
  const DetailTitleFlex({
    Key? key,
    required this.title,
    required this.expandFlag,
    required this.content,
  }) : super(key: key);
  final String title; // 标题文本
  final Widget content; // 展开时显示的内容
  final ValueNotifier<bool> expandFlag; // 控制展开和收起的状态

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: _buildEdgeInsets(),
          child: Row(
            children: [
              const _BlueBlock(),
              _Text(title: title),
              expandFlag.listen((value) => GestureDetector(
                    child: Image.asset(
                      expandFlag.value ? Assets.imagesIconDown.path : Assets.imagesIconUp.path,
                    ),
                    onTap: () {
                      expandFlag.value = !expandFlag.value; // 切换展开收起状态
                    },
                  ))
            ],
          ),
        ),
        expandFlag.listen((value) => Visibility(
              visible: expandFlag.value,
              child: content, // 显示或隐藏内容
            ))
      ],
    );
  }
}
