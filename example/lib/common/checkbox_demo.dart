import 'package:example/common/demo_base_page.dart';
import 'package:flutter/material.dart';
import 'package:jui/data_entry.dart';

class CheckBoxDemo extends DemoBasePage {
  CheckBoxDemo({super.key});


  @override
  Widget build(BuildContext context) {
    return super.builder("复选框", [
      JuiCheckBox(
        type: JuiCheckBoxType.square, flag: ValueNotifier<bool>(true),
      ),
      space,
      JuiCheckBox(
        type: JuiCheckBoxType.circle, flag: ValueNotifier<bool>(true),
      ),
    ]);
  }
}
