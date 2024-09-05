import 'package:flutter/material.dart';
import 'package:jui/src/data_entry/picker_new/jui_picker_config.dart';
import 'package:jui/src/data_entry/picker_new/jui_picker_content.dart';
import 'package:jui/src/data_entry/picker_new/jui_picker_header.dart';

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
    if (widget.initialSelection.isEmpty && widget.config.selectionMode == SelectionMode.single) {
      _selectedItems = [widget.items.first.data];
    } else {
      _selectedItems = List.from(widget.initialSelection);
    }
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
      _selectedItems,
      widget.config,
      _handleItemSelection,
      widget.config.selectionMode == SelectionMode.single ? _handleImmediateConfirm : null,
    );
  }

  void _handleItemSelection(PickerItemData item) {
    setState(() {
      switch (widget.config.selectionMode) {
        case SelectionMode.single:
          _selectedItems = [item];
          break;
        case SelectionMode.multiple:
          int index = _selectedItems.indexWhere((element) => element.key == item.key);
          if (index != -1) {
            _selectedItems.removeAt(index);
          } else {
            _selectedItems.add(item);
          }
          break;
      }
    });
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
