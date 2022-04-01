

import 'package:bruno/src/components/form/base/brn_form_item_type.dart';
import 'package:bruno/src/components/form/utils/brn_form_util.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_form_config.dart';
import 'package:bruno/src/constants/brn_fonts_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// 范围输入型录入项
///
/// 包括"标题"、"副标题"、"错误信息提示"、"必填项提示"、"添加/删除按钮"、"消息提示"、
/// "输入框"等元素
///
// ignore: must_be_immutable
class BrnRangeInputFormItem extends StatefulWidget {
  /// 录入项的唯一标识，主要用于录入类型页面框架中
  final String? label;

  /// 录入项类型，主要用于录入类型页面框架中
  String type = BrnInputItemType.textRangeInputType;

  /// 录入项标题
  final String title;

  /// 录入项子标题
  final String? subTitle;

  /// 录入项提示（问号图标&文案） 用户点击时触发onTip回调。
  /// 1. 若赋值为 空字符串（""）时仅展示"问号"图标，
  /// 2. 若赋值为非空字符串时 展示"问号图标&文案"，
  /// 3. 若不赋值或赋值为null时 不显示提示项
  /// 默认值为 3
  final String? tipLabel;

  /// 录入项前缀图标样式 "添加项" "删除项" 详见 PrefixIconType类
  final String prefixIconType;

  /// 录入项错误提示
  final String error;

  /// 录入项是否为必填项（展示*图标） 默认为 false 不必填
  final bool isRequire;

  /// 录入项 是否可编辑
  final bool isEdit;

  /// 录入项不可编辑时(isEdit: false) "+"、"-"号是否可点击
  /// true: 可点击回调 false: 不可点击回调
  /// 默认值: false
  final bool isPrefixIconEnabled;

  /// 点击"+"图标回调
  final VoidCallback? onAddTap;

  /// 点击"-"图标回调
  final VoidCallback? onRemoveTap;

  /// 点击"？"图标回调
  final VoidCallback? onTip;

  /// 最小值提示语
  final String hintMin;

  /// 最大值提示语
  final String hintMax;

  /// 最小值单位
  final String? minUnit;

  /// 最大值单位
  final String? maxUnit;

  /// 最小值输入框最大字符数
  final int? leftMaxCount;

  /// 最大值输入框最大字符数
  final int? rightMaxCount;

  /// 输入内容类型，参见[BrnInputType]
  final String? inputType;

  final TextEditingController? minController;
  final TextEditingController? maxController;
  List<TextInputFormatter>? minInputFormatters;
  List<TextInputFormatter>? maxInputFormatters;

  /// 最小值输入回调
  final ValueChanged<String>? onMinChanged;

  /// 最大值输入回调
  final ValueChanged<String>? onMaxChanged;

  /// form配置
  BrnFormItemConfig? themeData;

  BrnRangeInputFormItem(
      {Key? key,
      this.label,
      this.title: "",
      this.subTitle,
      this.tipLabel,
      this.prefixIconType: BrnPrefixIconType.normal,
      this.error: "",
      this.isEdit: true,
      this.isRequire: false,
      this.isPrefixIconEnabled: false,
      this.onAddTap,
      this.onRemoveTap,
      this.onTip,
      this.hintMin: '最小',
      this.hintMax: '最大',
      this.minUnit,
      this.maxUnit,
      this.leftMaxCount,
      this.rightMaxCount,
      this.inputType,
      this.onMinChanged,
      this.onMaxChanged,
      this.minController,
      this.maxController,
      this.minInputFormatters,
      this.maxInputFormatters,
      this.themeData})
      : super(key: key) {
    this.themeData ??= BrnFormItemConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .formItemConfig
        .merge(this.themeData);
  }

  @override
  BrnRangeInputFormItemState createState() {
    return BrnRangeInputFormItemState();
  }
}

class BrnRangeInputFormItemState extends State<BrnRangeInputFormItem> {
  late TextEditingController _minController;
  late TextEditingController _maxController;
  late BrnFormItemConfig config;

  @override
  void initState() {
    config = BrnThemeConfigurator.instance.getConfig().formItemConfig;
    _minController = widget.minController ?? TextEditingController();
    _maxController = widget.maxController ?? TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: BrnFormUtil.itemEdgeInsets(widget.themeData!),
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
                  padding: BrnFormUtil.titleEdgeInsets(widget.prefixIconType,
                      widget.isRequire, widget.themeData!),
                  child: Row(
                    children: <Widget>[
                      BrnFormUtil.buildPrefixIcon(
                          widget.prefixIconType,
                          widget.isEdit,
                          context,
                          widget.onAddTap,
                          widget.onRemoveTap),
                      BrnFormUtil.buildRequireWidget(widget.isRequire),
                      BrnFormUtil.buildTitleWidget(
                          widget.title, widget.themeData!),
                      BrnFormUtil.buildTipLabelWidget(
                          widget.tipLabel, widget.onTip, widget.themeData!),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 50,
                        ),
                        child: TextField(
                          keyboardType:
                              BrnFormUtil.getInputType(widget.inputType),
                          enabled: widget.isEdit,
                          maxLines: 1,
                          maxLength: widget.leftMaxCount,
                          style: BrnFormUtil.getIsEditTextStyle(
                              widget.themeData!, widget.isEdit),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle:
                                BrnFormUtil.getHintTextStyle(widget.themeData!),
                            hintText: widget.hintMin,
                            counterText: "",
                            contentPadding: EdgeInsets.all(0),
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                          ),
                          textAlign: TextAlign.end,
                          controller: _minController,
                          onChanged: (text) {
                            BrnFormUtil.notifyInputChanged(
                                widget.onMinChanged, text);
                          },
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          widget.minUnit ?? "",
                          style: TextStyle(
                            color: Color(0xFF101010),
                            fontSize: BrnFonts.f16,
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 20, right: 6),
                        child: Text(
                          "—",
                          style: TextStyle(
                            color: Color(0xFF101010),
                            fontSize: BrnFonts.f16,
                          ),
                        )),
                    Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 50,
                        ),
                        child: TextField(
                          keyboardType:
                              BrnFormUtil.getInputType(widget.inputType),
                          enabled: widget.isEdit,
                          maxLines: 1,
                          maxLength: widget.rightMaxCount,
                          style: BrnFormUtil.getIsEditTextStyle(
                              widget.themeData!, widget.isEdit),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle:
                                BrnFormUtil.getHintTextStyle(widget.themeData!),
                            hintText: widget.hintMax,
                            counterText: "",
                            contentPadding: EdgeInsets.all(0),
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                          ),
                          textAlign: TextAlign.end,
                          controller: _maxController,
                          onChanged: (text) {
                            BrnFormUtil.notifyInputChanged(
                                widget.onMaxChanged, text);
                          },
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          widget.maxUnit ?? "",
                          style: TextStyle(
                            color: Color(0xFF101010),
                            fontSize: BrnFonts.f16,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),

          // 副标题
          BrnFormUtil.buildSubTitleWidget(widget.subTitle, widget.themeData!),

          BrnFormUtil.buildErrorWidget(widget.error, widget.themeData!)
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // 如果controller由外部创建不需要销毁, 若由内部创建则需要销毁
    _minController.dispose();
    _maxController.dispose();
  }
}
