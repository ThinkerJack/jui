import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jui/src/utils/extension.dart';

import '../../../generated/assets.dart';
import '../../utils/jui_theme.dart';
import 'common.dart';

/// 可编辑输入框组件，包含标题、提示信息、输入框及清除按钮
class EditItem extends StatefulWidget {
  const EditItem({
    Key? key,
    required this.title,
    required this.controller,
    this.showTips = false,
    this.maxLength = 10000,
    this.tipText = "",
    this.hintText = "",
    this.maxLine = 3,
    this.isRequired = false,
    this.onUnFocus,
    this.focusNode,
    this.keyboardType = TextInputType.multiline,
    this.onlyNum = false,
    this.padding,
    this.needClear = false,
    this.needUpdateShowTips = false,
  }) : super(key: key);

  final String title; // 输入框标题
  final String hintText; // 输入框提示文字
  final TextEditingController controller; // 控制器
  final int maxLength; // 最大输入长度
  final int maxLine; // 最大输入行数
  final bool isRequired; // 是否为必填项
  final CheckTextFunc? onUnFocus; // 失焦时回调函数
  final bool showTips; // 是否显示提示信息
  final bool onlyNum; // 是否只允许输入数字
  final bool needClear; // 是否需要清除按钮
  final bool needUpdateShowTips; // 是否需要清除按钮
  final String tipText; // 提示文字
  final TextInputType keyboardType; // 键盘类型
  final EdgeInsets? padding; // 内边距
  final FocusNode? focusNode; // 焦点节点

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> with InputCheckMixin {
  late bool showTips; // 是否显示提示信息
  late final TextField _textField;
  bool _showTextField = false;
  bool _showClearIcon = false; // 是否显示清除按钮
  final TextStyle _textStyle = TextStyle(fontSize: 16, height: 1.5, color: JuiColors().text);

  @override
  void initState() {
    super.initState();
    initData();
  }

  /// 初始化数据
  void initData() {
    showTips = widget.showTips;
    initFocus(widget.tipText, widget.focusNode, _handleFocusChange);
    _textField = _buildTextField();
    _textField.controller?.addListener(_handleTextChange);
  }

  /// 构建输入框
  TextField _buildTextField() {
    return TextField(
      key: UniqueKey(),
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLine,
      minLines: 1,
      focusNode: focusNode,
      maxLength: widget.maxLength,
      controller: widget.controller,
      style: _textStyle,
      inputFormatters: widget.onlyNum ? [FilteringTextInputFormatter.digitsOnly] : null,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: itemHintStyle,
        isCollapsed: true,
        counterText: '',
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(right: widget.needClear ? 50 : 20),
      ),
    );
  }

  /// 焦点改变处理
  void _handleFocusChange() async {
    if (!focusNode.hasFocus) {
      _showTextField = false;
      _hideClearIcon();
      await _updateHintText();
    } else {
      _handleTextChange();
    }
  }

  /// 隐藏清除按钮
  void _hideClearIcon() {
    if (!widget.needClear) return;
    if (mounted) {
      setState(() {
        _showClearIcon = false;
      });
    }
  }

  /// 更新提示文字
  Future<void> _updateHintText() async {
    final hintText = await widget.onUnFocus?.call(widget.controller.text);
    if (hintText != null && hintText.isNotEmpty) {
      tipText = hintText;
      showTips = true;
    } else {
      showTips = false;
    }
    if (mounted) {
      setState(() {});
    }
  }

  /// 文本改变处理
  void _handleTextChange() {
    if (!widget.needClear) return;
    if (focusNode.hasFocus && widget.controller.text.isNotEmpty && mounted) {
      setState(() {
        _showClearIcon = widget.controller.text.isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChange);
    disposeFocus(widget.focusNode == null);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant EditItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.needUpdateShowTips) {
      setState(() {
        showTips = widget.showTips;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.only(left: itemPaddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: itemPaddingV),
          ItemTitle(title: widget.title, isRequired: widget.isRequired),
          SizedBox(height: 6),
          LayoutBuilder(builder: (context, size) {
            return buildText(size.maxWidth);
          }),
          ItemTipsText(showTips: showTips, tipText: tipText),
          SizedBox(height: itemPaddingV),
          const ItemDivider(),
        ],
      ),
    );
  }

  /// 构建输入框文本
  Widget buildText(size) {
    if (!_getContentTextPainter(_textField.controller?.text ?? "", size).didExceedMaxLines) {
      return _buildTextFieldWithClearButton();
    }
    if (_showTextField) {
      return _buildTextFieldWithClearButton();
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            _showTextField = true;
            focusNode.requestFocus();
          });
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(
            _textField.controller?.text ?? "",
            style: _textStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      );
    }
  }

  /// 构建带清除按钮的输入框
  Widget _buildTextFieldWithClearButton() {
    return Padding(
      padding: EdgeInsets.only(left: 2),
      child: Stack(
        children: [
          _textField,
          if (_showClearIcon && widget.needClear)
            Positioned(
              right: itemPaddingR,
              top: 0,
              bottom: 0,
              child: InkWell(
                child: Image.asset(Assets.imagesClear.path, width: 16),
                onTap: () {
                  widget.controller.clear();
                  _handleTextChange();
                },
              ),
            ),
        ],
      ),
    );
  }

  /// 获取内容的文本绘制器
  TextPainter _getContentTextPainter(String text, double maxWidth) {
    return TextPainter(
        text: TextSpan(text: text, style: _textStyle),
        maxLines: widget.maxLine,
        textDirection: TextDirection.ltr,
        textScaleFactor: MediaQuery.of(context).textScaleFactor)
      ..layout(maxWidth: maxWidth - 50);
  }
}
