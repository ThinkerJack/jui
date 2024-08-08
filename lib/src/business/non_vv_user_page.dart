import 'package:flutter/cupertino.dart';
import 'package:jac_uikit/src/basic/extension.dart';

import '../../generated/assets.dart';

///非微微用户标识
class NonVVUserPage extends StatelessWidget {
  const NonVVUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.imagesNonVvUserIcon.path,
      width: 20,
      height: 20,
      fit: BoxFit.contain,
    );
  }
}
