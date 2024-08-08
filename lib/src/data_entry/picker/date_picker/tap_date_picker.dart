import 'package:flutter/material.dart';
import 'package:habit/dependencies.dart';
import 'package:habit/habit.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils.dart';

/// 日期选择器组件，允许用户选择年和月
class TapDatePicker extends StatefulWidget {
  final String? title; // 标题
  final Function(DateTime chooseTime) onDone; // 用户完成选择后的回调
  final DateTime? initTime; // 初始选择的时间
  final DateTime? maxTime; // 最大可选择的时间

  const TapDatePicker({
    super.key,
    this.title,
    required this.onDone,
    this.initTime,
    this.maxTime,
  });

  @override
  State<TapDatePicker> createState() => _TapDatePickerState();
}

class _TapDatePickerState extends State<TapDatePicker> {
  YearMonth _yearMonth = YearMonth.now(); // 当前选择的年和月
  int _year = YearMonth.now().year; // 当前选择的年

  // 当前语言环境下的月份列表
  final List<String> _monthList = [
    getLanguage<S>().LMID_00021087,
    getLanguage<S>().LMID_00021088,
    getLanguage<S>().LMID_00021089,
    getLanguage<S>().LMID_00021090,
    getLanguage<S>().LMID_00021085,
    getLanguage<S>().LMID_00021086,
    getLanguage<S>().LMID_00021084,
    getLanguage<S>().LMID_00021083,
    getLanguage<S>().LMID_00021082,
    getLanguage<S>().LMID_00021080,
    getLanguage<S>().LMID_00021081,
    getLanguage<S>().LMID_00021079,
  ];

  // 判断是否可以增加年份
  bool get canForwardYear {
    final maxYear = widget.maxTime?.year;
    return maxYear == null || _year < maxYear;
  }

  @override
  void initState() {
    super.initState();
    _yearMonth = YearMonth.of(widget.initTime ?? DateTime.now());
    _year = _yearMonth.year;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52.r + 48.r + 1 + 16.r + (36.r + 16.sp) * 4 + 34.r,
      padding: EdgeInsets.only(bottom: 34.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(16.r), topLeft: Radius.circular(16.r)),
      ),
      child: Column(
        children: [
          _buildTitleBar(), // 构建标题栏，包含取消和确认按钮
          const Divider(color: uiE8EAEF, height: 0.5),
          _buildYearBar(), // 构建年份选择栏
          const Divider(color: Color(0xffe5e6e8), height: 0.5),
          _buildMonthGrid(), // 构建月份选择网格
        ],
      ),
    );
  }

  /// 构建标题栏
  Widget _buildTitleBar() {
    return Container(
      height: 52.r,
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 取消按钮
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              minimumSize: const Size(0, 0),
            ),
            child: Text(getLanguage<S>().LMID_00002552, style: const TextStyle(color: ui858B9B)),
          ),
          Expanded(
            // 标题文本
            child: Text(
              widget.title ?? getLanguage<S>().LMID_00012931,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(color: ui2A2F3C, fontSize: 17, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          // 确认按钮
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onDone(_yearMonth.toDateTime());
            },
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              minimumSize: const Size(0, 0),
            ),
            child: Text(
              getLanguage<S>().LMID_00013631,
              style: const TextStyle(color: ui5590F6, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建年份选择栏
  Widget _buildYearBar() {
    return Container(
      height: 48.r,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          // 向前选择年份按钮
          GestureDetector(
            onTap: () {
              setState(() {
                _year--;
              });
            },
            child: SizedBox(
              width: 32.r,
              height: 32.r,
              child: const Icon(Icons.keyboard_double_arrow_left, color: Color(0xff4e5969)),
            ),
          ),
          Expanded(
            // 显示当前年份
            child: Text(
              _year.toString(),
              style: TextStyle(color: ui2A2F3C, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: "DIN"),
              textAlign: TextAlign.center,
            ),
          ),
          // 向后选择年份按钮
          GestureDetector(
            onTap: canForwardYear
                ? () {
                    setState(() {
                      _year++;
                    });
                  }
                : null,
            child: SizedBox(
              width: 32.r,
              height: 32.r,
              child: Icon(
                Icons.keyboard_double_arrow_right,
                color: canForwardYear ? const Color(0xff4e5969) : uiBCC1CD,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建月份选择网格
  Widget _buildMonthGrid() {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final itemWidth = (width - 32.r) / 3;
          return GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 16.r, left: 16.r, right: 16.r),
            crossAxisCount: 3,
            childAspectRatio: itemWidth / (36.r + 16.sp),
            children: _monthList.mapIndexed((index, e) {
              final itemMonth = index + 1;
              final itemYearMonth = YearMonth(_year, itemMonth);
              final isSelect = itemYearMonth.isEqual(_yearMonth);
              var canSelect = true;
              if (widget.maxTime != null) {
                final max = YearMonth.of(widget.maxTime!);
                canSelect = itemYearMonth.isBefore(max) || itemYearMonth.isEqual(max);
              }
              return _YearMonthItem(
                itemYearMonth: itemYearMonth,
                canSelect: canSelect,
                isSelect: isSelect,
                onSelect: (item) {
                  setState(() {
                    _yearMonth = item;
                  });
                },
                text: e,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

/// 月份选择项组件
class _YearMonthItem extends StatelessWidget {
  final YearMonth itemYearMonth; // 年月对象
  final String text; // 显示的文本
  final bool canSelect; // 是否可选择
  final bool isSelect; // 是否被选中
  final ValueChanged<YearMonth> onSelect; // 选择回调

  const _YearMonthItem({
    required this.text,
    required this.itemYearMonth,
    required this.canSelect,
    required this.isSelect,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.5.r, vertical: 4.r),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: canSelect ? () => onSelect.call(itemYearMonth) : null,
        child: Container(
          decoration: isSelect
              ? BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  color: ui5590F6,
                )
              : null,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: canSelect ? (isSelect ? uiFFFFFF : ui2A2F3C) : uiBCC1CD, fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

/// YearMonth类，用于表示年和月
class YearMonth {
  final int year; // 年
  final int month; // 月

  const YearMonth(this.year, this.month);

  /// 将YearMonth转换为DateTime对象
  DateTime toDateTime() {
    return DateTime(year, month);
  }

  /// 通过DateTime对象创建YearMonth实例
  factory YearMonth.of(DateTime dateTime) {
    return YearMonth(dateTime.year, dateTime.month);
  }

  /// 创建当前时间的YearMonth实例
  factory YearMonth.now() {
    return YearMonth.of(DateTime.now());
  }

  /// 判断当前YearMonth是否在另一个YearMonth之前
  bool isBefore(YearMonth yearMonth) {
    return year < yearMonth.year || (year == yearMonth.year && month < yearMonth.month);
  }

  /// 判断当前YearMonth是否在另一个YearMonth之后
  bool isAfter(YearMonth yearMonth) {
    return year > yearMonth.year || (year == yearMonth.year && month > yearMonth.month);
  }

  /// 判断两个YearMonth是否相等
  bool isEqual(YearMonth yearMonth) {
    return year == yearMonth.year && month == yearMonth.month;
  }

  /// 创建一个新的YearMonth对象，允许更改年和月
  YearMonth copyWith({int? year, int? month}) {
    return YearMonth(year ?? this.year, month ?? this.month);
  }
}
