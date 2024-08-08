import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';

/// 限制流量的按钮组件，防止短时间内多次点击
class ThrottleButton extends StatefulWidget {
  final VoidCallback? onPressed; // 点击回调函数
  final Widget child; // 按钮子组件
  final Duration duration; // 限制点击频率的时间间隔

  const ThrottleButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  State<ThrottleButton> createState() => _ThrottleButtonState();
}

class _ThrottleButtonState extends State<ThrottleButton> {
  StreamController? _controller; // 流控制器，用于处理点击事件

  @override
  void dispose() {
    _controller?.close(); // 关闭流控制器
    super.dispose();
  }

  /// 初始化流控制器并设置节流监听
  void _factoryStreamController() {
    if (widget.onPressed != null) {
      _controller = StreamController();
      _controller!.stream.throttle(widget.duration).listen((event) {
        widget.onPressed?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed == null ? null : _runOnTap, // 设置点击事件处理
      child: widget.child,
    );
  }

  /// 处理点击事件，发送事件到流控制器
  void _runOnTap() {
    if (_controller == null) {
      _factoryStreamController();
    }
    _controller?.sink.add(1); // 添加事件到流
  }
}
