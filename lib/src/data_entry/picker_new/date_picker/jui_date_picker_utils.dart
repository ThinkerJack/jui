// lib/src/data_entry/jui_date_picker/jui_date_picker_utils.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'jui_date_picker_types.dart';

List<String> getYearList(DateTime initDate, {JuiRangeType type = JuiRangeType.common, int? minYear, int? maxYear}) {
  List<String> list = [];
  int start, end;

  switch (type) {
    case JuiRangeType.common:
      start = initDate.year - 50;
      end = initDate.year + 50;
      break;
    case JuiRangeType.hasMin:
      start = minYear!;
      end = minYear + 100;
      break;
    case JuiRangeType.hasMax:
      start = maxYear! - 100;
      end = maxYear;
      break;
    case JuiRangeType.hasMinAndMax:
      start = minYear!;
      end = maxYear!;
      break;
  }

  for (int i = start; i <= end; i++) {
    list.add(i.toString());
  }

  return list;
}

List<String> getMonthList({JuiRangeType type = JuiRangeType.common, int minMonth = 1, int maxMonth = 12}) {
  List<String> list = [];
  int start, end;

  switch (type) {
    case JuiRangeType.common:
      start = 1;
      end = 12;
      break;
    case JuiRangeType.hasMin:
      start = minMonth;
      end = 12;
      break;
    case JuiRangeType.hasMax:
      start = 1;
      end = maxMonth;
      break;
    case JuiRangeType.hasMinAndMax:
      start = minMonth;
      end = maxMonth;
      break;
  }

  for (int i = start; i <= end; i++) {
    list.add(i.toString().padLeft(2, "0"));
  }

  return list;
}

List<String> getDayList({JuiRangeType type = JuiRangeType.common, int? startDay, int? days, required DateTime date}) {
  List<String> list = [];
  int totalDays = DateTime(date.year, date.month + 1, 0).day;
  int start = type == JuiRangeType.hasMin ? (startDay ?? 1) : 1;
  int end = type == JuiRangeType.hasMax ? (days ?? totalDays) : totalDays;

  for (int i = start; i <= end; i++) {
    list.add(i.toString().padLeft(2, "0"));
  }

  return list;
}

List<String> getEndYearList(DateTime startDate) {
  return getYearList(startDate, type: JuiRangeType.hasMin, minYear: startDate.year);
}

List<String> getEndMonthList(DateTime startTime, DateTime endTime, Duration timeGap) {
  if (endTime.year == startTime.add(timeGap).year) {
    return getMonthList(minMonth: startTime.add(timeGap).month, type: JuiRangeType.hasMin);
  } else {
    return getMonthList();
  }
}

List<String> getEndDayList(DateTime startTime, DateTime endTime, Duration timeGap) {
  if (endTime.year == startTime.add(timeGap).year && endTime.month == startTime.add(timeGap).month) {
    return getDayList(type: JuiRangeType.hasMin, startDay: startTime.add(timeGap).day, date: endTime);
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

String getMinuteText(DateTime date) {
  return date.minute.toString().padLeft(2, "0");
}

String getHourText(DateTime date) {
  return date.hour.toString().padLeft(2, "0");
}

String getMonthText(DateTime date) {
  return date.month.toString().padLeft(2, "0");
}

String getDayText(DateTime date) {
  return date.day.toString().padLeft(2, "0");
}

String getYMDWText(DateTime date, BuildContext context, {bool isAbbreviation = false}) {
  return '${getDateStringFromDate(date, 'yyyy-MM-dd')} ${getWeekString(date.weekday, context, isAbbreviation: isAbbreviation)}';
}

String getMDWText(DateTime date, BuildContext context) {
  return "${getMonthText(date)}月${getDayText(date)}日 ${getWeekString(date.weekday, context)}";
}

String getYMDText(DateTime date, BuildContext context) {
  return "${date.year}年${getMonthText(date)}月${getDayText(date)}日";
}

String getWText(DateTime date, BuildContext context) {
  return getWeekString(date.weekday, context);
}

String getHMText(DateTime date) {
  return "${getHourText(date)}:${getMinuteText(date)}";
}

String getWeekString(int weekIndex, BuildContext context, {bool isAbbreviation = false}) {
  final weekArray = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];
  if (weekArray.length > weekIndex - 1) {
    return weekArray[weekIndex - 1];
  }
  return '';
}

String getDateStringFromDate(DateTime date, String formatterString) {
  return DateFormat(formatterString).format(date);
}

extension JuiDateTimeExtension on DateTime {
  bool isSameDay(DateTime date) {
    final dateFormat = DateFormat("yyyy-MM-dd");
    final date1 = dateFormat.format(this);
    final date2 = dateFormat.format(date);
    return date1 == date2;
  }
}

Duration getDefaultTimeGap(JuiDatePickerMode mode) {
  switch (mode) {
    case JuiDatePickerMode.scrollYMD:
      return const Duration(days: 1);
    default:
      return const Duration(minutes: 1);
  }
}