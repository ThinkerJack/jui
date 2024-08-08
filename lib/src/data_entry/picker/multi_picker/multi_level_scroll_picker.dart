import 'package:flutter/material.dart';
import 'package:habit/habit.dart';
import 'package:vv_ui_kit/src/utils/color.dart';

import '../../../../data_entry.dart';
import '../../../../generated/l10n.dart';
import '../../../basic/picker_widget.dart';
import 'multi_level_scroll_vm.dart';

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
        constraints: BoxConstraints(maxHeight: 350.w, minWidth: 37.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _buildHeader(context),
            widget.tipsWidget ?? const SizedBox(),
            _buildPicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return PickerTitle(
      leftText: getLanguage<S>().LMID_00002552,
      rightText: getLanguage<S>().LMID_00013631,
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
      constraints: BoxConstraints(maxHeight: 220.w, minWidth: 345.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
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
        top: 90.w,
        right: 0,
        child: PickerSelectionArea(
          height: 40.w,
          child: Center(
            child: Text(
              "～",
              style: TextStyle(color: ui858B9B, fontSize: 16.w),
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
