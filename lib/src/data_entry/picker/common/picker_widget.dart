import 'package:flutter/cupertino.dart';


import 'package:jac_uikit/src/basic/extension.dart';

import '../../../../generated/assets.dart';
import '../../../../utils.dart';

class PickerEmptyWidget extends StatelessWidget {
  const PickerEmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 65),
        Image.asset(
          Assets.imagesListEmpty.path,
        ),
        Text(
          "暂无数据",
          style: TextStyle(fontSize: 16, color: ui858B9B, height: 1.5, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
