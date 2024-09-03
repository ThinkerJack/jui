import 'package:flutter/material.dart';
import '../../../generated/assets.dart';
import '../../utils/jui_theme.dart';

class ItemTipsText extends StatelessWidget {
  const ItemTipsText({
    Key? key,
    required this.showTips,
    required this.tipText,
  }) : super(key: key);

  final bool showTips;
  final String tipText;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showTips,
      child: Column(
        children: [
          const SizedBox(height: 4),
          Text(
            tipText,
            style: TextStyle(color: JuiTheme.colors.tips, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class ItemTitle extends StatelessWidget {
  const ItemTitle({
    Key? key,
    required this.title,
    required this.isRequired,
    this.isDisabled = false,
  }) : super(key: key);

  final String title;
  final bool isRequired;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: isDisabled ? JuiTheme.textStyles.itemTitleDisabled : JuiTheme.textStyles.itemTitle,
          maxLines: 1,
        ),
        const SizedBox(width: 4),
        if (!isDisabled && isRequired)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Image.asset(Assets.imagesItemRequired),
          )
      ],
    );
  }
}

class ItemDivider extends StatelessWidget {
  const ItemDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: JuiTheme.colors.divider,
      height: 1,
    );
  }
}