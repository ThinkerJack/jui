import 'package:flutter/material.dart';

class DemoBasePage extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  const DemoBasePage({
    Key? key,
    required this.title,
    required this.children,
    this.padding,
  }) : super(key: key);

  static const Widget space = SizedBox(height: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: padding ?? const EdgeInsets.all(20),
        children: children,
      ),
    );
  }
}