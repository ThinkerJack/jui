import 'package:flutter/cupertino.dart';

import 'jui_base_dialog.dart';
import 'jui_dialog_config.dart';

class JuiCustomDialog extends StatelessWidget {
  final JuiDialogConfig config;
  final Widget contentWidget;

  const JuiCustomDialog({
    Key? key,
    required this.config,
    required this.contentWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JuiBaseDialog(
      config: config,
      contentWidget: contentWidget,
    );
  }
}
