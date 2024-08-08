import 'package:habit/habit.dart';
import 'package:intl/intl.dart';

import '../../../../../generated/l10n.dart';

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
  return "${getMonthText(date)}${getLanguage<S>().LMID_00012413}${getDayText(date)}${getLanguage<S>().LMID_00012289} ${getWeekString(date.weekday, context)}";
}

String getYMDText(DateTime date, context) {
  return "${date.year}${getLanguage<S>().LMID_00011395}${getMonthText(date)}${getLanguage<S>().LMID_00012413}${getDayText(date)}${getLanguage<S>().LMID_00012289}";
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
      getLanguage<S>().LMID_00021072,
      getLanguage<S>().LMID_00021073,
      getLanguage<S>().LMID_00021074,
      getLanguage<S>().LMID_00021075,
      getLanguage<S>().LMID_00021076,
      getLanguage<S>().LMID_00021077,
      getLanguage<S>().LMID_00021078,
    ];
    if (abbreviationWeekArray.length > weekIndex - 1) {
      return abbreviationWeekArray[weekIndex - 1];
    }
  } else {
    final weekArray = [
      getLanguage<S>().LMID_00000834,
      getLanguage<S>().LMID_00000921,
      getLanguage<S>().LMID_00000846,
      getLanguage<S>().LMID_00001904,
      getLanguage<S>().LMID_00000916,
      getLanguage<S>().LMID_00001241,
      getLanguage<S>().LMID_00003749,
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
