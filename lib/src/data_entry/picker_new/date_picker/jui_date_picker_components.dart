// lib/src/data_entry/jui_date_picker/jui_date_picker_components.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jui/generated/assets.dart';
import 'package:jui/src/utils/extension.dart';
import 'package:jui/src/utils/jui_theme.dart';
import 'jui_date_picker_types.dart';
import 'jui_date_picker_utils.dart';

class JuiDateProcessTitle extends StatelessWidget {
  const JuiDateProcessTitle({
    Key? key,
    required this.time,
    required this.onDone,
    this.title,
  }) : super(key: key);

  final ValueNotifier<DateTime?> time;
  final VoidCallback onDone;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      constraints: BoxConstraints(maxHeight: 56, minHeight: 56),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              "取消",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'PingFang SC',
                color: const Color(0xFF858B9B),
              ),
            ),
          ),
          Text(
            title ?? "选择时间",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 1.3,
              color: const Color(0xFF2A2F3C),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: time,
            builder: (context, value, child) => Visibility(
              visible: time.value != null,
              replacement: Text(
                "确定",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'PingFang SC',
                  color: const Color(0xFFC7DDFF),
                ),
              ),
              child: GestureDetector(
                onTap: onDone,
                child: Text(
                  "确定",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'PingFang SC',
                    color: const Color(0xFF5590F6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JuiDatePickerSliding extends StatelessWidget {
  const JuiDatePickerSliding({
    Key? key,
    required this.picker,
    required this.mode,
  }) : super(key: key);

  final Widget picker;
  final JuiDatePickerMode mode;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 220, minWidth: 345),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 90,
            right: 0,
            child: JuiPickerSelectionArea(
              height: 40,
              child: getLine(),
            ),
          ),
          picker,
        ],
      ),
    );
  }

  Widget? getLine() {
    switch (mode) {
      case JuiDatePickerMode.scrollYMD:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            JuiDateSpaceLine(),
            JuiDateSpaceLine(),
          ],
        );
      case JuiDatePickerMode.scrollYM:
        return const Center(child: JuiDateSpaceLine());
      default:
        return null;
    }
  }
}

class JuiDateSpaceLine extends StatelessWidget {
  const JuiDateSpaceLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 1,
      decoration: BoxDecoration(
        color: const Color(0x5C141824),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}

class JuiCommonTimeTitle extends StatelessWidget {
  const JuiCommonTimeTitle({
    Key? key,
    required this.startOrEndFlag,
    required this.endTime,
    required this.tapStart,
    required this.tapEnd,
    required this.mode,
    required this.startTime,
  }) : super(key: key);

  final ValueNotifier<bool> startOrEndFlag;
  final ValueNotifier<DateTime?> endTime;
  final VoidCallback tapStart;
  final VoidCallback tapEnd;
  final JuiDatePickerMode mode;
  final DateTime? startTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 64, minHeight: 64),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: tapStart,
              child: buildStartWidget(context),
            ),
          ),
          Image.asset(
           Assets.imagesArrow.path,  // Replace with your actual asset pat
            height: 6,
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: tapEnd,
              child: Visibility(
                visible: endTime.value != null,
                replacement: Container(
                  color: Colors.white,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "结束时间",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      height: 1.2,
                      color: !startOrEndFlag.value ? const Color(0xFF5590F6) : const Color(0xFF858B9B),
                    ),
                  ),
                ),
                child: buildEndWidget(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEndWidget(BuildContext context) {
    bool endTimeIsNotNull = endTime.value != null;
    switch (mode) {
      case JuiDatePickerMode.scrollYMD:
        return Container(
          color: Colors.white,
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 9),
                child: Text(
                  endTimeIsNotNull ? getDateStringFromDate(endTime.value!, 'yyyy-MM-dd') : "",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    color: !startOrEndFlag.value ? const Color(0xFF5590F6) : const Color(0xFF2A2F3C),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 9),
                child: Text(
                  endTimeIsNotNull ? getWeekString(endTime.value!.weekday, context, isAbbreviation: true) : "",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    color: !startOrEndFlag.value ? const Color(0xFF5590F6) : const Color(0xFF2A2F3C),
                  ),
                ),
              ),
            ],
          ),
        );
      case JuiDatePickerMode.scrollYMDWHM:
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 9),
                child: Text(
                  endTimeIsNotNull ? getYMDWText(endTime.value!, context, isAbbreviation: true) : "",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PingFang SC',
                    color: !startOrEndFlag.value ? const Color(0xFF5590F6) : const Color(0xFF2A2F3C),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 9),
                child: Text(
                  endTimeIsNotNull ? getHMText(endTime.value!) : "",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'PingFang SC',
                    color: !startOrEndFlag.value ? const Color(0xFF5590F6) : const Color(0xFF2A2F3C),
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget buildStartWidget(BuildContext context) {
    bool startTimeIsNotNull = startTime != null;
    switch (mode) {
      case JuiDatePickerMode.scrollYMD:
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  startTimeIsNotNull ? getDateStringFromDate(startTime!, 'yyyy-MM-dd') : "",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    color: startOrEndFlag.value ? const Color(0xFF5590F6) : const Color(0xFF2A2F3C),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  startTimeIsNotNull ? getWeekString(startTime!.weekday, context, isAbbreviation: true) : "",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'PingFang SC',
                    color: startOrEndFlag.value ? const Color(0xFF5590F6) : const Color(0xFF2A2F3C),
                  ),
                ),
              ),
            ],
          ),
        );
      case JuiDatePickerMode.scrollYMDWHM:
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  startTimeIsNotNull ? getYMDWText(startTime!, context, isAbbreviation: true) : "",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PingFang SC',
                    color: startOrEndFlag.value ? const Color(0xFF5590F6) : const Color(0xFF2A2F3C),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  startTimeIsNotNull ? getHMText(startTime!) : "",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'PingFang SC',
                    color: startOrEndFlag.value ? const Color(0xFF5590F6) : const Color(0xFF2A2F3C),
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }
}

class JuiPickerEmptyWidget extends StatelessWidget {
  const JuiPickerEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 65),
        Image.asset(
          'assets/images/list_empty.png',  // Replace with your actual asset path
        ),
        Text(
          "暂无数据",
          style: TextStyle(fontSize: 16, color: JuiColors().textSecondary, height: 1.5, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class JuiPickerTitle extends StatelessWidget {
  const JuiPickerTitle({
    Key? key,
    required this.title,
    this.onConfirm,
    required this.onCancel,
    required this.leftText,
    this.rightText,
    this.rightTextStyle,
    this.paddingHorizontal = 5,
  }) : super(key: key);

  final String title;
  final String leftText;
  final VoidCallback onCancel;
  final String? rightText;
  final TextStyle? rightTextStyle;
  final VoidCallback? onConfirm;
  final double paddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(bottom: BorderSide(color: JuiColors().border, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onCancel,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(leftText, style: TextStyle(fontSize: 14, color: JuiColors().textSecondary, height: 1.5)),
            ),
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              style: TextStyle(
                fontSize: 16,
                color: JuiColors().text,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Visibility(
            visible: rightText != null,
            replacement: SizedBox(width: 60),
            child: GestureDetector(
              onTap: onConfirm,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  rightText ?? "",
                  style: rightTextStyle ?? TextStyle(fontSize: 14, color: JuiColors().primary, height: 1.5, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
class JuiPickerDivider extends StatelessWidget {
  const JuiPickerDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: const Color(0X14000000),
      height: 0.5,
    );
  }
}

class JuiPickerSelectionArea extends StatelessWidget {
  const JuiPickerSelectionArea({super.key, this.child, required this.height});

  final Widget? child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFC),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: JuiColors().divider, width: 0.5),
      ),
      height: height,
      child: child,
    );
  }
}

class JuiCupertinoPicker extends StatelessWidget {
  const JuiCupertinoPicker({
    Key? key,
    required this.controller,
    required this.childCount,
    required this.textList,
    this.scrollEnd,
    this.scrollStart,
    this.scrollUpdate,
    this.itemChanged,
  }) : super(key: key);

  final VoidCallback? scrollEnd;
  final VoidCallback? scrollStart;
  final VoidCallback? scrollUpdate;
  final Function(int)? itemChanged;
  final FixedExtentScrollController? controller;
  final int childCount;
  final List<String> textList;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          scrollStart?.call();
        } else if (notification is ScrollEndNotification) {
          scrollEnd?.call();
        } else if (notification is ScrollUpdateNotification) {
          scrollUpdate?.call();
        }
        return false;
      },
      child: CupertinoPicker.builder(
        scrollController: controller,
        selectionOverlay: null,
        childCount: childCount,
        itemExtent: 44,
        squeeze: 1.2,
        onSelectedItemChanged: (index) {
          itemChanged?.call(index);
        },
        itemBuilder: (context, index) {
          return Center(
            child: Text(
              textList[index],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Avenger',
                color: const Color(0xFF2A2F3C),
              ),
            ),
          );
        },
      ),
    );
  }
}