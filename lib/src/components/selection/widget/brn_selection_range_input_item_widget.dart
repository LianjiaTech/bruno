// @dart=2.9

import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:bruno/src/utils/brn_event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void OnRangeChangedFunction(String minInput, String maxInput);
typedef void OnFocusChangedFunction(bool focus);

/// 清空自定义范围输入框焦点的事件类
class ClearSelectionFocusEvent {}

// ignore: must_be_immutable
class BrnSelectionRangeItemWidget extends StatefulWidget {
  final BrnSelectionEntity item;

  final OnRangeChangedFunction onRangeChanged;
  final OnFocusChangedFunction onFocusChanged;

  final bool isShouldClearText;

  final TextEditingController minTextEditingController;
  final TextEditingController maxTextEditingController;

  BrnSelectionConfig themeData;

  BrnSelectionRangeItemWidget(
      {this.item,
      @required this.minTextEditingController,
      @required this.maxTextEditingController,
      this.isShouldClearText = false,
      this.themeData,
      this.onRangeChanged,
      this.onFocusChanged});

  _BrnSelectionRangeItemWidgetState createState() =>
      _BrnSelectionRangeItemWidgetState();
}

class _BrnSelectionRangeItemWidgetState
    extends State<BrnSelectionRangeItemWidget> {
  FocusNode _minFocusNode = FocusNode();
  FocusNode _maxFocusNode = FocusNode();

  @override
  void initState() {
    widget.minTextEditingController.text =
        (widget.item.customMap != null && widget.item.customMap['min'] != null)
            ? widget.item.customMap['min']?.toString()
            : null;
    widget.maxTextEditingController.text =
        (widget.item.customMap != null && widget.item.customMap['max'] != null)
            ? widget.item.customMap['max']?.toString()
            : null;

    //输入框焦点
    _minFocusNode.addListener(() {
      if (widget.onFocusChanged != null) {
        widget.onFocusChanged(_minFocusNode.hasFocus || _maxFocusNode.hasFocus);
      }
    });

    _maxFocusNode.addListener(() {
      if (widget.onFocusChanged != null) {
        widget.onFocusChanged(_minFocusNode.hasFocus || _maxFocusNode.hasFocus);
      }
    });

    widget.minTextEditingController.addListener(() {
      String minInput = widget.minTextEditingController.text ?? "";

      if (widget.item.customMap == null) {
        widget.item.customMap = {};
      }
      widget.item.customMap['min'] = minInput;
      widget.item.isSelected = true;
    });

    widget.maxTextEditingController.addListener(() {
      String maxInput = widget.maxTextEditingController.text ?? "";
      if (widget.item.customMap == null) {
        widget.item.customMap = {};
      }
      widget.item.customMap['max'] = maxInput;
      widget.item.isSelected = true;
    });

    EventBus.instance
        .on<ClearSelectionFocusEvent>()
        .listen((ClearSelectionFocusEvent event) {
      _minFocusNode?.unfocus();
      _maxFocusNode?.unfocus();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                (widget.item.title != null ? widget.item.title : '自定义区间') +
                    "(" +
                    widget.item.extMap['unit']?.toString() +
                    ")",
                textAlign: TextAlign.left,
                style:
                    widget.themeData.rangeTitleTextStyle?.generateTextStyle(),
              ),
            ),
            Row(
              children: <Widget>[
                getRangeTextField(false),
                Container(
                  child: Text(
                    "至",
                    style: widget.themeData.inputTextStyle?.generateTextStyle(),
                  ),
                ),
                getRangeTextField(true),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getRangeTextField(bool isMax) {
    return Expanded(
      child: TextFormField(
        style: widget.themeData.inputTextStyle?.generateTextStyle(),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        onChanged: (input) {
          widget.item.isSelected = true;
        },
        focusNode: isMax ? _maxFocusNode : _minFocusNode,
        controller: isMax
            ? widget.maxTextEditingController
            : widget.minTextEditingController,
        cursorColor: widget.themeData.commonConfig.brandPrimary,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintStyle: widget.themeData.hintTextStyle?.generateTextStyle(),
          hintText: (isMax ? '最大值' : '最小值'),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: widget.themeData.commonConfig.dividerColorBase,
          )),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: widget.themeData.commonConfig.dividerColorBase,
          )),
          contentPadding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
