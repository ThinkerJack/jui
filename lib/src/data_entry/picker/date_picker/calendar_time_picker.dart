import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:habit/dependencies.dart';
import 'package:habit/habit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:vv_ui_kit/src/basic/extension.dart';

import '../../../../data_entry.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils.dart';

class CalendarTimePicker extends StatefulWidget {
  final ValueChanged<DateTimeRange?>? onDone;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool isFilter;
  final CalendarSelectRangeType rangeSelectType;
  final String? title;
  final DateTime? maxSelect;

  const CalendarTimePicker({
    Key? key,
    this.title,
    required this.onDone,
    this.startTime,
    this.endTime,
    this.isFilter = true,
    required this.rangeSelectType,
    this.maxSelect,
  }) : super(key: key);

  @override
  CalendarTimePickerState createState() => CalendarTimePickerState();
}

class CalendarTimePickerState extends State<CalendarTimePicker> {
  final ValueNotifier<DateTime?> _rangeStart = ValueNotifier(null);
  final ValueNotifier<DateTime?> _rangeEnd = ValueNotifier(null);
  List<String> weeks = [
    getLanguage<S>().LMID_00024070,
    getLanguage<S>().LMID_00024078,
    getLanguage<S>().LMID_00024079,
    getLanguage<S>().LMID_00024080,
    getLanguage<S>().LMID_00024081,
    getLanguage<S>().LMID_00024083,
    getLanguage<S>().LMID_00024084
  ];
  ValueNotifier<bool> canCheck = ValueNotifier(false);
  ValueNotifier<CalendarFilterType> selectedFilter = ValueNotifier(CalendarFilterType.none);
  List<CalendarFilterItemModel> filterItems = [
    CalendarFilterItemModel(CalendarFilterType.today),
    CalendarFilterItemModel(CalendarFilterType.thisWeek),
    CalendarFilterItemModel(CalendarFilterType.thisMonth),
    CalendarFilterItemModel(CalendarFilterType.thisYear),
    CalendarFilterItemModel(CalendarFilterType.long),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.startTime != null && widget.endTime != null) {
      _rangeStart.value = widget.startTime!;
      _rangeEnd.value = widget.endTime!;
      if (widget.isFilter && _rangeEnd.value!.isSameDayOrAfter(DateTime.fromMillisecondsSinceEpoch(32503651200000))) {
        selectedFilter.value = CalendarFilterType.long;
      }
      canCheck.value = true;
    }
  }

  bool isInRange(DateTime date) {
    if (_rangeStart.value == null) return false;
    if (_rangeEnd.value == null) return date == _rangeStart.value;
    return ((date.isAfter(_rangeStart.value!)) && (date.isBefore(_rangeEnd.value!)));
  }

  bool isStart(DateTime date) {
    if (_rangeStart.value == null) return false;
    return date.isSameDay(_rangeStart.value!);
  }

  bool isEnd(DateTime date) {
    if (_rangeEnd.value == null) return date.isSameDay(_rangeStart.value!);
    return date.isSameDay(_rangeEnd.value!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 80.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
          color: Colors.white),
      child: Column(
        children: [
          Container(
            height: 52.r,
            margin: EdgeInsets.symmetric(horizontal: 12.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// 取消按钮
                TextButton(
                  onPressed: () {
                    // _rangeStart.value = null;
                    // _rangeEnd.value = null;
                    Navigator.pop(context);
                  },
                  child: Text(getLanguage<S>().LMID_00002552, style: TextStyle(color: ui858B9B, fontSize: 16.sp)),
                ),
                Expanded(
                  child: Text(
                    widget.title ?? getLanguage<S>().LMID_00012931,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: ui2A2F3C, fontSize: 16.sp, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onDone?.call(DateTimeRange(start: _rangeStart.value!, end: _rangeEnd.value!));
                  },
                  child: ValueListenableBuilder(
                    valueListenable: canCheck,
                    builder: (context, value, child) {
                      return Text(
                        getLanguage<S>().LMID_00013631,
                        style: TextStyle(color: canCheck.value ? ui5590F6 : ui5590F6.withAlpha(112), fontSize: 16.sp),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: uiE8EAEF,
            height: 0.5,
          ),
          if (widget.isFilter)
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        getLanguage<S>().LMID_00019729,
                        style: TextStyle(fontSize: 14.sp, color: ui858B9B),
                      ).marginBottom(12.r),
                    ],
                  ),
                  selectedFilter.listen(
                    (value) => Wrap(
                      spacing: 10.r,
                      runSpacing: 10.r,
                      children: [
                        ...filterItems.map((e) => _item(e)).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            height: 40.w,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(weeks.length, (index) {
                return Text(
                  weeks[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ui49536C,
                    fontSize: 14.sp,
                  ),
                );
              }),
            ).marginRight(16.r).marginLeft(16.r),
          ),
          Expanded(
            child: ValueListnableTuple2Builder<DateTime?, DateTime?>(
                valueListenables: Tuple2(_rangeStart, _rangeEnd),
                builder: (context, value, _) {
                  return PagedVerticalCalendar(
                    addAutomaticKeepAlives: true,
                    startWeekWithSunday: true,
                    dayBuilder: (context, date) {
                      var isStart = this.isStart(date);
                      var isEnd = this.isEnd(date);
                      var isStarOrEnd = isStart || isEnd;
                      var isInSelectedRange = isInRange(date);
                      var isToday = (date.day == DateTime.now().day) &&
                          (date.year == DateTime.now().year) &&
                          (date.month == DateTime.now().month);
                      var isOverLimit = widget.maxSelect?.isBefore(date) ?? false;
                      final color;
                      if (isStarOrEnd) {
                        color = ui5590F6;
                      } else if (isInSelectedRange) {
                        color = ui5590F6.withOpacity(0.08);
                      } else {
                        color = Colors.transparent;
                      }

                      final Color textColor;
                      if (isStarOrEnd) {
                        textColor = Colors.white;
                      } else if (isInSelectedRange) {
                        textColor = ui2A2F3C;
                      } else if (isToday) {
                        textColor = ui5590F6;
                      } else if (isOverLimit) {
                        textColor = uiBCC1CD;
                      } else {
                        textColor = ui2A2F3C;
                      }

                      return Container(
                        margin: EdgeInsets.only(bottom: 4.r),
                        decoration: BoxDecoration(
                          borderRadius: isStarOrEnd
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(isStart ? 24.r : (date.weekday == 7 ? 8.r : 0)),
                                  bottomLeft: Radius.circular(isStart ? 24.r : (date.weekday == 7 ? 8.r : 0)),
                                  topRight: Radius.circular(isEnd ? 24.r : (date.weekday == 6 ? 8.r : 0)),
                                  bottomRight: Radius.circular(isEnd ? 24.r : (date.weekday == 6 ? 8.r : 0)),
                                )
                              : null,
                          color: isStarOrEnd ? ui5590F6.withOpacity(0.08) : null,
                        ),
                        child: Container(
                          margin: isStarOrEnd
                              ? EdgeInsets.only(bottom: 2.r, left: 3.r, top: 2.r, right: 3.r)
                              : EdgeInsets.zero,
                          decoration: BoxDecoration(
                            borderRadius: isStarOrEnd
                                ? BorderRadius.circular(24.r)
                                : BorderRadius.only(
                                    topLeft: Radius.circular(date.weekday == 7 ? 8.r : 0),
                                    topRight: Radius.circular(date.weekday == 6 ? 8.r : 0),
                                    bottomLeft: Radius.circular(date.weekday == 7 ? 8.r : 0),
                                    bottomRight: Radius.circular(date.weekday == 6 ? 8.r : 0),
                                  ),
                            color: color,
                          ),
                          child: Center(
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(
                                color: textColor,
                                fontSize: date.weekday == 6 || date.weekday == 7 ? 14.sp : 16.sp,
                                fontFamily: "Avenir",
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    monthBuilder: (context, month, year) {
                      return Text(
                        _getTime(year, month),
                        style: TextStyle(
                          color: ui2A2F3C,
                          fontSize: 16.sp,
                          fontFamily: "Avenir",
                        ),
                      ).marginBottom(16.r);
                    },
                    onDayPressed: (date) {
                      if (widget.maxSelect != null) {
                        bool isBefore = widget.maxSelect?.isBefore(date) ?? false;
                        if (isBefore) return;
                      }
                      if (widget.rangeSelectType == CalendarSelectRangeType.day) {
                        _rangeStart.value = date;
                        _rangeEnd.value = date;
                        canCheck.value = true;
                        return;
                      }
                      if (widget.rangeSelectType == CalendarSelectRangeType.week) {
                        _rangeStart.value = date.startOfWeek;
                        _rangeEnd.value = date.endOfWeek.removeTime();
                        canCheck.value = true;
                        return;
                      }
                      if (widget.rangeSelectType == CalendarSelectRangeType.month) {
                        _rangeStart.value = date.startOfMonth;
                        _rangeEnd.value = date.endOfMonth.removeTime();
                        canCheck.value = true;
                        return;
                      }
                      //选择方式为自定义的逻辑
                      if (_rangeStart.value == null) {
                        _rangeStart.value = date;
                        canCheck.value = false;
                        showToast(getLanguage<S>().LMID_00008010);
                      } else if (_rangeEnd.value == null) {
                        _rangeEnd.value = date;
                        if (_rangeEnd.value!.compareTo(_rangeStart.value!) == -1) {
                          _rangeEnd.value = _rangeStart.value;
                          _rangeStart.value = date;
                        }
                        canCheck.value = true;
                      } else {
                        _rangeStart.value = null;
                        _rangeEnd.value = null;
                        selectedFilter.value = CalendarFilterType.none;
                        canCheck.value = false;
                      }
                    },
                  ).paddingRight(16.r).paddingLeft(16.r);
                }),
          ),
        ],
      ),
    );
  }

  String _getTime(int year, int month) {
    if (LanguageHelper.instance.isZh) {
      return DateFormat(
              'yyyy${DateTimeRangeSelectType.year.getTimeTextByType()}MM${DateTimeRangeSelectType.month.getTimeTextByType()}')
          .format(DateTime(year, month));
    } else {
      return "${month.getMonthInFullEng()}  $year";
    }
  }

  Widget _item(CalendarFilterItemModel model) {
    final isSelected = model.filterType == selectedFilter.value;
    final title = model.title;
    return InkWell(
      onTap: () {
        if (selectedFilter.value == model.filterType) {
          selectedFilter.value = CalendarFilterType.none;
          _rangeStart.value = null;
          _rangeEnd.value = null;
          canCheck.value = false;
        } else {
          switch (model.filterType) {
            case CalendarFilterType.today:
              _rangeStart.value = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
              _rangeEnd.value = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
              print("weekday:${DateTime(2023, 9, 18).weekday}");
              canCheck.value = true;
              break;
            case CalendarFilterType.thisWeek:
              _rangeStart.value = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
              _rangeEnd.value = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
                  .add(Duration(days: 7 - DateTime.now().weekday));
              canCheck.value = true;
              break;
            case CalendarFilterType.thisMonth:
              _rangeStart.value = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
              if (DateTime.now().month == 12) {
                _rangeEnd.value = DateTime(DateTime.now().year, DateTime.now().month, 31);
              } else {
                _rangeEnd.value =
                    DateTime(DateTime.now().year, DateTime.now().month + 1, 1).subtract(Duration(days: 1));
              }
              canCheck.value = true;
              break;
            case CalendarFilterType.thisYear:
              // _rangeStart.value = DateTime(DateTime.now().year, 1, 1);
              _rangeStart.value = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
              _rangeEnd.value = DateTime(DateTime.now().year, 12, 31);
              canCheck.value = true;
              break;
            case CalendarFilterType.long:
              if (selectedFilter.value == CalendarFilterType.none) {
                print("CalendarFilterType.none");
                _rangeStart.value ??= DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
              } else {
                _rangeStart.value = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
              }
              _rangeEnd.value = DateTime.fromMillisecondsSinceEpoch(32503651200000);
              canCheck.value = true;
              break;
            case CalendarFilterType.none:
              break;
          }
          selectedFilter.value = model.filterType;
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.r, vertical: 6.r),
        constraints: BoxConstraints(
          minWidth: 60.r,
        ),
        height: 32.r,
        decoration: BoxDecoration(
          color: isSelected ? ui5590F6.withOpacity(0.08) : Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(16.r),
          border: isSelected ? Border.all(color: ui5590F6, width: 1) : Border.all(color: Colors.white, width: 1),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            height: 1.35,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            color: isSelected ? ui5590F6 : Colors.black,
          ),
        ),
      ),
    );
  }
}

enum CalendarFilterType {
  none,

  /// 无
  today,

  /// 今天
  thisWeek,

  /// 本周
  thisMonth,

  /// 本月
  thisYear,

  /// 本年
  long,

  /// 长期
}

extension FilterItem on CalendarFilterType {
  String get title {
    switch (this) {
      case CalendarFilterType.none:
        return "";
      case CalendarFilterType.today:
        return getLanguage<S>().LMID_00012017;
      case CalendarFilterType.thisWeek:
        return getLanguage<S>().LMID_00019657;
      case CalendarFilterType.thisMonth:
        return getLanguage<S>().LMID_00012222;
      case CalendarFilterType.thisYear:
        return getLanguage<S>().LMID_00020256;
      case CalendarFilterType.long:
        return getLanguage<S>().LMID_00000203;
    }
  }
}

class CalendarFilterItemModel {
  String get title => filterType.title;
  bool isSelected = false;
  final CalendarFilterType filterType;

  CalendarFilterItemModel(this.filterType);
}

abstract class BaseBottomSheetDialog extends StatelessWidget {
  const BaseBottomSheetDialog({Key? key}) : super(key: key);

  Future<T?> show<T>(
    BuildContext context, {
    required bool isDismissible,
    required bool isScrollControlled,
    bool? enableDrag,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      builder: build,
      enableDrag: enableDrag == null ? true : enableDrag,
    );
  }

  /// Desc: 构建内容布局
  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
        ),
        child: Column(
          children: [
            // Container(
            //   height: 37.r,
            //   child: Center(
            //     child: Image.asset(
            //       'assets/images/agent/home_indicator.png',
            //     , package: AssetsConstants.package),
            //   ),
            // ),
            buildContent(context),
            Container(
              color: Colors.white,
              height: 34.r,
            ),
          ],
        ),
      ),
    );
  }
}

class DateTimeUtils {
  /// generates a [Month] object from the Nth index from the startdate
  static Month getMonth(
    DateTime? minDate,
    DateTime? maxDate,
    int monthPage,
    bool up, {
    bool startWeekWithSunday = false,
  }) {
    // if no start date is provided use the current date
    DateTime startDate = (minDate ?? DateTime.now()).removeTime();

    // if this is not the first month in this calendar then calculate a new
    // start date for this month
    if (monthPage > 0) {
      if (up) {
        // fetsch up: month will be subtructed
        startDate = DateTime(startDate.year, startDate.month - monthPage, 1);
      } else {
        // fetch down: month will be added
        startDate = DateTime(startDate.year, startDate.month + monthPage, 1);
      }
    }

    // find the first day of the first week in this month
    final weekMinDate = _findDayOfWeekInMonth(
      startDate,
      getWeekDay(startDate, startWeekWithSunday),
      startWeekWithSunday: startWeekWithSunday,
    );

    // every week has a start and end date, calculate them once for the start
    // of the month then reuse these variables for every other week in
    // month
    DateTime firstDayOfWeek = weekMinDate;
    DateTime lastDayOfWeek = _lastDayOfWeek(weekMinDate, startWeekWithSunday);

    List<Week> weeks = [];

    // we don't know when this month ends until we reach it, so we have to use
    // an indefinate loop
    while (true) {
      // if an endDate is provided we need to check if the current week extends
      // beyond this date. if it does, cap the week to the endDate and stop the
      // loop

      if (up) {
        // fetching up
        Week week;
        if (maxDate != null && firstDayOfWeek.isBefore(maxDate)) {
          week = Week(maxDate, lastDayOfWeek);
        } else {
          week = Week(firstDayOfWeek, lastDayOfWeek);
        }

        if (maxDate != null && lastDayOfWeek.isSameDayOrAfter(maxDate)) {
          weeks.add(week);
        } else if (maxDate == null) {
          weeks.add(week);
        }
        if (week.isLastWeekOfMonth) break;
      } else {
        // fetching down
        if (maxDate != null && lastDayOfWeek.isSameDayOrAfter(maxDate)) {
          Week week = Week(firstDayOfWeek, maxDate);
          weeks.add(week);
          break;
        }

        Week week = Week(firstDayOfWeek, lastDayOfWeek);
        weeks.add(week);

        if (week.isLastWeekOfMonth) break;
      }

      firstDayOfWeek = lastDayOfWeek.nextDay;
      lastDayOfWeek = _lastDayOfWeek(firstDayOfWeek, startWeekWithSunday);
    }

    return Month(weeks);
  }

  static int getWeekDay(DateTime _date, bool startWeekWithSunday) {
    if (startWeekWithSunday) {
      return _date.weekday == DateTime.sunday ? 1 : _date.weekday + 1;
    } else {
      return _date.weekday;
    }
  }

  /// calculates the last of the week by calculating the remaining days in a
  /// standard week and evaluating if this week extends beyond the total days
  /// in that month, and capping it to the end of the month if it does
  static DateTime _lastDayOfWeek(
    DateTime firstDayOfWeek,
    bool startWeekWithSunday,
  ) {
    int daysInMonth = firstDayOfWeek.daysInMonth;

    final dayOfWeek = getWeekDay(firstDayOfWeek, startWeekWithSunday);
    final restOfWeek = DateTime.daysPerWeek - dayOfWeek;

    return firstDayOfWeek.day + restOfWeek > daysInMonth
        ? DateTime(firstDayOfWeek.year, firstDayOfWeek.month, daysInMonth)
        : firstDayOfWeek.add(Duration(days: restOfWeek));
  }

  static DateTime _findDayOfWeekInMonth(
    DateTime date,
    int dayOfWeek, {
    bool startWeekWithSunday = false,
  }) {
    date = date.removeTime();

    if (date.weekday == (startWeekWithSunday ? DateTime.sunday : DateTime.monday)) {
      return date;
    } else {
      return date.subtract(Duration(days: getWeekDay(date, startWeekWithSunday) - dayOfWeek));
    }
  }

  static List<int> daysPerMonth(int year) => <int>[
        31,
        _isLeapYear(year) ? 29 : 28,
        31,
        30,
        31,
        30,
        31,
        31,
        30,
        31,
        30,
        31,
      ];

  /// efficient leapyear calcualtion transcribed from a C stackoverflow answer
  static bool _isLeapYear(int year) {
    return (year & 3) == 0 && ((year % 25) != 0 || (year & 15) == 0);
  }
}

extension DateUtilsExtensions on DateTime {
  int get daysInMonth => DateTimeUtils.daysPerMonth(year)[month - 1];

  DateTime get nextDay => DateTime(year, month, day + 1);

  bool isSameDayOrAfter(DateTime other) => isAfter(other) || isSameDay(other);

  bool isSameDayOrBefore(DateTime other) => isBefore(other) || isSameDay(other);

  //
  // bool isSameDay(DateTime other) =>
  //     year == other.year && month == other.month && day == other.day;

  DateTime removeTime() => DateTime(year, month, day);
}

class Month {
  final int month;
  final int year;
  final int daysInMonth;
  final List<Week> weeks;

  Month(this.weeks)
      : year = weeks.first.firstDay.year,
        month = weeks.first.firstDay.month,
        daysInMonth = weeks.first.firstDay.daysInMonth;

  @override
  String toString() {
    return 'Month{month: $month, year: $year, daysInMonth: $daysInMonth, weeks: $weeks}';
  }
}

class Week {
  final DateTime firstDay;
  final DateTime lastDay;

  Week(this.firstDay, this.lastDay);

  int get duration => lastDay.day - firstDay.day;

  bool get isLastWeekOfMonth => lastDay.day == lastDay.daysInMonth;

  @override
  String toString() {
    return 'Week{firstDay: $firstDay, lastDay: $lastDay}';
  }
}

enum PaginationDirection {
  up,
  down,
}

class PagedVerticalCalendar extends StatefulWidget {
  const PagedVerticalCalendar({
    super.key,
    this.minDate,
    this.maxDate,
    this.initialDate,
    this.monthBuilder,
    this.dayBuilder,
    this.addAutomaticKeepAlives = false,
    this.onDayPressed,
    this.onMonthLoaded,
    this.onPaginationCompleted,
    this.invisibleMonthsThreshold = 1,
    this.physics,
    this.scrollController,
    this.listPadding = EdgeInsets.zero,
    this.startWeekWithSunday = false,
  });

  /// the [DateTime] to start the calendar from, if no [startDate] is provided
  /// `DateTime.now()` will be used
  final DateTime? minDate;

  /// optional [DateTime] to end the calendar pagination, of no [endDate] is
  /// provided the calendar can paginate indefinitely
  final DateTime? maxDate;

  /// the initial date displayed by the calendar.
  /// if inititial date is nulll, the start date will be used
  final DateTime? initialDate;

  /// a Builder used for month header generation. a default [MonthBuilder] is
  /// used when no custom [MonthBuilder] is provided.
  /// * [context]
  /// * [int] year: 2021
  /// * [int] month: 1-12
  final MonthBuilder? monthBuilder;

  /// a Builder used for day generation. a default [DayBuilder] is
  /// used when no custom [DayBuilder] is provided.
  /// * [context]
  /// * [DateTime] date
  final DayBuilder? dayBuilder;

  /// if the calendar should stay cached when the widget is no longer loaded.
  /// this can be used for maintaining the last state. defaults to `false`
  final bool addAutomaticKeepAlives;

  /// callback that provides the [DateTime] of the day that's been interacted
  /// with
  final ValueChanged<DateTime>? onDayPressed;

  /// callback when a new paginated month is loaded.
  final OnMonthLoaded? onMonthLoaded;

  /// called when the calendar pagination is completed. if no [minDate] or [maxDate] is
  /// provided this method is never called for that direction
  final ValueChanged<PaginationDirection>? onPaginationCompleted;

  /// how many months should be loaded outside of the view. defaults to `1`
  final int invisibleMonthsThreshold;

  /// list padding, defaults to `EdgeInsets.zero`
  final EdgeInsetsGeometry listPadding;

  /// scroll physics, defaults to matching platform conventions
  final ScrollPhysics? physics;

  /// scroll controller for making programmable scroll interactions
  final ScrollController? scrollController;

  /// Select start day of the week to be Sunday
  final bool startWeekWithSunday;

  @override
  _PagedVerticalCalendarState createState() => _PagedVerticalCalendarState();
}

class _PagedVerticalCalendarState extends State<PagedVerticalCalendar> {
  late PagingController<int, Month> _pagingReplyUpController;
  late PagingController<int, Month> _pagingReplyDownController;

  final Key downListKey = UniqueKey();

  late DateTime initDate;
  late bool hideUp;

  @override
  void initState() {
    super.initState();

    if (widget.initialDate != null) {
      if (widget.maxDate != null) {
        int diffDaysEndDate = widget.maxDate!.difference(widget.initialDate!).inDays;
        if (diffDaysEndDate.isNegative) {
          initDate = widget.maxDate!;
        } else {
          initDate = widget.initialDate!;
        }
      } else {
        initDate = widget.initialDate!;
      }
    } else {
      initDate = DateTime.now().removeTime();
    }

    if (widget.minDate != null) {
      int diffDaysStartDate = widget.minDate!.difference(initDate).inDays;
      if (diffDaysStartDate.isNegative) {
        hideUp = true;
      } else {
        hideUp = false;
      }
    } else {
      hideUp = true;
    }

    _pagingReplyUpController = PagingController<int, Month>(
      firstPageKey: 0,
      invisibleItemsThreshold: widget.invisibleMonthsThreshold,
    );
    _pagingReplyUpController.addPageRequestListener(_fetchUpPage);
    _pagingReplyUpController.addStatusListener(paginationStatusUp);

    _pagingReplyDownController = PagingController<int, Month>(
      firstPageKey: 0,
      invisibleItemsThreshold: widget.invisibleMonthsThreshold,
    );
    _pagingReplyDownController.addPageRequestListener(_fetchDownPage);
    _pagingReplyDownController.addStatusListener(paginationStatusDown);
  }

  void paginationStatusUp(PagingStatus state) {
    if (state == PagingStatus.completed) return widget.onPaginationCompleted?.call(PaginationDirection.up);
  }

  void paginationStatusDown(PagingStatus state) {
    if (state == PagingStatus.completed) return widget.onPaginationCompleted?.call(PaginationDirection.down);
  }

  /// fetch a new [Month] object based on the [pageKey] which is the Nth month
  /// from the start date
  void _fetchUpPage(int pageKey) async {
    try {
      final month = DateTimeUtils.getMonth(
        DateTime(initDate.year, initDate.month - 1, 1),
        widget.minDate,
        pageKey,
        true,
        startWeekWithSunday: widget.startWeekWithSunday,
      );

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.onMonthLoaded?.call(month.year, month.month),
      );

      final newItems = [month];
      final isLastPage = widget.minDate != null && widget.minDate!.isSameDayOrAfter(month.weeks.first.firstDay);

      if (isLastPage) {
        return _pagingReplyUpController.appendLastPage(newItems);
      }

      final nextPageKey = pageKey + newItems.length;
      _pagingReplyUpController.appendPage(newItems, nextPageKey);
    } catch (_) {
      _pagingReplyUpController.error;
    }
  }

  void _fetchDownPage(int pageKey) async {
    try {
      final month = DateTimeUtils.getMonth(
        DateTime(initDate.year, initDate.month, 1),
        widget.maxDate,
        pageKey,
        false,
        startWeekWithSunday: widget.startWeekWithSunday,
      );

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.onMonthLoaded?.call(month.year, month.month),
      );

      final newItems = [month];
      final isLastPage = widget.maxDate != null && widget.maxDate!.isSameDayOrBefore(month.weeks.last.lastDay);

      if (isLastPage) {
        return _pagingReplyDownController.appendLastPage(newItems);
      }

      final nextPageKey = pageKey + newItems.length;
      _pagingReplyDownController.appendPage(newItems, nextPageKey);
    } catch (_) {
      _pagingReplyDownController.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      controller: widget.scrollController,
      viewportBuilder: (BuildContext context, ViewportOffset position) {
        return Viewport(
          offset: position,
          center: downListKey,
          slivers: [
            if (hideUp)
              PagedSliverList(
                pagingController: _pagingReplyUpController,
                builderDelegate: PagedChildBuilderDelegate<Month>(
                  itemBuilder: (BuildContext context, Month month, int index) {
                    return _MonthView(
                      month: month,
                      monthBuilder: widget.monthBuilder,
                      dayBuilder: widget.dayBuilder,
                      onDayPressed: widget.onDayPressed,
                      startWeekWithSunday: widget.startWeekWithSunday,
                    );
                  },
                ),
              ),
            PagedSliverList(
              key: downListKey,
              pagingController: _pagingReplyDownController,
              builderDelegate: PagedChildBuilderDelegate<Month>(
                itemBuilder: (BuildContext context, Month month, int index) {
                  return _MonthView(
                    month: month,
                    monthBuilder: widget.monthBuilder,
                    dayBuilder: widget.dayBuilder,
                    onDayPressed: widget.onDayPressed,
                    startWeekWithSunday: widget.startWeekWithSunday,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _pagingReplyUpController.dispose();
    _pagingReplyDownController.dispose();
    super.dispose();
  }
}

class _MonthView extends StatelessWidget {
  _MonthView({
    required this.month,
    this.monthBuilder,
    this.dayBuilder,
    this.onDayPressed,
    required this.startWeekWithSunday,
  });

  final Month month;
  final MonthBuilder? monthBuilder;
  final DayBuilder? dayBuilder;
  final ValueChanged<DateTime>? onDayPressed;
  final bool startWeekWithSunday;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /// display the default month header if none is provided
        monthBuilder?.call(context, month.month, month.year) ??
            _DefaultMonthView(
              month: month.month,
              year: month.year,
            ),
        Table(
          children: month.weeks.map((Week week) {
            return _generateWeekRow(context, week, startWeekWithSunday);
          }).toList(growable: false),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  TableRow _generateWeekRow(BuildContext context, Week week, bool startWeekWithSunday) {
    DateTime firstDay = week.firstDay;

    return TableRow(
      children: List<Widget>.generate(
        DateTime.daysPerWeek,
        (int position) {
          DateTime day = DateTime(
            week.firstDay.year,
            week.firstDay.month,
            firstDay.day + (position - (DateTimeUtils.getWeekDay(firstDay, startWeekWithSunday) - 1)),
          );

          if ((position + 1) < DateTimeUtils.getWeekDay(week.firstDay, startWeekWithSunday)) {
            if ((position + 1) == DateTimeUtils.getWeekDay(week.firstDay, startWeekWithSunday) - 1) {
              return const SizedBox();
            }
            return const SizedBox();
          } else if ((position + 1) > DateTimeUtils.getWeekDay(week.lastDay, startWeekWithSunday)) {
            if (position + 1 == DateTimeUtils.getWeekDay(week.lastDay, startWeekWithSunday) + 1) {
              return const SizedBox();
            } else {
              return const SizedBox();
            }
          } else {
            return AspectRatio(
              aspectRatio: 1.0,
              child: InkWell(
                onTap: onDayPressed == null ? null : () => onDayPressed!(day),
                child: dayBuilder?.call(context, day) ?? _DefaultDayView(date: day),
              ),
            );
          }
        },
        growable: false,
      ),
    );
  }
}

class _DefaultMonthView extends StatelessWidget {
  final int month;
  final int year;

  _DefaultMonthView({required this.month, required this.year});

  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${months[month - 1]} $year',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}

class _DefaultDayView extends StatelessWidget {
  final DateTime date;

  _DefaultDayView({required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        date.day.toString(),
      ),
    );
  }
}

typedef MonthBuilder = Widget Function(BuildContext context, int month, int year);
typedef DayBuilder = Widget Function(BuildContext context, DateTime date);

typedef OnMonthLoaded = void Function(int year, int month);

extension DateRangeExtensions on DateTime {
  bool isSameDay(DateTime other) => year == other.year && month == other.month && day == other.day;

  bool get isToday => DateTime.now().isSameDay(this);

  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  DateTime get startOfWeek => subtract(Duration(days: weekday - 1)).startOfDay;

  DateTime get endOfWeek => add(Duration(days: 7 - weekday)).endOfDay;

  DateTime get startOfMonth => DateTime(year, month, 1);

  DateTime get endOfMonth => DateTime(year, month + 1, 0).endOfDay;

  DateTime minus(int n, {DurationType type = DurationType.day}) {
    switch (type) {
      case DurationType.day:
        return DateTime(year, month, day - n, hour, minute, second, millisecond);
      case DurationType.week:
        return DateTime(year, month, day - 7 * n, hour, minute, second, millisecond);
      case DurationType.month:
        return DateTime(year, month - n, day, hour, minute, second, millisecond);
    }
  }

  DateTime plus(int n, {DurationType type = DurationType.day}) {
    switch (type) {
      case DurationType.day:
        return DateTime(year, month, day + n, hour, minute, second, millisecond);
      case DurationType.week:
        return DateTime(year, month, day + 7 * n, hour, minute, second, millisecond);
      case DurationType.month:
        return DateTime(year, month + n, day, hour, minute, second, millisecond);
    }
  }

  String formatYMD() => DateFormat("yyyy-MM-dd").format(this);

  String formatFull() => DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(this);
}

/// 日期选择类型
enum DateTimeRangeSelectType {
  year,
  month,
  day,
  hour,
  min,
  second,
}

extension DateTimeRangeSelectTypeExt on DateTimeRangeSelectType {
  String getTimeTextByType() {
    switch (this) {
      case DateTimeRangeSelectType.year:
        return getLanguage<S>().LMID_00011395;
      case DateTimeRangeSelectType.month:
        return getLanguage<S>().LMID_00012413;
      case DateTimeRangeSelectType.day:
        return getLanguage<S>().LMID_00012289;
      case DateTimeRangeSelectType.hour:
        return getLanguage<S>().LMID_00012294;
      case DateTimeRangeSelectType.min:
        return getLanguage<S>().LMID_00009864;
      case DateTimeRangeSelectType.second:
        return getLanguage<S>().LMID_00014660;
      default:
        return "";
    }
  }
}

extension Int2EnMonth on int {
  String getMonthInEng() {
    switch (this) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "";
    }
  }

  String getMonthInFullEng() {
    switch (this) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }
}

enum DurationType {
  day,
  week,
  month,
}
