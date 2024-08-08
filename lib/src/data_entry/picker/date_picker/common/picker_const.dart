import 'package:intl/intl.dart';

import '../date_picker_func.dart';

extension CustomDateTimeExtension on DateTime {
  bool isSameDay(DateTime date) {
    final dateFormat = DateFormat("yyyy-MM-dd");
    final date1 = dateFormat.format(this);
    final date2 = dateFormat.format(date);
    return date1 == date2;
  }
}

class TimeRange {
  final DateTime? min; //开始时间最小值 开始时间最大值默认当天
  final DateTime? max; //结束时间最大值 结束时间最小值由开始时间推算

  const TimeRange({required this.min, required this.max});
}

Duration getDefaultTimeGap(DatePickerType unit) {
  switch (unit) {
    case DatePickerType.SINGLE_YMD:
    case DatePickerType.scrollYMD:
      return const Duration(days: 1);
    default:
      return const Duration(minutes: 1);
  }
}
