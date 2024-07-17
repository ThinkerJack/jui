import 'package:example/demo/item_demo.dart';
import 'package:example/demo/tag_demo.dart';
import 'package:example/splash_page.dart';
import 'package:flutter/cupertino.dart';

import 'demo/button_demo.dart';
import 'demo/dashed_border_demo.dart';
import 'demo/text_demo.dart';

final demoRouterMap = <String, WidgetBuilder>{
  DemoRouter.mainPage: (context) => const MainPage(),
  DemoRouter.textDemo: (context) => const TextDemo(),
  DemoRouter.buttonDemo: (context) => const ButtonDemo(),
  DemoRouter.itemDemo: (context) => const ItemDemo(),
  DemoRouter.tagDemo: (context) => const TagDemo(),
  DemoRouter.dashedBorderDemo: (context) => const DashedBorderDemo(),
};

class DemoRouter {
  static const String mainPage = "mainPage";
  static const String textDemo = "textDemo";
  static const String buttonDemo = "buttonDemo";
  static const String itemDemo = "itemDemo";
  static const String tagDemo = "tagDemo";
  static const String dashedBorderDemo = "dashedBorderDemo";
}
