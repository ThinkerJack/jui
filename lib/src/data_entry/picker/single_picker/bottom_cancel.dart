import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../basic/bottom_cancel_widget.dart';
import '../../../basic/picker_widget.dart';
import '../common/picker_const.dart';

/// 底部取消按钮选择器
class BottomCancelPicker extends StatefulWidget {
  const BottomCancelPicker({
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
  State<BottomCancelPicker> createState() => _BottomCancelPickerState();
}

class _BottomCancelPickerState extends State<BottomCancelPicker> {
  late List keys; // 键值列表

  @override
  void initState() {
    keys = widget.filterItemData.keys.toList();
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
                        Navigator.pop(context);
                        widget.onDone(key, widget.filterItemData[key]);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        children: [
                          Container(
                            width: ScreenUtil().screenWidth,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.filterItemData[key] ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    color: const Color(0xFF2A2F3C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const PickerDivider(),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const BCPSpacer(), // 底部空白间距
          BCPButton(onCancel: widget.onCancel), // 取消按钮
        ],
      ),
    );
  }
}
