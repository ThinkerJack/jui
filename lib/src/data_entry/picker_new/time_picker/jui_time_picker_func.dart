// file: custom_time_picker_show.dart

import 'package:flutter/material.dart';

import 'jui_time_picker_view.dart';

enum TimePickerType {
  yearMonthSeparate,
  yearMonthDaySeparate,
  yearMonthDayHourMinuteSeparate,
  yearMonthDayCombined,
  yearMonthDayHourMinuteCombined
}

enum TimePickerMode { single, range }

class TimePickerModel {
  final DateTime? selectedTime;
  final DateTime? startTime;
  final DateTime? endTime;

  TimePickerModel({this.selectedTime, this.startTime, this.endTime});
}

Future<TimePickerModel?> showCustomTimePicker({
  required BuildContext context,
  required TimePickerType type,
  TimePickerMode mode = TimePickerMode.single,
  DateTime? initialTime,
  DateTime? initialStartTime,
  DateTime? initialEndTime,
  DateTime? minTime,
  DateTime? maxTime,
}) {
  return showModalBottomSheet<TimePickerModel?>(
    context: context,
    builder: (BuildContext context) {
      return CustomTimePicker(
        type: type,
        mode: mode,
        initialTime: initialTime,
        initialStartTime: initialStartTime,
        initialEndTime: initialEndTime,
        minTime: minTime,
        maxTime: maxTime,
      );
    },
  );
}
