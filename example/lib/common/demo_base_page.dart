import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jui/common.dart';

class DemoBasePage extends StatelessWidget {
  const DemoBasePage({super.key});

  Widget builder(String title, List<Widget> widgets) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: widgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
