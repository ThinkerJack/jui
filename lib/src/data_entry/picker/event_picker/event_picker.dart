import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/bottom_cancel_widget.dart';
import '../common/picker_const.dart';
import '../common/picker_widget.dart';
import 'event_picker_func.dart';

/// 事件选择器组件
class EventPicker extends StatefulWidget {
  const EventPicker({
    Key? key,
    required this.cancelText,
    this.onCancel,
    required this.eventBeanList,
    required this.type,
  }) : super(key: key);

  final String cancelText; // 取消按钮文本
  final CancelCallBack? onCancel; // 取消回调
  final List<EventPickerBean> eventBeanList; // 事件数据列表
  final EventPickerType type; // 事件选择器类型

  @override
  State<EventPicker> createState() => _EventPickerState();
}

class _EventPickerState extends State<EventPicker> {
  @override
  void initState() {
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
          Container(
            constraints: BoxConstraints(maxHeight: 550),
            child: MediaQuery.removePadding(
              removeBottom: true,
              context: context,
              child: ListView(
                shrinkWrap: true,
                physics: widget.eventBeanList.length < 8 ? const NeverScrollableScrollPhysics() : null,
                children: [
                  for (EventPickerBean data in widget.eventBeanList)
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        data.onTap.call();
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Column(
                        children: [
                          _getContent(context, data),
                          const PickerDivider(),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
          const BCPSpacer(), // 底部取消按钮的间隔
          BCPButton(onCancel: widget.onCancel) // 底部取消按钮
        ],
      ),
    );
  }

  /// 获取内容，根据不同类型返回不同的内容组件
  Widget _getContent(BuildContext context, EventPickerBean data) {
    switch (widget.type) {
      case EventPickerType.text:
        return _getContainer([_getText(data)]);
      case EventPickerType.icon:
        return _getContainer([
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: data.icon ?? const SizedBox(),
          ),
          _getText(data)
        ]);
      case EventPickerType.widget:
        return _getContainer([data.contentWidget ?? const SizedBox()]);
    }
  }

  /// 获取容器，包装传入的子组件
  Container _getContainer(List<Widget> data) {
    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: data,
      ),
    );
  }

  /// 获取文本组件
  Text _getText(EventPickerBean data) {
    return Text(
      data.contentText ?? "",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        height: 1.5,
        color: const Color(0xFF2A2F3C),
      ),
    );
  }
}
