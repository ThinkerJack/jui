# 简介

Flutter UI组件库

# 组件文档

## 通用

### 按钮

使用方式：

```dart
            JacButton(
              colorType: JacButtonColorType.blue,
              sizeType: JacButtonSizeType.ultraSmall,
              text: "最小号蓝色按钮",
              onTap: () {},
            ),
      
            JacButton(
              colorType: JacButtonColorType.blue,
              sizeType: JacButtonSizeType.small,
              text: "小号蓝色按钮",
              onTap: () {},
            ),

            JacButton(
              colorType: JacButtonColorType.blue,
              sizeType: JacButtonSizeType.middle,
              text: "中号蓝色按钮",
              onTap: () {},
            ),
      
            JacButton(
              colorType: JacButtonColorType.blue,
              sizeType: JacButtonSizeType.large,
              text: "大号蓝色按钮",
              onTap: () {},
            ),
     
            JacButton(
              colorType: JacButtonColorType.white,
              sizeType: JacButtonSizeType.large,
              text: "大号白色按钮",
              onTap: () {},
            ),
       
            JacButton(
              colorType: JacButtonColorType.gray,
              sizeType: JacButtonSizeType.large,
              text: "大号灰色按钮",
              onTap: () {},
            ),
        
            JacButton(
              colorType: JacButtonColorType.blueBorder,
              sizeType: JacButtonSizeType.large,
              text: "大号蓝边按钮",
              onTap: () {},
            ),
     
            JacButton(
              colorType: JacButtonColorType.blueBorder,
              sizeType: JacButtonSizeType.large,
              width: 230,
              height: 80,
              text: "自定义宽高按钮",
              onTap: () {},
            ),
```

图片示例：

![](https://github.com/ThinkerJack/jac_uikit/blob/develop/example/assets/img_3.png)

参数：
```dart
  final Function onTap; //点击事件
  final String text; //文本内容
  final JacButtonSizeType sizeType; //大小类型
  final JacButtonColorType colorType; //颜色类型
  final bool? visibility; //是否展示
  final bool disable; //是否禁用
  final double? width; //宽度
  final double? height; //高度
  final double? fontSize; //文字大小
  final double? circular; //圆角度
  final double? fontHeight; //文字行高
```



## 数据展示

### 文本

#### 富文本组件

使用方式：

```dart
            HighlightedText.builder(
              text: "全部文案包含高亮文案测试用",
              highlights: [
                HighlightWord(
                  "文案",
                  () {
                    debugPrint("文案");
                  },
                  highlightStyle: const TextStyle(color: Colors.red),
                ),
                HighlightWord("含", () {
                  debugPrint("含");
                }),
                HighlightWord("测试", () {
                  debugPrint("测试");
                }),
              ],
              defaultTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
              defaultHighlightStyle: const TextStyle(color: Colors.cyanAccent, fontSize: 16),
            )
```

图片示例：

![](https://github.com/ThinkerJack/jac_uikit/blob/develop/example/assets/img_2.png)

参数：
```dart
    required String text,//全部文本内容
    List<HighlightWord> highlights = const [],//高亮数据集合
    TextStyle? defaultTextStyle,//默认文本样式
    TextStyle? defaultHighlightStyle,//高亮文本样式
    int maxLines = 5,//最大行数
    TextOverflow overflow = TextOverflow.ellipsis,//文本超出样式

class HighlightWord {
  final String word;//文字内容
  final VoidCallback onTap;//点击事件
  final TextStyle? highlightStyle;//高亮样式

  HighlightWord(this.word, this.onTap,{ this.highlightStyle});
}
```

#### 展开收起文本

使用方式：

```dart
  ExpandableText(
              content: '测试' * 50,
              maxLines: 3,
            ),
```

图片示例：

![](https://github.com/ThinkerJack/jac_uikit/blob/develop/example/assets/img.png)

![](https://github.com/ThinkerJack/jac_uikit/blob/develop/example/assets/img_1.png)

参数：

```dart
  final String content; //文本内容
  final String expandText; //展开文字
  final String collapsedText; //收起文字
  final int maxLines; //最大行数
  final bool canCollapsed; //是否支持收起
  final TextStyle? contentTextStyle; //普通文本样式
  final TextStyle? expandTextStyle; //展开收起文本样式
```

### 标签

使用方式：

```dart
                  JacTag(
                    paddingVertical: 1,
                    paddingHorizontal: 6,
                    tagType: JacTagType.text,
                    tagShapeType: JacTagShapeType.rectangle,
                    tagColorType: JacTagColorType.blue,
                    text: "标签",
                    fontSize: 12,
                  ),
                  JacTag(
                    paddingVertical: 5,
                    paddingHorizontal: 10,
                    tagType: JacTagType.icon,
                    tagShapeType: JacTagShapeType.semicircle,
                    tagColorType: JacTagColorType.blue,
                    text: "标签",
                    icon: Icon(
                      Icons.ac_unit,
                      size: 14,
                      color: Color(0XFF5590F6),
                    ),
                    fontSize: 14,
                  ),
                  JacTag(
                    paddingVertical: 5,
                    paddingHorizontal: 10,
                    tagType: JacTagType.icon,
                    tagShapeType: JacTagShapeType.rectangle,
                    tagColorType: JacTagColorType.blue,
                    text: "标签",
                    icon: Icon(
                      Icons.ac_unit,
                      size: 14,
                      color: Color(0XFF5590F6),
                    ),
                    fontSize: 14,
                  ),

                  JacTag(
                    paddingVertical: 5,
                    paddingHorizontal: 10,
                    tagType: JacTagType.icon,
                    tagShapeType: JacTagShapeType.capsule,
                    tagColorType: JacTagColorType.blue,
                    text: "标签",
                    icon: Icon(
                      Icons.ac_unit,
                      size: 14,
                      color: Color(0XFF5590F6),
                    ),
                    fontSize: 14,
                  ),
```

图片示例：

![](https://github.com/ThinkerJack/jac_uikit/blob/develop/example/assets/img_5.png)

参数：

```dart
  final double paddingVertical; //垂直内边距
  final double paddingHorizontal; //水平内边距
  final JacTagType tagType; //tag类型
  final JacTagShapeType tagShapeType; //tag形状类型
  final JacTagColorType tagColorType; //tag颜色类型
  final String text; //文字内容
  final double fontSize; //字体大小
  final Widget? icon; //左侧图标

//tag颜色类型
enum JacTagColorType { black, blue, green, yellow, red, gray }

//tag形状类型
enum JacTagShapeType {
  //半圆
  semicircle,
  //矩形
  rectangle,
  //胶囊
  capsule
}

//tag类型
enum JacTagType {
  //纯文字
  text,
  //icon+文字
  icon
}
```

## 数据录入

### 表单项

#### 点击

使用方式：

```dart
              TapItem(
                title: '标题',
                content: '内容',
                tipText: "请输入",
                onTap: () {
                  debugPrint("点击");
                },
              ),
              TapItem(
                title: '标题',
                content: '内容',
                tipText: "请输入",
                isRequired: true,
                maxLine: 1,
                hintText: '请选择',
                showTips: true,
                onTap: () {
                  debugPrint("点击");
                },
              ),
```

图片示例：

![](https://github.com/ThinkerJack/jac_uikit/blob/develop/example/assets/img_4.png)

参数：

```dart
  final String title; //标题
  final String hintText; //输入框底文
  final String content; //输入框内容
  final Function onTap; //点击事件
  final bool showTips; //是否报错
  final String tipText; //错误文案
  final int maxLine; //文本内容最大行数
  final bool isRequired; //是否是必填
```

