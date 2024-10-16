import 'package:flutter/cupertino.dart';

import 'date_picker_func.dart';
import 'picker_widget.dart';

class MVScrollDatePickerVM {
  late Duration timeGap;
  late DateTime initialStartTime;
  late DatePickerType type;

  //时间变量
  ValueNotifier<bool> startOrEndFlag = ValueNotifier(true);
  ValueNotifier<DateTime?> startTime = ValueNotifier(null);
  ValueNotifier<DateTime?> endTime = ValueNotifier(null);
  ValueNotifier<bool> endMonthChange = ValueNotifier(true);
  ValueNotifier<bool> endYearChange = ValueNotifier(true);
  ValueNotifier<bool> endYMDWChange = ValueNotifier(true);
  ValueNotifier<bool> endHourChange = ValueNotifier(true);
  ValueNotifier<bool> startMonthChange = ValueNotifier(true);

  //滚动条控制器
  late FixedExtentScrollController startYMDWController;
  late FixedExtentScrollController startYearController;
  late FixedExtentScrollController startMonthController;
  late FixedExtentScrollController startDayController;
  late FixedExtentScrollController startHourController;
  late FixedExtentScrollController startMinuteController;
  late FixedExtentScrollController endYMDWController;
  late FixedExtentScrollController endYearController;
  late FixedExtentScrollController endMonthController;
  late FixedExtentScrollController endDayController;
  late FixedExtentScrollController endHourController;
  late FixedExtentScrollController endMinuteController;

  init(widget) {
    timeGap = getDefaultTimeGap(widget.type);
    type = widget.type;
    initialStartTime = widget.startTime ?? DateTime.now();
    startTime.value = widget.startTime ?? DateTime.now();
    if (widget.endTime != null) endTime.value = widget.endTime!;
  }

  int getStartYear() => int.parse(startYearList()[startYearController.selectedItem]);

  int getStartMonth() => int.parse(startMonthList()[startMonthController.selectedItem]);

  int getStartDay() => int.parse(startDayList(startTime.value!)[startDayController.selectedItem]);

  int getStartHour() => int.parse(getHourList()[startHourController.selectedItem]);

  int getStartMinute() => int.parse(getMinuteList()[startMinuteController.selectedItem]);

  int getEndYear() => int.parse(endYearList()[endYearController.selectedItem]);

  int getEndMonth(date) => int.parse(endMonthList(date)[endMonthController.selectedItem]);

  int getEndDay(date) => int.parse(endDayList(date)[endDayController.selectedItem]);

  int getEndHour(date) => int.parse(endHourList(date)[endHourController.selectedItem]);

  int getEndMinute(date) => int.parse(endMinuteList(date)[endMinuteController.selectedItem]);

  List<String> startYearList() => getYearList(initialStartTime);

  List<String> startMonthList() => getMonthList();

  List<String> startDayList(DateTime time) => getDayList(date: time);

  List<String> endYMDWList(context) => getEndYMDWList(startTime.value!.add(timeGap), context);

  List<String> endYearList() => getEndYearList(startTime.value!.add(timeGap));

  List<String> endMonthList(DateTime time) => getEndMonthList(startTime.value!, time, timeGap);

  List<String> endDayList(DateTime time) => getEndDayList(startTime.value!, time, timeGap);

  List<String> endHourList(date) => getEndHourList(startTime.value!, date, timeGap);

  List<String> endMinuteList(date) => getEndMinuteList(startTime.value!, date, timeGap);

  //初始化开始控制器
  void initStartController(context) {
    DateTime time = (startTime.value ?? initialStartTime);
    switch (type) {
      case DatePickerType.scrollYMD:
        startYearController = FixedExtentScrollController(initialItem: startYearList().indexOf(time.year.toString()));
        startMonthController = FixedExtentScrollController(initialItem: startMonthList().indexOf(getMonthText(time)));
        startDayController = FixedExtentScrollController(initialItem: startDayList(time).indexOf(getDayText(time)));
        break;
      case DatePickerType.scrollYMDWHM:
        startYMDWController = FixedExtentScrollController(
            initialItem: getYMDWList(initialStartTime, context).indexOf(getYMDWText(time, context)));
        startHourController = FixedExtentScrollController(initialItem: getHourList().indexOf(getHourText(time)));
        startMinuteController = FixedExtentScrollController(initialItem: getMinuteList().indexOf(getMinuteText(time)));
        break;
      default:
        break;
    }
  }

  //初始化结束控制器
  void initEndController(context) {
    switch (type) {
      case DatePickerType.scrollYMD:
        endYearController =
            FixedExtentScrollController(initialItem: endYearList().indexOf(endTime.value!.year.toString()));
        endMonthController = FixedExtentScrollController(
            initialItem: endMonthList(endTime.value!).indexOf(getMonthText(endTime.value!)));
        endDayController =
            FixedExtentScrollController(initialItem: endDayList(endTime.value!).indexOf(getDayText(endTime.value!)));
        break;
      case DatePickerType.scrollYMDWHM:
        endYMDWController = FixedExtentScrollController(
            initialItem:
                getEndYMDWList(startTime.value!.add(timeGap), context).indexOf(getYMDWText(endTime.value!, context)));
        endHourController =
            FixedExtentScrollController(initialItem: endHourList(endTime.value!).indexOf(getHourText(endTime.value!)));
        endMinuteController = FixedExtentScrollController(
            initialItem: endMinuteList(endTime.value!).indexOf(getMinuteText(endTime.value!)));
        break;
      default:
        break;
    }
  }

  void tapStartTime() {
    startOrEndFlag.value = true;
  }

  void tapEndTime() {
    startTime.value ??= DateTime.now();
    if (endTime.value == null || endTime.value!.isBefore(startTime.value!)) {
      endTime.value = startTime.value!.add(timeGap);
    }
    startOrEndFlag.value = false;
  }

  void updateStartByYMDW(context) {
    String dateText = getYMDWList(initialStartTime, context)[startYMDWController.selectedItem].substring(0, 10);
    DateTime date = DateTime.parse(dateText);
    startTime.value = DateTime(date.year, date.month, date.day, getStartHour(), getStartMinute());
  }

  void updateEndByYMDW(context) {
    String dateText = endYMDWList(context)[endYMDWController.selectedItem].substring(0, 10);
    DateTime date = DateTime.parse(dateText);
    if (endHourController.selectedItem >= endHourList(date).length) {
      endHourController.jumpToItem(0);
    }
    date = DateTime(date.year, date.month, date.day, getEndHour(date));
    if (endMinuteController.selectedItem >= endMinuteList(date).length) {
      endMinuteController.jumpToItem(0);
    }
    endTime.value = DateTime(date.year, date.month, date.day, getEndHour(date), getEndMinute(date));
    endYMDWChange.value = !endYMDWChange.value;
  }

  void updateEndByHour(context) {
    String dateText = endYMDWList(context)[endYMDWController.selectedItem].substring(0, 10);
    DateTime date = DateTime.parse(dateText);
    if (endHourController.selectedItem >= endHourList(date).length) {
      endHourController.jumpToItem(0);
    }
    date = DateTime(date.year, date.month, date.day, getEndHour(date));
    if (endMinuteController.selectedItem >= endMinuteList(date).length) {
      endMinuteController.jumpToItem(0);
    }
    endTime.value = DateTime(date.year, date.month, date.day, getEndHour(date), getEndMinute(date));
    endHourChange.value = !endHourChange.value;
  }

  void updateEndByMinute(context) {
    String dateText = endYMDWList(context)[endYMDWController.selectedItem].substring(0, 10);
    DateTime date = DateTime.parse(dateText);
    date = DateTime(date.year, date.month, date.day, getEndHour(date));
    endTime.value = DateTime(date.year, date.month, date.day, getEndHour(date), getEndMinute(date));
  }

  void updateStartYearOrMonth() {
    var date = DateTime(getStartYear(), getStartMonth());
    if (startDayController.selectedItem >= startDayList(date).length) {
      startDayController.jumpToItem(startDayList(date).length - 1);
    }
    updateStartTimeByDay();
    startMonthChange.value = !startMonthChange.value;
  }

  void updateStartTimeByDay() {
    startTime.value = DateTime(getStartYear(), getStartMonth(), getStartDay());
  }

  void updateEndTimeByDay() {
    endTime.value = DateTime(
      getEndYear(),
      getEndMonth(endTime.value!),
      getEndDay(endTime.value!),
    );
  }

  void updateEndTimeByMonth() {
    var date = DateTime(getEndYear(), getEndMonth(endTime.value!));
    if (endDayController.selectedItem >= endDayList(date).length) {
      endDayController.jumpToItem(endDayList(date).length - 1);
    }
    endTime.value = DateTime(getEndYear(), getEndMonth(date), getEndDay(date));
    endMonthChange.value = !endMonthChange.value;
  }

  void updateEndTimeByYear() {
    var date = DateTime(getEndYear());
    if (endMonthController.selectedItem >= endMonthList(date).length) {
      endMonthController.jumpToItem(endMonthList(date).length - 1);
    }
    date = DateTime(getEndYear(), getEndMonth(date));
    if (endDayController.selectedItem >= endDayList(date).length) {
      endDayController.jumpToItem(endDayList(date).length - 1);
    }
    endTime.value = DateTime(getEndYear(), getEndMonth(date), getEndDay(date));
    endYearChange.value = !endYearChange.value;
  }

  //检查提交的时间
  checkSubmitTime() {
    if (startTime.value == null || endTime.value == null) return;
  }
}
