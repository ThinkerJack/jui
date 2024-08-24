import 'package:flutter/material.dart';

import '../common/picker_widget.dart';
import 'common/picker_func.dart';
import 'common/picker_widget.dart';
import 'date_picker_func.dart';
import 'mv_date_picker_vm.dart';

class MVScrollDatePicker extends StatefulWidget {
  const MVScrollDatePicker({super.key, required this.onDone, required this.type, this.startTime, this.endTime});

  final Function(DateTime startTime, DateTime? endTime) onDone; //点击确定调用
  final DatePickerType type; //选择器类型
  final DateTime? startTime; //开始时间
  final DateTime? endTime; //结束时间
  @override
  State<MVScrollDatePicker> createState() => _MVScrollDatePickerState();
}

class _MVScrollDatePickerState extends State<MVScrollDatePicker> {
  late MVScrollDatePickerVM vm;

  @override
  void initState() {
    vm = MVScrollDatePickerVM();
    vm.init(widget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        constraints: BoxConstraints(maxHeight: 370, minWidth: 37),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              16,
            ),
            topRight: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            DateProcessTitle(
                time: vm.endTime,
                onDone: () {
                  Navigator.pop(context);
                  widget.onDone(vm.startTime.value!, vm.endTime.value);
                }),
            const Divider(thickness: 0.5, color: Color.fromRGBO(0, 0, 0, 0.04)),
            ValueListenableBuilder(
                key: UniqueKey(),
                valueListenable: vm.startTime,
                builder: (context, value, child) {
                  return ValueListenableBuilder(
                      key: UniqueKey(),
                      valueListenable: vm.endTime,
                      builder: (context, value, child) {
                        return ValueListenableBuilder(
                            key: UniqueKey(),
                            valueListenable: vm.startOrEndFlag,
                            builder: (context, value, child) {
                              return CommonTimeTitle(
                                startOrEndFlag: vm.startOrEndFlag,
                                endTime: vm.endTime,
                                tapStart: () {
                                  vm.tapStartTime();
                                },
                                tapEnd: () {
                                  vm.tapEndTime();
                                },
                                type: widget.type,
                                startTime: vm.startTime.value!,
                              );
                            });
                      });
                }),
            DatePickerSliding(
              picker: ValueListenableBuilder(
                  valueListenable: vm.startOrEndFlag,
                  builder: (context, value, child) {
                    return vm.startOrEndFlag.value ? getStartPickerList() : getEndPickerList();
                  }),
              type: widget.type,
            ),
          ],
        ),
      ),
    );
  }

  Widget getStartPickerList() {
    switch (widget.type) {
      case DatePickerType.SINGLE_YMD:
      case DatePickerType.scrollYMD:
        vm.initStartController(context);
        return Row(
          children: [
            Expanded(
              child: VVCupertinoPicker(
                key: UniqueKey(),
                scrollEnd: () {
                  vm.updateStartYearOrMonth();
                },
                childCount: vm.startYearList().length,
                textList: vm.startYearList(),
                controller: vm.startYearController,
              ),
            ),
            Expanded(
              child: VVCupertinoPicker(
                key: UniqueKey(),
                scrollEnd: () {
                  vm.updateStartYearOrMonth();
                },
                childCount: 12,
                textList: vm.startMonthList(),
                controller: vm.startMonthController,
              ),
            ),
            Expanded(
                child: ValueListenableBuilder(
                    key: UniqueKey(),
                    valueListenable: vm.startMonthChange,
                    builder: (context, value, child) {
                      return VVCupertinoPicker(
                        scrollEnd: () {
                          vm.updateStartTimeByDay();
                        },
                        childCount: vm.startDayList(vm.startTime.value!).length,
                        textList: vm.startDayList(vm.startTime.value!),
                        controller: vm.startDayController,
                      );
                    })),
          ],
        );
      case DatePickerType.YMDWHM:
      case DatePickerType.scrollYMDWHM:
        vm.initStartController(context);
        return Row(
          children: [
            Expanded(
              flex: 3,
              child: VVCupertinoPicker(
                key: UniqueKey(),
                scrollEnd: () {
                  vm.updateStartByYMDW(context);
                },
                childCount: getYMDWList(vm.initialStartTime, context).length,
                textList: getYMDWList(vm.initialStartTime, context),
                controller: vm.startYMDWController,
              ),
            ),
            Expanded(
              child: VVCupertinoPicker(
                key: UniqueKey(),
                scrollEnd: () {
                  vm.updateStartByYMDW(context);
                },
                childCount: 24,
                textList: getHourList(),
                controller: vm.startHourController,
              ),
            ),
            Expanded(
                child: VVCupertinoPicker(
              key: UniqueKey(),
              scrollEnd: () {
                vm.updateStartByYMDW(context);
              },
              childCount: 60,
              textList: getMinuteList(),
              controller: vm.startMinuteController,
            )),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget getEndPickerList() {
    switch (widget.type) {
      case DatePickerType.SINGLE_YMD:
      case DatePickerType.scrollYMD:
        vm.initEndController(context);
        return Row(
          children: [
            Expanded(
                child: VVCupertinoPicker(
              key: UniqueKey(),
              scrollEnd: () {
                vm.updateEndTimeByYear();
              },
              childCount: 100,
              textList: vm.endYearList(),
              controller: vm.endYearController,
            )),
            Expanded(
              child: ValueListenableBuilder(
                  key: UniqueKey(),
                  valueListenable: vm.endYearChange,
                  builder: (context, value, child) {
                    return VVCupertinoPicker(
                      scrollEnd: () {
                        vm.updateEndTimeByMonth();
                      },
                      childCount: vm.endMonthList(vm.endTime.value!).length,
                      textList: vm.endMonthList(vm.endTime.value!),
                      controller: vm.endMonthController,
                    );
                  }),
            ),
            Expanded(
                child: ValueListenableBuilder(
                    key: UniqueKey(),
                    valueListenable: vm.endMonthChange,
                    builder: (context, value, child) {
                      return ValueListenableBuilder(
                          key: UniqueKey(),
                          valueListenable: vm.endYearChange,
                          builder: (context, value, child) {
                            return VVCupertinoPicker(
                              scrollEnd: () {
                                vm.updateEndByMinute(context);
                              },
                              childCount: vm.endMinuteList(vm.endTime.value!).length,
                              textList: vm.endMinuteList(vm.endTime.value!),
                              controller: vm.endMinuteController,
                            );
                          });
                    })),
          ],
        );
      case DatePickerType.YMDWHM:
      case DatePickerType.scrollYMDWHM:
        vm.initEndController(context);
        return Row(
          children: [
            Expanded(
              flex: 3,
              child: VVCupertinoPicker(
                key: UniqueKey(),
                scrollEnd: () {
                  vm.updateEndByYMDW(context);
                },
                childCount: vm.endYMDWList(context).length,
                textList: vm.endYMDWList(context),
                controller: vm.endYMDWController,
              ),
            ),
            Expanded(
                child: ValueListenableBuilder(
                    key: UniqueKey(),
                    valueListenable: vm.endYMDWChange,
                    builder: (context, value, child) {
                      return VVCupertinoPicker(
                        scrollEnd: () {
                          vm.updateEndByHour(context);
                        },
                        childCount: vm.endHourList(vm.endTime.value!).length,
                        textList: vm.endHourList(vm.endTime.value!),
                        controller: vm.endHourController,
                      );
                    })),
            Expanded(
                child: ValueListenableBuilder(
                    key: UniqueKey(),
                    valueListenable: vm.endYMDWChange,
                    builder: (context, value, child) {
                      return ValueListenableBuilder(
                          key: UniqueKey(),
                          valueListenable: vm.endHourChange,
                          builder: (context, value, child) {
                            return VVCupertinoPicker(
                              scrollEnd: () {
                                vm.updateEndByMinute(context);
                              },
                              childCount: vm.endMinuteList(vm.endTime.value!).length,
                              textList: vm.endMinuteList(vm.endTime.value!),
                              controller: vm.endMinuteController,
                            );
                          });
                    })),
          ],
        );
      default:
        return const SizedBox();
    }
  }
}
