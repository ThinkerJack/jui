import 'package:flutter/material.dart';
import 'package:jui/src/data_entry/picker_new/picker_config.dart';
import 'package:jui/src/data_entry/picker_new/picker_content_builder.dart';

// 核心选择器组件
class Picker extends StatefulWidget {
  final PickerConfig config;
  final List<PickerItem> items;
  final List<String> initialSelection;
  final PickerCallback onSelect;
  final VoidCallback? onCancel;

  Picker({
    Key? key,
    required this.config,
    required this.items,
    required this.onSelect,
    this.initialSelection = const [],
    this.onCancel,
  }) : super(key: key);

  @override
  PickerState createState() => PickerState();
}

class PickerState extends State<Picker> {
  late Set<String> _selectedKeys;
  late PickerContentBuilder _contentBuilder;

  @override
  void initState() {
    super.initState();
    _selectedKeys = Set.from(widget.initialSelection);
    _contentBuilder = PickerContentBuilderFactory.getBuilder(widget.config.style);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildContent(),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    // 实现标题栏
    return Container();
  }

  Widget _buildContent() {
    return _contentBuilder.build(
      context,
      widget.items,
      _selectedKeys,
      widget.config,
      _handleItemSelection,
      widget.config.selectionMode == SelectionMode.single ? _handleImmediateConfirm : null,
    );
  }

  Widget _buildFooter() {
    // 实现底部栏
    return Container();
  }

  void _handleItemSelection(String key) {
    setState(() {
      if (widget.config.selectionMode == SelectionMode.single) {
        _selectedKeys = {key};
      } else {
        if (_selectedKeys.contains(key)) {
          _selectedKeys.remove(key);
        } else {
          _selectedKeys.add(key);
        }
      }
    });
  }

  void _handleImmediateConfirm(String key) {
    _handleItemSelection(key);
    _handleConfirm();
  }

  void _handleConfirm() {
    List<String> selectedValues =
        _selectedKeys.map((key) => widget.items.firstWhere((item) => item.key == key).value).toList();
    widget.onSelect(_selectedKeys.toList(), selectedValues);
  }
}
