import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jui/src/utils/extension.dart';

import '../../../../generated/assets.dart';
import '../../../utils/jui_theme.dart';
import 'date_picker_func.dart';

/// 日期选择标题栏组件，包括取消、确定按钮及标题
class DateProcessTitle extends StatelessWidget {
  const DateProcessTitle({
    Key? key,
    required this.time,
    required this.onDone,
    this.title,
  }) : super(key: key);

  final ValueNotifier<DateTime?> time; // 时间状态
  final void Function() onDone; // 点击确定的回调
  final String? title; // 标题

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

/// 日期选择器滑动区域组件
class DatePickerSliding extends StatelessWidget {
  const DatePickerSliding({
    Key? key,
    required this.picker,
    required this.type,
  }) : super(key: key);

  final Widget picker; // 选择器组件
  final DatePickerType type; // 选择器类型

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
              child: PickerSelectionArea(
                height: 40,
                child: getLine(),
              )),
          picker,
        ],
      ),
    );
  }

  dynamic getLine() {
    switch (type) {
      case DatePickerType.scrollYMD:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            DateSpaceLine(),
            DateSpaceLine(),
          ],
        );
      case DatePickerType.scrollYM:
        return const Center(child: DateSpaceLine());
      default:
        return null;
    }
  }
}

/// 日期选择器间隔线组件
class DateSpaceLine extends StatelessWidget {
  const DateSpaceLine({Key? key}) : super(key: key);

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

/// 时间展示区域组件
class CommonTimeTitle extends StatelessWidget {
  const CommonTimeTitle({
    Key? key,
    required this.startOrEndFlag,
    required this.endTime,
    required this.tapStart,
    required this.tapEnd,
    required this.type,
    required this.startTime,
  }) : super(key: key);

  final ValueNotifier<DateTime?> endTime; // 结束时间
  final ValueNotifier<bool> startOrEndFlag; // 开始或结束标志
  final Function tapStart; // 点击开始时间回调
  final Function tapEnd; // 点击结束时间回调
  final DatePickerType type; // 选择器类型
  final DateTime? startTime; // 开始时间

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
              onTap: () {
                tapStart();
              },
              child: buildStartWidget(context),
            ),
          ),
          Image.asset(
            Assets.imagesArrow.path,
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                tapEnd();
              },
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
    switch (type) {
      case DatePickerType.scrollYMD:
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
      case DatePickerType.scrollYMDWHM:
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
    switch (type) {
      case DatePickerType.scrollYMD:
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
      case DatePickerType.scrollYMDWHM:
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

class PickerEmptyWidget extends StatelessWidget {
  const PickerEmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 65),
        Image.asset(
          Assets.imagesListEmpty.path,
        ),
        Text(
          "暂无数据",
          style: TextStyle(fontSize: 16, color: JuiColors().textSecondary, height: 1.5, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

TextStyle _leftTextStyle = TextStyle(fontSize: 14, color: JuiColors().textSecondary, height: 1.5);

TextStyle _rightTextDefaultStyle =
    TextStyle(fontSize: 14, color: JuiColors().primary, height: 1.5, fontWeight: FontWeight.w500);

class PickerTitle extends StatelessWidget {
  const PickerTitle({
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
  final Function onCancel;
  final String? rightText;
  final TextStyle? rightTextStyle;
  final Function? onConfirm;
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
            onTap: () {
              onCancel();
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(leftText, style: _leftTextStyle),
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
            replacement: SizedBox(
              width: 60,
            ),
            child: GestureDetector(
              onTap: () {
                onConfirm?.call();
              },
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(rightText ?? "", style: rightTextStyle ?? _rightTextDefaultStyle),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PickerDivider extends StatelessWidget {
  const PickerDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: const Color(0X14000000),
      height: 0.5,
    );
  }
}

class PickerSelectionArea extends StatelessWidget {
  const PickerSelectionArea({super.key, this.child, required this.height});

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

class VVCupertinoPicker extends StatelessWidget {
  const VVCupertinoPicker({
    Key? key,
    required this.controller,
    required this.childCount,
    required this.textList,
    this.scrollEnd,
    this.scrollStart,
    this.scrollUpdate,
    this.itemChanged,
  }) : super(key: key);

  final Function? scrollEnd; // 滚动结束回调
  final Function? scrollStart; // 滚动开始回调
  final Function? scrollUpdate; // 滚动更新回调
  final Function? itemChanged; // 选项改变回调
  final FixedExtentScrollController? controller; // 滚动控制器
  final int childCount; // 子项数量
  final List<String> textList; // 文本列表

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

enum RangeType { hasMin, hasMax, common, hasMinAndMax }

List<String> getYearList(DateTime initDate, {RangeType type = RangeType.common, int? minYear, int? maxYear}) {
  List<String> list = [];
  int start, end;

  switch (type) {
    case RangeType.common:
      start = initDate.year - 50;
      end = initDate.year + 50;
      break;
    case RangeType.hasMin:
      start = minYear!;
      end = minYear + 100;
      break;
    case RangeType.hasMax:
      start = maxYear! - 100;
      end = maxYear;
      break;
    case RangeType.hasMinAndMax:
      start = minYear!;
      end = maxYear!;
      break;
  }

  for (int i = start; i <= end; i++) {
    list.add(i.toString());
  }

  return list;
}

List<String> getMonthList({RangeType type = RangeType.common, int minMonth = 1, int maxMonth = 12}) {
  List<String> list = [];
  int start, end;

  switch (type) {
    case RangeType.common:
      start = 1;
      end = 12;
      break;
    case RangeType.hasMin:
      start = minMonth;
      end = 12;
      break;
    case RangeType.hasMax:
      start = 1;
      end = maxMonth;
      break;
    case RangeType.hasMinAndMax:
      start = minMonth;
      end = maxMonth;
      break;
  }

  for (int i = start; i <= end; i++) {
    list.add(i.toString().padLeft(2, "0"));
  }

  return list;
}

List<String> getDayList({RangeType type = RangeType.common, int? startDay, int? days, required DateTime date}) {
  List<String> list = [];
  int totalDays = DateTime(date.year, date.month + 1, 0).day;
  int start = type == RangeType.hasMin ? (startDay ?? 1) : 1;
  int end = type == RangeType.hasMax ? (days ?? totalDays) : totalDays;

  for (int i = start; i <= end; i++) {
    list.add(i.toString().padLeft(2, "0"));
  }

  return list;
}

List<String> getEndYearList(DateTime startDate) {
  return getYearList(startDate, type: RangeType.hasMin, minYear: startDate.year);
}

List<String> getEndMonthList(DateTime startTime, DateTime endTime, Duration timeGap) {
  if (endTime.year == startTime.add(timeGap).year) {
    return getMonthList(minMonth: startTime.add(timeGap).month, type: RangeType.hasMin);
  } else {
    return getMonthList();
  }
}

List<String> getEndDayList(DateTime startTime, DateTime endTime, Duration timeGap) {
  if (endTime.year == startTime.add(timeGap).year && endTime.month == startTime.add(timeGap).month) {
    return getDayList(type: RangeType.hasMin, startDay: startTime.add(timeGap).day, date: endTime);
  } else {
    return getDayList(date: endTime);
  }
}

List<String> getHourList() {
  return List.generate(24, (i) => i.toString().padLeft(2, "0"));
}

List<String> getEndHourList(DateTime startTime, DateTime endTime, Duration timeGap) {
  if (endTime.year == startTime.add(timeGap).year &&
      endTime.month == startTime.add(timeGap).month &&
      endTime.day == startTime.add(timeGap).day) {
    int startHour = startTime.add(timeGap).hour;
    return List.generate(24 - startHour, (i) => (startHour + i).toString().padLeft(2, "0"));
  } else {
    return getHourList();
  }
}

List<String> getMinuteList() {
  return List.generate(60, (i) => i.toString().padLeft(2, "0"));
}

List<String> getEndMinuteList(DateTime startTime, DateTime endTime, Duration timeGap) {
  if (endTime.year == startTime.add(timeGap).year &&
      endTime.month == startTime.add(timeGap).month &&
      endTime.day == startTime.add(timeGap).day &&
      endTime.hour == startTime.add(timeGap).hour) {
    int startMinute = startTime.add(timeGap).minute;
    return List.generate(60 - startMinute, (i) => (startMinute + i).toString().padLeft(2, "0"));
  } else {
    return getMinuteList();
  }
}

List<String> getYMDWList(DateTime date, BuildContext context) {
  return List.generate(731, (i) => getYMDWText(date.add(Duration(days: i - 365)), context));
}

List<String> getEndYMDWList(DateTime startDate, BuildContext context) {
  return List.generate(731, (i) => getYMDWText(startDate.add(Duration(days: i)), context));
}

String getMinuteText(DateTime date) {
  return date.minute.toString().padLeft(2, "0");
}

String getHourText(DateTime date) {
  return date.hour.toString().padLeft(2, "0");
}

String getMonthText(DateTime date) {
  return date.month.toString().padLeft(2, "0");
}

String getDayText(DateTime date) {
  return date.day.toString().padLeft(2, "0");
}

String getYMDWText(DateTime date, context, {bool isAbbreviation = false}) {
  return '${getDateStringFromDate(date, 'yyyy-MM-dd')} ${getWeekString(date.weekday, context, isAbbreviation: isAbbreviation)}';
}

String getMDWText(DateTime date, context) {
  return "${getMonthText(date)}${"月"}${getDayText(date)}${"日"} ${getWeekString(date.weekday, context)}";
}

String getYMDText(DateTime date, context) {
  return "${date.year}${"年"}${getMonthText(date)}${"月"}${getDayText(date)}${"日"}";
}

String getWText(DateTime date, context) {
  return getWeekString(date.weekday, context);
}

String getHMText(DateTime date) {
  return "${getHourText(date)}:${getMinuteText(date)}";
}

String getWeekString(int weekIndex, context, {bool isAbbreviation = false}) {
  if (isAbbreviation) {
    final abbreviationWeekArray = [
      "周一",
      "周二",
      "周三",
      "周四",
      "周五",
      "周六",
      "周日",
    ];
    if (abbreviationWeekArray.length > weekIndex - 1) {
      return abbreviationWeekArray[weekIndex - 1];
    }
  } else {
    final weekArray = [
      "周一",
      "周二",
      "周三",
      "周四",
      "周五",
      "周六",
      "周日",
    ];
    if (weekArray.length > weekIndex - 1) {
      return weekArray[weekIndex - 1];
    }
  }

  return '';
}

String getDateStringFromDate(DateTime date, String formatterString) {
  return DateFormat(formatterString).format(date);
}

extension CustomDateTimeExtension on DateTime {
  bool isSameDay(DateTime date) {
    final dateFormat = DateFormat("yyyy-MM-dd");
    final date1 = dateFormat.format(this);
    final date2 = dateFormat.format(date);
    return date1 == date2;
  }
}

class TimeRange {
  final DateTime? min; //开始时间最小值 开始时间最大值默认当天
  final DateTime? max; //结束时间最大值 结束时间最小值由开始时间推算

  const TimeRange({required this.min, required this.max});
}

Duration getDefaultTimeGap(DatePickerType unit) {
  switch (unit) {
    case DatePickerType.scrollYMD:
      return const Duration(days: 1);
    default:
      return const Duration(minutes: 1);
  }
}
