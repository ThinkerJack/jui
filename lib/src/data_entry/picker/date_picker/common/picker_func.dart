import 'package:flutter/cupertino.dart';
import 'package:jac_uikit/src/data_entry/picker/date_picker/common/picker_date_to_string.dart';

enum RangeType { hasMin, hasMax, common, hasMinAndMax }

List<String> getYearList(DateTime initDate, {RangeType type = RangeType.common, int? minYear, int? maxYear}) {
  List<String> list = [];
  int start, end;

  switch (type) {
    case RangeType.common:
      start = initDate.year - 50;
      end = initDate.year + 50;
      break;
    case RangeType.hasMin:
      start = minYear!;
      end = minYear + 100;
      break;
    case RangeType.hasMax:
      start = maxYear! - 100;
      end = maxYear;
      break;
    case RangeType.hasMinAndMax:
      start = minYear!;
      end = maxYear!;
      break;
  }

  for (int i = start; i <= end; i++) {
    list.add(i.toString());
  }

  return list;
}

List<String> getMonthList({RangeType type = RangeType.common, int minMonth = 1, int maxMonth = 12}) {
  List<String> list = [];
  int start, end;

  switch (type) {
    case RangeType.common:
      start = 1;
      end = 12;
      break;
    case RangeType.hasMin:
      start = minMonth;
      end = 12;
      break;
    case RangeType.hasMax:
      start = 1;
      end = maxMonth;
      break;
    case RangeType.hasMinAndMax:
      start = minMonth;
      end = maxMonth;
      break;
  }

  for (int i = start; i <= end; i++) {
    list.add(i.toString().padLeft(2, "0"));
  }

  return list;
}

List<String> getDayList({RangeType type = RangeType.common, int? startDay, int? days, required DateTime date}) {
  List<String> list = [];
  int totalDays = DateTime(date.year, date.month + 1, 0).day;
  int start = type == RangeType.hasMin ? (startDay ?? 1) : 1;
  int end = type == RangeType.hasMax ? (days ?? totalDays) : totalDays;

  for (int i = start; i <= end; i++) {
    list.add(i.toString().padLeft(2, "0"));
  }

  return list;
}

List<String> getEndYearList(DateTime startDate) {
  return getYearList(startDate, type: RangeType.hasMin, minYear: startDate.year);
}

List<String> getEndMonthList(DateTime startTime, DateTime endTime, Duration timeGap) {
  if (endTime.year == startTime.add(timeGap).year) {
    return getMonthList(minMonth: startTime.add(timeGap).month, type: RangeType.hasMin);
  } else {
    return getMonthList();
  }
}

List<String> getEndDayList(DateTime startTime, DateTime endTime, Duration timeGap) {
  if (endTime.year == startTime.add(timeGap).year && endTime.month == startTime.add(timeGap).month) {
    return getDayList(type: RangeType.hasMin, startDay: startTime.add(timeGap).day, date: endTime);
  } else {
    return getDayList(date: endTime);
  }
}

List<String> getHourList() {
  return List.generate(24, (i) => i.toString().padLeft(2, "0"));
}

List<String> getEndHourList(DateTime startTime, DateTime endTime, Duration timeGap) {
  if (endTime.year == startTime.add(timeGap).year &&
      endTime.month == startTime.add(timeGap).month &&
      endTime.day == startTime.add(timeGap).day) {
    int startHour = startTime.add(timeGap).hour;
    return List.generate(24 - startHour, (i) => (startHour + i).toString().padLeft(2, "0"));
  } else {
    return getHourList();
  }
}

List<String> getMinuteList() {
  return List.generate(60, (i) => i.toString().padLeft(2, "0"));
}

List<String> getEndMinuteList(DateTime startTime, DateTime endTime, Duration timeGap) {
  if (endTime.year == startTime.add(timeGap).year &&
      endTime.month == startTime.add(timeGap).month &&
      endTime.day == startTime.add(timeGap).day &&
      endTime.hour == startTime.add(timeGap).hour) {
    int startMinute = startTime.add(timeGap).minute;
    return List.generate(60 - startMinute, (i) => (startMinute + i).toString().padLeft(2, "0"));
  } else {
    return getMinuteList();
  }
}

List<String> getYMDWList(DateTime date, BuildContext context) {
  return List.generate(731, (i) => getYMDWText(date.add(Duration(days: i - 365)), context));
}

List<String> getEndYMDWList(DateTime startDate, BuildContext context) {
  return List.generate(731, (i) => getYMDWText(startDate.add(Duration(days: i)), context));
}
