# Flutter UI组件文档

在线版本：https://www.yuque.com/jui_flutter/kb/howistv001f1ghp9?singleDoc#%20%E3%80%8AJUI%E7%BB%84%E4%BB%B6%E6%96%87%E6%A1%A3%E3%80%8B

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

#### 代码示例

```dart
JuiButton(
  colorType: JuiButtonColorType.blue,
  sizeType: JuiButtonSizeType.large,
  text: "大号蓝色按钮",
  onTap: () {},
)
```

#### 主要参数

- `onTap`: 点击按钮时触发的回调函数
- `text`: 按钮上显示的文本
- `sizeType`: 按钮的大小类型
- `colorType`: 按钮的颜色类型
- `visibility`: 按钮是否可见
- `disable`: 按钮是否禁用

### 虚线边框

JuiDashedBorder 组件用于创建带有虚线边框的容器。

#### 代码示例

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

#### 主要参数

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

#### 代码示例

```dart
JuiExpandableText(
  text: "这是一段超过最大行数的文本点击展开" * 30,
)
```

#### 主要参数

- `text`: 文本内容
- `maxLines`: 最大行数
- `canPackUp`: 是否支持收起
- `contentTextStyle`: 文本样式
- `expandedTextStyle`: 展开/收起按钮文本样式
- `expandText`: 展开按钮文本
- `collapseText`: 收起按钮文本

### 高亮文本

JuiHighlightedText 组件用于在文本中突出显示特定部分。

#### 代码示例

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
  ]
)
```

#### 主要参数

- `text`: 要显示的文本内容
- `highlights`: 需要高亮显示的部分
- `textStyle`: 文本的样式
- `highlightStyle`: 高亮文本的样式

### 标签

JuiTag 组件用于显示各种样式的标签。

#### 代码示例

```dart
JuiTag(
  text: "标签",
  tagColorType: JuiTagColorType.blue,
)
```

#### 主要参数

- `text`: 标签文本
- `tagColorType`: 标签颜色类型
- `tagShapeType`: 标签形状类型
- `icon`: 标签图标（可选）

### 空页面

JuiNoContent 组件用于显示空内容页面。

#### 代码示例

```dart
JuiNoContent(
  type: JuiNoContentType.list,
)
```

#### 主要参数

- `paddingTop`: 顶部填充
- `imageWidth`: 图片宽度
- `text`: 显示的文本内容
- `imagePath`: 图片路径（可选）
- `type`: JuiNoContent组件的类型

## 数据录入

### 复选框

JuiCheckBox 组件用于创建复选框。

#### 代码示例

```dart
JuiCheckBox(
  type: JuiCheckBoxType.square,
  flag: ValueNotifier<bool>(true),
)
```

#### 主要参数

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
- `initialSelection`: 初始选中的项目列表

#### 代码示例（滚动选择器）

```dart
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
)
```

### 时间选择器

CustomTimePicker 组件用于创建各种类型的时间选择器。

#### 通用参数

- `context`: 上下文环境
- `type`: 时间选择器的类型
- `mode`: 时间选择器的模式
- `initialTime`: 初始时间（单选模式）
- `initialStartTime`: 初始开始时间（范围选择模式）
- `initialEndTime`: 初始结束时间（范围选择模式）
- `minTime`: 可选的最小时间限制
- `maxTime`: 可选的最大时间限制

#### 代码示例（年月日选择器）

```dart
showCustomTimePicker(
  context: context,
  type: TimePickerType.yearMonthDaySeparate,
  mode: TimePickerMode.single,
  minTime: DateTime(2020, 10, 10),
  maxTime: DateTime(2025, 10, 10),
)
```

## 反馈

### 对话框

JuiDialog 组件用于创建各种类型的对话框。

#### 通用参数

- `title`: 对话框的标题
- `confirmButtonText`: 确认按钮的文本
- `cancelButtonText`: 取消按钮的文本
- `onConfirm`: 点击确认按钮时的回调函数
- `onCancel`: 点击取消按钮时的回调函数
- `showCancelButton`: 是否显示取消按钮
- `dialogWidth`: 对话框的宽度

#### 代码示例（标准对话框）

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
)
```

## 表单

### 表单通用参数

JuiItemConfig 类用于配置表单项的通用参数。

主要参数包括：

- `isRequired`: 是否为必填项
- `isDisabled`: 是否禁用
- `showTips`: 是否显示提示
- `tipText`: 提示文本
- `onTap`: 点击回调

### 自定义表单

JuiCustomItem 组件用于创建自定义表单项。

#### 代码示例

```dart
JuiCustomItem(
  title: 'Custom Item',
  content: const Text('This is a custom item'),
  config: JuiItemConfig(
    isRequired: true,
    showTips: true,
    tipText: '提示',
    onTap: () {
      debugPrint('onTap');
    },
  ),
)
```

#### 主要参数

- `title`: 自定义UI项的标题
- `content`: 自定义UI项的内容
- `config`: 自定义UI项的配置信息

### 文本详情表单

JuiTextDetailItem 组件用于创建文本详情表单项。

#### 代码示例

```dart
JuiTextDetailItem(
  title: "Text Detail Item",
  contentText: 'This is a text detail item',
  config: JuiItemConfig(
    onTap: () {
      debugPrint('onTap');
    },
  ),
)
```

#### 主要参数

- `title`: 自定义UI项的标题
- `contentText`: 自定义UI项的内容文本
- `config`: 自定义UI项的配置信息

### 点击表单

JuiTapItem 组件用于创建可点击的表单项。

#### 代码示例

```dart
JuiTapItem(
  title: "Tap Item",
  contentText: 'This is a detail item',
  hintText: '请输入',
  config: JuiItemConfig(
    onTap: () {
      debugPrint('onTap');
    },
    isRequired: true,
  ),
)
```

#### 主要参数

- `title`: 用于显示的标题文本
- `contentText`: 主要内容的文本
- `hintText`: 当内容文本不显示时，用于提示的文本
- `config`: JuiTapItem的配置信息

### 范围表单

JuiRangeItem 组件用于创建范围选择表单项。

#### 代码示例

```dart
const JuiRangeItem(
  title: "Range Item",
  minValue: "1",
  maxValue: "10",
  maxHintText: "最大信息",
  minHintText: "最小信息",
)
```

#### 主要参数

- `title`: 标题
- `minValue`: 最小值
- `maxValue`: 最大值
- `minHintText`: 最小值提示文本
- `maxHintText`: 最大值提示文本
- `config`: JuiRangeItem的配置信息

### 文本输入表单

JuiTextInputItem 组件用于创建文本输入表单项。

#### 代码示例

```dart
JuiTextInputItem(
  title: "用户名",
  hintText: "请输入用户名",
  controller: TextEditingController(),
  showClearButton: false, // 不显示清除按钮
)
```

#### 主要参数

- `title`: 标题
- `hintText`: 提示文本
- `controller`: 文本控制器
- `keyboardType`: 键盘类型
- `maxLines`: 最大行数
- `maxLength`: 最大长度
- `onlyNumbers`: 是否只允许输入数字
- `onChanged`: 文本改变时的回调函数
- `config`: JuiTextInputItem的配置信息
- `showClearButton`: 是否显示清除按钮