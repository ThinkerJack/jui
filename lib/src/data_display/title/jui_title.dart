import 'package:flutter/material.dart';
import 'package:jui/src/utils/extension.dart';

import '../../../generated/assets.dart';

class JUITitle extends StatelessWidget {
  /// 标题文本
  final String title;

  /// 内容可折叠
  final Widget? expandedContent;

  /// 内容可折叠开关
  final ValueNotifier<bool>? expandFlag;

  const JUITitle({
    Key? key,
    required this.title,
    this.expandedContent,
    this.expandFlag,
  })  : assert(expandedContent == null || expandFlag != null,
            'expandFlag must be provided if expandedContent is not null'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleRow(),
        if (expandedContent != null) _buildExpandableContent(),
      ],
    );
  }

  Widget _buildTitleRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          _buildBlueBlock(),
          const SizedBox(width: 16),
          Expanded(child: _buildTitleText()),
          if (expandedContent != null) _buildExpandToggle(),
        ],
      ),
    );
  }

  Widget _buildBlueBlock() {
    return Container(
      width: 4,
      height: 16,
      decoration: const BoxDecoration(
        color: Color(0xFF5590F6),
        borderRadius: BorderRadius.horizontal(right: Radius.circular(2)),
      ),
    );
  }

  Widget _buildTitleText() {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF2A2F3C),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildExpandToggle() {
    return ValueListenableBuilder<bool>(
      valueListenable: expandFlag!,
      builder: (context, isExpanded, _) {
        return GestureDetector(
          onTap: () => expandFlag!.value = !isExpanded,
          child: Image.asset(
            isExpanded ? Assets.imagesIconDown.path : Assets.imagesIconUp.path,
            width: 20,
          ),
        );
      },
    );
  }

  Widget _buildExpandableContent() {
    return ValueListenableBuilder<bool>(
      valueListenable: expandFlag!,
      builder: (context, isExpanded, _) {
        return Visibility(
          visible: isExpanded,
          child: expandedContent!,
        );
      },
    );
  }
}
