import 'package:flutter/material.dart';
import 'package:jui/src/utils/extension.dart';
import '../../../generated/assets.dart';
import '../../utils/jui_theme.dart';

class JuiTitle extends StatelessWidget {
  final String title;
  final Widget? expandedContent;
  final ValueNotifier<bool>? expandFlag;

  const JuiTitle({
    Key? key,
    required this.title,
    this.expandedContent,
    this.expandFlag,
  }) : assert(
  expandedContent == null || expandFlag != null,
  'expandFlag must be provided if expandedContent is not null',
  ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleRow(
          title: title,
          expandFlag: expandFlag,
          hasExpandedContent: expandedContent != null,
        ),
        if (expandedContent != null)
          ValueListenableBuilder<bool>(
            valueListenable: expandFlag!,
            builder: (_, isExpanded, __) => isExpanded ? expandedContent! : const SizedBox.shrink(),
          ),
      ],
    );
  }
}

class _TitleRow extends StatelessWidget {
  final String title;
  final ValueNotifier<bool>? expandFlag;
  final bool hasExpandedContent;

  const _TitleRow({
    Key? key,
    required this.title,
    required this.expandFlag,
    required this.hasExpandedContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              color: JUITheme.colors.primary,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(2)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: JUITheme.textStyles.sectionTitle,
            ),
          ),
          if (hasExpandedContent)
            ValueListenableBuilder<bool>(
              valueListenable: expandFlag!,
              builder: (_, isExpanded, __) => GestureDetector(
                onTap: () => expandFlag!.value = !isExpanded,
                child: Image.asset(
                  isExpanded ? Assets.imagesDown.path : Assets.imagesUp.path,
                  width: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}