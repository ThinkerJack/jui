import 'package:flutter/material.dart';

import '../../../utils/jui_theme.dart';
import '../common/picker_widget.dart';
import 'multi_level_scroll_vm.dart';
import 'multi_picker_func.dart';

class MultiLevelScrollPicker extends StatefulWidget {
  const MultiLevelScrollPicker({
    Key? key,
    required this.title,
    this.tipsWidget,
    required this.data,
    required this.onDone,
  }) : super(key: key);

  final String title;
  final Widget? tipsWidget;
  final List<MultiLevelPickerModel> data;
  final Function(String firstLevelKey, String? secondLevelKey) onDone;

  @override
  State<MultiLevelScrollPicker> createState() => _MultiLevelScrollPickerState();
}

class _MultiLevelScrollPickerState extends State<MultiLevelScrollPicker> {
  final MultiLevelScrollVM vm = MultiLevelScrollVM();

  @override
  void initState() {
    super.initState();
    vm.init(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        constraints: BoxConstraints(maxHeight: 350, minWidth: 37),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _buildHeader(context),
            widget.tipsWidget ?? SizedBox.shrink(),
            _buildPicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return PickerTitle(
      leftText: "取消",
      rightText: "确定",
      onCancel: () => Navigator.pop(context),
      onConfirm: () {
        final firstSelected = widget.data[vm.firstController.selectedItem];
        final firstLevelKey = firstSelected.key;
        bool listIsNotNullOrEmpty = firstSelected.list != null && firstSelected.list!.isNotEmpty;
        final String? secondLevelKey =
            listIsNotNullOrEmpty ? firstSelected.list![vm.secondController.selectedItem].key : null;
        Navigator.pop(context);
        widget.onDone(firstLevelKey, secondLevelKey);
      },
      title: widget.title,
      paddingHorizontal: 5,
    );
  }

  Widget _buildPicker() {
    return Container(
      constraints: BoxConstraints(maxHeight: 220, minWidth: 345),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          _buildSelectionIndicator(),
          Row(
            children: [
              _buildFirstLevelPicker(),
              _buildSecondLevelPicker(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionIndicator() {
    return Positioned(
        left: 0,
        top: 90,
        right: 0,
        child: PickerSelectionArea(
          height: 40,
          child: Center(
            child: Text(
              "～",
              style: TextStyle(color: JuiColors().textSecondary, fontSize: 16),
            ),
          ),
        ));
  }

  Widget _buildFirstLevelPicker() {
    return Expanded(
      child: VVCupertinoPicker(
        scrollEnd: vm.firstScrollEnd,
        childCount: vm.firstTextList.length,
        textList: vm.firstTextList,
        controller: vm.firstController,
      ),
    );
  }

  Widget _buildSecondLevelPicker() {
    return ValueListenableBuilder(
      valueListenable: vm.dataChange,
      builder: (context, _, __) {
        return Expanded(
          child: VVCupertinoPicker(
            childCount: vm.getSecondTextList().length,
            textList: vm.getSecondTextList(),
            controller: vm.secondController,
          ),
        );
      },
    );
  }
}
