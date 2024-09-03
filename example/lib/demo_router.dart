import 'package:example/splash_page.dart';
import 'package:flutter/cupertino.dart';

import 'common/button_demo.dart';
import 'common/checkbox_demo.dart';
import 'common/dashed_border_container_demo.dart';
import 'common/dialog_demo.dart';
import 'common/empty_placeholder_demo.dart';
import 'common/expanded_text_demo.dart';
import 'common/highlighted_text_demo.dart';
import 'common/item_demo.dart';
import 'common/tag_demo.dart';
import 'common/title_demo.dart';

final demoRouterMap = <String, WidgetBuilder>{
  DemoRouter.mainPage: (context) => const MainPage(),
  DemoRouter.dashedBorderContainerDemo: (context) =>  DashedBorderContainerDemo(),
  DemoRouter.jUIButtonDemo: (context) =>  JuiButtonDemo(),
  DemoRouter.emptyPlaceholderDemo: (context) =>  EmptyPlaceholderDemo(),
  DemoRouter.tagDemo: (context) =>  TagDemo(),
  DemoRouter.expandedTextDemo: (context) =>  ExpandedTextDemo(),
  DemoRouter.highlightedTextDemo: (context) =>  HighlightedTextDemo(),
  DemoRouter.titleDemo: (context) =>  TitleDemo(),
  DemoRouter.dialogDemo: (context) =>  DialogDemo(),
  DemoRouter.checkBoxDemo: (context) =>  CheckBoxDemo(),
  DemoRouter.itemDemo: (context) =>   ItemDemo(),
};

class DemoRouter {
  static const String mainPage = "mainPage";
  static const String dashedBorderContainerDemo = "DashedBorderContainerDemo";
  static const String jUIButtonDemo = "JuiButtonDemo";
  static const String emptyPlaceholderDemo = "EmptyPlaceholderDemo";
  static const String tagDemo = "TagDemo";
  static const String expandedTextDemo = "ExpandedTextDemo";
  static const String highlightedTextDemo = "HighlightedTextDemo";
  static const String titleDemo = "TitleDemo";
  static const String dialogDemo = "DialogDemo";
  static const String checkBoxDemo = "CheckBoxDemo";
  static const String itemDemo = "ItemDemo";
}
