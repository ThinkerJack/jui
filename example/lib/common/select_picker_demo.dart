import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jui/data_entry.dart';

import 'demo_base_page.dart';

class PickerDemo extends StatelessWidget {
  const PickerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoBasePage(
      title: "复选框",
      children: [
        ElevatedButton(
          child: Text('Show Wheel Picker'),
          onPressed: () => _showWheelPicker(context),
        ),
        ElevatedButton(
          child: Text('Show List Picker'),
          onPressed: () => _showListPicker(context),
        ),
        ElevatedButton(
          child: Text('Show Action Picker'),
          onPressed: () => _showActionPicker(context),
        ),
        ElevatedButton(
          child: Text('Select Date'),
          onPressed: () async {
            await showJuiDatePicker(
              context,
              mode: JuiDatePickerMode.scrollYMD,
              onDone: (DateTime selectedDate) {
                print('Selected date: $selectedDate');
                // 在这里处理选中的日期
              },
              initTime: DateTime.now(),
              title: '选择日期',
              showTopTitle: false,
            );
          },
        ),
        ElevatedButton(
          child: Text('Select Date Range'),
          onPressed: () async {
            await showJuiDatePicker(
              context,
              mode: JuiDatePickerMode.scrollYMDWHM,
              onDone: (DateTime startTime, DateTime? endTime) {
                print('Start date: $startTime');
                print('End date: $endTime');
                // 在这里处理选中的日期范围
              },
              startTime: DateTime.now(),
              endTime: DateTime.now().add(Duration(days: 7)),
              showTopTitle: true,
            );
          },
        ),
      ],
    );
  }

  void _showWheelPicker(BuildContext context) {
    final items = [
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: '1', value: 'Apple')),
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: '2', value: 'Banana')),
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: '3', value: 'Cherry')),
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: '4', value: 'Date')),
    ];

    showJuiSelectPicker(
      context: context,
      config: JuiSelectPickerConfig(
        layout: JuiSelectPickerLayout.wheel,
        headerConfig: JuiSelectPickerHeaderConfig(title: 'Select a Fruit'),
      ),
      items: items,
      initialSelection: [items[1].data],
      // Banana is initially selected
      onSelect: (selectedKeys, selectedValues) {
        print('Selected: $selectedValues');
      },
    );
  }

  void _showListPicker(BuildContext context) {
    final items = [
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: 'red', value: 'Red')),
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: 'blue', value: 'Blue')),
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: 'green', value: 'Green')),
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: 'yellow', value: 'Yellow')),
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: 'purple', value: 'Purple')),
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: 'orange', value: 'Orange')),
      // PickerItemUI(data: PickerItemData(key: 'orange2', value: 'Orange2')),
      // PickerItemUI(data: PickerItemData(key: 'orange3', value: 'Orange3')),
      // PickerItemUI(data: PickerItemData(key: 'orange4', value: 'Orange4')),
      // PickerItemUI(data: PickerItemData(key: 'orange5', value: 'Orange5')),
      // PickerItemUI(data: PickerItemData(key: 'orange6', value: 'Orange6')),
      // PickerItemUI(data: PickerItemData(key: 'orange7', value: 'Orange7')),
    ];

    showJuiSelectPicker(
      context: context,
      config: JuiSelectPickerConfig(
        layout: JuiSelectPickerLayout.list,
        selectionMode: SelectionMode.multiple,
        headerConfig: JuiSelectPickerHeaderConfig(title: 'Select Colors'),
      ),
      items: items,
      initialSelection: [items[0].data, items[2].data],
      // Red and Green are initially selected
      onSelect: (selectedKeys, selectedValues) {
        print('Selected: $selectedValues');
      },
    );
  }

  void _showActionPicker(BuildContext context) {
    final items = [
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: 'red', value: 'Red')),
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: 'blue', value: 'Blue')),
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: 'green', value: 'Green')),
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: 'yellow', value: 'Yellow')),
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: 'purple', value: 'Purple')),
      JuiSelectPickerItemUI(data: JuiSelectPickerItemData(key: 'orange', value: 'Orange')),
      // PickerItemUI(data: PickerItemData(key: 'orange2', value: 'Orange2')),
      // PickerItemUI(data: PickerItemData(key: 'orange3', value: 'Orange3')),
      // PickerItemUI(data: PickerItemData(key: 'orange4', value: 'Orange4')),
      // PickerItemUI(data: PickerItemData(key: 'orange5', value: 'Orange5')),
      // PickerItemUI(data: PickerItemData(key: 'orange6', value: 'Orange6')),
      // PickerItemUI(data: PickerItemData(key: 'orange7', value: 'Orange7')),
    ];

    showJuiSelectPicker(
      context: context,
      config: JuiSelectPickerConfig(
        layout: JuiSelectPickerLayout.action,
        selectionMode: SelectionMode.single,
        headerConfig: JuiSelectPickerHeaderConfig(title: 'Select Colors'),
      ),
      items: items,
      initialSelection: [items[0].data],
      // Red and Green are initially selected
      onSelect: (selectedKeys, selectedValues) {
        print('Selected: $selectedValues');
      },
    );
  }
}
