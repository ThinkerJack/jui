import 'package:example/splash_page.dart';
import 'package:flutter/cupertino.dart';

import 'common/dashed_border_container_demo.dart';

final demoRouterMap = <String, WidgetBuilder>{
  DemoRouter.mainPage: (context) => const MainPage(),
  DemoRouter.dashedBorderContainerDemo: (context) =>  DashedBorderContainerDemo(),
};

class DemoRouter {
  static const String mainPage = "mainPage";
  static const String dashedBorderContainerDemo = "DashedBorderContainerDemo";
}
