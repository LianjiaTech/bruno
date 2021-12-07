import 'package:bruno/bruno.dart';
import 'package:bruno/src/components/form/base/brn_form_item_type.dart';
import 'package:bruno/src/components/form/base/input_item_interface.dart';
import 'package:bruno/src/components/form/utils/brn_form_util.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_form_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:bruno/src/utils/font/brn_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///
/// 递增/递减型录入项
///
/// 包括"标题"、"副标题"、"错误信息提示"、"必填项提示"、"添加/删除按钮"、"消息提示"、
/// "递增/递减按钮"等元素
///
class BrnStepInputFormItem extends StatefulWidget {
  /// 录入项的唯一标识，主要用于录入类型页面框架中
  final String label;

  /// 录入项类型，主要用于录入类型页面框架中
  String type = BrnInputItemType.TEXT_STEP_INPUT_TYPE;

  /// 录入项标题
  final String title;

  /// 录入项子标题
  final String subTitle;

  /// 录入项提示（问号图标&文案） 用户点击时触发onTip回调。
  /// 1. 若赋值为 空字符串（""）时仅展示"问号"图标，
  /// 2. 若赋值为非空字符串时 展示"问号图标&文案"，
  /// 3. 若不赋值或赋值为null时 不显示提示项
  /// 默认值为 3
  final String tipLabel;

  /// 录入项前缀图标样式 "添加项" "删除项" 详见 PrefixIconType类
  final String prefixIconType;

  /// 录入项错误提示
  final String error;

  /// 录入项是否为必填项（展示*图标） 默认为 false 不必填
  final bool isRequire;

  /// 录入项 是否可编辑
  final bool isEdit;

  /// 点击"+"图标回调
  final VoidCallback onAddTap;

  /// 点击"-"图标回调
  final VoidCallback onRemoveTap;

  /// 点击"？"图标回调
  final VoidCallback onTip;

  /// 特有字段
  int value;

  /// 单步上限值
  final int maxLimit;

  /// 单步下限值
  final int minLimit;

  /// 当前值变化回调
  final OnBrnFormValueChanged onChanged;

  /// form配置
  BrnFormItemConfig themeData;

  BrnStepInputFormItem(
      {Key key,
      this.label,
      this.title: "",
      this.subTitle,
      this.tipLabel,
      this.prefixIconType: BrnPrefixIconType.TYPE_NORMAL,
      this.error: "",
      this.isEdit: true,
      this.isRequire: false,
      this.onAddTap,
      this.onRemoveTap,
      this.onTip,
      this.value: 0,
      this.maxLimit: 10,
      this.minLimit: 0,
      this.onChanged,
      this.themeData, })
      : super(key: key) {

    this.themeData ??= BrnFormItemConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData.configId)
        .formItemConfig
        .merge(this.themeData);
  }


  @override
  BrnStepInputFormItemState createState() {
    return BrnStepInputFormItemState();
  }

}

class BrnStepInputFormItemState extends State<BrnStepInputFormItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: BrnFormUtil.itemEdgeInsets(widget.themeData),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: BrnFormUtil.titleEdgeInsets(
                      widget.prefixIconType, widget.isRequire, widget.themeData),
                  child: Row(
                    children: <Widget>[
                      BrnFormUtil.buildPrefixIcon(widget.prefixIconType, widget.isEdit, context, widget.onAddTap, widget.onRemoveTap),
                      BrnFormUtil.buildRequireWidget(widget.isRequire),
                      BrnFormUtil.buildTitleWidget(widget.title, widget.themeData),
                      BrnFormUtil.buildTipLabelWidget(widget.tipLabel, widget.onTip, widget.themeData),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (!isEnable()) {
                          return;
                        }

                        if (isReachMinLevel()) {
                          return;
                        }

                        if (widget.value == null) {
                          widget.value = 1;
                          BrnFormUtil.notifyValueChanged(
                              widget.onChanged, context, widget.value + 1, widget.value);
                          setState(() {});
                          return;
                        }

                        if (!isReachMinLevel()) {
                          widget.value = widget.value - 1;
                          BrnFormUtil.notifyValueChanged(
                              widget.onChanged, context, widget.value + 1, widget.value);
                          setState(() {});
                        }
                      },
                      child: Container(
                        child: getMinusIcon(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      child: Text(
                        "${widget.value}",
                        style: TextStyle(
                          color: Color(0xFF222222),
                          fontSize: BrnFont.FONT_16,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!isEnable()) {
                          return;
                        }

                        if (isReachMaxLevel()) {
                          return;
                        }

                        if (widget.value == null) {
                          widget.value = 1;
                          BrnFormUtil.notifyValueChanged(
                              widget.onChanged, context, widget.value - 1, widget.value);
                          setState(() {});
                          return;
                        }

                        if (!isReachMaxLevel()) {
                          widget.value = widget.value + 1;
                          BrnFormUtil.notifyValueChanged(
                              widget.onChanged, context, widget.value - 1, widget.value);
                          setState(() {});
                        }
                      },
                      child: Container(
                        child: getAddIcon(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 副标题
          BrnFormUtil.buildSubTitleWidget(widget.subTitle, widget.themeData),

          BrnFormUtil.buildErrorWidget(widget.error, widget.themeData)
        ],
      ),
    );
  }

  bool isEnable() {
    if (widget.isEdit == null) {
      return true;
    }

    return widget.isEdit;
  }

  Image getAddIcon() {
    if (widget.isEdit != null && !widget.isEdit) {
      return BrunoTools.getAssetImage(BrnAsset.ICON_ADD_DISABLE);
    }

    if (isReachMaxLevel()) {
      return BrunoTools.getAssetImage(BrnAsset.ICON_ADD_DISABLE);
    }

    return BrunoTools.getAssetImage(BrnAsset.ICON_ADD_ENABLE);
  }

  bool isReachMaxLevel() {
    int value = widget.value;

    if (widget.value == null) {
      return false;
    }

    if (value >= widget.maxLimit) {
      return true;
    }

    return false;
  }

  Image getMinusIcon() {
    if (widget.isEdit != null && !widget.isEdit) {
      return BrunoTools.getAssetImage(BrnAsset.ICON_MINUS_DISABLE);
    }

    if (isReachMinLevel()) {
      return BrunoTools.getAssetImage(BrnAsset.ICON_MINUS_DISABLE);
    }

    return BrunoTools.getAssetImage(BrnAsset.ICON_MINUS_ENABLE);
  }

  bool isReachMinLevel() {
    int value = widget.value;

    if (widget.value == null) {
      return false;
    }

    if (value <= widget.minLimit) {
      return true;
    }

    return false;
  }

}



