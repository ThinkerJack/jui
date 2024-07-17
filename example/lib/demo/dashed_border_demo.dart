import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jac_uikit/common.dart';

Widget space = const SizedBox(
  height: 30,
);

class DashedBorderDemo extends StatelessWidget {
  const DashedBorderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("表单示例")),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              space,
              DashedBorderContainer(
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Dashed Border Container', style: TextStyle(fontSize: 20)),
                ),
                onTap: () {
                  debugPrint("点击事件");
                },
              ),
            ],
          )),
    );
  }
}
