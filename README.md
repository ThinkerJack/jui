# 组件依赖

`flutter pub add jac_uikit`

# 组件文档

## 数据展示

### 文本

#### 富文本组件

使用方式：

```dart
HighlightedTextWidget.builder(
  text: "全部文案包含高亮文案测试用",
  highlights: [
    HighlightWord(
      "文案",
      () {
        print("文案");
      },
      highlightStyle: TextStyle(color: Colors.red),
    ),
    HighlightWord("含", () {
      print("含");
    }),
    HighlightWord("测试", () {
      print("测试");
    }),
  ],
  defaultTextStyle: TextStyle(color: Colors.black, fontSize: 16),
  defaultHighlightStyle: TextStyle(color: Colors.cyanAccent, fontSize: 16),
)
```

图片示例：

