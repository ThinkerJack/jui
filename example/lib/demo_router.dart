import 'package:example/splash_page.dart';
import 'package:flutter/cupertino.dart';

import 'common/button_demo.dart';
import 'common/checkbox_demo.dart';
import 'common/dashed_border_container_demo.dart';
import 'common/dialog_demo.dart';
import 'common/empty_placeholder_demo.dart';
import 'common/expanded_text_demo.dart';
import 'common/highlighted_text_demo.dart';
import 'common/tag_demo.dart';
import 'common/title_demo.dart';

final demoRouterMap = <String, WidgetBuilder>{
  DemoRouter.mainPage: (context) => const MainPage(),
  DemoRouter.dashedBorderContainerDemo: (context) => const DashedBorderContainerDemo(),
  DemoRouter.jUIButtonDemo: (context) => const JuiButtonDemo(),
  DemoRouter.emptyPlaceholderDemo: (context) => const EmptyPlaceholderDemo(),
  DemoRouter.tagDemo: (context) => const TagDemo(),
  DemoRouter.expandedTextDemo: (context) => const ExpandedTextDemo(),
  DemoRouter.highlightedTextDemo: (context) => const HighlightedTextDemo(),
  DemoRouter.titleDemo: (context) => const TitleDemo(),
  DemoRouter.dialogDemo: (context) => const DialogDemo(),
  DemoRouter.checkBoxDemo: (context) =>  CheckBoxDemo(),
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
}
