import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../data_entry.dart';
import '../common/jui_picker_header.dart';
import 'jui_time_picker_utils.dart';
import 'jui_time_picker_widgets.dart';

class CustomTimePicker extends StatefulWidget {
  final TimePickerType type;
  final TimePickerMode mode;
  final DateTime? initialTime;
  final DateTime? initialStartTime;
  final DateTime? initialEndTime;
  final DateTime? minTime;
  final DateTime? maxTime;

  const CustomTimePicker({
    super.key,
    required this.type,
    required this.mode,
    this.initialTime,
    this.initialStartTime,
    this.initialEndTime,
    this.minTime,
    this.maxTime,
  });

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late DateTime _selectedTime;
  late DateTime _startTime;
  late DateTime _endTime;
  late DateTime _minTime;
  late DateTime _maxTime;
  bool _isSelectingStartTime = true;

  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _combinedYearMonthDayController;
  late FixedExtentScrollController _combinedYearMonthDayHourMinuteController;
  late TimePickerUtils _timePickerUtils;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    DateTime now = DateTime.now();
    _minTime = widget.minTime ?? DateTime(now.year - 100, 1, 1);
    _maxTime = widget.maxTime ?? DateTime(now.year + 100, 12, 31);
    _timePickerUtils = TimePickerUtils(minTime: _minTime, maxTime: _maxTime);
    _selectedTime = _timePickerUtils.normalizeDateTime(widget.initialTime ?? now, widget.type);
    _startTime = _timePickerUtils.normalizeDateTime(widget.initialStartTime ?? now, widget.type);
    _endTime =
        _timePickerUtils.normalizeDateTime(widget.initialEndTime ?? _startTime.add(Duration(days: 1)), widget.type);
    _minTime = widget.minTime ?? DateTime(now.year - 100, 1, 1);
    _maxTime = widget.maxTime ?? DateTime(now.year + 100, 12, 31);

    _initScrollControllers();
  }

  void _initScrollControllers() {
    _yearController = FixedExtentScrollController(initialItem: _timePickerUtils.getYears().indexOf(_selectedTime.year));
    _monthController = FixedExtentScrollController(
        initialItem: _timePickerUtils.getMonths(_selectedTime).indexOf(_selectedTime.month));
    _dayController =
        FixedExtentScrollController(initialItem: _timePickerUtils.getDays(_selectedTime).indexOf(_selectedTime.day));
    _hourController =
        FixedExtentScrollController(initialItem: _timePickerUtils.getHours(_selectedTime).indexOf(_selectedTime.hour));
    _minuteController = FixedExtentScrollController(
        initialItem: _timePickerUtils.getMinutes(_selectedTime).indexOf(_selectedTime.minute));
    _combinedYearMonthDayController =
        FixedExtentScrollController(initialItem: _getCombinedYearMonthDayIndex(_selectedTime));
    _combinedYearMonthDayHourMinuteController =
        FixedExtentScrollController(initialItem: _getCombinedYearMonthDayHourMinuteIndex(_selectedTime));
  }

  int _getCombinedYearMonthDayIndex(DateTime date) {
    return date.difference(_minTime).inDays;
  }

  int _getCombinedYearMonthDayHourMinuteIndex(DateTime date) {
    return date.difference(_minTime).inMinutes;
  }

  DateTime _getDateTimeFromCombinedIndex(int index, bool includeTime) {
    return includeTime ? _minTime.add(Duration(minutes: index)) : _minTime.add(Duration(days: index));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        JuiPickerHeader(
            title: "选择时间",
            titleLeftText: const JuiPickerHeaderConfig().cancelText,
            titleRightText: const JuiPickerHeaderConfig().confirmText,
            onConfirm: () {
              if (widget.mode == TimePickerMode.single) {
                Navigator.of(context).pop(TimePickerModel(selectedTime: _selectedTime));
              } else {
                Navigator.of(context).pop(TimePickerModel(startTime: _startTime, endTime: _endTime));
              }
            },
            onCancel: () => Navigator.of(context).pop()),
        if (widget.mode == TimePickerMode.range) _buildTimeDisplay(),
        _buildContent(),
      ],
    );
  }

  Widget _buildTimeDisplay() {
    return TimeDisplay(
      startTime: _timePickerUtils.formatDateTime(_startTime, widget.type),
      endTime: _timePickerUtils.formatDateTime(_endTime, widget.type),
      tapStart: () => _selectTime(true),
      tapEnd: () => _selectTime(false),
      isSelectingStartTime: _isSelectingStartTime,
    );
  }

  void _selectTime(bool isStart) {
    setState(() {
      _isSelectingStartTime = isStart;
      _scrollToTime(isStart ? _startTime : _endTime);
    });
  }

  void _scrollToTime(DateTime time) {
    switch (widget.type) {
      case TimePickerType.yearMonthSeparate:
        _yearController.jumpToItem(_timePickerUtils.getYears().indexOf(time.year));
        _monthController.jumpToItem(_timePickerUtils.getMonths(_selectedTime).indexOf(time.month));
        break;
      case TimePickerType.yearMonthDaySeparate:
        _yearController.jumpToItem(_timePickerUtils.getYears().indexOf(time.year));
        _monthController.jumpToItem(_timePickerUtils.getMonths(_selectedTime).indexOf(time.month));
        _dayController.jumpToItem(_timePickerUtils.getDays(_selectedTime).indexOf(time.day));
        break;
      case TimePickerType.yearMonthDayHourMinuteSeparate:
        _yearController.jumpToItem(_timePickerUtils.getYears().indexOf(time.year));
        _monthController.jumpToItem(_timePickerUtils.getMonths(_selectedTime).indexOf(time.month));
        _dayController.jumpToItem(_timePickerUtils.getDays(_selectedTime).indexOf(time.day));
        _hourController.jumpToItem(_timePickerUtils.getHours(_selectedTime).indexOf(time.hour));
        _minuteController.jumpToItem(_timePickerUtils.getMinutes(_selectedTime).indexOf(time.minute));
        break;
      case TimePickerType.yearMonthDayCombined:
        _combinedYearMonthDayController.jumpToItem(_getCombinedYearMonthDayIndex(time));
        break;
      case TimePickerType.yearMonthDayHourMinuteCombined:
        _combinedYearMonthDayHourMinuteController.jumpToItem(_getCombinedYearMonthDayHourMinuteIndex(time));
        break;
    }
  }

  Widget _buildContent() {
    List<Widget> pickers = [];

    switch (widget.type) {
      case TimePickerType.yearMonthSeparate:
        pickers = [
          _buildPicker(_timePickerUtils.getYears(), _yearController,
              (index) => _updateDateTime(year: _timePickerUtils.getYears()[index])),
          _buildPicker(_timePickerUtils.getMonths(_selectedTime), _monthController,
              (index) => _updateDateTime(month: _timePickerUtils.getMonths(_selectedTime)[index])),
        ];
        break;
      case TimePickerType.yearMonthDaySeparate:
        pickers = [
          _buildPicker(_timePickerUtils.getYears(), _yearController,
              (index) => _updateDateTime(year: _timePickerUtils.getYears()[index])),
          _buildPicker(_timePickerUtils.getMonths(_selectedTime), _monthController, (index) {
            _updateDateTime(month: _timePickerUtils.getMonths(_selectedTime)[index]);
          }),
          _buildPicker(_timePickerUtils.getDays(_selectedTime), _dayController, (index) {
            _updateDateTime(day: _timePickerUtils.getDays(_selectedTime)[index]);
          }),
        ];
        break;
      case TimePickerType.yearMonthDayHourMinuteSeparate:
        pickers = [
          _buildPicker(_timePickerUtils.getYears(), _yearController,
              (index) => _updateDateTime(year: _timePickerUtils.getYears()[index])),
          _buildPicker(_timePickerUtils.getMonths(_selectedTime), _monthController,
              (index) => _updateDateTime(month: _timePickerUtils.getMonths(_selectedTime)[index])),
          _buildPicker(_timePickerUtils.getDays(_selectedTime), _dayController,
              (index) => _updateDateTime(day: _timePickerUtils.getDays(_selectedTime)[index])),
          _buildPicker(_timePickerUtils.getHours(_selectedTime), _hourController,
              (index) => _updateDateTime(hour: _timePickerUtils.getHours(_selectedTime)[index])),
          _buildPicker(_timePickerUtils.getMinutes(_selectedTime), _minuteController,
              (index) => _updateDateTime(minute: _timePickerUtils.getMinutes(_selectedTime)[index])),
        ];
        break;
      case TimePickerType.yearMonthDayCombined:
        pickers = [
          _buildCombinedPicker(_combinedYearMonthDayController, (index) => _updateDateTimeFromCombined(index),
              _getCombinedYearMonthDayIndex(_maxTime) + 1, false),
        ];
        break;
      case TimePickerType.yearMonthDayHourMinuteCombined:
        pickers = [
          _buildCombinedPicker(_combinedYearMonthDayHourMinuteController, (index) => _updateDateTimeFromCombined(index),
              _getCombinedYearMonthDayHourMinuteIndex(_maxTime) + 1, true),
        ];
        break;
    }

    return Container(
      height: 200,
      child: Row(
        children: pickers.map((picker) => Expanded(child: picker)).toList(),
      ),
    );
  }

  Widget _buildPicker(List<int> items, FixedExtentScrollController controller, Function(int) onSelectedItemChanged) {
    return CustomWheelPicker(onSelectedItemChanged: onSelectedItemChanged, items: items, controller: controller);
  }

  Widget _buildCombinedPicker(
      FixedExtentScrollController controller, Function(int) onSelectedItemChanged, int itemCount, bool includeTime) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (notification.depth == 0) {
          // 滚动结束时调用 onSelectedItemChanged
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onSelectedItemChanged(controller.selectedItem);
          });
        }
        return true;
      },
      child: CupertinoPicker.builder(
        itemExtent: 32,
        scrollController: controller,
        onSelectedItemChanged: (_) {},
        // 保留空的回调以满足 CupertinoPicker 的要求
        itemBuilder: (context, index) {
          DateTime date = _getDateTimeFromCombinedIndex(index, includeTime);
          return Center(child: Text(_timePickerUtils.formatDateTime(date, widget.type)));
        },
        childCount: itemCount,
      ),
    );
  }

  void _updateDateTime({int? year, int? month, int? day, int? hour, int? minute}) {
    setState(() {
      DateTime updatedTime;
      if (widget.mode == TimePickerMode.single) {
        updatedTime =
            _timePickerUtils.updateTime(_selectedTime, year: year, month: month, day: day, hour: hour, minute: minute);
        _selectedTime = _timePickerUtils.normalizeDateTime(updatedTime, widget.type);
      } else {
        if (_isSelectingStartTime) {
          updatedTime =
              _timePickerUtils.updateTime(_startTime, year: year, month: month, day: day, hour: hour, minute: minute);
          _startTime = _timePickerUtils.normalizeDateTime(updatedTime, widget.type);
          if (_startTime.isAfter(_endTime)) {
            _endTime = _startTime;
          }
        } else {
          updatedTime =
              _timePickerUtils.updateTime(_endTime, year: year, month: month, day: day, hour: hour, minute: minute);
          _endTime = _timePickerUtils.normalizeDateTime(updatedTime, widget.type);
          if (_endTime.isBefore(_startTime)) {
            _startTime = _endTime;
          }
        }
      }

      // 更新控制器
      if (year != null) _yearController.jumpToItem(_timePickerUtils.getYears().indexOf(year));
      if (month != null) {
        if (_selectedTime.month != month) {
          _selectedTime = updateSelectedTime(_selectedTime, month);
          _monthController.jumpToItem(_timePickerUtils.getMonths(_selectedTime).indexOf(month));
          _dayController.jumpToItem(_timePickerUtils.getDays(_selectedTime).indexOf(_selectedTime.day));
        }
        _monthController.jumpToItem(_timePickerUtils.getMonths(_selectedTime).indexOf(month));
      }

      if (day != null) _dayController.jumpToItem(_timePickerUtils.getDays(_selectedTime).indexOf(day));
      if (hour != null) _hourController.jumpToItem(_timePickerUtils.getHours(_selectedTime).indexOf(hour));
      if (minute != null) _minuteController.jumpToItem(_timePickerUtils.getMinutes(_selectedTime).indexOf(minute));
    });
  }

  DateTime updateSelectedTime(DateTime selectedTime, int month) {
    int year = selectedTime.year;
    // 获取目标月份的最大天数
    int maxDayInMonth = DateTime(year, month + 1, 0).day;
    DateTime updatedTime = DateTime(year, month, maxDayInMonth, selectedTime.hour, selectedTime.minute);
    return updatedTime;
  }

  void _updateDateTimeFromCombined(int index) {
    setState(() {
      DateTime updatedTime =
          _getDateTimeFromCombinedIndex(index, widget.type == TimePickerType.yearMonthDayHourMinuteCombined);
      if (widget.mode == TimePickerMode.single) {
        _selectedTime = _timePickerUtils.normalizeDateTime(updatedTime, widget.type);
      } else {
        if (_isSelectingStartTime) {
          _startTime = _timePickerUtils.normalizeDateTime(updatedTime, widget.type);
          if (_startTime.isAfter(_endTime)) {
            _endTime = _startTime;
          }
        } else {
          _endTime = _timePickerUtils.normalizeDateTime(updatedTime, widget.type);
          _endTime = _timePickerUtils.normalizeDateTime(updatedTime, widget.type);
          if (_endTime.isBefore(_startTime)) {
            _startTime = _endTime;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    _combinedYearMonthDayController.dispose();
    _combinedYearMonthDayHourMinuteController.dispose();
    super.dispose();
  }
}
