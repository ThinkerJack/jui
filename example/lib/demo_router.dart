import 'package:example/splash_page.dart';
import 'package:flutter/cupertino.dart';

import 'demo/button_demo.dart';
import 'demo/text_demo.dart';

final demoRouterMap = <String, WidgetBuilder>{
  DemoRouter.splashPage: (context) => const SplashPage(),
  DemoRouter.textDemo: (context) => const TextDemo(),
  DemoRouter.buttonDemo: (context) => const ButtonDemo(),
};

class DemoRouter {
  static const String splashPage = "splashPage";
  static const String textDemo = "textDemo";
  static const String buttonDemo = "buttonDemo";
}
