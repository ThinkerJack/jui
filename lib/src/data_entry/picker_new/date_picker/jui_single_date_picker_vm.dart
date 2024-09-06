// lib/src/data_entry/jui_date_picker/jui_single_date_picker_vm.dart

import 'package:flutter/cupertino.dart';

import 'jui_date_picker_types.dart';
import 'jui_date_picker_utils.dart';

class JuiSingleDatePickerVM {
  late DateTime initialTime;
  DateTime? maxTime;
  DateTime? minTime;
  late JuiDatePickerMode mode;
  late final JuiRangeType rangeType;

  final ValueNotifier<DateTime?> chooseTime = ValueNotifier(null);
  final ValueNotifier<bool> isToDate = ValueNotifier(false);

  late FixedExtentScrollController chooseYearController;
  late FixedExtentScrollController chooseMonthController;
  late FixedExtentScrollController chooseDayController;

  void init(dynamic widget) {
    mode = widget.mode;
    initialTime = widget.time ?? DateTime.now();
    chooseTime.value = initialTime;
    maxTime = widget.maxTime;
    minTime = widget.minTime;
    rangeType = _determineRangeType();
    isToDate.value = widget.isToDate;
    initController();
  }

  JuiRangeType _determineRangeType() {
    if (maxTime != null && minTime != null) {
      return JuiRangeType.hasMinAndMax;
    } else if (maxTime != null) {
      return JuiRangeType.hasMax;
    } else if (minTime != null) {
      return JuiRangeType.hasMin;
    } else {
      return JuiRangeType.common;
    }
  }

  void initController() {
    DateTime time = chooseTime.value ?? initialTime;
    chooseYearController = FixedExtentScrollController(initialItem: yearList().indexOf(time.year.toString()));
    chooseMonthController = FixedExtentScrollController(initialItem: monthList(time).indexOf(getMonthText(time)));

    if (mode == JuiDatePickerMode.scrollYMD) {
      chooseDayController = FixedExtentScrollController(initialItem: dayList(time).indexOf(getDayText(time)));
    }
  }

  int getYear() => int.parse(yearList()[chooseYearController.selectedItem]);
  int getMonth() => int.parse(monthList(chooseTime.value!)[chooseMonthController.selectedItem]);
  int getDay() => int.parse(dayList(chooseTime.value!)[chooseDayController.selectedItem]);

  List<String> yearList() => getYearList(initialTime, type: rangeType, maxYear: maxTime?.year, minYear: minTime?.year);
  List<String> monthList(DateTime date) =>
      getMonthList(type: rangeType, maxMonth: _getMaxMonths(date), minMonth: _getMinMonths(date));
  List<String> dayList(DateTime date) => getDayList(date: date, type: rangeType, days: _getMaxDays(date));

  int _getMaxMonths(DateTime date) => (maxTime != null && date.year == maxTime!.year) ? maxTime!.month : 12;
  int _getMinMonths(DateTime date) => (minTime != null && date.year == minTime!.year) ? minTime!.month : 1;
  int _getMaxDays(DateTime date) => (maxTime != null && date.year == maxTime!.year && date.month == maxTime!.month)
      ? maxTime!.day
      : DateTime(date.year, date.month + 1, 0).day;

  void updateYear() {
    switch (mode) {
      case JuiDatePickerMode.scrollYMD:
        _updateYearForScrollYMD();
        break;
      case JuiDatePickerMode.scrollYM:
        _updateYearForScrollYM();
        break;
      default:
        break;
    }
    updateChooseTime();
  }

  void _updateYearForScrollYMD() {
    if (maxTime != null && getYear() == maxTime!.year) {
      if (chooseMonthController.selectedItem > maxTime!.month - 1) {
        chooseMonthController.jumpToItem(maxTime!.month - 1);
      }
      if (chooseMonthController.selectedItem == maxTime!.month - 1 &&
          chooseDayController.selectedItem > maxTime!.day - 1) {
        chooseDayController.jumpToItem(maxTime!.day - 1);
      }
    }
  }

  void _updateYearForScrollYM() {
    if (maxTime != null && getYear() == maxTime!.year && chooseMonthController.selectedItem > maxTime!.month - 1) {
      chooseMonthController.jumpToItem(maxTime!.month - 1);
    }
  }

  void updateMonth() {
    switch (mode) {
      case JuiDatePickerMode.scrollYMD:
        _updateMonthForScrollYMD();
        break;
      case JuiDatePickerMode.scrollYM:
        _updateMonthForScrollYM();
        break;
      default:
        break;
    }
    updateChooseTime();
  }

  void _updateMonthForScrollYMD() {
    if (maxTime != null && getYear() == maxTime!.year) {
      if (chooseMonthController.selectedItem > maxTime!.month - 1) {
        chooseMonthController.jumpToItem(maxTime!.month - 1);
      }
      if (chooseMonthController.selectedItem == maxTime!.month - 1 &&
          chooseDayController.selectedItem > maxTime!.day - 1) {
        chooseDayController.jumpToItem(maxTime!.day - 1);
      }
    }
    DateTime date = DateTime(getYear(), getMonth());
    if (chooseDayController.selectedItem >= dayList(date).length) {
      chooseDayController.jumpToItem(dayList(date).length - 1);
    }
  }

  void _updateMonthForScrollYM() {
    if (maxTime != null && getYear() == maxTime!.year && chooseMonthController.selectedItem > maxTime!.month - 1) {
      chooseMonthController.jumpToItem(maxTime!.month - 1);
    }
  }

  void updateChooseTime() {
    switch (mode) {
      case JuiDatePickerMode.scrollYMD:
        chooseTime.value = DateTime(getYear(), getMonth(), getDay());
        break;
      case JuiDatePickerMode.scrollYM:
        chooseTime.value = DateTime(getYear(), getMonth());
        break;
      default:
        break;
    }
  }

  void checkSubmitTime() {
    if (chooseTime.value == null) return;
    // 可以在这里添加提交时间的检查逻辑
  }
}