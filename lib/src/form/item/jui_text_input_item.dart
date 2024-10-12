import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jui/src/utils/extension.dart';
import 'package:jui/src/utils/jui_theme.dart';

import '../../../generated/assets.dart';
import 'jui_item.dart';
import 'jui_item_config.dart';

class JuiTextInputItem extends StatelessWidget {
  // 标题，用于显示在文本输入框上方
  final String title;

  // 提示文本，当输入框为空时显示
  final String hintText;

  // 文本控制器，用于控制文本输入框的内容
  final TextEditingController controller;

  // 焦点节点，用于管理输入框的焦点状态
  final FocusNode? focusNode;

  // 键盘类型，决定打开输入框时显示的键盘类型
  final TextInputType keyboardType;

  // 最大行数，限制文本输入框最多可以显示的行数
  final int maxLines;

  // 最大长度，限制文本输入框中可以输入的最大字符数
  final int? maxLength;

  // 是否只允许输入数字
  final bool onlyNumbers;

  // 文本改变时的回调函数
  final ValueChanged<String>? onChanged;

  // 编辑完成时的回调函数
  final VoidCallback? onEditingComplete;

  // 提交文本时的回调函数
  final ValueChanged<String>? onSubmitted;

  // 配置项，用于自定义文本输入框的外观和行为
  final JuiItemConfig config;

  // 是否显示清除按钮，新添加的属性
  final bool showClearButton;

  const JuiTextInputItem({
    Key? key,
    required this.title,
    this.hintText = '',
    required this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.onlyNumbers = false,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.config = const JuiItemConfig(),
    this.showClearButton = true, // Default to true for backward compatibility
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JuiItem(
      title: title,
      content: _InputField(
        hintText: hintText,
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        onlyNumbers: onlyNumbers,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        showClearButton: showClearButton, // Pass the new property
      ),
      config: config,
    );
  }
}

class _InputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final int maxLines;
  final int? maxLength;
  final bool onlyNumbers;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final bool showClearButton; // New property

  const _InputField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.focusNode,
    required this.keyboardType,
    required this.maxLines,
    this.maxLength,
    required this.onlyNumbers,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    required this.showClearButton, // New required property
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  late final FocusNode _focusNode;
  bool _showClearIcon = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
    widget.controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    widget.controller.removeListener(_handleTextChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isEditing = _focusNode.hasFocus;
      _updateClearIconVisibility();
    });
  }

  void _handleTextChange() {
    _updateClearIconVisibility();
  }

  void _updateClearIconVisibility() {
    final shouldShowClearIcon = widget.showClearButton && _focusNode.hasFocus && widget.controller.text.isNotEmpty;
    if (_showClearIcon != shouldShowClearIcon) {
      setState(() {
        _showClearIcon = shouldShowClearIcon;
      });
    }
  }

  void _clearText() {
    widget.controller.clear();
    _updateClearIconVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
        setState(() {
          _isEditing = true;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          if (_isEditing)
            TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              onChanged: widget.onChanged,
              onEditingComplete: widget.onEditingComplete,
              onSubmitted: (value) {
                setState(() {
                  _isEditing = false;
                });
                widget.onSubmitted?.call(value);
              },
              style: JuiTheme.textStyles.itemContent,
              inputFormatters: widget.onlyNumbers ? [FilteringTextInputFormatter.digitsOnly] : null,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: JuiTheme.textStyles.itemHint,
                isCollapsed: true,
                counterText: '',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(right: widget.showClearButton ? 20 : 0),
              ),
            )
          else
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.controller.text.isEmpty ? widget.hintText : widget.controller.text,
                style: widget.controller.text.isEmpty ? JuiTheme.textStyles.itemHint : JuiTheme.textStyles.itemContent,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (_showClearIcon)
            InkWell(
              onTap: _clearText,
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Image.asset(Assets.imagesClear.path, width: 16),
              ),
            ),
        ],
      ),
    );
  }
}
