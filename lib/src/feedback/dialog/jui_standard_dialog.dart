import 'package:flutter/cupertino.dart';

import '../../utils/jui_theme.dart';
import 'jui_base_dialog.dart';
import 'jui_dialog_config.dart';

class JuiStandardDialog extends StatelessWidget {
  final JuiDialogConfig config;
  final String content;

  const JuiStandardDialog({
    Key? key,
    required this.config,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JuiBaseDialog(
      config: config,
      contentWidget: content.isEmpty
          ? null
          : Text(
              content,
              style: JuiTheme.textStyles.dialogContent,
            ),
    );
  }
}
