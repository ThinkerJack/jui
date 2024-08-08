import 'package:flutter/material.dart';
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
  final List<String> _monthList = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"];

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
      height: 52 + 48 + 1 + 16 + (36 + 16) * 4 + 34,
      padding: EdgeInsets.only(bottom: 34),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
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
      height: 52,
      margin: EdgeInsets.symmetric(horizontal: 16),
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
            child: Text("取消", style: const TextStyle(color: ui858B9B)),
          ),
          Expanded(
            // 标题文本
            child: Text(
              widget.title ?? "选择起止日期",
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
              "确定",
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
      height: 48,
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
              width: 32,
              height: 32,
              child: const Icon(Icons.keyboard_double_arrow_left, color: Color(0xff4e5969)),
            ),
          ),
          Expanded(
            // 显示当前年份
            child: Text(
              _year.toString(),
              style: TextStyle(color: ui2A2F3C, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "DIN"),
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
              width: 32,
              height: 32,
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
          final itemWidth = (width - 32) / 3;
          return GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            crossAxisCount: 3,
            childAspectRatio: itemWidth / (36 + 16),
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
      margin: EdgeInsets.symmetric(horizontal: 4.5, vertical: 4),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: canSelect ? () => onSelect.call(itemYearMonth) : null,
        child: Container(
          decoration: isSelect
              ? BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: ui5590F6,
                )
              : null,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: canSelect ? (isSelect ? uiFFFFFF : ui2A2F3C) : uiBCC1CD, fontSize: 16),
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

extension ListExtensions<E> on List<E> {
  /// Maps each element and its index to a new value.
  Iterable<R> mapIndexed<R>(R Function(int index, E element) convert) sync* {
    for (var index = 0; index < length; index++) {
      yield convert(index, this[index]);
    }
  }
}
