import 'package:flutter/material.dart';
import 'package:jui/data_entry.dart';

import 'demo_base_page.dart';

class PickerDemo extends StatefulWidget {
  const PickerDemo({Key? key}) : super(key: key);

  @override
  State<PickerDemo> createState() => _PickerDemoState();
}

class _PickerDemoState extends State<PickerDemo> {
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
        headerConfig: JuiPickerHeaderConfig(title: 'Select a Fruit'),
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
    ];

    showJuiSelectPicker(
      context: context,
      config: JuiSelectPickerConfig(
        layout: JuiSelectPickerLayout.list,
        selectionMode: SelectionMode.multiple,
        headerConfig: JuiPickerHeaderConfig(title: 'Select Colors'),
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
    ];

    showJuiSelectPicker(
      context: context,
      config: JuiSelectPickerConfig(
        layout: JuiSelectPickerLayout.action,
        selectionMode: SelectionMode.single,
        headerConfig: JuiPickerHeaderConfig(title: 'Select Colors'),
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
