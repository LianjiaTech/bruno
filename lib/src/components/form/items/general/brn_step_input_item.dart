import 'package:bruno/src/components/form/base/brn_form_item_type.dart';
import 'package:bruno/src/components/form/base/input_item_interface.dart';
import 'package:bruno/src/components/form/utils/brn_form_util.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/constants/brn_fonts_constants.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// 递增/递减型录入项
///
/// 包括"标题"、"副标题"、"错误信息提示"、"必填项提示"、"添加/删除按钮"、"消息提示"、
/// "递增/递减按钮"等元素
///
// ignore: must_be_immutable
class BrnStepInputFormItem extends StatefulWidget {
  /// 录入项的唯一标识，主要用于录入类型页面框架中
  final String? label;

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

  /// 点击"+"图标回调
  final VoidCallback? onAddTap;

  /// 点击"-"图标回调
  final VoidCallback? onRemoveTap;

  /// 点击"？"图标回调
  final VoidCallback? onTip;

  /// 特有字段
  final int? value;

  /// 单步上限值
  final int maxLimit;

  /// 单步下限值
  final int minLimit;

  /// 当前值变化回调
  final OnBrnFormValueChanged? onChanged;

  /// 是否可通过键盘手动输入内容
  final bool canManualInput;

  final TextEditingController? controller;

  /// form配置
  BrnFormItemConfig? themeData;

  /// 背景色
  final Color? backgroundColor;

  BrnStepInputFormItem({
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
    this.maxLimit = 10,
    this.minLimit = 0,
    this.onChanged,
    this.canManualInput = false,
    this.controller,
    this.backgroundColor,
    this.themeData,
  }) : super(key: key) {
    if (value != null) {
      assert(value! >= minLimit && value! <= maxLimit);
    }
    if (controller != null) {
      int? defaultValue = int.tryParse(controller!.text);
      assert(defaultValue == null || (defaultValue >= minLimit && defaultValue <= maxLimit),
          'The text or value in the controller is not in the limits.');
    }
    this.themeData ??= BrnFormItemConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .formItemConfig
        .merge(this.themeData);
    this.themeData = this.themeData!.merge(
        BrnFormItemConfig(backgroundColor: backgroundColor));
  }

  @override
  BrnStepInputFormItemState createState() {
    return BrnStepInputFormItemState();
  }
}

class BrnStepInputFormItemState extends State<BrnStepInputFormItem> {
  late TextEditingController _textEditingController;
  late int _oldValue;
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _textEditingController = TextEditingController();
      _textEditingController.text = (widget.value ?? 0).toString();
    } else {
      _textEditingController = widget.controller!;
    }
    _oldValue = _value;
    _textEditingController.addListener(_onControllerTextChangedHandleTicker);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_onControllerTextChangedHandleTicker);
    super.dispose();
  }

  void _onControllerTextChangedHandleTicker() {
    if (_oldValue != _value) {
      BrnFormUtil.notifyValueChanged(widget.onChanged, context, _oldValue, _value);
      setState(() {});
      _oldValue = _value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.themeData!.backgroundColor,
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
                  padding: BrnFormUtil.titleEdgeInsets(
                      widget.prefixIconType, widget.isRequire, widget.themeData!),
                  child: Row(
                    children: <Widget>[
                      BrnFormUtil.buildPrefixIcon(widget.prefixIconType, widget.isEdit, context,
                          widget.onAddTap, widget.onRemoveTap),
                      BrnFormUtil.buildRequireWidget(widget.isRequire),
                      BrnFormUtil.buildTitleWidget(widget.title, widget.themeData!),
                      BrnFormUtil.buildTipLabelWidget(
                          widget.tipLabel, widget.onTip, widget.themeData!),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (!widget.isEdit) {
                          return;
                        }
                        _checkReachMinLevel();
                      },
                      child: Container(
                        child: _getMinusIcon(),
                      ),
                    ),
                    _buildValueWidget(),
                    GestureDetector(
                      onTap: () {
                        if (!widget.isEdit) {
                          return;
                        }
                        _checkReachMaxLevel();
                      },
                      child: Container(
                        child: _getAddIcon(),
                      ),
                    ),
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

  Image _getAddIcon() {
    if (!widget.isEdit) {
      return BrunoTools.getAssetImage(BrnAsset.iconAddDisable);
    }

    if (_isReachMaxLevel()) {
      return BrunoTools.getAssetImage(BrnAsset.iconAddDisable);
    }

    return BrunoTools.getAssetImage(BrnAsset.iconAddEnable);
  }

  bool _isReachMaxLevel() {
    if (_value >= widget.maxLimit) {
      return true;
    }
    return false;
  }

  Image _getMinusIcon() {
    if (!widget.isEdit) {
      return BrunoTools.getAssetImage(BrnAsset.iconMinusDisable);
    }

    if (_isReachMinLevel()) {
      return BrunoTools.getAssetImage(BrnAsset.iconMinusDisable);
    }

    return BrunoTools.getAssetImage(BrnAsset.iconMinusEnable);
  }

  bool _isReachMinLevel() {
    if (_value <= widget.minLimit) {
      return true;
    }
    return false;
  }

  Widget _buildValueWidget() {
    if (widget.canManualInput) {
      return Container(
        alignment: Alignment.center,
        width: 50,
        child: TextField(
          maxLines: 1,
          minLines: 1,
          enabled: widget.isEdit,
          textAlign: TextAlign.center,
          controller: _textEditingController,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            RangeLimitedTextInputFormatter(minValue: widget.minLimit, maxValue: widget.maxLimit)
          ],
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: BrnFonts.f16,
          ),
          decoration: InputDecoration(
            hintText: '0',
            hintStyle: TextStyle(
              color: Color(0xFFCCCCCC),
              fontSize: BrnFonts.f16,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(0),
            isDense: true,
          ),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        width: 50,
        child: Text(
          "$_value",
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: BrnFonts.f16,
          ),
        ),
      );
    }
  }

  void _checkReachMinLevel() {
    if (!_isReachMinLevel()) {
      _value = _value - 1;
      return;
    }
  }

  void _checkReachMaxLevel() {
    if (!_isReachMaxLevel()) {
      _value = _value + 1;
      return;
    }
  }

  int get _value => int.tryParse(_textEditingController.text) ?? 0;

  set _value(int value) {
    // 如果是通过代码设置TextField的值，就将光标移动到最后
    _textEditingController.value = TextEditingValue(
        text: value.toString(),
        selection: TextSelection.fromPosition(
            TextPosition(offset: value.toString().length)));
  }
}

class RangeLimitedTextInputFormatter extends TextInputFormatter {
  int minValue;
  int maxValue;

  RangeLimitedTextInputFormatter({this.minValue = 0, this.maxValue = 0});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int? newNum = int.tryParse(newValue.text);
    if (newNum == null && minValue == 0) {
      return const TextEditingValue(
          text: '', selection: TextSelection.collapsed(offset: 0));
    } else if (newNum != null && minValue <= newNum && newNum <= maxValue) {
      /// perf issue:#458，eg. '020' should displayed as '20'
      if (newNum.toString() != newValue.text) {
        return TextEditingValue(
            text: newNum.toString(),
            selection: TextSelection.collapsed(offset: newNum.toString().length));
      } else {
        return newValue;
      }
    } else {
      return oldValue;
    }
  }
}
