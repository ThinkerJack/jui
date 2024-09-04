import 'package:example/common/demo_base_page.dart';
import 'package:flutter/material.dart';
import 'package:jui/feedback.dart';

class DialogDemo extends StatelessWidget {
  DialogDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoBasePage(title: "弹窗", children: [
      TextButton(
        onPressed: () {
          showJuiDialog(
            context,
            JuiDialogType.custom,
            customContent: Text("自定义内容"),
            JuiDialogConfig(
              title: "标题",
              onCancel: () {
                print("点击取消");
              },
              onConfirm: () {
                print("点击确定");
              },
            ),
          );
        },
        child: Text("自定义"),
      ),
      TextButton(
        onPressed: () {
          showJuiDialog(
            context,
            JuiDialogType.standard,
            content: "内容" * 50,
            JuiDialogConfig(
              title: "标题",
              onConfirm: () {},
              onCancel: () {},
            ),
          );
        },
        child: Text("通用"),
      ),
      TextButton(
        onPressed: () {
          showJuiDialog(
            context,
            JuiDialogType.standard,
            JuiDialogConfig(
              title: "内容" * 50,
              onConfirm: () {},
              onCancel: () {},
            ),
          );
        },
        child: Text("无标题"),
      ),
      TextButton(
        onPressed: () {
          showJuiDialog(
            context,
            JuiDialogType.input,
            onConfirmInput: (inputText) {
              print("用户输入的文本是: $inputText");
            },
            JuiDialogConfig(
              title: "标题",
            ),
          );
        },
        child: Text("输入"),
      ),
      ElevatedButton(
        child: Text('显示标准对话框'),
        onPressed: () => _showStandardDialog(context),
      ),
      ElevatedButton(
        child: Text('显示输入对话框'),
        onPressed: () => _showInputDialog(context),
      ),
      ElevatedButton(
        child: Text('显示自定义对话框'),
        onPressed: () => _showCustomDialog(context),
      ),
    ]);
  }

  void _showStandardDialog(BuildContext context) {
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
  }

  void _showInputDialog(BuildContext context) {
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
  }

  void _showCustomDialog(BuildContext context) {
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
  }
}
