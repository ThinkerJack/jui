import 'package:example/common/demo_base_page.dart';
import 'package:flutter/material.dart';
import 'package:jui/data_entry.dart';

class DatePickerDemo extends StatelessWidget {
  const DatePickerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoBasePage(
      title: "日期选择器演示",
      children: [
        _buildExample(
          context,
          '基础年月选择器',
              () => showCustomTimePicker(
            context: context,
            type: TimePickerType.yearMonthSeparate,
            mode: TimePickerMode.single,
          ),
        ),
        _buildExample(
          context,
          '带最小/最大值的年月日选择器',
              () => showCustomTimePicker(
            context: context,
            type: TimePickerType.yearMonthDaySeparate,
            mode: TimePickerMode.single,
            minTime: DateTime(2020, 10, 10),
            maxTime: DateTime(2025, 10, 10),
          ),
        ),
        _buildExample(
          context,
          '完整日期时间范围选择器',
              () => showCustomTimePicker(
            context: context,
            type: TimePickerType.yearMonthDayHourMinuteSeparate,
            mode: TimePickerMode.range,
            initialStartTime: DateTime(2023, 1, 1, 9, 0),
            initialEndTime: DateTime(2023, 1, 2, 17, 0),
          ),
        ),
        _buildExample(
          context,
          '带初始时间的组合日期选择器',
              () => showCustomTimePicker(
            context: context,
            type: TimePickerType.yearMonthDayCombined,
            mode: TimePickerMode.single,
            initialTime: DateTime(2023, 6, 15),
          ),
        ),
        _buildExample(
          context,
          '下周内的组合日期时间选择器',
              () => showCustomTimePicker(
            context: context,
            type: TimePickerType.yearMonthDayHourMinuteCombined,
            mode: TimePickerMode.single,
            minTime: DateTime.now(),
            maxTime: DateTime.now().add(const Duration(days: 7)),
          ),
        ),
      ],
    );
  }
  Widget _buildExample(BuildContext context, String title, Future<TimePickerModel?> Function() onTap) {
    return ListTile(
      title: Text(title),
      onTap: () async {
        final result = await onTap();
        if (result != null) {
          String message = _formatResult(result);
          print(message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      },
    );
  }

  String _formatResult(TimePickerModel result) {
    if (result.selectedTime != null) {
      return '选择的时间: ${_formatDateTime(result.selectedTime!)}';
    } else if (result.startTime != null && result.endTime != null) {
      return '开始时间: ${_formatDateTime(result.startTime!)}, 结束时间: ${_formatDateTime(result.endTime!)}';
    } else {
      return '未知结果';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}