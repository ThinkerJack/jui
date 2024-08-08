import 'package:flutter/cupertino.dart';

import 'common/picker_date_to_string.dart';
import 'common/picker_func.dart';
import 'date_picker_func.dart';

class SVScrollDatePickerVM {
  late DateTime initialTime; // 初始时间
  DateTime? maxTime; // 最大时间
  DateTime? minTime; // 最小时间
  late DatePickerType type; // 日期选择器类型
  late final RangeType rangeType; // 时间范围类型

  // 时间变量
  final ValueNotifier<DateTime?> chooseTime = ValueNotifier(null);
  final ValueNotifier<bool> isToDate = ValueNotifier(false);

  // 滚动条控制器
  late FixedExtentScrollController chooseYearController;
  late FixedExtentScrollController chooseMonthController;
  late FixedExtentScrollController chooseDayController;

  // 初始化方法
  void init(dynamic widget) {
    type = widget.type;
    initialTime = widget.time ?? DateTime.now();
    chooseTime.value = initialTime;
    maxTime = widget.maxTime;
    minTime = widget.minTime;
    rangeType = _determineRangeType();
    isToDate.value = widget.isToDate;
    initController();
  }

  // 确定时间范围类型
  RangeType _determineRangeType() {
    if (maxTime != null && minTime != null) {
      return RangeType.hasMinAndMax;
    } else if (maxTime != null) {
      return RangeType.hasMax;
    } else if (minTime != null) {
      return RangeType.hasMin;
    } else {
      return RangeType.common;
    }
  }

  // 初始化控制器
  void initController() {
    DateTime time = chooseTime.value ?? initialTime;
    chooseYearController = FixedExtentScrollController(initialItem: yearList().indexOf(time.year.toString()));
    chooseMonthController = FixedExtentScrollController(initialItem: monthList(time).indexOf(getMonthText(time)));

    // 如果是年月日选择器，初始化日控制器
    if (type == DatePickerType.scrollYMD) {
      chooseDayController = FixedExtentScrollController(initialItem: dayList(time).indexOf(getDayText(time)));
    }
  }

  // 获取当前选择的年份
  int getYear() => int.parse(yearList()[chooseYearController.selectedItem]);

  // 获取当前选择的月份
  int getMonth() => int.parse(monthList(chooseTime.value!)[chooseMonthController.selectedItem]);

  // 获取当前选择的日期
  int getDay() => int.parse(dayList(chooseTime.value!)[chooseDayController.selectedItem]);

  // 获取年份列表
  List<String> yearList() => getYearList(initialTime, type: rangeType, maxYear: maxTime?.year, minYear: minTime?.year);

  // 获取月份列表
  List<String> monthList(DateTime date) =>
      getMonthList(type: rangeType, maxMonth: _getMaxMonths(date), minMonth: _getMinMonths(date));

  // 获取日期列表
  List<String> dayList(DateTime date) => getDayList(date: date, type: rangeType, days: _getMaxDays(date));

  // 获取最大月份
  int _getMaxMonths(DateTime date) => (maxTime != null && date.year == maxTime!.year) ? maxTime!.month : 12;

  // 获取最小月份
  int _getMinMonths(DateTime date) => (minTime != null && date.year == minTime!.year) ? minTime!.month : 1;

  // 获取最大日期
  int _getMaxDays(DateTime date) => (maxTime != null && date.year == maxTime!.year && date.month == maxTime!.month)
      ? maxTime!.day
      : DateTime(date.year, date.month + 1, 0).day;

  // 更新年份
  void updateYear() {
    switch (type) {
      case DatePickerType.scrollYMD:
        _updateYearForScrollYMD();
        break;
      case DatePickerType.scrollYM:
        _updateYearForScrollYM();
        break;
      default:
        break;
    }
    updateChooseTime();
  }

  // 年月日选择器的年份更新逻辑
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

  // 年月选择器的年份更新逻辑
  void _updateYearForScrollYM() {
    if (maxTime != null && getYear() == maxTime!.year && chooseMonthController.selectedItem > maxTime!.month - 1) {
      chooseMonthController.jumpToItem(maxTime!.month - 1);
    }
  }

  // 更新月份
  void updateMonth() {
    switch (type) {
      case DatePickerType.scrollYMD:
        _updateMonthForScrollYMD();
        break;
      case DatePickerType.scrollYM:
        _updateMonthForScrollYM();
        break;
      default:
        break;
    }
    updateChooseTime();
  }

  // 年月日选择器的月份更新逻辑
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

  // 年月选择器的月份更新逻辑
  void _updateMonthForScrollYM() {
    if (maxTime != null && getYear() == maxTime!.year && chooseMonthController.selectedItem > maxTime!.month - 1) {
      chooseMonthController.jumpToItem(maxTime!.month - 1);
    }
  }

  // 更新选择的时间
  void updateChooseTime() {
    switch (type) {
      case DatePickerType.scrollYMD:
        chooseTime.value = DateTime(getYear(), getMonth(), getDay());
        break;
      case DatePickerType.scrollYM:
        chooseTime.value = DateTime(getYear(), getMonth());
        break;
      default:
        break;
    }
  }

  // 检查提交的时间
  void checkSubmitTime() {
    if (chooseTime.value == null) return;
    // 提交时间检查逻辑可以在这里实现
  }
}
