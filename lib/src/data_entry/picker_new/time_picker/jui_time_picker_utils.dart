import 'jui_time_picker_func.dart';

class TimePickerUtils {
  final DateTime minTime;
  final DateTime maxTime;

  TimePickerUtils({required this.minTime, required this.maxTime});

  String formatDateTime(DateTime dateTime, TimePickerType type) {
    switch (type) {
      case TimePickerType.yearMonthSeparate:
        return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}';
      case TimePickerType.yearMonthDaySeparate:
      case TimePickerType.yearMonthDayCombined:
        return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
      case TimePickerType.yearMonthDayHourMinuteSeparate:
      case TimePickerType.yearMonthDayHourMinuteCombined:
        return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  DateTime updateTime(DateTime original, {int? year, int? month, int? day, int? hour, int? minute}) {
    return DateTime(
      year ?? original.year,
      month ?? original.month,
      day ?? original.day,
      hour ?? original.hour,
      minute ?? original.minute,
    );
  }

  DateTime normalizeDateTime(DateTime dateTime, TimePickerType type) {
    switch (type) {
      case TimePickerType.yearMonthSeparate:
        return DateTime(dateTime.year, dateTime.month);
      case TimePickerType.yearMonthDaySeparate:
      case TimePickerType.yearMonthDayCombined:
        return DateTime(dateTime.year, dateTime.month, dateTime.day);
      case TimePickerType.yearMonthDayHourMinuteSeparate:
      case TimePickerType.yearMonthDayHourMinuteCombined:
        return dateTime;
    }
  }

  List<int> getYears() {
    return List.generate(maxTime.year - minTime.year + 1, (index) => minTime.year + index);
  }

  List<int> getMonths(DateTime selectedTime) {
    if (selectedTime.year == minTime.year && selectedTime.year == maxTime.year) {
      return List.generate(maxTime.month - minTime.month + 1, (index) => minTime.month + index);
    } else if (selectedTime.year == minTime.year) {
      return List.generate(13 - minTime.month, (index) => minTime.month + index);
    } else if (selectedTime.year == maxTime.year) {
      return List.generate(maxTime.month, (index) => index + 1);
    }
    return List.generate(12, (index) => index + 1);
  }

  List<int> getDays(DateTime selectedTime) {
    int daysInMonth = DateTime(selectedTime.year, selectedTime.month + 1, 0).day;
    int startDay = (selectedTime.year == minTime.year && selectedTime.month == minTime.month) ? minTime.day : 1;
    int endDay = (selectedTime.year == maxTime.year && selectedTime.month == maxTime.month) ? maxTime.day : daysInMonth;
    return List.generate(endDay - startDay + 1, (index) => startDay + index);
  }

  List<int> getHours(DateTime selectedTime) {
    if (selectedTime.year == minTime.year && selectedTime.month == minTime.month && selectedTime.day == minTime.day) {
      return List.generate(24 - minTime.hour, (index) => minTime.hour + index);
    } else if (selectedTime.year == maxTime.year &&
        selectedTime.month == maxTime.month &&
        selectedTime.day == maxTime.day) {
      return List.generate(maxTime.hour + 1, (index) => index);
    }
    return List.generate(24, (index) => index);
  }

  List<int> getMinutes(DateTime selectedTime) {
    if (selectedTime.year == minTime.year &&
        selectedTime.month == minTime.month &&
        selectedTime.day == minTime.day &&
        selectedTime.hour == minTime.hour) {
      return List.generate(60 - minTime.minute, (index) => minTime.minute + index);
    } else if (selectedTime.year == maxTime.year &&
        selectedTime.month == maxTime.month &&
        selectedTime.day == maxTime.day &&
        selectedTime.hour == maxTime.hour) {
      return List.generate(maxTime.minute + 1, (index) => index);
    }
    return List.generate(60, (index) => index);
  }
}
