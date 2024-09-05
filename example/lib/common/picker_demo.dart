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
          child: Text('显示 Picker'),
          onPressed: () {
            _showPicker(context);
          },
        ),
        ElevatedButton(
          child: Text('选择城市'),
          onPressed: () => _showCityPicker(context),
        )
      ],
    );
  }

  void _showPicker(BuildContext context) {
// 创建自定义的 PickerConfig
    final customConfig = PickerConfig(
      layout: PickerLayout.grid, // 使用网格布局而不是默认的列表布局
      selectionMode: SelectionMode.multiple, // 允许多选
      uiConfig: PickerUIConfig(
        topBorderRadius: BorderRadius.circular(16), // 自定义顶部圆角
        maxHeight: 500, // 自定义最大高度
      ),
      headerConfig: PickerHeaderConfig(
        title: '选择物品',
        cancelText: '关闭', // 自定义取消按钮文本
        confirmText: '完成', // 自定义确认按钮文本
        cancelTextStyle: TextStyle(color: Colors.red), // 自定义取消按钮样式
        confirmTextStyle: TextStyle(color: Colors.green), // 自定义确认按钮样式
      ),
    );

    // 创建 PickerItem 列表
    final items = [
      PickerItem(key: '1', value: '苹果', icon: Icon(Icons.apple)),
      PickerItem(key: '2', value: '香蕉', icon: Icon(Icons.beach_access)),
      PickerItem(key: '3', value: '葡萄', icon: Icon(Icons.grain)),
    ];

    // 显示 Picker
    showJuiPicker(
      context: context,
      config: customConfig,
      items: items,
      initialSelection: ['1'], // 默认选中苹果
      onSelect: (selectedKeys, selectedValues) {
        print('Selected keys: $selectedKeys');
        print('Selected values: $selectedValues');
      },
      onCancel: () {
        print('Picker cancelled');
      },
    );
  }

  void _showCityPicker(BuildContext context) {
    // 使用默认配置，只自定义标题
    final config = PickerConfig(
      layout: PickerLayout.list, // 使用默认的列表布局
      headerConfig: PickerHeaderConfig(
        title: '选择城市',
        // 其他头部配置使用默认值
      ),
      // 使用默认的 UI 配置和选择模式
    );

    // 创建城市列表
    final cities = [
      PickerItem(key: 'BJ', value: '北京'),
      PickerItem(key: 'SH', value: '上海'),
      PickerItem(key: 'GZ', value: '广州'),
      PickerItem(key: 'SZ', value: '深圳'),
      PickerItem(key: 'CD', value: '成都'),
      PickerItem(key: 'HZ', value: '杭州'),
      PickerItem(key: 'NJ', value: '南京'),
      PickerItem(key: 'WH', value: '武汉'),
      PickerItem(key: 'XA', value: '西安'),
      PickerItem(key: 'CQ', value: '重庆'),
      PickerItem(key: 'SY', value: '沈阳'),
      PickerItem(key: 'HRB', value: '哈尔滨'),
      PickerItem(key: 'ZZ', value: '郑州'),
      PickerItem(key: 'JN', value: '济南'),
      PickerItem(key: 'TJ', value: '天津'),
      PickerItem(key: 'DL', value: '大连'),
      PickerItem(key: 'QD', value: '青岛'),
      PickerItem(key: 'NB', value: '宁波'),
      PickerItem(key: 'XM', value: '厦门'),
      PickerItem(key: 'CS', value: '长沙'),
    ];

    // 显示 Picker
    showJuiPicker(
      context: context,
      config: config,
      items: cities,
      onSelect: (selectedKeys, selectedValues) {
        // 由于是单选模式，selectedKeys 和 selectedValues 都只会包含一个元素
        print('选中的城市代码: ${selectedKeys[0]}');
        print('选中的城市名称: ${selectedValues[0]}');

        // 显示选中的城市
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('您选择了: ${selectedValues[0]}')),
        );
      },
    );
  }
}
