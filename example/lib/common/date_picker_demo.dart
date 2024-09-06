import 'package:example/common/demo_base_page.dart';
import 'package:flutter/material.dart';
import 'package:jui/data_entry.dart';

class DatePickerDemo extends StatelessWidget {
  DatePickerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoBasePage(
      title: "标题文本",
      children: [
        ElevatedButton(
          child: Text('Year-Month Picker'),
          onPressed: () => _showYearMonthPicker(context),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          child: Text('Year-Month-Day Picker'),
          onPressed: () => _showYearMonthDayPicker(context),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          child: Text('Full Date-Time Picker'),
          onPressed: () => _showFullDateTimePicker(context),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          child: Text('Combined Year-Month-Day Picker'),
          onPressed: () => _showCombinedYearMonthDayPicker(context),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          child: Text('Combined Full Date-Time Picker'),
          onPressed: () => _showCombinedFullDateTimePicker(context),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          child: Text('Date Range Picker'),
          onPressed: () => _showDateRangePicker(context),
        ),
      ],
    );
  }
  void _showYearMonthPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomTimePicker(
          type: TimePickerType.yearMonthDayHourMinute,
          mode: TimePickerMode.single,
          onSingleTimeSelected: (DateTime time) {
            print('Selected Year-Month: ${time.year}-${time.month}');
            Navigator.pop(context);
          },
          onRangeTimeSelected: (_, __) {}, // Not used in this case
        );
      },
    );
  }

  void _showYearMonthDayPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomTimePicker(
          type: TimePickerType.yearMonthDayHourMinute,
          mode: TimePickerMode.single,
          onSingleTimeSelected: (DateTime time) {
            print('Selected Date: ${time.year}-${time.month}-${time.day}');
            Navigator.pop(context);
          },
          onRangeTimeSelected: (_, __) {}, // Not used in this case
        );
      },
    );
  }

  void _showFullDateTimePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomTimePicker(
          type: TimePickerType.yearMonthDayHourMinute,
          mode: TimePickerMode.single,
          onSingleTimeSelected: (DateTime time) {
            print('Selected Date-Time: ${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}');
            Navigator.pop(context);
          },
          onRangeTimeSelected: (_, __) {}, // Not used in this case
        );
      },
    );
  }

  void _showCombinedYearMonthDayPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomTimePicker(
          type: TimePickerType.yearMonthDayHourMinute,
          mode: TimePickerMode.single,
          onSingleTimeSelected: (DateTime time) {
            print('Selected Date: ${time.year}-${time.month}-${time.day}');
            Navigator.pop(context);
          },
          onRangeTimeSelected: (_, __) {}, // Not used in this case
        );
      },
    );
  }

  void _showCombinedFullDateTimePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomTimePicker(
          type: TimePickerType.yearMonthDayHourMinute,
          mode: TimePickerMode.single,
          onSingleTimeSelected: (DateTime time) {
            print('Selected Date-Time: ${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}');
            Navigator.pop(context);
          },
          onRangeTimeSelected: (_, __) {}, // Not used in this case
        );
      },
    );
  }

  void _showDateRangePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomTimePicker(
          type: TimePickerType.yearMonthDayHourMinute,
          mode: TimePickerMode.range,
          onSingleTimeSelected: (_) {}, // Not used in this case
          onRangeTimeSelected: (DateTime startTime, DateTime endTime) {
            print('Selected Date Range: ${startTime.year}-${startTime.month}-${startTime.day} to ${endTime.year}-${endTime.month}-${endTime.day}');
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
