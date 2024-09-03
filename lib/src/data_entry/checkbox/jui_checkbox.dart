import 'package:flutter/material.dart';
import 'package:jui/src/utils/extension.dart';

import '../../../generated/assets.dart';

enum JuiCheckBoxType { square, circle }

class JuiCheckBox extends StatelessWidget {
  const JuiCheckBox({
    Key? key,
    required this.flag,
    required this.type,
    this.isDisabled = false,
    this.onChanged,
  }) : super(key: key);

  final ValueNotifier<bool> flag;
  final JuiCheckBoxType type;
  final bool isDisabled;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: flag,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: isDisabled ? null : _handleTap,
          child: Image.asset(
            _getImage(value).path,
            width: 20,
            height: 20,
          ),
        );
      },
    );
  }

  void _handleTap() {
    final newValue = !flag.value;
    flag.value = newValue;
    onChanged?.call(newValue);
  }

  String _getImage(bool value) {
    switch (type) {
      case JuiCheckBoxType.circle:
        return value ? Assets.imagesCircularSelected : Assets.imagesCircularUnselected;
      case JuiCheckBoxType.square:
        if (isDisabled) {
          return value ? Assets.imagesSelectedDisabled : Assets.imagesUnselectedDisabled;
        } else {
          return value ? Assets.imagesSelected : Assets.imagesUnselected;
        }
    }
  }
}
