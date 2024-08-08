import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jui/src/data_entry/picker/date_picker/sv_scroll_date_picker.dart';
import 'package:jui/src/data_entry/picker/date_picker/tap_date_picker.dart';

import 'mv_date_picker.dart';

Future<dynamic> showVVDatePicker(
  BuildContext context, {
  required DatePickerType type,
  required Function onDone,
  DateTime? startTime,
  DateTime? endTime,
  DateTime? maxTime,
  DateTime? minTime,
  DateTime? initTime,
  CalendarSelectRangeType? rangeSelectType,
  bool showTopTitle = true,
  bool hasToDate = false,
  bool isToDate = false,
  String? title,
}) {
  final String defaultTitle = title ?? "选择时间";

  Widget buildCupertinoPicker() {
    return showTopTitle
        ? MVScrollDatePicker(
            onDone: (DateTime startTime, DateTime? endTime) {
              onDone(startTime, endTime);
            },
            type: type,
            startTime: startTime,
            endTime: endTime,
          )
        : SVScrollDatePicker(
            onDone: hasToDate
                ? (DateTime chooseTime, bool isToDate) {
                    onDone(chooseTime, isToDate);
                  }
                : (DateTime chooseTime) {
                    onDone(chooseTime);
                  },
            type: type,
            time: initTime,
            title: title,
            maxTime: maxTime,
            minTime: minTime,
            hasToDate: hasToDate,
            isToDate: isToDate,
          );
  }

  Widget buildYearMonthPicker() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TapDatePicker(
        title: defaultTitle,
        onDone: (DateTime chooseTime) {
          onDone(chooseTime);
        },
        initTime: initTime,
        maxTime: maxTime,
      ),
    );
  }

  switch (type) {
    case DatePickerType.SINGLE_YMD:
    case DatePickerType.YMDWHM:
    case DatePickerType.scrollYMDWHM:
    case DatePickerType.scrollYMD:
      return showCupertinoModalPopup(
        context: context,
        barrierColor: const Color(0x80000000),
        builder: (BuildContext context) => buildCupertinoPicker(),
      );
    case DatePickerType.yearMonth:
    case DatePickerType.tapYM:
      return showModalBottomSheet(
        context: context,
        barrierColor: const Color.fromRGBO(0, 0, 0, 0.7),
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => buildYearMonthPicker(),
      );
    default:
      return Future(() => null);
  }
}

enum DatePickerType {
  tapYM, //点击年月
  scrollYM, //滚动年月
  scrollYMD, //滚动年月日
  scrollYMDWHM, //滚动年月日时分
  yearMonth, //废弃
  YMDWHM, //废弃
  SINGLE_YMD, //废弃
}

/// 日历选中区域的类型
enum CalendarSelectRangeType {
  custom, // 自定义自由选择两个日期
  day, // 只能选择单个日期
  week, // 只能选择整周
  month, // 只能选择整月
}
