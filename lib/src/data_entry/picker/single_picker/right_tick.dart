import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jui/src/utils/color.dart';
import 'package:jui/src/utils/extension.dart';

import '../../../../generated/assets.dart';
import '../common/picker_const.dart';
import '../common/picker_widget.dart';

/// 右侧打钩选择器组件
class RightTickPicker extends StatefulWidget {
  const RightTickPicker({
    Key? key,
    required this.title,
    required this.filterItemData,
    required this.onDone,
    required this.selectedKey,
    required this.cancelText,
    required this.confirmText,
    this.onCancel,
  }) : super(key: key);

  final String title; // 选择器标题
  final String selectedKey; // 初始选中的键值
  final String cancelText; // 取消按钮文本
  final CancelCallBack? onCancel; // 取消按钮回调
  final String confirmText; // 确认按钮文本
  final Map<dynamic, String> filterItemData; // 可选项数据
  final SingleDoneCallBack onDone; // 确认选择后的回调

  @override
  State<RightTickPicker> createState() => _RightTickPickerState();
}

class _RightTickPickerState extends State<RightTickPicker> {
  late List keys; // 键值列表
  late String selectedKey; // 当前选中的键值

  @override
  void initState() {
    keys = widget.filterItemData.keys.toList();
    selectedKey = widget.selectedKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 标题栏，包含取消按钮
          PickerTitle(
            leftText: widget.cancelText,
            onCancel: () {
              Navigator.pop(context);
            },
            title: widget.title,
            paddingHorizontal: 5,
          ),
          // 列表区域
          Container(
            constraints: BoxConstraints(maxHeight: 550),
            child: MediaQuery.removePadding(
              removeBottom: true,
              context: context,
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (var key in keys)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedKey = key;
                        });
                        Navigator.pop(context);
                        widget.onDone(key, widget.filterItemData[key]);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: ScreenUtil().screenWidth,
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(widget.filterItemData[key] ?? "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                          color: key == selectedKey ? ui2A2F3C : ui858B9B,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20, top: 5, left: 20),
                                    child: Visibility(
                                        visible: key == selectedKey, child: Image.asset(Assets.imagesIconTick.path)),
                                  )
                                ],
                              ),
                            ),
                            const PickerDivider(),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
