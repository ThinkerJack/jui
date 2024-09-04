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
  }) : super(key: key);

  final double paddingTop;
  final double imageWidth;
  final String text;
  final String? imagePath;
  final JuiNoContentType type;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: Column(
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
