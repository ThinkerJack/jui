import 'package:flutter/cupertino.dart';

import 'package:jac_uikit/src/basic/extension.dart';

import '../../../generated/assets.dart';

/// 复选框类型：方形或圆形
enum VVCheckBoxType { square, circle }

/// 自定义复选框组件
class VVCheckBox extends StatelessWidget {
  const VVCheckBox({
    super.key,
    required this.flag,
    required this.type,
    this.isDisabled = false,
  });

  final ValueNotifier<bool> flag; // 复选框的状态（选中或未选中）
  final VVCheckBoxType type; // 复选框的类型（方形或圆形）
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: flag,
      builder: (BuildContext context, value, Widget? child) {
        return GestureDetector(
          onTap: () {
            if (isDisabled) return;
            flag.value = !flag.value; // 点击时切换复选框的状态
          },
          child: Image.asset(
            _getImage(), // 根据状态和类型获取相应的图片资源
            width: 20,
            height: 20,
          ),
        );
      },
    );
  }

  /// 根据复选框类型和状态返回对应的图片资源路径
  String _getImage() {
    switch (type) {
      case VVCheckBoxType.circle:
        return flag.value ? Assets.imagesIconCircularSelected.path : Assets.imagesIconCircularUnselected.path;
      case VVCheckBoxType.square:
        return flag.value
            ? (isDisabled ? Assets.imagesIconSelectedDisabled.path : Assets.imagesIconSelected.path)
            : (isDisabled ? Assets.imagesIconUnselectedDisabled.path : Assets.imagesIconUnselected.path);
    }
  }
}
