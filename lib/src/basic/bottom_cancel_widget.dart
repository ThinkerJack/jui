import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils.dart';

//底部取消组件 灰色分割线
class BCPSpacer extends StatelessWidget {
  const BCPSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: uiF6F7F8,
      height: 8,
      width: double.infinity,
    );
  }
}

// 底部取消组件 按钮
class BCPButton extends StatelessWidget {
  const BCPButton({
    Key? key,
    required this.onCancel,
  }) : super(key: key);

  final Function? onCancel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onCancel?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().screenWidth,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text("取消",
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: const Color(0xFF858B9B),
            )),
      ),
    );
  }
}
