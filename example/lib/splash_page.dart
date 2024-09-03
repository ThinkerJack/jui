import 'package:example/demo_router.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //横轴三个子widget
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 3 //宽高比为1时，子widget
              ),
          children: [
            _buildTextButton(context, DemoRouter.dashedBorderContainerDemo, "虚线边框"),
            _buildTextButton(context, DemoRouter.jUIButtonDemo, "按钮"),
            _buildTextButton(context, DemoRouter.emptyPlaceholderDemo, "空页面"),
            _buildTextButton(context, DemoRouter.tagDemo, "标签"),
            _buildTextButton(context, DemoRouter.expandedTextDemo, "展开收起文本"),
            _buildTextButton(context, DemoRouter.highlightedTextDemo, "高亮文本"),
            _buildTextButton(context, DemoRouter.titleDemo, "标题"),
            _buildTextButton(context, DemoRouter.dialogDemo, "弹窗"),
            _buildTextButton(context, DemoRouter.checkBoxDemo, "复选框"),
            _buildTextButton(context, DemoRouter.itemDemo, "表单"),
          ],
        ),
      ),
    );
  }

  TextButton _buildTextButton(BuildContext context, routerName, text) {
    return TextButton(onPressed: () => Navigator.of(context).pushNamed(routerName), child: Text(text));
  }
}
