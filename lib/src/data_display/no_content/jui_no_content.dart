import 'package:flutter/material.dart';
import 'package:jui/src/utils/extension.dart';

import '../../../generated/assets.dart';
import '../../utils/jui_theme.dart';

enum JuiNoContentType { list, search, custom }

class JuiNoContent extends StatelessWidget {
  const JuiNoContent({
    Key? key,
    this.paddingTop = 130,
    this.text = "暂无数据",
    required this.type,
    this.imagePath,
    this.imageWidth = 180,
    this.paddingBottom = 0,
  }) : super(key: key);

// 定义JuiNoContent组件的属性
  // paddingTop: 顶部填充
  final double paddingTop;

  final double paddingBottom;

  // imageWidth: 图片宽度
  final double imageWidth;

  // text: 显示的文本内容
  final String text;

  // imagePath: 图片路径，可选参数
  final String? imagePath;

  // type: JuiNoContent组件的类型
  final JuiNoContentType type;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              _getImagePath(),
              width: imageWidth,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: JuiTheme.textStyles.noContent,
            ),
          ],
        ),
      ),
    );
  }

  String _getImagePath() {
    switch (type) {
      case JuiNoContentType.list:
        return Assets.imagesListEmpty.path;
      case JuiNoContentType.search:
        return Assets.imagesSearchEmpty.path;
      case JuiNoContentType.custom:
        return imagePath ?? Assets.imagesListEmpty.path;
    }
  }
}
