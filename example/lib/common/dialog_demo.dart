import 'package:example/common/demo_base_page.dart';
import 'package:flutter/material.dart';
import 'package:jui/feedback.dart';

class DialogDemo extends DemoBasePage {
  const DialogDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return super.builder("弹窗", [
      TextButton(
        onPressed: () {
          showJuiDialog(
            context,
            JuiDialogType.custom,
            JuiDialogConfig(
              title: "标题",
              contentWidget: Text("自定义内容"),
              onCancelTap: () {
                print("点击取消");
              },
              onConfirmTap: () {
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
            JuiDialogConfig(
              title: "标题",
              content: "内容" * 50,
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
            JuiDialogConfig(
              title: "标题",
              onConfirmTapWithInput: (value) {
                print(value);
              },
            ),
          );
        },
        child: Text("输入"),
      ),
    ]);
  }
}
