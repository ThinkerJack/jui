import 'package:flutter/cupertino.dart';
import 'package:habit/dependencies.dart';
import 'package:habit/life/base/extensions/language_extension.dart';
import 'package:vv_ui_kit/src/basic/extension.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
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
        SizedBox(height: 65.w),
        Image.asset(
          Assets.imagesListEmpty.path,
        ),
        Text(
          getLanguage<S>().LMID_00007233,
          style: TextStyle(fontSize: 16.sp, color: ui858B9B, height: 1.5.r, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
