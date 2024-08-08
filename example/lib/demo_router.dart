
import 'package:example/splash_page.dart';
import 'package:flutter/cupertino.dart';


final demoRouterMap = <String, WidgetBuilder>{
  DemoRouter.mainPage: (context) => const MainPage(),

};

class DemoRouter {
  static const String mainPage = "mainPage";

}
