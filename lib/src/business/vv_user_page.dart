import 'package:flutter/cupertino.dart';
import 'package:vv_ui_kit/src/basic/extension.dart';

import '../../generated/assets.dart';

class VVUserPage extends StatelessWidget {
  const VVUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.imagesVvNewIcon.path,
      width: 20,
      height: 20,
      fit: BoxFit.contain,
    );
  }
}
