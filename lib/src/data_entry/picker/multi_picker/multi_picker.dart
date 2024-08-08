import 'package:flutter/material.dart';
import 'package:habit/habit.dart';
import 'package:vv_ui_kit/src/basic/extension.dart';

import '../../../../generated/assets.dart';
import '../../../../utils.dart';
import '../../../basic/picker_widget.dart';
import '../common/picker_const.dart';
import '../common/picker_func.dart';
import '../common/picker_widget.dart';
import 'multi_picker_func.dart';

/// 多选选择器组件
class MultiSelectionPicker extends StatefulWidget {
  const MultiSelectionPicker({
    Key? key,
    required this.title,
    required this.filterItemData,
    required this.onDone,
    required this.selectedKeys,
    required this.topLeftText,
    required this.topRightText,
    required this.type,
    this.onCancel,
  }) : super(key: key);

  final String title; // 标题
  final List<String> selectedKeys; // 已选中的键
  final Map<String, dynamic> filterItemData; // 过滤项数据
  final String topLeftText; // 左侧顶部文本
  final String topRightText; // 右侧顶部文本
  final MultiDoneCallBack onDone; // 完成回调
  final MultiPickerType type; // 选择器类型
  final CancelCallBack? onCancel; // 取消回调

  @override
  State<MultiSelectionPicker> createState() => _MultiSelectionPickerState();
}

class _MultiSelectionPickerState extends State<MultiSelectionPicker> {
  late List<String> keys; // 键列表
  List<String> selectedKeys = []; // 已选中的键列表

  @override
  void initState() {
    keys = widget.filterItemData.keys.toList();
    selectedKeys.addAll(widget.selectedKeys);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(24.w), topLeft: Radius.circular(24.w)),
      ),
      padding: EdgeInsets.only(bottom: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 标题栏
          PickerTitle(
            leftText: widget.topLeftText,
            rightText: widget.topRightText,
            onCancel: () {
              Navigator.pop(context);
              widget.onCancel?.call();
            },
            onConfirm: () {
              Navigator.pop(context);
              onConfirm();
            },
            title: widget.title,
            paddingHorizontal: 10,
          ),
          // 列表区域
          Container(
            constraints: BoxConstraints(maxHeight: 550.w),
            child: keys.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return buildItemWidget(keys[index]);
                    },
                    itemCount: keys.length,
                  )
                : const PickerEmptyWidget(),
          ),
        ],
      ),
    );
  }

  /// 确认选择后的操作
  void onConfirm() {
    List<String> selectedValues = [];
    for (var data in widget.filterItemData.keys) {
      if (selectedKeys.contains(data)) {
        selectedValues.add(widget.filterItemData[data]);
      }
    }
    widget.onDone(selectedKeys, convertListToString(selectedValues));
  }

  /// 构建列表项
  Widget buildItemWidget(data) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedKeys.contains(data) ? selectedKeys.remove(data) : selectedKeys.add(data);
        });
      },
      child: Padding(
        padding: EdgeInsets.only(left: 24.w),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              height: 63.r,
              child: getItemRow(data),
            ),
            const PickerDivider()
          ],
        ),
      ),
    );
  }

  /// 构建选择项的行
  Row getItemRow(data) {
    switch (widget.type) {
      case MultiPickerType.checkBox:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Image.asset(
                selectedKeys.contains(data) ? Assets.imagesIconSelected.path : Assets.imagesIconUnselected.path,
                width: 20.r,
                height: 20.r,
              ),
            ),
            Expanded(
              child: Text(widget.filterItemData[data].toString(),
                      style: TextStyle(
                        color: ui2A2F3C,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis)
                  .margin(right: 9.r),
            ),
          ],
        );
      case MultiPickerType.circularCheckBox:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(widget.filterItemData[data],
                      style: TextStyle(
                        color: ui2A2F3C,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis)
                  .margin(left: 9.r, right: 9.r),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Image.asset(
                selectedKeys.contains(data)
                    ? Assets.imagesIconCircularSelected.path
                    : Assets.imagesIconCircularUnselected.path,
                width: 20.r,
                height: 20.r,
              ),
            ),
          ],
        );
    }
  }
}
