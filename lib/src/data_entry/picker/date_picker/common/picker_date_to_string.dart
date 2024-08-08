


import 'package:intl/intl.dart';

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

String getYMDWText(DateTime date, context, {bool isAbbreviation = false}) {
  return '${getDateStringFromDate(date, 'yyyy-MM-dd')} ${getWeekString(date.weekday, context, isAbbreviation: isAbbreviation)}';
}

String getMDWText(DateTime date, context) {
  return "${getMonthText(date)}${"月"}${getDayText(date)}${"日"} ${getWeekString(date.weekday, context)}";
}

String getYMDText(DateTime date, context) {
  return "${date.year}${"年"}${getMonthText(date)}${"月"}${getDayText(date)}${"日"}";
}

String getWText(DateTime date, context) {
  return getWeekString(date.weekday, context);
}

String getHMText(DateTime date) {
  return "${getHourText(date)}:${getMinuteText(date)}";
}

String getWeekString(int weekIndex, context, {bool isAbbreviation = false}) {
  if (isAbbreviation) {
    final abbreviationWeekArray = [
      "周一",
      "周二",
      "周三",
      "周四",
      "周五",
      "周六",
      "周日",
    ];
    if (abbreviationWeekArray.length > weekIndex - 1) {
      return abbreviationWeekArray[weekIndex - 1];
    }
  } else {
    final weekArray = [
      "周一",
      "周二",
      "周三",
      "周四",
      "周五",
      "周六",
      "周日",
    ];
    if (weekArray.length > weekIndex - 1) {
      return weekArray[weekIndex - 1];
    }
  }

  return '';
}

String getDateStringFromDate(DateTime date, String formatterString) {
  return DateFormat(formatterString).format(date);
}
