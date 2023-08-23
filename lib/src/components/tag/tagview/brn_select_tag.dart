import 'dart:math';

import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_tag_config.dart';
import 'package:flutter/material.dart';

/// 选择模式的标签组合
/// 支持流式和横向布局
/// 支持定宽和非定宽
/// 宽高间距可设置
/// 支持单选和多选
// ignore: must_be_immutable
class BrnSelectTag extends StatefulWidget {
  /// 展示的标签列表
  final List<String> tags;

  /// 选择tag的回调,返回选中 tag 的位置
  final void Function(List<int>)? onSelect;

  /// 水平间距，默认 12
  final double spacing;

  /// 垂直间距，默认 10
  final double verticalSpacing;

  /// 普通标签的样式
  final TextStyle? tagTextStyle;

  /// 选中的标签样式
  final TextStyle? selectedTagTextStyle;

  /// 普通标签背景色，默认 F0Color
  final Color? tagBackgroundColor;

  /// 选中的标签背景色，默认 B0Color
  final Color? selectedTagBackgroundColor;

  /// 标签宽度。默认全局配置宽度 75
  final double? tagWidth;

  /// 标签高度。默认全局配置高度 34
  final double? tagHeight;

  /// true 流式展示，false 横向滑动展示，默认 true
  final bool softWrap;

  /// 对齐模式，默认为 Alignment.centerLeft，靠左
  final Alignment alignment;

  /// 是否需要固定宽度，默认为true，指定为false为流式布局
  final bool fixWidthMode;

  /// 是否是单选，默认 true
  final bool isSingleSelect;

  /// 多选时的初始状态数组
  final List<bool>? initTagState;

  BrnTagConfig? themeData;

  BrnSelectTag({
    Key? key,
    required this.tags,
    this.onSelect,
    this.spacing = 12,
    this.verticalSpacing = 10,
    this.tagTextStyle,
    this.selectedTagTextStyle,
    this.tagBackgroundColor,
    this.selectedTagBackgroundColor,
    this.tagWidth,
    this.tagHeight,
    this.isSingleSelect = true,
    this.initTagState,
    this.softWrap = true,
    this.alignment = Alignment.centerLeft,
    this.fixWidthMode = true,
    this.themeData,
  }) : super(key: key) {
    if (isSingleSelect == true) {
      assert(initTagState == null || (initTagState!.length <= 1));
    }
    this.themeData ??= BrnTagConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .tagConfig
        .merge(this.themeData);
    this.themeData = this.themeData!.merge(BrnTagConfig(
        tagBackgroundColor: this.tagBackgroundColor,
        tagTextStyle: BrnTextStyle.withStyle(this.tagTextStyle),
        selectTagTextStyle: BrnTextStyle.withStyle(this.selectedTagTextStyle),
        tagWidth: this.tagWidth,
        tagHeight: this.tagHeight,
        selectedTagBackgroundColor: this.selectedTagBackgroundColor));
  }

  @override
  _BrnSelectTagState createState() => _BrnSelectTagState();
}

class _BrnSelectTagState extends State<BrnSelectTag> {
  List<bool> _tagState = [];

  @override
  void initState() {
    super.initState();
    _tagState = widget.tags.map((name) => false).toList();
    if (widget.initTagState != null) {
      for (int index = 0;
          index < min(widget.initTagState!.length, widget.tags.length);
          index++) {
        _tagState[index] = widget.initTagState![index];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (widget.softWrap) {
      content = Wrap(
        runSpacing: widget.verticalSpacing,
        spacing: widget.spacing,
        children: _tagWidgetList(context),
      );
    } else {
      content = _scrollTagListWidget(context);
    }

    return Align(
      child: content,
      alignment: widget.alignment,
    );
  }

  Widget _scrollTagListWidget(context) {
    var tagList = _tagWidgetList(context);
    int tagIdx = 0;
    var finalTagList = tagList.map((tag) {
      double rightPadding = (tagIdx == tagList.length - 1) ? 0 : widget.spacing;
      var padding = Padding(
        child: tag,
        padding: EdgeInsets.only(right: rightPadding),
      );
      tagIdx++;
      return padding;
    }).toList();
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: finalTagList,
        ));
  }

  List<Widget> _tagWidgetList(context) {
    List<Widget> list = [];
    for (int nameIndex = 0; nameIndex < widget.tags.length; nameIndex++) {
      Widget tagWidget = _tagWidgetAtIndex(nameIndex);
      GestureDetector gdt = GestureDetector(
          child: tagWidget,
          onTap: () {
            if (widget.isSingleSelect) {
              bool selected = _tagState[nameIndex];
              if (selected) {
                return;
              }
              _tagState = _tagState.map((value) => false).toList();
              setState(() {
                _tagState[nameIndex] = true;
              });
            } else {
              setState(() {
                _tagState[nameIndex] = !_tagState[nameIndex];
              });
            }

            if (null != widget.onSelect) {
              List<int> _selectedIndexes = [];
              for (int index = 0; index < _tagState.length; index++) {
                if (_tagState[index]) _selectedIndexes.add(index);
              }
              widget.onSelect!(_selectedIndexes);
            }
          });
      list.add(gdt);
    }
    return list;
  }

  Widget _tagWidgetAtIndex(int nameIndex) {
    bool selected = _tagState[nameIndex];
    Text tx = Text(
      widget.tags[nameIndex],
      style: selected ? _selectedTextStyle() : _tagTextStyle(),
      overflow: TextOverflow.ellipsis,
    );
    Container container = Container(
      constraints: BoxConstraints(minWidth: widget.themeData!.tagMinWidth),
      decoration: BoxDecoration(
          color: selected
              ? (widget.themeData!.selectedTagBackgroundColor.withOpacity(0.12))
              : (widget.themeData!.tagBackgroundColor),
          borderRadius: BorderRadius.circular(widget.themeData!.tagRadius)),
      width: widget.fixWidthMode ? widget.themeData!.tagWidth : null,
      height: widget.themeData!.tagHeight,
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Center(widthFactor: 1, child: tx),
    );
    return container;
  }

  TextStyle _tagTextStyle() {
    return widget.themeData!.tagTextStyle.generateTextStyle();
  }

  TextStyle _selectedTextStyle() {
    return widget.themeData!.selectTagTextStyle.generateTextStyle();
  }

  @override
  void didUpdateWidget(BrnSelectTag oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果两个数组不相等,重置选中状态
    if (!sameList(oldWidget.tags, widget.tags)) {
      _tagState = List.filled(widget.tags.length, false);
    }
  }

  /// 比较两个数组内容是否一致，如果一致，返回 true，否则 false
  bool sameList(List<String> first, List<String> second) {
    if (first.length != second.length) return false;
    int index = 0;
    return first.firstWhere((item) => item != second[index++],
            orElse: () => '') ==
        '';
  }
}
