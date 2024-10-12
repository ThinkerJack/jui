# Flutter UI组件文档

## 目录
1. [通用组件](#通用组件)
    - [按钮](#按钮)
    - [虚线边框](#虚线边框)
2. [数据展示](#数据展示)
    - [展开收起文本](#展开收起文本)
    - [高亮文本](#高亮文本)
    - [标签](#标签)
    - [空页面](#空页面)
3. [数据录入](#数据录入)
    - [复选框](#复选框)
    - [选择器](#选择器)
    - [时间选择器](#时间选择器)
4. [反馈](#反馈)
    - [对话框](#对话框)
5. [表单](#表单)
    - [通用参数](#表单通用参数)
    - [自定义表单](#自定义表单)
    - [文本详情表单](#文本详情表单)
    - [点击表单](#点击表单)
    - [范围表单](#范围表单)
    - [文本输入表单](#文本输入表单)

## 通用组件

### 按钮

JuiButton 组件用于创建各种样式和大小的按钮。

代码示例

```dart
JuiButton(
  colorType: JuiButtonColorType.blue,
  sizeType: JuiButtonSizeType.large,
  text: "大号蓝色按钮",
  onTap: () {},
)
```

主要参数

- `onTap`: 点击按钮时触发的回调函数
- `text`: 按钮上显示的文本
- `sizeType`: 按钮的大小类型
- `colorType`: 按钮的颜色类型
- `visibility`: 按钮是否可见
- `disable`: 按钮是否禁用
- `width`: 按钮的宽度（可选）
- `height`: 按钮的高度（可选）
- `fontSize`: 按钮文本的字体大小（可选）
- `circular`: 按钮的圆角半径
- `fontHeight`: 字体的高度比例
- `backGroundColor`: 按钮的背景颜色（可选）

### 虚线边框

JuiDashedBorder 组件用于创建带有虚线边框的容器。

代码示例

```dart
JuiDashedBorder(
  dashColor: Colors.blue,
  dashWidth: 3,
  dashHeight: 1,
  dashSpace: 3,
  borderRadius: 10,
  onTap: () {
    print('Container tapped!');
  },
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Hello, Dashed Border!'),
  ),
)
```

主要参数

- `dashColor`: 虚线的颜色
- `dashWidth`: 虚线的宽度
- `dashHeight`: 虚线的高度
- `dashSpace`: 虚线之间的间距
- `borderRadius`: 边框的圆角半径
- `child`: 虚线边框内部包含的子组件
- `onTap`: 当用户点击虚线边框时触发的回调函数

## 数据展示

### 展开收起文本

JuiExpandableText 组件用于显示可展开和收起的长文本。

代码示例

```dart
JuiExpandableText(
  text: "这是一段超过最大行数的文本点击展开" * 30,
)
```

主要参数

- `text`: 文本内容
- `maxLines`: 最大行数
- `canPackUp`: 是否支持收起
- `contentTextStyle`: 文本样式
- `expandedTextStyle`: 展开/收起按钮文本样式
- `expandText`: 展开按钮文本
- `collapseText`: 收起按钮文本

### 高亮文本

JuiHighlightedText 组件用于在文本中突出显示特定部分，支持不可点击和可点击两种模式。

#### 通用参数

- `text`: 要显示的完整文本内容 (String)
- `textStyle`: 普通文本的样式 (TextStyle?)
- `highlightStyle`: 高亮文本的默认样式 (TextStyle?)
- `maxLines`: 文本显示的最大行数 (int)
- `overflow`: 文本溢出时的处理方式 (TextOverflow)

#### 不可点击的高亮文本

代码示例

```dart
JuiHighlightedText.buildNoTapHighlight(
  text: "这是一行文字",
  textStyle: const TextStyle(color: Colors.black),
  highlightStyle: const TextStyle(color: Colors.blue),
  highlightText: "文字"
)
```

特有参数

- `highlightText`: 需要高亮显示的文本 (String)

#### 可点击的高亮文本

代码示例

```dart
JuiHighlightedText(
  text: "这是一行可点击的文字",
  textStyle: TextStyle(color: Colors.black),
  highlightStyle: TextStyle(color: Colors.blue),
  highlights: [
    HighlightWord("文", onTap: () {
      print("文");
    }, highlightStyle: TextStyle(color: Colors.red)),
    HighlightWord("字", onTap: () {
      print("字");
    }, highlightStyle: TextStyle(color: Colors.orange)),
    HighlightWord("行", onTap: () {
      print("行");
    }),
    HighlightWord("可点击", onTap: () {
      print("点击");
    }, highlightStyle: TextStyle(color: Colors.green)),
  ]
)
```

特有参数

- `highlights`: 高亮单词列表 (List<HighlightWord>)

HighlightWord 类

- `word`: 要高亮显示的单词 (String)
- `onTap`: 点击该单词时触发的回调函数 (VoidCallback)
- `highlightStyle`: 该单词的特定高亮样式 (TextStyle?)

### 标签

JuiTag 组件用于显示各种样式的标签。

代码示例

```dart
JuiTag(
  text: "标签",
  tagColorType: JuiTagColorType.blue,
)
```

主要参数

- `text`: 标签文本
- `tagColorType`: 标签颜色类型
- `tagShapeType`: 标签形状类型
- `icon`: 标签图标（可选）

### 空页面

JuiNoContent 组件用于显示空内容页面。

代码示例

```dart
JuiNoContent(
  type: JuiNoContentType.list,
)
```

主要参数

- `paddingTop`: 顶部填充
- `imageWidth`: 图片宽度
- `text`: 显示的文本内容
- `imagePath`: 图片路径（可选）
- `type`: JuiNoContent组件的类型

## 数据录入

### 复选框

JuiCheckBox 组件用于创建复选框。

代码示例

```dart
JuiCheckBox(
  type: JuiCheckBoxType.square,
  flag: ValueNotifier<bool>(true),
)
```

主要参数

- `flag`: 复选框状态的通知器
- `type`: 复选框的类型
- `isDisabled`: 复选框是否被禁用
- `onChanged`: 当复选框状态改变时的回调函数

### 选择器

JuiSelectPicker 组件用于创建各种类型的选择器。

#### 通用参数

- `context`: 构建上下文
- `config`: JuiSelectPicker的配置信息
- `items`: 选择器中显示的项目列表
- `onSelect`: 当用户选择一个项目时调用的回调函数
- `initialSelection`: 初始选中的项目列表（默认为空）
- `onCancel`: 当用户取消选择时调用的回调函数（可选）

#### 滚动选择器

代码示例

```dart
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
    onSelect: (selectedKeys, selectedValues) {
      print('Selected: $selectedValues');
    },
  );
}
```

#### 列表选择器

代码示例

```dart
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
    onSelect: (selectedKeys, selectedValues) {
      print('Selected: $selectedValues');
    },
  );
}
```

#### 动作选择器

代码示例

```dart
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
    onSelect: (selectedKeys, selectedValues) {
      print('Selected: $selectedValues');
    },
  );
}
```

### 时间选择器

CustomTimePicker 组件用于创建各种类型的时间选择器。

#### 通用参数

- `context`: 上下文环境，用于构建UI
- `type`: 时间选择器的类型（TimePickerType枚举）
- `mode`: 时间选择器的模式，默认为单选模式（TimePickerMode枚举）
- `initialTime`: 初始时间，仅在单选模式下使用
- `initialStartTime`: 初始开始时间，仅在范围选择模式下使用
- `initialEndTime`: 初始结束时间，仅在范围选择模式下使用
- `minTime`: 可选的最小时间限制
- `maxTime`: 可选的最大时间限制

#### 年月选择器

代码示例

```dart
showCustomTimePicker(
  context: context,
  type: TimePickerType.yearMonthSeparate,
  mode: TimePickerMode.single,
  initialTime: DateTime(2023, 6),
)
```

#### 年月日选择器

代码示例

```dart
showCustomTimePicker(
  context: context,
  type: TimePickerType.yearMonthDaySeparate,
  mode: TimePickerMode.single,
  initialTime: DateTime(2023, 6, 15),
  minTime: DateTime(2020, 10, 10),
  maxTime: DateTime(2025, 10, 10),
)
```

#### 时间范围选择器

代码示例

```dart
showCustomTimePicker(
  context: context,
  type: TimePickerType.yearMonthDayHourMinuteSeparate,
  mode: TimePickerMode.range,
  initialStartTime: DateTime(2023, 1, 1, 9, 0),
  initialEndTime: DateTime(2023, 1, 2, 17, 0),
)
```

#### 组合年月日选择器

代码示例

```dart
showCustomTimePicker(
  context: context,
  type: TimePickerType.yearMonthDayCombined,
  mode: TimePickerMode.single,
  initialTime: DateTime(2023, 6, 15),
)
```

#### 组合年月日时分选择器

代码示例

```dart
showCustomTimePicker(
  context: context,
  type: TimePickerType.yearMonthDayHourMinuteCombined,
  mode: TimePickerMode.single,
  initialTime: DateTime(2023, 6, 15, 14, 30),
  minTime: DateTime.now(),
  maxTime: DateTime.now().add(const Duration(days: 7)),
)
```

## 反馈

### 对话框

JuiDialog 组件用于创建各种类型的对话框，包括标准对话框、输入对话框和自定义对话框。

#### 通用参数

JuiDialogConfig 类用于配置对话框的通用参数：

- `title`: 对话框的标题
- `confirmButtonText`: 确认按钮的文本
- `cancelButtonText`: 取消按钮的文本
- `onConfirm`: 点击确认按钮时的回调函数
- `onCancel`: 点击取消按钮时的回调函数
- `showCancelButton`: 是否显示取消按钮
- `dialogWidth`: 对话框的宽度

#### 标准对话框

代码示例

```dart
showJuiDialog(
  context,
  JuiDialogType.standard,
  JuiDialogConfig(
    title: "标准对话框",
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    onConfirm: () {
      print("用户点击了确定");
    },
    onCancel: () {
      print("用户点击了取消");
    },
  ),
  content: "这是一个标准对话框的内容。您可以在这里放置一些文本信息。",
);
```

特有参数

- `content`: 对话框内容，类型为 String

#### 输入对话框

代码示例

```dart
showJuiDialog(
  context,
  JuiDialogType.input,
  JuiDialogConfig(
    title: "输入对话框",
    confirmButtonText: "提交",
    cancelButtonText: "取消",
    onConfirm: () {
      print("用户提交了输入");
    },
    onCancel: () {
      print("用户取消了输入");
    },
  ),
  hintText: "请输入您的名字",
  maxLength: 20,
  allowEmoji: false,
  onConfirmInput: (inputText) {
    print("用户输入的文本是: $inputText");
  },
  onChange: (value) {
    print("输入的内容变化: $value");
  },
);
```

特有参数

- `hintText`: 提示文本，用于指导用户输入
- `textController`: 文本控制器，用于管理文本输入
- `allowEmoji`: 是否允许输入表情，默认为true
- `maxLength`: 输入内容的最大长度，可选
- `focusNode`: 焦点节点，用于控制文本输入框的焦点
- `onChange`: 文本变化回调函数，当文本改变时调用
- `onConfirmInput`: 确认输入回调函数，当用户确认输入时调用

#### 自定义对话框

代码示例

```dart
showJuiDialog(
  context,
  JuiDialogType.custom,
  JuiDialogConfig(
    title: "自定义对话框",
    confirmButtonText: "好的",
    showCancelButton: false,
    onConfirm: () {
      print("用户确认了自定义对话框");
    },
  ),
  customContent: Column(
    children: [
      Icon(Icons.info, size: 48, color: Colors.blue),
      SizedBox(height: 16),
      Text("这是一个自定义内容的对话框。"),
      Text("您可以在这里放置任何 Widget。"),
    ],
  ),
);
```

特有参数

- `customContent`: 自定义对话框内容，类型为 Widget

## 表单

### 表单通用参数

JuiItemConfig 类用于配置表单项的通用参数。

主要参数包括：

- `isRequired`: 是否为必填项
- `isDisabled`: 是否禁用
- `titleSuffixWidget`: 标题后缀小部件
- `titleBeforeRequiredWidget`: 标题前的必填标记小部件
- `requiredMarker`: 必填标记小部件
- `customTitleStyle`: 自定义标题样式
- `showDivider`: 是否显示分隔线
- `padding`: 内边距
- `dividerPadding`: 分隔线内边距
- `showTips`: 是否显示提示
- `tipText`: 提示文本
- `onTap`: 点击回调
- `semanticsLabel`: 语义标签

### 自定义表单

JuiCustomItem 组件用于创建完全自定义的表单项，允许你插入任何自定义 Widget 作为内容。

代码示例

```dart
JuiCustomItem(
  title: 'Custom Item',
  content: const Text('This is a custom item'),
  config: JuiItemConfig(
    isRequired: true,
    showTips: true,
    tipText: '这是一个提示',
    onTap: () {
      debugPrint('Item tapped');
    },
  ),
)
```

主要参数

- `title`: 自定义UI项的标题 (String)
- `content`: 自定义UI项的内容 (Widget)
- `config`: 自定义UI项的配置信息 (JuiItemConfig)

### 文本详情表单

JuiTextDetailItem 组件用于展示详细的文本信息，通常用于只读的信息展示。

代码示例

```dart
JuiTextDetailItem(
  title: "Text Detail Item",
  contentText: 'This is a text detail item',
  config: JuiItemConfig(
    onTap: () {
      debugPrint('Item tapped');
    },
  ),
)
```

主要参数

- `title`: 表单项的标题 (String)
- `contentText`: 表单项的内容文本 (String)
- `config`: 表单项的配置信息 (JuiItemConfig)

### 点击表单

JuiTapItem 组件用于创建可点击的表单项，通常用于触发某些操作或导航到其他页面。

代码示例

```dart
JuiTapItem(
  title: "Tap Item",
  contentText: 'This is a detail item',
  hintText: '请点击',
  config: JuiItemConfig(
    onTap: () {
      debugPrint('Item tapped');
    },
    isRequired: true,
  ),
)
```

主要参数

- `title`: 用于显示的标题文本 (String)
- `contentText`: 主要内容的文本 (String)
- `hintText`: 当内容文本不显示时，用于提示的文本 (String)
- `maxLines`: 内容文本显示的最大行数 (int)
- `trailing`: 可选的尾部组件，例如图标或按钮 (Widget?)
- `config`: JuiTapItem的配置信息 (JuiItemConfig)

### 范围表单

JuiRangeItem 组件用于创建范围选择表单项，允许用户输入一个范围的最小值和最大值。

代码示例

```dart
const JuiRangeItem(
  title: "Range Item",
  minValue: "1",
  maxValue: "10",
  maxHintText: "最大值",
  minHintText: "最小值",
  config: JuiItemConfig(
    isRequired: true,
    showTips: true,
    tipText: '请输入1-10之间的范围',
  ),
)
```

主要参数

- `title`: 标题 (String)
- `minValue`: 最小值，可选参数 (String?)
- `maxValue`: 最大值，可选参数 (String?)
- `minHintText`: 最小值提示文本 (String)
- `maxHintText`: 最大值提示文本 (String)
- `separator`: 分隔符，可选参数 (Widget?)
- `config`: JuiRangeItem的配置信息 (JuiItemConfig)

### 文本输入表单

JuiTextInputItem 组件用于创建文本输入表单项，允许用户输入文本。

代码示例

```dart
JuiTextInputItem(
  title: "用户名",
  hintText: "请输入用户名",
  controller: TextEditingController(),
  showClearButton: true,
  config: JuiItemConfig(
    isRequired: true,
    showTips: true,
    tipText: '用户名长度应在3-20个字符之间',
  ),
)
```

主要参数

- `title`: 标题 (String)
- `hintText`: 提示文本 (String)
- `controller`: 文本控制器 (TextEditingController)
- `focusNode`: 焦点节点，可选 (FocusNode?)
- `keyboardType`: 键盘类型 (TextInputType)
- `maxLines`: 最大行数 (int)
- `maxLength`: 最大长度，可选 (int?)
- `onlyNumbers`: 是否只允许输入数字 (bool)
- `onChanged`: 文本改变时的回调函数，可选 (ValueChanged<String>?)
- `onEditingComplete`: 编辑完成时的回调函数，可选 (VoidCallback?)
- `onSubmitted`: 提交文本时的回调函数，可选 (ValueChanged<String>?)
- `config`: JuiTextInputItem的配置信息 (JuiItemConfig)
- `showClearButton`: 是否显示清除按钮 (bool)
