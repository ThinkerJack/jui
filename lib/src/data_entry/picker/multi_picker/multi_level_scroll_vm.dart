import 'package:flutter/cupertino.dart';

import '../../../../data_entry.dart';

class MultiLevelScrollVM {
  List<String> firstTextList = [];
  List<List<String>> secondTextList = [];
  late FixedExtentScrollController firstController;
  late FixedExtentScrollController secondController;
  ValueNotifier<bool> dataChange = ValueNotifier(true);
  int firstControllerSelected = 0;

  void init(List<MultiLevelPickerModel> data) {
    firstController = FixedExtentScrollController(initialItem: 0);
    secondController = FixedExtentScrollController(initialItem: 0);
    _initData(data);
  }

  void _initData(List<MultiLevelPickerModel> data) {
    for (MultiLevelPickerModel map in data) {
      firstTextList.add(map.value);
      secondTextList.add(map.list?.map((e) => e.value).toList() ?? []);
    }
  }

  void firstScrollEnd() {
    firstControllerSelected = firstController.selectedItem;
    dataChange.value = !dataChange.value;
  }

  List<String> getSecondTextList() => secondTextList[firstControllerSelected];
}
