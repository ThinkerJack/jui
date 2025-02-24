import 'package:example/demo_router.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 800; // 判断是否为桌面端

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                    context,
                    '通用',
                    [
                      _DemoButton(DemoRouter.jUIButtonDemo, "按钮"),
                      _DemoButton(DemoRouter.dashedBorderContainerDemo, "虚线边框"),
                    ],
                    isDesktop,
                    constraints.maxWidth),
                _buildSection(
                    context,
                    '数据展示',
                    [
                      _DemoButton(DemoRouter.expandedTextDemo, "展开收起文本"),
                      _DemoButton(DemoRouter.highlightedTextDemo, "高亮文本"),
                      _DemoButton(DemoRouter.tagDemo, "标签"),
                      _DemoButton(DemoRouter.emptyPlaceholderDemo, "空页面"),
                    ],
                    isDesktop,
                    constraints.maxWidth),
                _buildSection(
                    context,
                    '数据录入',
                    [
                      _DemoButton(DemoRouter.checkBoxDemo, "复选框"),
                      _DemoButton(DemoRouter.singlePickerDemo, "单选选择器"),
                      _DemoButton(DemoRouter.datePickerDemo, "时间选择器"),
                    ],
                    isDesktop,
                    constraints.maxWidth),
                _buildSection(
                    context,
                    '反馈',
                    [
                      _DemoButton(DemoRouter.dialogDemo, "弹窗"),
                    ],
                    isDesktop,
                    constraints.maxWidth),
                _buildSection(
                    context,
                    '表单',
                    [
                      _DemoButton(DemoRouter.itemDemo, "表单项"),
                    ],
                    isDesktop,
                    constraints.maxWidth),
              ],
            ),
          );
        },
      ),
    );
  }

  /// **自适应 AppBar**
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('JUI 组件展示'),
      backgroundColor: Colors.blue,
      centerTitle: MediaQuery.of(context).size.width > 800, // 仅桌面端居中
    );
  }

  /// **自适应网格布局**
  Widget _buildSection(BuildContext context, String title,
      List<_DemoButton> buttons, bool isDesktop, double maxWidth) {
    int crossAxisCount =
        isDesktop ? (maxWidth ~/ 250).clamp(2, 4) : 2; // 桌面端 2-4 列，移动端 2 列

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: buttons.length,
          itemBuilder: (context, index) =>
              _buildButton(context, buttons[index]),
        ),
      ],
    );
  }

  /// **按钮样式**
  Widget _buildButton(BuildContext context, _DemoButton button) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pushNamed(button.routerName),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.blue),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(button.text, style: const TextStyle(fontSize: 16)),
    );
  }
}

class _DemoButton {
  final String routerName;
  final String text;

  _DemoButton(this.routerName, this.text);
}
