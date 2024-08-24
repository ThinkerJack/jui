import 'package:example/splash_page.dart';
import 'package:flutter/cupertino.dart';

import 'common/button_demo.dart';
import 'common/dashed_border_container_demo.dart';
import 'common/empty_placeholder_demo.dart';
import 'common/tag_demo.dart';

final demoRouterMap = <String, WidgetBuilder>{
  DemoRouter.mainPage: (context) => const MainPage(),
  DemoRouter.dashedBorderContainerDemo: (context) => const DashedBorderContainerDemo(),
  DemoRouter.jUIButtonDemo: (context) => const JUIButtonDemo(),
  DemoRouter.emptyPlaceholderDemo: (context) => const EmptyPlaceholderDemo(),
  DemoRouter.tagDemo: (context) => const TagDemo(),
};

class DemoRouter {
  static const String mainPage = "mainPage";
  static const String dashedBorderContainerDemo = "DashedBorderContainerDemo";
  static const String jUIButtonDemo = "JUIButtonDemo";
  static const String emptyPlaceholderDemo = "EmptyPlaceholderDemo";
  static const String tagDemo = "TagDemo";
}
