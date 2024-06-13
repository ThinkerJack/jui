import 'package:example/demo/data_display_demo.dart';
import 'package:example/splash_page.dart';
import 'package:flutter/material.dart';

import 'demo_router.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: demoRouterMap,
      home: const SplashPage(),
    );
  }
}

