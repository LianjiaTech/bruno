import 'dart:math';

import 'package:bruno/src/components/form/base/brn_form_item_type.dart';
import 'package:bruno/src/components/form/base/input_item_interface.dart';
import 'package:bruno/src/components/form/utils/brn_form_util.dart';
import 'package:bruno/src/components/radio/brn_radio_button.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_form_config.dart';
import 'package:flutter/material.dart';

///
/// 横向单选录入项
///
/// 包括"标题"、"副标题"、"错误信息提示"、"必填项提示"、"添加/删除按钮"、"消息提示"、
/// "单选项"等元素
///
// ignore: must_be_immutable
class BrnRadioInputFormItem extends StatefulWidget {
  /// 录入项的唯一标识，主要用于录入类型页面框架中
  final String? label;

  /// 录入项标题
  final String title;

  /// 录入项子标题
  final String? subTitle;

  /// 录入项提示（问号图标&文案） 用户点击时触发onTip回调。
  /// 1. 若赋值为 空字符串（""）时仅展示"问号"图标，
  /// 2. 若赋值为非空字符串时 展示"问号图标&文案"，
  /// 3. 若不赋值或赋值为null时 不显示提示项，默认值为 3
  final String? tipLabel;

  /// 录入项前缀图标样式 "添加项" "删除项" 详见 PrefixIconType类
  final String prefixIconType;

  /// 录入项错误提示
  final String error;

  /// 录入项是否为必填项（展示*图标） 默认为 false 不必填
  final bool isRequire;

  /// 录入项 是否可编辑
  final bool isEdit;

  /// 点击"+"图标回调
  final VoidCallback? onAddTap;

  /// 点击"-"图标回调
  final VoidCallback? onRemoveTap;

  /// 点击"？"图标回调
  final VoidCallback? onTip;

  /// 录入项 值
  String? value;

  /// 选项
  List<String>? options;

  /// 局部禁用list
  List<bool>? enableList;

  /// 选项选中状态变化回调
  final OnBrnFormRadioValueChanged? onChanged;

  /// 标题显示的最大行数，默认值 1
  final int? titleMaxLines;

  /// 左边标题部分/右边选项部分的宽度比例。例如 1/2 显示就传 0.5。
  /// 右边选项部分的显示宽度 = min(选项部分的实际宽度, 选项部分的比例计算宽度)
  double? layoutRatio;

  /// 是否自动布局
  bool? _isAutoLayout;

  /// 背景色
  final Color? backgroundColor;

  /// form配置
  BrnFormItemConfig? themeData;

  BrnRadioInputFormItem({
    Key? key,
    this.label,
    this.title = "",
    this.subTitle,
    this.tipLabel,
    this.prefixIconType = BrnPrefixIconType.normal,
    this.error = "",
    this.isEdit = true,
    this.isRequire = false,
    this.onAddTap,
    this.onRemoveTap,
    this.onTip,
    this.value,
    this.options,
    this.enableList,
    this.onChanged,
    this.themeData,
    this.backgroundColor,
    this.titleMaxLines,
  }) : super(key: key) {
    this.themeData ??= BrnFormItemConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .formItemConfig
        .merge(this.themeData);
    this.themeData = this
        .themeData!
        .merge(BrnFormItemConfig(backgroundColor: backgroundColor));
    this._isAutoLayout = false;
  }

  BrnRadioInputFormItem.autoLayout({
    Key? key,
    this.label,
    this.title = "",
    this.subTitle,
    this.tipLabel,
    this.prefixIconType = BrnPrefixIconType.normal,
    this.error = "",
    this.isEdit = true,
    this.isRequire = false,
    this.onAddTap,
    this.onRemoveTap,
    this.onTip,
    this.value,
    this.options,
    this.enableList,
    this.onChanged,
    this.titleMaxLines,
    this.layoutRatio,
    this.backgroundColor,
    this.themeData,
  }) : super(key: key) {
    this._isAutoLayout = true;
    this.themeData ??= BrnFormItemConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .formItemConfig
        .merge(this.themeData);
    this.themeData = this
        .themeData!
        .merge(BrnFormItemConfig(backgroundColor: backgroundColor));
  }

  @override
  BrnRadioInputFormItemState createState() {
    return BrnRadioInputFormItemState();
  }
}

class BrnRadioInputFormItemState extends State<BrnRadioInputFormItem> {
  double _kRadioTitleLeftPadding = 6;
  double _kRadioIconWidth = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.themeData!.backgroundColor,
      padding: BrnFormUtil.itemEdgeInsets(widget.themeData!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget._isAutoLayout ?? false
              ? _buildAutoLayoutTitleWidget(context)
              : _buildTitleWidget(context),
          // 副标题
          BrnFormUtil.buildSubTitleWidget(widget.subTitle, widget.themeData!),

          // 错误提示
          BrnFormUtil.buildErrorWidget(widget.error, widget.themeData!)
        ],
      ),
    );
  }

  double _getTitleMaxWidth(BuildContext context, BoxConstraints constraints) {
    // 计算表单右边部分的宽度
    double contentRatio = BrnFormUtil.getAutoLayoutContentRatio(
        tipLabelHidden: widget.tipLabel == null || widget.tipLabel!.isEmpty,
        layoutRatio: widget.layoutRatio);
    double ratioWidth = constraints.maxWidth * contentRatio;
    double maxWidth = min(ratioWidth, _calculateTextWidth(context));
    return maxWidth;
  }

  Widget _buildAutoLayoutTitleWidget(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double maxWidth = _getTitleMaxWidth(context, constraints);
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Container(
              padding: BrnFormUtil.titleEdgeInsets(
                  widget.prefixIconType, widget.isRequire, widget.themeData!),
              child: Row(
                children: <Widget>[
                  BrnFormUtil.buildPrefixIcon(
                      widget.prefixIconType,
                      widget.isEdit,
                      context,
                      widget.onAddTap,
                      widget.onRemoveTap),
                  BrnFormUtil.buildRequireWidget(widget.isRequire),
                  Flexible(child: _buildTitleTextWidget()),
                  _buildTipWidget()
                ],
              ),
            ),
          ),

          /// 选项选择区
          Container(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: _buildRightWidget(),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildTipWidget() {
    return Offstage(
      offstage: (widget.tipLabel == null /*|| widget.tipLabel.isEmpty*/),
      child: GestureDetector(
        onTap: () {
          if (widget.onTip != null) {
            widget.onTip!();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 6, right: 7),
                child: BrnFormUtil.getQuestionMarkIcon()),
            Container(
              constraints: BoxConstraints(
                  maxWidth: widget._isAutoLayout ?? false
                      ? BrnFormUtil.tipDescMaxWidth
                      : double.infinity),
              child: Text(
                widget.tipLabel ?? "",
                overflow: TextOverflow.ellipsis,
                style: BrnFormUtil.getTipsTextStyle(widget.themeData!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightWidget() {
    /// 单选项
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: getRadioList(widget.options),
    );
  }

  /// 计算Text所占宽度
  double _calculateTextWidth(BuildContext context) {
    List<String>? options = widget.options;
    // 计算所有备选文案的文字长度
    double totalTextWidth = 0;
    if (options != null && options.isNotEmpty) {
      int idx = -1;
      for (String? item in options) {
        idx += 1;
        TextStyle? optionStyle = getOptionTextStyle(item, idx);
        TextPainter painter = TextPainter(
            locale: Localizations.localeOf(context),
            textAlign: TextAlign.start,
            textDirection: TextDirection.ltr,
            text: TextSpan(text: item, style: optionStyle));
        painter.layout();

        // 6 是备选文案和单选按钮之间的间距
        // 16 是 radio 按钮的宽度
        double optionWidth = painter.width +
            BrnFormUtil.optionsMiddlePadding(widget.themeData!)!.left +
            _kRadioTitleLeftPadding +
            _kRadioIconWidth;
        totalTextWidth += optionWidth;
      }
    }
    return totalTextWidth;
  }

  Widget _buildTitleTextWidget() {
    return Text(widget.title,
        overflow: widget.titleMaxLines == null
            ? TextOverflow.clip
            : TextOverflow.ellipsis,
        maxLines: widget.titleMaxLines,
        style: BrnFormUtil.getTitleTextStyle(widget.themeData!));
  }

  Row _buildTitleWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 25,
          ),
          child: Container(
            padding: BrnFormUtil.titleEdgeInsets(
                widget.prefixIconType, widget.isRequire, widget.themeData!),
            child: Row(
              children: <Widget>[
                // 添加/删除图标
                BrnFormUtil.buildPrefixIcon(
                    widget.prefixIconType,
                    widget.isEdit,
                    context,
                    widget.onAddTap,
                    widget.onRemoveTap),
                // 必填项 "*" 图标
                BrnFormUtil.buildRequireWidget(widget.isRequire),

                // 主标题
                Container(child: _buildTitleTextWidget()),

                // 问号图标
                _buildTipWidget(),
              ],
            ),
          ),
        ),

        /// 单选项
        Expanded(
          child: _buildRightWidget(),
        ),
      ],
    );
  }

  List<Widget> getRadioList(List<String>? options) {
    List<Widget> result = [];
    String? option;
    if (options == null || options.isEmpty) {
      result.add(Container());
      return result;
    }

    for (int index = 0; index < options.length; ++index) {
      option = options[index];

      result.add(
        Container(
          padding: BrnFormUtil.optionsMiddlePadding(widget.themeData!),
          child: Row(
            children: <Widget>[
              BrnRadioButton(
                iconPadding: const EdgeInsets.all(0),
                child: Container(
                    padding: EdgeInsets.only(left: _kRadioTitleLeftPadding),
                    child: Text(
                      option,
                      style: getOptionTextStyle(option, index),
                    )),
                disable: getRadioEnableState(index),
                radioIndex: index,
                isSelected:
                    index == widget.options!.indexOf(widget.value ?? ''),
                onValueChangedAtIndex: (int position, bool selected) {
                  if (getRadioEnableState(position)) {
                    return;
                  }

                  String? oldValue = widget.value;
                  widget.value = options[index];
                  BrnFormUtil.notifyRadioStatusChanged(
                      widget.onChanged, context, oldValue, widget.value);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      );
    }

    return result;
  }

  TextStyle getOptionTextStyle(String? opt, int index) {
    TextStyle result = BrnFormUtil.getOptionTextStyle(widget.themeData!);
    if (opt == null) {
      return result;
    }

    if (opt == widget.value) {
      result = BrnFormUtil.getOptionSelectedTextStyle(widget.themeData!);
    }

    if (!widget.isEdit) {
      result = BrnFormUtil.getIsEditTextStyle(widget.themeData!, widget.isEdit);
    }

    if (widget.enableList != null &&
        widget.enableList!.isNotEmpty &&
        widget.enableList!.length > index &&
        !widget.enableList![index]) {
      result = BrnFormUtil.getIsEditTextStyle(widget.themeData!, false);
    }

    return result;
  }

  bool getRadioEnableState(int index) {
    if (!widget.isEdit) {
      return true;
    }

    if (widget.enableList == null ||
        widget.enableList!.isEmpty ||
        widget.enableList!.length < index) {
      return false;
    }

    return !widget.enableList![index];
  }
}
