import 'package:flutter/material.dart';
import '../common/picker_const.dart';
import 'event_picker.dart';

class EventPickerBean {
  final String? contentText;
  final Function onTap;
  final Widget? contentWidget;
  final Widget? icon;

  EventPickerBean({
    this.contentText,
    required this.onTap,
    this.contentWidget,
    this.icon,
  });
}

enum EventPickerType {
  text,
  widget,
  icon,
}

//滚动单选
showEventPicker(
  BuildContext context, {
  CancelCallBack? onCancel,
  required List<EventPickerBean> eventBeanList,
  required EventPickerType type,
}) {
  FocusManager.instance.primaryFocus?.unfocus();
  showModalBottomSheet(
      context: context,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.7),
      isScrollControlled: true,
      enableDrag: false,
      constraints: BoxConstraints(maxHeight: 650),
      backgroundColor: Colors.transparent,
      builder: (context) => EventPicker(
            cancelText: "取消",
            onCancel: onCancel,
            eventBeanList: eventBeanList,
            type: type,
          ));
}
