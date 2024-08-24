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
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3 //宽高比为1时，子widget
              ),
          children: [
            _buildTextButton(context, DemoRouter.dashedBorderContainerDemo, "虚线边框组件"),
            _buildTextButton(context, DemoRouter.jUIButtonDemo, "按钮组件"),
            _buildTextButton(context, DemoRouter.emptyPlaceholderDemo, "空页面组件"),
          ],
        ),
      ),
    );
  }

  TextButton _buildTextButton(BuildContext context, routerName, text) {
    return TextButton(onPressed: () => Navigator.of(context).pushNamed(routerName), child: Text(text));
  }
}
