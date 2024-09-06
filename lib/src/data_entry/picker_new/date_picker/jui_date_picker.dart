// lib/src/data_entry/jui_date_picker/jui_date_picker.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'jui_single_date_picker.dart';
import 'jui_range_date_picker.dart';
import 'jui_date_picker_types.dart';

Future<dynamic> showJuiDatePicker(
    BuildContext context, {
      required JuiDatePickerMode mode,
      required Function onDone,
      DateTime? startTime,
      DateTime? endTime,
      DateTime? maxTime,
      DateTime? minTime,
      DateTime? initTime,
      JuiCalendarSelectRangeType? rangeSelectType,
      bool showTopTitle = true,
      bool hasToDate = false,
      bool isToDate = false,
      String? title,
    }) {
  Widget buildDatePicker() {
    return showTopTitle
        ? JuiRangeDatePicker(
      onDone: (DateTime startTime, DateTime? endTime) {
        onDone(startTime, endTime);
      },
      mode: mode,
      startTime: startTime,
      endTime: endTime,
    )
        : JuiSingleDatePicker(
      onDone: hasToDate
          ? (DateTime chooseTime, bool isToDate) {
        onDone(chooseTime, isToDate);
      }
          : (DateTime chooseTime) {
        onDone(chooseTime);
      },
      mode: mode,
      time: initTime,
      title: title,
      maxTime: maxTime,
      minTime: minTime,
      hasToDate: hasToDate,
      isToDate: isToDate,
    );
  }

  switch (mode) {
    case JuiDatePickerMode.scrollYMDWHM:
    case JuiDatePickerMode.scrollYMD:
    case JuiDatePickerMode.scrollYM:
      return showCupertinoModalPopup(
        context: context,
        barrierColor: const Color(0x80000000),
        builder: (BuildContext context) => buildDatePicker(),
      );
    default:
      return Future(() => null);
  }
}