# 简介

flutter UI组件库

# 组件文档

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
