import 'package:flutter/material.dart';
import 'package:jui/src/utils/extension.dart';

import '../../../generated/assets.dart';
import '../../utils/jui_theme.dart';

/// `JuiNoContentType` 枚举，定义不同类型的空内容显示
enum JuiNoContentType {
  /// 用于列表为空的情况
  list,

  /// 用于搜索无结果的情况
  search,

  /// 自定义图片的情况
  custom
}

/// `JuiNoContent` 组件用于显示空页面的占位内容。
///
/// 该组件可用于列表为空、搜索无结果等场景，并支持自定义图片和文本。
class JuiNoContent extends StatelessWidget {
  /// 创建一个 `JuiNoContent` 组件
  ///
  /// - [paddingTop]：顶部填充，默认为 `130`。
  /// - [text]：显示的文本内容，默认为 `"暂无数据"`。
  /// - [type]：空页面的类型，必填。
  /// - [imagePath]：自定义图片路径，仅在 `JuiNoContentType.custom` 类型下使用。
  /// - [imageWidth]：图片的宽度，默认为 `180`。
  /// - [paddingBottom]：底部填充，默认为 `0`。
  const JuiNoContent({
    Key? key,
    this.paddingTop = 130,
    this.text = "暂无数据",
    required this.type,
    this.imagePath,
    this.imageWidth = 180,
    this.paddingBottom = 0,
  }) : super(key: key);

  /// 顶部填充
  final double paddingTop;

  /// 底部填充
  final double paddingBottom;

  /// 图片宽度
  final double imageWidth;

  /// 显示的文本内容
  final String text;

  /// 自定义图片路径（仅在 `JuiNoContentType.custom` 类型下使用）
  final String? imagePath;

  /// `JuiNoContent` 组件的类型
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

  /// 获取对应的空页面图片路径
  ///
  /// 根据 `type` 返回默认图片路径：
  /// - `JuiNoContentType.list`：显示列表为空的图片。
  /// - `JuiNoContentType.search`：显示搜索无结果的图片。
  /// - `JuiNoContentType.custom`：使用自定义 `imagePath`，如果为空则回退到 `list` 图片。
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
