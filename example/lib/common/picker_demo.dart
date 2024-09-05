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
          child: Text('Show Single Select List Picker'),
          onPressed: () => _showSingleSelectListPicker(context),
        ),
        ElevatedButton(
          child: Text('Show Multi Select Grid Picker'),
          onPressed: () => _showMultiSelectGridPicker(context),
        ),
        ElevatedButton(
          child: Text('Show Multi Wheel Picker'),
          onPressed: () => _showMultiWheelPicker(context),
        ),
      ],
    );
  }

  void _showSingleSelectListPicker(BuildContext context) {
    final items = [
      PickerItemUI(data: PickerItemData(key: '1', value: 'Apple')),
      PickerItemUI(data: PickerItemData(key: '2', value: 'Banana')),
      PickerItemUI(data: PickerItemData(key: '3', value: 'Cherry')),
      PickerItemUI(data: PickerItemData(key: '4', value: 'Date')),
    ];

    showJuiPicker(
      context: context,
      config: PickerConfig(
        layout: PickerLayout.iosWheel,
        headerConfig: PickerHeaderConfig(title: 'Select a Fruit'),
      ),
      items: items,
      initialSelection: [items[1].data], // Banana is initially selected
      onSelect: (selectedKeys, selectedValues) {
        print('Selected: $selectedValues');
      },
    );
  }

  void _showMultiSelectGridPicker(BuildContext context) {
    final items = [
      PickerItemUI(data: PickerItemData(key: 'red', value: 'Red')),
      PickerItemUI(data: PickerItemData(key: 'blue', value: 'Blue')),
      PickerItemUI(data: PickerItemData(key: 'green', value: 'Green')),
      PickerItemUI(data: PickerItemData(key: 'yellow', value: 'Yellow')),
      PickerItemUI(data: PickerItemData(key: 'purple', value: 'Purple')),
      PickerItemUI(data: PickerItemData(key: 'orange', value: 'Orange')),
    ];

    showJuiPicker(
      context: context,
      config: PickerConfig(
        layout: PickerLayout.list,
        selectionMode: SelectionMode.multiple,
        headerConfig: PickerHeaderConfig(title: 'Select Colors'),
      ),
      items: items,
      initialSelection: [items[0].data, items[2].data], // Red and Green are initially selected
      onSelect: (selectedKeys, selectedValues) {
        print('Selected: $selectedValues');
      },
    );
  }

  void _showMultiWheelPicker(BuildContext context) {
    final yearItems = [
      PickerItemUI(data: PickerItemData(key: '2023', value: '2023')),
      PickerItemUI(data: PickerItemData(key: '2024', value: '2024')),
      PickerItemUI(data: PickerItemData(key: '2025', value: '2025')),
    ];

    final monthItems = [
      PickerItemUI(data: PickerItemData(key: '1', value: 'Jan')),
      PickerItemUI(data: PickerItemData(key: '2', value: 'Feb')),
      PickerItemUI(data: PickerItemData(key: '3', value: 'Mar')),
      // Add more months...
    ];

    final items = [
      PickerItemUI(data: PickerItemData(key: 'year', value: '年')),
      PickerItemUI(data: PickerItemData(key: 'month', value: '月')),
    ];

    showJuiPicker(
      context: context,
      config: PickerConfig(
        layout: PickerLayout.multiWheel,
        headerConfig: PickerHeaderConfig(title: 'Select Date'),
      ),
      items: items,
      initialSelection: [
        PickerItemData(key: '2024', value: '2024'),
        PickerItemData(key: '2', value: 'Feb')
      ],
      onSelect: (selectedKeys, selectedValues) {
        print('Selected: $selectedValues');
      },
    );
  }
}
