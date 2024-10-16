import 'package:flutter/cupertino.dart';
import 'package:jui/src/data_entry/picker/date_picker/sv_scroll_date_picker.dart';

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
  bool showTopTitle = true,
  bool hasToDate = false,
  bool isToDate = false,
  String? title,
}) {
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

  switch (type) {
    case DatePickerType.scrollYMDWHM:
    case DatePickerType.scrollYMD:
    case DatePickerType.scrollYM:
      return showCupertinoModalPopup(
        context: context,
        barrierColor: const Color(0x80000000),
        builder: (BuildContext context) => buildCupertinoPicker(),
      );
    default:
      return Future(() => null);
  }
}

enum DatePickerType {
  scrollYM, //滚动年月
  scrollYMD, //滚动年月日
  scrollYMDWHM, //滚动年月日时分
}
