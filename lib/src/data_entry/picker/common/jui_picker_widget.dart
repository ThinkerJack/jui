import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/jui_theme.dart';

class JuiPickerDivider extends StatelessWidget {
  const JuiPickerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: JuiTheme.colors.divider,
      height: 0.5,
    );
  }
}
