import 'package:bruno/src/components/appraise/brn_appraise.dart';
import 'package:bruno/src/components/appraise/brn_appraise_header.dart';
import 'package:bruno/src/components/appraise/brn_appraise_config.dart';
import 'package:flutter/material.dart';
import 'package:bruno/src/components/appraise/brn_appraise_interface.dart';

/// 描述: 评价组件bottom picker，
/// 对BrnAppraise做了一层封装，可直接使用在showDialog里面

class BrnAppraiseBottomPicker extends StatefulWidget {
  /// 标题
  final String title;

  /// 标题类型
  final BrnAppraiseHeaderType headerType;

  /// 评分组件类型，分为表情包和星星，默认星星
  final BrnAppraiseType type;

  /// 自定义文案
  /// 若评分组件为表情，则list长度为5，不足5个时请在对应位置补空字符串
  /// 若评分组件为星星，则list长度不能比count小
  final List<String> iconDescriptions;

  /// 标签
  final List<String>? tags;

  ///输入框允许提示文案
  final String inputHintText;

  /// 提交按钮的点击回调
  final BrnAppraiseConfirmClick? onConfirm;

  /// 评价组件的配置项
  final BrnAppraiseConfig config;

  /// 评价组建每个评分对应的默认文案
  static const List<String> _defaultIconDescriptions = [
    '不好',
    '还行',
    '满意',
    '很棒',
    '超惊喜'
  ];

  BrnAppraiseBottomPicker({
    Key? key,
    this.title = '',
    this.headerType = BrnAppraiseHeaderType.spaceBetween,
    this.type = BrnAppraiseType.star,
    this.iconDescriptions = _defaultIconDescriptions,
    this.tags,
    this.inputHintText = '',
    this.onConfirm,
    this.config = const BrnAppraiseConfig(),
  }) : super(key: key);

  @override
  _BrnAppraiseBottomPickerState createState() =>
      _BrnAppraiseBottomPickerState();
}

class _BrnAppraiseBottomPickerState extends State<BrnAppraiseBottomPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0x99000000),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: BrnAppraise(
          title: widget.title,
          headerType: widget.headerType,
          type: widget.type,
          iconDescriptions: widget.iconDescriptions,
          tags: widget.tags,
          inputHintText: widget.inputHintText,
          onConfirm: (index, list, input) {
            if (widget.onConfirm != null) {
              widget.onConfirm!(index, list, input);
            }
          },
          config: widget.config,
        ),
      ),
    );
  }
}
