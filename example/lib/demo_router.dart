import 'package:example/splash_page.dart';
import 'package:flutter/cupertino.dart';

import 'demo/common_demo.dart';
import 'demo/data_display_demo.dart';

final demoRouterMap = <String, WidgetBuilder>{
  DemoRouter.splashPage: (context) => const SplashPage(),
  DemoRouter.dataDisplayDemo: (context) => const DataDisplayDemo(),
  DemoRouter.commonDemo: (context) => const CommonDemo(),
};

class DemoRouter {
  static const String splashPage = "splashPage";
  static const String dataDisplayDemo = "dataDisplayDemo";
  static const String commonDemo = "commonDemo";
}
