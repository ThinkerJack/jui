import 'package:flutter/material.dart';

abstract class DemoBasePage extends StatelessWidget {
  const DemoBasePage({super.key});

  final Widget space = const SizedBox(height: 30);

  Widget builder(String title, List<Widget> widgets) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title,style: const TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: widgets,
      ),
    );
  }

}
