import 'package:flutter/material.dart';
import 'package:habit/habit.dart';
import 'package:vv_ui_kit/src/data_entry/picker/date_picker/sv_scroll_date_picker_vm.dart';
import 'package:vv_ui_kit/src/utils/color.dart';

import '../../../../common.dart';
import '../../../../generated/l10n.dart';
import '../../../basic/picker_widget.dart';
import 'common/picker_widget.dart';
import 'date_picker_func.dart';

class SVScrollDatePicker extends StatefulWidget {
  const SVScrollDatePicker({
    Key? key,
    required this.onDone,
    this.time,
    required this.type,
    this.title,
    this.maxTime,
    this.minTime,
    this.hasToDate = false,
    this.isToDate = false,
  }) : super(key: key);

  final DatePickerType type; // 选择器类型
  final Function onDone; // 点击确定调用
  final DateTime? time; // 开始时间
  final DateTime? maxTime; // 最大时间
  final DateTime? minTime; // 最小时间
  final String? title; // 标题
  final bool hasToDate; // 是否有"至今"选项
  final bool isToDate; // 是否选择了"至今"

  @override
  State<SVScrollDatePicker> createState() => _SVScrollDatePickerState();
}

class _SVScrollDatePickerState extends State<SVScrollDatePicker> {
  late SVScrollDatePickerVM vm;

  @override
  void initState() {
    super.initState();
    vm = SVScrollDatePickerVM();
    vm.init(widget);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        constraints: BoxConstraints(maxHeight: widget.hasToDate ? 370.w : 320.w, minWidth: 37.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _buildTitleBar(),
            const Divider(thickness: 0.5, color: Color.fromRGBO(0, 0, 0, 0.04)),
            if (widget.hasToDate) _buildToDateToggle(),
            DatePickerSliding(
              picker: _buildPickerList(),
              type: widget.type,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleBar() {
    return DateProcessTitle(
      time: vm.chooseTime,
      title: widget.title,
      onDone: () {
        Navigator.pop(context);
        if (widget.hasToDate) {
          widget.onDone(vm.chooseTime.value!, vm.isToDate.value);
        } else {
          widget.onDone(vm.chooseTime.value!);
        }
      },
    );
  }

  Widget _buildToDateToggle() {
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: vm.isToDate,
          builder: (context, value, child) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, top: 12.w, bottom: 12.w),
                child: VVButton(
                  text: getLanguage<S>().LMID_00001359,
                  onTap: () {
                    vm.isToDate.value = !vm.isToDate.value;
                  },
                  colorType: vm.isToDate.value ? VVButtonColorType.blueBorder : VVButtonColorType.gray,
                  backGroundColor: vm.isToDate.value ? uiEEF4FE : null,
                  type: VVButtonSizeType.small,
                  height: 32.w,
                  width: 110.w,
                  circular: 8.w,
                ),
              ),
            );
          },
        ),
        const Divider(thickness: 0.5, color: Color.fromRGBO(0, 0, 0, 0.04)),
      ],
    );
  }

  Widget _buildPickerList() {
    vm.initController();
    return Row(
      children: [
        _buildPicker(
          vm.yearList(),
          vm.chooseYearController,
          vm.updateYear,
        ),
        _buildPicker(
          vm.monthList(vm.chooseTime.value!),
          vm.chooseMonthController,
          vm.updateMonth,
        ),
        if (widget.type == DatePickerType.scrollYMD)
          _buildPicker(
            vm.dayList(vm.chooseTime.value!),
            vm.chooseDayController,
            vm.updateChooseTime,
          ),
      ],
    );
  }

  Widget _buildPicker(List<String> textList, FixedExtentScrollController controller, VoidCallback onScrollEnd) {
    return Expanded(
      child: VVCupertinoPicker(
        key: UniqueKey(),
        scrollEnd: () {
          if (vm.isToDate.value) {
            vm.isToDate.value = false;
          }
          setState(onScrollEnd);
        },
        childCount: textList.length,
        textList: textList,
        controller: controller,
      ),
    );
  }
}
