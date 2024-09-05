import 'package:flutter/material.dart';
import 'package:jui/src/data_entry/picker_new/jui_picker_config.dart';
import 'package:jui/src/data_entry/picker_new/jui_picker_content.dart';
import 'package:jui/src/data_entry/picker_new/jui_picker_header.dart';

class JuiPicker extends StatefulWidget {
  final PickerConfig config;
  final List<PickerItem> items;
  final List<String> initialSelection;
  final PickerCallback onSelect;
  final VoidCallback? onCancel;

  const JuiPicker({
    Key? key,
    required this.config,
    required this.items,
    required this.onSelect,
    this.initialSelection = const [],
    this.onCancel,
  }) : super(key: key);

  @override
  JuiPickerState createState() => JuiPickerState();
}

class JuiPickerState extends State<JuiPicker> {
  late Set<String> _selectedKeys;
  late PickerContentBuilder _contentBuilder;
  late PickerHeaderHandler _headerHandler;

  @override
  void initState() {
    super.initState();
    _selectedKeys = Set.from(widget.initialSelection);
    _contentBuilder = PickerContentBuilderFactory.getBuilder(widget.config.layout);
    _headerHandler = PickerHeaderHandler(
      config: widget.config,
      onCancel: widget.onCancel,
      onConfirm: _handleConfirm,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.config.uiConfig.topBorderRadius,
      child: Container(
        color: widget.config.uiConfig.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _headerHandler.buildHeader(),
            _buildContent(),
          ],
        ),
      ),
    );
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