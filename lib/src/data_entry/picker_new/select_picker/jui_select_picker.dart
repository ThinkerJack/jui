import 'package:flutter/material.dart';
import '../../../../data_entry.dart';
import 'jui_select_picker_content.dart';
import 'jui_select_picker_header.dart';

class JuiSelectPicker extends StatefulWidget {
  final JuiSelectPickerConfig config;
  final List<JuiSelectPickerItemUI> items;
  final List<JuiSelectPickerItemData> initialSelection;
  final JuiSelectPickerCallback onSelect;
  final VoidCallback? onCancel;

  const JuiSelectPicker({
    Key? key,
    required this.config,
    required this.items,
    required this.onSelect,
    this.initialSelection = const [],
    this.onCancel,
  }) : super(key: key);

  @override
  JuiSelectPickerState createState() => JuiSelectPickerState();
}

class JuiSelectPickerState extends State<JuiSelectPicker> {
  late List<JuiSelectPickerItemData> _selectedItems;
  late JuiSelectPickerContentBuilder _contentBuilder;
  late JuiSelectPickerHeaderHandler _headerHandler;

  @override
  void initState() {
    super.initState();
    _initializeSelection();
    _contentBuilder = JuiSelectPickerContentBuilderFactory.getBuilder(widget.config.layout);
    _headerHandler = JuiSelectPickerHeaderHandler(
      config: widget.config,
      onCancel: widget.onCancel,
      onConfirm: _handleConfirm,
    );
  }

  void _initializeSelection() {
    _selectedItems = List.from(widget.initialSelection);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.config.uiConfig.topBorderRadius ?? BorderRadius.zero,
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
      context: context,
      items: widget.items,
      selectedItems: _selectedItems,
      config: widget.config,
      onItemTap: _handleItemSelection,
      onImmediateConfirm: widget.config.selectionMode == SelectionMode.single ? _handleImmediateConfirm : null,
    );
  }

  void _handleItemSelection(JuiSelectPickerItemData item) {
    setState(() {
      if (widget.config.selectionMode == SelectionMode.single) {
        _handleSingleSelection(item);
      } else {
        _handleMultipleSelection(item);
      }
    });
  }

  void _handleSingleSelection(JuiSelectPickerItemData item) {
    _selectedItems = [item];
  }

  void _handleMultipleSelection(JuiSelectPickerItemData item) {
    int index = _selectedItems.indexWhere((element) => element.key == item.key);
    if (index != -1) {
      _selectedItems.removeAt(index);
    } else {
      _selectedItems.add(item);
    }
  }

  void _handleImmediateConfirm(JuiSelectPickerItemData item) {
    _handleItemSelection(item);
    _handleConfirm();
  }

  void _handleConfirm() {
    List<String> selectedKeys = _selectedItems.map((item) => item.key).toList();
    List<String> selectedValues = _selectedItems.map((item) => item.value).toList();
    widget.onSelect(selectedKeys, selectedValues);
  }
}
