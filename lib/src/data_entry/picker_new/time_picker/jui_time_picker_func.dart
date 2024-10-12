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

/// 构造函数参数
/// [context] 上下文环境，用于构建UI
/// [type] 时间选择器的类型
/// [mode] 时间选择器的模式，默认为单选模式
/// [initialTime] 初始时间，仅在单选模式下使用
/// [initialStartTime] 初始开始时间，仅在范围选择模式下使用
/// [initialEndTime] 初始结束时间，仅在范围选择模式下使用
/// [minTime] 可选的最小时间限制
/// [maxTime] 可选的最大时间限制
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
