//滚动单选
import 'package:flutter/material.dart';
import 'package:habit/habit.dart';
import 'package:vv_ui_kit/src/data_entry/picker/single_picker/bottom_cancel.dart';
import 'package:vv_ui_kit/src/data_entry/picker/single_picker/right_tick.dart';
import 'package:vv_ui_kit/src/data_entry/picker/single_picker/scroll.dart';

import '../../../../generated/l10n.dart';
import '../common/picker_const.dart';

enum SinglePickerType { scroll, bottomCancel, rightTick }

showScrollPicker(BuildContext context,
    {String title = "",
    required SingleDoneCallBack onDone,
    required Map<dynamic, String> itemData,
    required String selectedKey}) {
  showSinglePicker(
    context,
    onDone: onDone,
    itemData: itemData,
    type: SinglePickerType.scroll,
    title: title,
    selectedKey: selectedKey,
  );
}

//单选
showSinglePicker(
  BuildContext context, {
  String title = "",
  required SingleDoneCallBack onDone,
  required Map<dynamic, String> itemData,
  SinglePickerType type = SinglePickerType.bottomCancel,
  String selectedKey = "",
  CancelCallBack? onCancel,
}) {
  FocusManager.instance.primaryFocus?.unfocus();
  showModalBottomSheet(
      context: context,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.7),
      isScrollControlled: true,
      enableDrag: false,
      constraints: BoxConstraints(maxHeight: 650.w),
      backgroundColor: Colors.transparent,
      builder: (context) => _getPicker(title, itemData, onDone, selectedKey, onCancel, type));
}

Widget _getPicker(
  String title,
  Map<dynamic, String> itemData,
  SingleDoneCallBack onDone,
  String selectedKey,
  CancelCallBack? onCancel,
  SinglePickerType type,
) {
  switch (type) {
    case SinglePickerType.bottomCancel:
      return BottomCancelPicker(
        title: title,
        filterItemData: itemData,
        onDone: onDone,
        selectedKey: selectedKey,
        cancelText: getLanguage<S>().LMID_00002552,
        confirmText: getLanguage<S>().LMID_00013631,
        onCancel: onCancel,
      );
    case SinglePickerType.scroll:
      return SingleScrollPicker(
        title: title,
        filterItemData: itemData,
        onDone: onDone,
        selectedKey: selectedKey,
        cancelText: getLanguage<S>().LMID_00002552,
        confirmText: getLanguage<S>().LMID_00013631,
      );
    case SinglePickerType.rightTick:
      return RightTickPicker(
        title: title,
        filterItemData: itemData,
        onDone: onDone,
        selectedKey: selectedKey,
        cancelText: getLanguage<S>().LMID_00002552,
        confirmText: getLanguage<S>().LMID_00013631,
        onCancel: onCancel,
      );
  }
}
