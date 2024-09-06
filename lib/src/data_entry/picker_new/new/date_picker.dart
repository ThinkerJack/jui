import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TimePickerType { yearMonth, yearMonthDay, yearMonthDayHourMinute }

enum TimePickerMode { single, range }

class CustomTimePicker extends StatefulWidget {
  final TimePickerType type;
  final TimePickerMode mode;
  final DateTime? initialTime;
  final DateTime? initialStartTime;
  final DateTime? initialEndTime;
  final DateTime? minTime;
  final DateTime? maxTime;
  final Function(DateTime time) onSingleTimeSelected;
  final Function(DateTime startTime, DateTime endTime) onRangeTimeSelected;

  CustomTimePicker({
    required this.type,
    required this.mode,
    this.initialTime,
    this.initialStartTime,
    this.initialEndTime,
    this.minTime,
    this.maxTime,
    required this.onSingleTimeSelected,
    required this.onRangeTimeSelected,
  });

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late List<int> _years;
  late List<int> _months;
  late List<int> _days;
  late List<int> _hours;
  late List<int> _minutes;

  late DateTime _selectedTime;
  late DateTime _startTime;
  late DateTime _endTime;
  bool _isSelectingStartTime = true;

  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    DateTime now = DateTime.now();
    _selectedTime = _normalizeDateTime(widget.initialTime ?? now);
    _startTime = _normalizeDateTime(widget.initialStartTime ?? now);
    _endTime = _normalizeDateTime(widget.initialEndTime ?? _startTime.add(Duration(days: 1)));
    DateTime minTime = widget.minTime ?? DateTime(now.year - 100, 1, 1);
    DateTime maxTime = widget.maxTime ?? DateTime(now.year + 100, 12, 31);

    _years = List.generate(maxTime.year - minTime.year + 1, (index) => minTime.year + index);
    _months = List.generate(12, (index) => index + 1);
    _updateDays(_selectedTime.year, _selectedTime.month);

    if (widget.type == TimePickerType.yearMonthDayHourMinute) {
      _hours = List.generate(24, (index) => index);
      _minutes = List.generate(60, (index) => index);
    }

    _initScrollControllers();
  }

  void _initScrollControllers() {
    _yearController = FixedExtentScrollController(initialItem: _years.indexOf(_selectedTime.year));
    _monthController = FixedExtentScrollController(initialItem: _selectedTime.month - 1);
    _dayController = FixedExtentScrollController(initialItem: _selectedTime.day - 1);
    if (widget.type == TimePickerType.yearMonthDayHourMinute) {
      _hourController = FixedExtentScrollController(initialItem: _selectedTime.hour);
      _minuteController = FixedExtentScrollController(initialItem: _selectedTime.minute);
    }
  }

  DateTime _normalizeDateTime(DateTime dateTime) {
    switch (widget.type) {
      case TimePickerType.yearMonth:
        return DateTime(dateTime.year, dateTime.month);
      case TimePickerType.yearMonthDay:
        return DateTime(dateTime.year, dateTime.month, dateTime.day);
      case TimePickerType.yearMonthDayHourMinute:
        return dateTime;
    }
  }

  void _updateDays(int year, int month) {
    int daysInMonth = DateTime(year, month + 1, 0).day;
    _days = List.generate(daysInMonth, (index) => index + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        if (widget.mode == TimePickerMode.range) _buildTimeDisplay(),
        _buildContent(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('取消'),
          ),
          Text(
            widget.mode == TimePickerMode.single ? '选择时间' : '选择时间范围',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              if (widget.mode == TimePickerMode.single) {
                widget.onSingleTimeSelected(_selectedTime);
              } else {
                widget.onRangeTimeSelected(_startTime, _endTime);
              }
              Navigator.of(context).pop();
            },
            child: Text('确定'),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDisplay() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelectingStartTime = true;
                  _scrollToTime(_startTime);
                });
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isSelectingStartTime ? Colors.blue : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('开始时间', style: TextStyle(fontSize: 12)),
                    Text(_formatDateTime(_startTime), style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelectingStartTime = false;
                  _scrollToTime(_endTime);
                });
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: !_isSelectingStartTime ? Colors.blue : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('结束时间', style: TextStyle(fontSize: 12)),
                    Text(_formatDateTime(_endTime), style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToTime(DateTime time) {
    _yearController.jumpToItem(_years.indexOf(time.year));
    _monthController.jumpToItem(time.month - 1);
    _dayController.jumpToItem(time.day - 1);
    if (widget.type == TimePickerType.yearMonthDayHourMinute) {
      _hourController.jumpToItem(time.hour);
      _minuteController.jumpToItem(time.minute);
    }
  }

  String _formatDateTime(DateTime dateTime) {
    switch (widget.type) {
      case TimePickerType.yearMonth:
        return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}';
      case TimePickerType.yearMonthDay:
        return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
      case TimePickerType.yearMonthDayHourMinute:
        return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  Widget _buildContent() {
    List<Widget> pickers = [];

    switch (widget.type) {
      case TimePickerType.yearMonth:
        pickers = [
          _buildPicker(_years, _yearController, (index) => _updateDateTime(year: _years[index])),
          _buildPicker(_months, _monthController, (index) => _updateDateTime(month: index + 1)),
        ];
        break;
      case TimePickerType.yearMonthDay:
        pickers = [
          _buildPicker(_years, _yearController, (index) => _updateDateTime(year: _years[index])),
          _buildPicker(_months, _monthController, (index) => _updateDateTime(month: index + 1)),
          _buildPicker(_days, _dayController, (index) => _updateDateTime(day: index + 1)),
        ];
        break;
      case TimePickerType.yearMonthDayHourMinute:
        pickers = [
          _buildPicker(_years, _yearController, (index) => _updateDateTime(year: _years[index])),
          _buildPicker(_months, _monthController, (index) => _updateDateTime(month: index + 1)),
          _buildPicker(_days, _dayController, (index) => _updateDateTime(day: index + 1)),
          _buildPicker(_hours, _hourController, (index) => _updateDateTime(hour: index)),
          _buildPicker(_minutes, _minuteController, (index) => _updateDateTime(minute: index)),
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
    return CupertinoPicker(
      itemExtent: 32,
      scrollController: controller,
      onSelectedItemChanged: onSelectedItemChanged,
      children: items.map((item) => Center(child: Text('$item'))).toList(),
    );
  }

  void _updateDateTime({int? year, int? month, int? day, int? hour, int? minute}) {
    setState(() {
      DateTime updatedTime;
      if (widget.mode == TimePickerMode.single) {
        updatedTime = _updateTime(_selectedTime, year: year, month: month, day: day, hour: hour, minute: minute);
        _selectedTime = _normalizeDateTime(updatedTime);
      } else {
        if (_isSelectingStartTime) {
          updatedTime = _updateTime(_startTime, year: year, month: month, day: day, hour: hour, minute: minute);
          _startTime = _normalizeDateTime(updatedTime);
          if (_startTime.isAfter(_endTime)) {
            _endTime = _startTime;
          }
        } else {
          updatedTime = _updateTime(_endTime, year: year, month: month, day: day, hour: hour, minute: minute);
          _endTime = _normalizeDateTime(updatedTime);
          if (_endTime.isBefore(_startTime)) {
            _startTime = _endTime;
          }
        }
      }
      if (year != null || month != null) {
        _updateDays(
          widget.mode == TimePickerMode.single
              ? _selectedTime.year
              : (_isSelectingStartTime ? _startTime.year : _endTime.year),
          widget.mode == TimePickerMode.single
              ? _selectedTime.month
              : (_isSelectingStartTime ? _startTime.month : _endTime.month),
        );
      }
    });
  }

  DateTime _updateTime(DateTime original, {int? year, int? month, int? day, int? hour, int? minute}) {
    return DateTime(
      year ?? original.year,
      month ?? original.month,
      day ?? original.day,
      hour ?? original.hour,
      minute ?? original.minute,
    );
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    if (widget.type == TimePickerType.yearMonthDayHourMinute) {
      _hourController.dispose();
      _minuteController.dispose();
    }
    super.dispose();
  }
}
