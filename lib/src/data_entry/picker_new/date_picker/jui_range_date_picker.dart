// lib/src/data_entry/jui_date_picker/jui_range_date_picker.dart

import 'package:flutter/material.dart';

import 'jui_date_picker_types.dart';
import 'jui_range_date_picker_vm.dart';
import 'jui_date_picker_components.dart';
import 'jui_date_picker_utils.dart';

class JuiRangeDatePicker extends StatefulWidget {
  const JuiRangeDatePicker({
    super.key,
    required this.onDone,
    required this.mode,
    this.startTime,
    this.endTime
  });

  final Function(DateTime startTime, DateTime? endTime) onDone;
  final JuiDatePickerMode mode;
  final DateTime? startTime;
  final DateTime? endTime;

  @override
  State<JuiRangeDatePicker> createState() => _JuiRangeDatePickerState();
}

class _JuiRangeDatePickerState extends State<JuiRangeDatePicker> {
  late JuiRangeDatePickerVM vm;

  @override
  void initState() {
    vm = JuiRangeDatePickerVM();
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
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            JuiDateProcessTitle(
                time: vm.endTime,
                onDone: () {
                  Navigator.pop(context);
                  widget.onDone(vm.startTime.value!, vm.endTime.value);
                }),
            const JuiPickerDivider(),
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
                              return JuiCommonTimeTitle(
                                startOrEndFlag: vm.startOrEndFlag,
                                endTime: vm.endTime,
                                tapStart: () {
                                  vm.tapStartTime();
                                },
                                tapEnd: () {
                                  vm.tapEndTime();
                                },
                                mode: widget.mode,
                                startTime: vm.startTime.value!,
                              );
                            });
                      });
                }),
            JuiDatePickerSliding(
              picker: ValueListenableBuilder(
                  valueListenable: vm.startOrEndFlag,
                  builder: (context, value, child) {
                    return vm.startOrEndFlag.value ? getStartPickerList() : getEndPickerList();
                  }),
              mode: widget.mode,
            ),
          ],
        ),
      ),
    );
  }

  Widget getStartPickerList() {
    switch (widget.mode) {
      case JuiDatePickerMode.scrollYMD:
        vm.initStartController(context);
        return Row(
          children: [
            Expanded(
              child: JuiCupertinoPicker(
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
              child: JuiCupertinoPicker(
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
                      return JuiCupertinoPicker(
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
      case JuiDatePickerMode.scrollYMDWHM:
        vm.initStartController(context);
        return Row(
          children: [
            Expanded(
              flex: 3,
              child: JuiCupertinoPicker(
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
              child: JuiCupertinoPicker(
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
                child: JuiCupertinoPicker(
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
        return SizedBox.shrink();
    }
  }

  Widget getEndPickerList() {
    switch (widget.mode) {
      case JuiDatePickerMode.scrollYMD:
        vm.initEndController(context);
        return Row(
          children: [
            Expanded(
                child: JuiCupertinoPicker(
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
                    return JuiCupertinoPicker(
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
                            return JuiCupertinoPicker(
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
      case JuiDatePickerMode.scrollYMDWHM:
        vm.initEndController(context);
        return Row(
          children: [
            Expanded(
              flex: 3,
              child: JuiCupertinoPicker(
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
                      return JuiCupertinoPicker(
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
                            return JuiCupertinoPicker(
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
        return SizedBox.shrink();
    }
  }
}