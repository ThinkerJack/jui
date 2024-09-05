import 'package:flutter/material.dart';
import 'jui_picker_config.dart';
import 'jui_picker_content.dart';
import 'jui_picker_header.dart';

class JuiPicker extends StatefulWidget {
  final PickerConfig config;
  final List<PickerItemUI> items;
  final List<PickerItemData> initialSelection;
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
  late List<PickerItemData> _selectedItems;
  late PickerContentBuilder _contentBuilder;
  late PickerHeaderHandler _headerHandler;

  @override
  void initState() {
    super.initState();
    _initializeSelection();
    _contentBuilder = PickerContentBuilderFactory.getBuilder(widget.config.layout);
    _headerHandler = PickerHeaderHandler(
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

  void _handleItemSelection(PickerItemData item) {
    setState(() {
      if (widget.config.selectionMode == SelectionMode.single) {
        _handleSingleSelection(item);
      } else {
        _handleMultipleSelection(item);
      }
    });
  }

  void _handleSingleSelection(PickerItemData item) {
    _selectedItems = [item];
  }

  void _handleMultipleSelection(PickerItemData item) {
    int index = _selectedItems.indexWhere((element) => element.key == item.key);
    if (index != -1) {
      _selectedItems.removeAt(index);
    } else {
      _selectedItems.add(item);
    }
  }

  void _handleImmediateConfirm(PickerItemData item) {
    _handleItemSelection(item);
    _handleConfirm();
  }

  void _handleConfirm() {
    List<String> selectedKeys = _selectedItems.map((item) => item.key).toList();
    List<String> selectedValues = _selectedItems.map((item) => item.value).toList();
    widget.onSelect(selectedKeys, selectedValues);
  }
}
