import 'package:example/demo_router.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('JUI 组件展示'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(context, '通用', [
            _DemoButton(DemoRouter.jUIButtonDemo, "按钮"),
            _DemoButton(DemoRouter.dashedBorderContainerDemo, "虚线边框"),
          ]),
          _buildSection(context, '数据展示', [
            _DemoButton(DemoRouter.expandedTextDemo, "展开收起文本"),
            _DemoButton(DemoRouter.highlightedTextDemo, "高亮文本"),
            _DemoButton(DemoRouter.tagDemo, "标签"),
            _DemoButton(DemoRouter.emptyPlaceholderDemo, "空页面"),
            _DemoButton(DemoRouter.titleDemo, "标题"),
          ]),
          _buildSection(context, '数据录入', [
            _DemoButton(DemoRouter.checkBoxDemo, "复选框"),
            _DemoButton(DemoRouter.singlePickerDemo, "单选选择器"),
          ]),

          _buildSection(context, '反馈', [
            _DemoButton(DemoRouter.dialogDemo, "弹窗"),
          ]),
          _buildSection(context, '表单', [
            _DemoButton(DemoRouter.itemDemo, "表单项"),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<_DemoButton> buttons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: buttons.map((button) => _buildButton(context, button)).toList(),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, _DemoButton button) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pushNamed(button.routerName),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue, backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.blue),
      ),
      child: Text(button.text),
    );
  }
}

class _DemoButton {
  final String routerName;
  final String text;

  _DemoButton(this.routerName, this.text);
}