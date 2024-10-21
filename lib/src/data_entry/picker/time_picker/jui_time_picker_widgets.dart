// file: custom_time_picker_widgets.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomWheelPicker extends StatelessWidget {
  final List<int> items;
  final FixedExtentScrollController controller;
  final Function(int) onSelectedItemChanged;

  const CustomWheelPicker({
    Key? key,
    required this.items,
    required this.controller,
    required this.onSelectedItemChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (notification.depth == 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onSelectedItemChanged(controller.selectedItem);
          });
        }
        return true;
      },
      child: CupertinoPicker(
        itemExtent: 32,
        scrollController: controller,
        onSelectedItemChanged: (_) {},
        children: items.map((item) => Center(child: Text('$item'))).toList(),
      ),
    );
  }
}

class TimeDisplay extends StatelessWidget {
  final VoidCallback tapStart;
  final VoidCallback tapEnd;
  final String startTime;
  final String endTime;
  final bool isSelectingStartTime;

  const TimeDisplay({
    Key? key,
    required this.tapStart,
    required this.tapEnd,
    required this.startTime,
    required this.endTime,
    required this.isSelectingStartTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: tapStart,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelectingStartTime ? Colors.blue : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('开始时间', style: TextStyle(fontSize: 12)),
                    Text(startTime, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: tapEnd,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: !isSelectingStartTime ? Colors.blue : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('结束时间', style: TextStyle(fontSize: 12)),
                    Text(endTime, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
