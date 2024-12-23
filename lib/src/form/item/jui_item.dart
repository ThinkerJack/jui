import 'package:flutter/material.dart';
import 'package:jui/src/utils/extension.dart';
import 'package:jui/src/utils/jui_theme.dart';
import 'package:jui/src/utils/screen_util.dart';

import '../../../generated/assets.dart';
import '../../data_entry/picker/common/jui_picker_widget.dart';
import 'jui_item_config.dart';

class JuiItem extends StatelessWidget {
  final String title;
  final Widget content;
  final JuiItemConfig config;

  const JuiItem({
    Key? key,
    required this.title,
    required this.content,
    this.config = const JuiItemConfig(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: config.isDisabled ? null : config.onTap,
      focusColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: config.padding ??
                EdgeInsets.only(
                  top: JuiTheme.dimensions.itemPaddingV,
                  right: JuiTheme.dimensions.itemPaddingR,
                  left: JuiTheme.dimensions.itemPaddingL,
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                SizedBox(height: JuiTheme.dimensions.itemSpace),
                content,
                if (config.showTips) _buildTips(),
                SizedBox(height: JuiTheme.dimensions.itemPaddingV),
              ],
            ),
          ),
          if (config.showDivider) _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            title,
            style: config.customTitleStyle ??
                (config.isDisabled ? JuiTheme.textStyles.itemTitleDisabled : JuiTheme.textStyles.itemTitle),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (config.titleBeforeRequiredWidget != null)
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: config.titleBeforeRequiredWidget!,
          ),
        if (!config.isDisabled && config.isRequired)
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: config.requiredMarker ?? Image.asset(Assets.imagesItemRequired.path, width: 7.w),
          ),
        if (config.titleSuffixWidget != null)
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: config.titleSuffixWidget!,
          ),
      ],
    );
  }

  Widget _buildTips() {
    return Column(
      children: [
        SizedBox(height: JuiTheme.dimensions.itemSpace),
        Text(
          config.tipText,
          style: TextStyle(color: JuiTheme.colors.tips, fontSize: 12.sp, height: 1.3),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: config.dividerPadding ?? EdgeInsets.only(left: JuiTheme.dimensions.itemPaddingL),
      child: const JuiPickerDivider(),
    );
  }
}
