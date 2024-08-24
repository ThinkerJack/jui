import 'package:flutter/material.dart';
import 'package:jui/src/basic/extension.dart';
import '../../../generated/assets.dart';

enum EmptyPlaceholderType { list, search, custom }

/// 列表空页面组件，用于显示没有数据时的提示
class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({
    Key? key,
    this.paddingTop = 130,
    this.text = "暂无数据",
    required this.type,
    this.imagePath,
    this.imageWidth = 180,
  }) : super(key: key);

  /// 顶部内边距
  final double paddingTop;

  /// 图片宽度
  final double imageWidth;

  // 空页面显示的文字，默认为空时显示默认提示语
  final String text;

  // 自定义图片
  final String? imagePath;

  ///空页面类型
  final EmptyPlaceholderType type;

  /// 显示空页面提示文字
  Text _noDataText(String emptyText) {
    return Text(
      emptyText,
      style: const TextStyle(color: Color(0XFF858B9B), fontWeight: FontWeight.w500, fontSize: 16, height: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center, // 内容居中对齐
        padding: EdgeInsets.only(top: paddingTop), // 顶部内边距
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 主轴方向对齐方式
          crossAxisAlignment: CrossAxisAlignment.center, // 交叉轴方向对齐方式
          children: <Widget>[
            Image.asset(
              getImagePath(),
              width: imageWidth,
            ), // 显示列表为空的图片
            const SizedBox(
              height: 8, // 图片和文字之间的间距
            ),
            _noDataText(text), // 显示空页面提示文字
          ],
        ),
      ),
    );
  }

  String getImagePath() {
    switch (type) {
      case EmptyPlaceholderType.list:
        return Assets.imagesListEmpty.path;
      case EmptyPlaceholderType.search:
        return Assets.imagesSearchEmpty.path;
      case EmptyPlaceholderType.custom:
        return imagePath ?? Assets.imagesListEmpty.path;
    }
  }
}
