import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../utils.dart';
import '../data_entry/picker/date_picker/common/vv_ios_cupertino_picker.dart';

TextStyle _leftTextStyle = TextStyle(fontSize: 14, color: ui858B9B, height: 1.5);

TextStyle _rightTextDefaultStyle = TextStyle(fontSize: 14, color: ui5590F6, height: 1.5, fontWeight: FontWeight.w500);

class PickerTitle extends StatelessWidget {
  const PickerTitle({
    Key? key,
    required this.title,
    this.onConfirm,
    required this.onCancel,
    required this.leftText,
    this.rightText,
    this.rightTextStyle,
    this.paddingHorizontal = 5,
  }) : super(key: key);
  final String title;
  final String leftText;
  final Function onCancel;
  final String? rightText;
  final TextStyle? rightTextStyle;
  final Function? onConfirm;
  final double paddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(bottom: BorderSide(color: uiE5E5E5, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              onCancel();
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(leftText, style: _leftTextStyle),
            ),
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              style: TextStyle(
                fontSize: 16,
                color: ui2A2F3C,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Visibility(
            visible: rightText != null,
            replacement: SizedBox(
              width: 60,
            ),
            child: GestureDetector(
              onTap: () {
                onConfirm?.call();
              },
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(rightText ?? "", style: rightTextStyle ?? _rightTextDefaultStyle),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PickerDivider extends StatelessWidget {
  const PickerDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: const Color(0X14000000),
      height: 0.5,
    );
  }
}

class PickerSelectionArea extends StatelessWidget {
  const PickerSelectionArea({super.key, this.child, required this.height});

  final Widget? child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFC),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: uiE8EAEF, width: 0.5),
      ),
      height: height,
      child: child,
    );
  }
}

class VVCupertinoPicker extends StatelessWidget {
  const VVCupertinoPicker({
    Key? key,
    required this.controller,
    required this.childCount,
    required this.textList,
    this.scrollEnd,
    this.scrollStart,
    this.scrollUpdate,
    this.itemChanged,
  }) : super(key: key);

  final Function? scrollEnd; // 滚动结束回调
  final Function? scrollStart; // 滚动开始回调
  final Function? scrollUpdate; // 滚动更新回调
  final Function? itemChanged; // 选项改变回调
  final FixedExtentScrollController? controller; // 滚动控制器
  final int childCount; // 子项数量
  final List<String> textList; // 文本列表

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          scrollStart?.call();
        } else if (notification is ScrollEndNotification) {
          scrollEnd?.call();
        } else if (notification is ScrollUpdateNotification) {
          scrollUpdate?.call();
        }
        return false;
      },
      child: _isWeb()
          ? VViOSCupertinoPicker.builder(
              scrollController: controller,
              itemExtent: 44,
              childCount: childCount,
              squeeze: 1.2,
              selectionOverlay: null,
              useMagnifier: true,
              onSelectedItemChanged: (index) {
                itemChanged?.call(index);
              },
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    textList[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Avenger',
                      color: const Color(0xFF2A2F3C),
                    ),
                  ),
                );
              },
            )
          : CupertinoPicker.builder(
              scrollController: controller,
              selectionOverlay: null,
              childCount: childCount,
              itemExtent: 44,
              squeeze: 1.2,
              onSelectedItemChanged: (index) {
                itemChanged?.call(index);
              },
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    textList[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Avenger',
                      color: const Color(0xFF2A2F3C),
                    ),
                  ),
                );
              },
            ),
    );
  }

  bool _isWeb() {
    return kIsWeb;
  }
}
