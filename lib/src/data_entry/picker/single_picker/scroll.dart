import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../basic/picker_widget.dart';
import '../common/picker_const.dart';

/// 单列滚动选择器组件
class SingleScrollPicker extends StatefulWidget {
  const SingleScrollPicker({
    Key? key,
    required this.title,
    required this.filterItemData,
    required this.onDone,
    required this.selectedKey,
    required this.cancelText,
    required this.confirmText,
  }) : super(key: key);

  final String title; // 选择器标题
  final String selectedKey; // 初始选中的键值
  final String cancelText; // 取消按钮文本
  final String confirmText; // 确认按钮文本
  final Map<dynamic, String> filterItemData; // 可选项数据
  final SingleDoneCallBack onDone; // 确认选择后的回调

  @override
  State<SingleScrollPicker> createState() => _SingleScrollPickerState();
}

class _SingleScrollPickerState extends State<SingleScrollPicker> {
  late List keys; // 键值列表
  late List<String> values; // 显示文本列表
  late FixedExtentScrollController controller; // 滚动控制器

  @override
  void initState() {
    keys = widget.filterItemData.keys.toList();
    values = widget.filterItemData.values.toList();
    controller =
        FixedExtentScrollController(initialItem: widget.selectedKey.isNotEmpty ? keys.indexOf(widget.selectedKey) : 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 343),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // 标题栏，包含取消和确认按钮
            PickerTitle(
              leftText: widget.cancelText,
              rightText: widget.confirmText,
              onCancel: () {
                Navigator.pop(context);
              },
              onConfirm: () {
                Navigator.pop(context);
                widget.onDone(keys[controller.selectedItem], widget.filterItemData[keys[controller.selectedItem]]);
              },
              title: widget.title,
            ),
            Expanded(
              child: Column(
                children: [
                  // 固定区域，包含滚动选择器
                  ScrollFixedArea(
                    picker: CustomCupertinoPicker(
                      scrollEnd: () {},
                      childCount: values.length,
                      textList: values,
                      controller: controller,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 自定义滚动选择器组件
class CustomCupertinoPicker extends StatelessWidget {
  const CustomCupertinoPicker(
      {Key? key,
      required this.childCount,
      required this.textList,
      this.scrollEnd,
      this.scrollStart,
      this.scrollUpdate,
      this.itemChanged,
      this.controller})
      : super(key: key);

  final Function? scrollEnd; // 滚动结束回调
  final Function? scrollStart; // 滚动开始回调
  final Function? scrollUpdate; // 滚动更新回调
  final Function? itemChanged; // 选项改变回调
  final FixedExtentScrollController? controller; // 滚动控制器
  final int childCount; // 选项数量
  final List<String> textList; // 选项文本列表

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (Notification notification) {
        if (notification is ScrollStartNotification) {
          scrollStart?.call();
        }
        if (notification is ScrollEndNotification) {
          scrollEnd?.call();
        }
        if (notification is ScrollUpdateNotification) {
          scrollUpdate?.call();
        }
        return false;
      },
      child: CupertinoPicker.builder(
        scrollController: controller,
        selectionOverlay: null,
        childCount: childCount,
        itemExtent: 52,
        squeeze: 1.2,
        onSelectedItemChanged: (index) {
          itemChanged?.call(index);
        },
        itemBuilder: (context, index) {
          return Center(
            child: Text(
              textList[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF2A2F3C),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// 固定区域组件
class ScrollFixedArea extends StatelessWidget {
  const ScrollFixedArea({Key? key, required this.picker}) : super(key: key);

  final Widget picker; // 滚动选择器

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 220, minWidth: 345),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          // 选择区域的视觉效果
          Positioned(
            left: 0,
            top: 84,
            right: 0,
            child: PickerSelectionArea(
              height: 46,
              child: null,
            ),
          ),
          picker,
        ],
      ),
    );
  }
}
