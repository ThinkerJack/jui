import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/picker_const.dart';
import 'multi_level_scroll_picker.dart';
import 'multi_picker.dart';

enum MultiPickerType { checkBox, circularCheckBox }

//多选
showMultiPicker(BuildContext context,
    {String title = "",
    required MultiDoneCallBack onDone,
    required Map<String, dynamic> itemData,
    required MultiPickerType type,
    CancelCallBack? onCancel,
    bool isDismissible = true,
    List<String>? selectedKeys}) {
  FocusManager.instance.primaryFocus?.unfocus();
  showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
          maxHeight: ScreenUtil().screenHeight -
              MediaQuery.of(context).viewPadding.top -
              MediaQuery.of(context).viewPadding.bottom),
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.7),
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      builder: (context) => MultiSelectionPicker(
            title: title,
            filterItemData: itemData,
            onDone: onDone,
            selectedKeys: selectedKeys ?? [],
            topLeftText: "取消",
            topRightText: "确定",
            onCancel: onCancel,
            type: type,
          ));
}

showMultiLevelScrollPicker(BuildContext context,
    {required String title,
    Widget? tipsWidget,
    required List<MultiLevelPickerModel> data,
    required Function(String firstLevelKey, String? secondLevelKey) onDone}) {
  showModalBottomSheet(
      context: context,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.7),
      isScrollControlled: true,
      enableDrag: false,
      constraints: BoxConstraints(maxHeight: 650),
      backgroundColor: Colors.transparent,
      builder: (context) => MultiLevelScrollPicker(title: title, data: data, tipsWidget: tipsWidget, onDone: onDone));
}

class MultiLevelPickerModel {
  final String key;
  final String value;
  final List<MultiLevelPickerModel>? list;

  MultiLevelPickerModel(this.key, this.value, {this.list});
}
