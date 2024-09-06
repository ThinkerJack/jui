// lib/src/data_entry/jui_date_picker/jui_single_date_picker.dart

import 'package:flutter/material.dart';
import '../../../../common.dart';
import '../../../utils/jui_theme.dart';
import 'jui_date_picker_types.dart';
import 'jui_date_picker_components.dart';
import 'jui_single_date_picker_vm.dart';

class JuiSingleDatePicker extends StatefulWidget {
  const JuiSingleDatePicker({
    Key? key,
    required this.onDone,
    this.time,
    required this.mode,
    this.title,
    this.maxTime,
    this.minTime,
    this.hasToDate = false,
    this.isToDate = false,
  }) : super(key: key);

  final JuiDatePickerMode mode;
  final Function onDone;
  final DateTime? time;
  final DateTime? maxTime;
  final DateTime? minTime;
  final String? title;
  final bool hasToDate;
  final bool isToDate;

  @override
  State<JuiSingleDatePicker> createState() => _JuiSingleDatePickerState();
}

class _JuiSingleDatePickerState extends State<JuiSingleDatePicker> {
  late JuiSingleDatePickerVM vm;

  @override
  void initState() {
    super.initState();
    vm = JuiSingleDatePickerVM();
    vm.init(widget);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        constraints: BoxConstraints(maxHeight: widget.hasToDate ? 370 : 320, minWidth: 37),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _buildTitleBar(),
            const JuiPickerDivider(),
            if (widget.hasToDate) _buildToDateToggle(),
            JuiDatePickerSliding(
              picker: _buildPickerList(),
              mode: widget.mode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleBar() {
    return JuiDateProcessTitle(
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
                padding: EdgeInsets.only(left: 16, top: 12, bottom: 12),
                child: JuiButton(
                  text: "至今",
                  onTap: () {
                    vm.isToDate.value = !vm.isToDate.value;
                  },
                  colorType: vm.isToDate.value ? JuiButtonColorType.blueBorder : JuiButtonColorType.gray,
                  backGroundColor: vm.isToDate.value ? JuiColors().lighterBlue : null,
                  sizeType: JuiButtonSizeType.small,
                  height: 32,
                  width: 110,
                  circular: 8,
                ),
              ),
            );
          },
        ),
        const JuiPickerDivider(),
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
        if (widget.mode == JuiDatePickerMode.scrollYMD)
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
      child: JuiCupertinoPicker(
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