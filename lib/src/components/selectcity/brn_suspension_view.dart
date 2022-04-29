import 'package:bruno/src/components/selectcity/brn_az_common.dart';
import 'package:flutter/material.dart';

/// on all sus section callback(map: Used to scroll the list to the specified tag location).
typedef SusSectionTapCallback = void Function(Map<String, int> map);

///Suspension Widget.Currently only supports fixed height items!
class SuspensionView extends StatefulWidget {
  /// with  ISuspensionBean Data
  final List<ISuspensionBean> data;

  /// content widget(must contain ListView).
  final Widget contentWidget;

  /// suspension widget.
  final Widget suspensionWidget;

  /// ListView ScrollController.
  final ScrollController controller;

  /// suspension widget Height.
  final int suspensionHeight;

  /// item Height.
  final int itemHeight;

  /// on sus tag change callback.
  final ValueChanged<String>? onSusTagChanged;

  /// on sus section callback.
  final SusSectionTapCallback? onSusSectionInited;

  final AzListViewHeader? header;

  SuspensionView({
    Key? key,
    required this.data,
    required this.contentWidget,
    required this.suspensionWidget,
    required this.controller,
    this.suspensionHeight = 40,
    this.itemHeight = 50,
    this.onSusTagChanged,
    this.onSusSectionInited,
    this.header,
  }) : super(key: key);

  @override
  _SuspensionWidgetState createState() => _SuspensionWidgetState();
}

class _SuspensionWidgetState extends State<SuspensionView> {
  int _suspensionTop = 0;
  int _lastIndex = -1;
  late int _suSectionListLength;

  List<int> _suspensionSectionList = [];
  Map<String, int> _suspensionSectionMap = Map();

  @override
  void initState() {
    super.initState();
    if (widget.header != null) {
      _suspensionTop = -widget.header!.height;
    }
    widget.controller.addListener(_handleScrollerListenerTick);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_handleScrollerListenerTick);
  }

  void _handleScrollerListenerTick() {
    int offset = widget.controller.offset.toInt();
    int _index = _getIndex(offset);
    if (_index != -1 && _lastIndex != _index) {
      _lastIndex = _index;
      if (widget.onSusTagChanged != null) {
        widget.onSusTagChanged!(_suspensionSectionMap.keys.toList()[_index]);
      }
    }
  }

  int _getIndex(int offset) {
    if (widget.header != null && offset < widget.header!.height) {
      if (_suspensionTop != -widget.header!.height) {
        setState(() {
          _suspensionTop = -widget.header!.height;
        });
      }
      return 0;
    }
    for (int i = 0; i < _suSectionListLength - 1; i++) {
      int space = _suspensionSectionList[i + 1] - offset;
      if (space > 0 && space < widget.suspensionHeight) {
        space = space - widget.suspensionHeight;
      } else {
        space = 0;
      }
      if (_suspensionTop != space) {
        setState(() {
          _suspensionTop = space;
        });
      }
      int a = _suspensionSectionList[i];
      int b = _suspensionSectionList[i + 1];
      if (offset >= a && offset < b) {
        return i;
      }
      if (offset >= _suspensionSectionList[_suSectionListLength - 1]) {
        return _suSectionListLength - 1;
      }
    }
    return -1;
  }

  void _init() {
    _suspensionSectionMap.clear();
    int offset = 0;
    String? tag;
    if (widget.header != null) {
      _suspensionSectionMap[widget.header!.tag] = 0;
      offset = widget.header!.height;
    }
    widget.data.forEach((v) {
      if (tag != v.tag) {
        tag = v.tag;
        _suspensionSectionMap.putIfAbsent(tag!, () => offset);
        offset = offset + widget.suspensionHeight + widget.itemHeight;
      } else {
        offset = offset + widget.itemHeight;
      }
    });
    _suspensionSectionList
      ..clear()
      ..addAll(_suspensionSectionMap.values);
    _suSectionListLength = _suspensionSectionList.length;
    if (widget.onSusSectionInited != null) {
      widget.onSusSectionInited!(_suspensionSectionMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    _init();
    var children = <Widget>[
      widget.contentWidget,
    ];

    children.add(Positioned(
      ///-0.1修复部分手机丢失精度问题
      top: _suspensionTop.toDouble() - 0.1,
      left: 0.0,
      right: 0.0,
      child: widget.suspensionWidget,
    ));

    return Stack(children: children);
  }
}
