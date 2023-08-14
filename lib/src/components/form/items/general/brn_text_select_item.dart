import 'dart:math';

import 'package:bruno/src/components/form/base/brn_form_item_type.dart';
import 'package:bruno/src/components/form/utils/brn_form_util.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_form_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:bruno/src/constants/brn_fonts_constants.dart';
import 'package:flutter/material.dart';

///
/// 选择型表单项
///
/// 包括"标题"、"副标题"、"错误信息提示"、"必填项提示"、"添加/删除按钮"、"消息提示"、
/// "单选项"等元素
///
/// 点击右侧文本显示区域后触发 onTap 回调函数，用户可在此回调函数中执行启动弹框，跳转页面等操作
///
// ignore: must_be_immutable
class BrnTextSelectFormItem extends StatefulWidget {

  /// 录入项的唯一标识，主要用于录入类型页面框架中
  final String? label;

  /// 录入项类型，主要用于录入类型页面框架中
  final String title;

  /// 录入项标题
  final String? subTitle;

  /// 录入项子标题
  final String? tipLabel;

  /// 录入项提示（问号图标&文案） 用户点击时触发onTip回调。
  /// 1. 若赋值为 空字符串（""）时仅展示"问号"图标，
  /// 2. 若赋值为非空字符串时 展示"问号图标&文案"，
  /// 3. 若不赋值或赋值为null时 不显示提示项
  /// 默认值为 3
  final String prefixIconType;

  /// 录入项前缀图标样式 "添加项" "删除项" 详见 PrefixIconType类
  final String error;

  /// 录入项错误提示

  final bool isRequire;

  /// 录入项是否为必填项（展示*图标） 默认为 false 不必填
  final bool isEdit;

  /// 点击"+"图标回调
  final VoidCallback? onAddTap;

  /// 点击"-"图标回调
  final VoidCallback? onRemoveTap;

  /// 点击"？"图标回调
  final VoidCallback? onTip;

  /// 点击录入区回调
  final VoidCallback? onTap;

  /// 录入项 hint 提示
  final String? hint;

  /// 录入项 值
  final String? value;

  /// 选中文本最大行数
  final int valueMaxLines;

  /// title最大行数
  final int? titleMaxLines;

  ///是否自动布局
  bool? _isAutoLayout;

  /// 行布局比例值   左边「标题+问号+提示语」  右边「选项值」
  /// 左:右 比例值  例如  左:右 = 6:4   则 ratio = 1.5
  double? layoutRatio;

  /// 背景色
  final Color? backgroundColor;

  /// form配置
  BrnFormItemConfig? themeData;

  BrnTextSelectFormItem({
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
    this.hint,
    this.value,
    this.valueMaxLines = 1,
    this.titleMaxLines,
    this.onTap,
    this.backgroundColor,
    this.themeData,
  }) : super(key: key) {
    this._isAutoLayout = false;
    this.themeData ??= BrnFormItemConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .formItemConfig
        .merge(this.themeData);
    this.themeData = this
        .themeData!
        .merge(BrnFormItemConfig(backgroundColor: backgroundColor));
  }

  BrnTextSelectFormItem.autoLayout(
      {Key? key,
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
      this.hint,
      this.value,
      this.valueMaxLines = 1,
      this.titleMaxLines,
      this.onTap,
      this.layoutRatio,
      this.backgroundColor,
      this.themeData})
      : super(key: key) {
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
  BrnTextSelectFormItemState createState() {
    return BrnTextSelectFormItemState();
  }
}

double _fontSize = BrnFonts.f16;
StrutStyle _contentStructStyle = StrutStyle(
    forceStrutHeight: true, height: 1, leading: 0.5, fontSize: _fontSize);

class BrnTextSelectFormItemState extends State<BrnTextSelectFormItem> {
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
    double contentRatio = BrnFormUtil.getAutoLayoutContentRatio(
        tipLabelHidden: widget.tipLabel == null || widget.tipLabel!.isEmpty,
        layoutRatio: widget.layoutRatio);
    double maxWidth = min(
        constraints.maxWidth * contentRatio,
        _calculateTextWidth(context) +
            BrnFormUtil.rightArrowLeftPadding +
            BrnFormUtil.rightArrowSize);
    return maxWidth;
  }

  // 当左右内容超出默认比例且「有」提示语，则按比例  6:4 布局
  // 当左右内容超出默认比例且「无」提示语，则按比例  4:6 布局
  // 当有右侧内容小于默认比例，则左侧会自动填充空白区域
  // 当左侧标题显示不下时折行展示
  // 当有用户自定义比例时用用户自定义比例
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
                  _buildTipWidget(),
                ],
              ),
            ),
          ),

          // 文案选择区
          Container(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: _buildRightWidget(context),
            ),
          ),
        ],
      );
    });
  }

  // 右侧区域
  GestureDetector _buildRightWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isEdit) {
          return;
        }

        BrnFormUtil.notifyTap(context, widget.onTap);
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: buildText()),
            Container(
              height: calculateTextHeight(
                  context, getCalculateText(), _fontSize, 1),
              alignment: Alignment.center,
              child: BrnFormUtil.getRightArrowIcon(),
            ),
          ],
        ),
      ),
    );
  }

  // 提示语
  Widget _buildTipWidget() {
    return Offstage(
      offstage: (widget.tipLabel == null),
      child: GestureDetector(
        onTap: () {
          if (widget.onTip != null) {
            widget.onTip!();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                strutStyle: StrutStyle(
                    forceStrutHeight: true,
                    height: 1,
                    leading: 0.5,
                    fontSize: BrnFonts.f14),
                style: BrnFormUtil.getTipsTextStyle(widget.themeData!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 标题widget
  Widget _buildTitleTextWidget() {
    return Text(
      widget.title,
      overflow: widget.titleMaxLines == null
          ? TextOverflow.clip
          : TextOverflow.ellipsis,
      maxLines: widget.titleMaxLines,
      strutStyle: _contentStructStyle,
      style: BrnFormUtil.getTitleTextStyle(widget.themeData!, height: 1),
    );
  }

  // 标题widget
  Row _buildTitleWidget(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: BrnFormUtil.titleEdgeInsets(
              widget.prefixIconType, widget.isRequire, widget.themeData!),
          child: Row(
            children: <Widget>[
              BrnFormUtil.buildPrefixIcon(widget.prefixIconType, widget.isEdit,
                  context, widget.onAddTap, widget.onRemoveTap),
              BrnFormUtil.buildRequireWidget(widget.isRequire),
              _buildTitleTextWidget(),
              _buildTipWidget(),
            ],
          ),
        ),

        // 文案选择区
        Expanded(
          child: _buildRightWidget(context),
        ),
      ],
    );
  }

  // 计算Text所占宽度
  double _calculateTextWidth(BuildContext context) {
    TextPainter painter;
    if (widget.value != null && widget.value!.isNotEmpty) {
      painter = TextPainter(
          locale: Localizations.localeOf(context),
          textAlign: TextAlign.end,
          textDirection: TextDirection.ltr,
          strutStyle: _contentStructStyle,
          text: TextSpan(
            text: widget.value,
            style: BrnFormUtil.getIsEditTextStyle(
                widget.themeData!, widget.isEdit,
                height: 1),
          ));
    } else {
      painter = TextPainter(
          locale: Localizations.localeOf(context),
          textAlign: TextAlign.end,
          textDirection: TextDirection.ltr,
          strutStyle: _contentStructStyle,
          text: TextSpan(
            text: widget.hint ??
                BrnIntl.of(context).localizedResource.pleaseChoose,
            style: BrnFormUtil.getHintTextStyle(widget.themeData!, height: 1),
          ));
    }
    painter.layout();

    //文字的高度:painter.height
    return painter.width;
  }

  Widget buildText() {
    if (widget.value != null && widget.value!.isNotEmpty) {
      return Text(
        widget.value!,
        overflow: TextOverflow.ellipsis,
        maxLines: widget.valueMaxLines,
        textAlign: TextAlign.end,
        strutStyle: _contentStructStyle,
        style: BrnFormUtil.getIsEditTextStyle(widget.themeData!, widget.isEdit,
            height: 1),
      );
    } else {
      return Text(
        widget.hint ?? BrnIntl.of(context).localizedResource.pleaseChoose,
        textAlign: TextAlign.end,
        strutStyle: _contentStructStyle,
        style: BrnFormUtil.getHintTextStyle(widget.themeData!, height: 1),
      );
    }
  }

  String getCalculateText() {
    String value = BrnIntl.of(context).localizedResource.pleaseChoose;
    if (!BrunoTools.isEmpty(widget.value)) {
      value = widget.value!;
    } else if (!BrunoTools.isEmpty(widget.hint)) {
      value = widget.hint ?? BrnIntl.of(context).localizedResource.pleaseChoose;
    }
    return value;
  }

  // value: 文本内容；
  // fontSize : 文字的大小；
  // maxLines：文本支持最大多少行
  static double calculateTextHeight(
      BuildContext context, String? value, double fontSize, int maxLines) {
    TextPainter painter = TextPainter(

        // AUTO：华为手机如果不指定locale的时候，该方法算出来的文字高度是比系统计算偏小的。
        locale: Localizations.localeOf(context),
        maxLines: maxLines,
        textAlign: TextAlign.end,
        textDirection: TextDirection.ltr,
        strutStyle: _contentStructStyle,
        text: TextSpan(
            text: value,
            style: TextStyle(
              height: 1,
              fontSize: fontSize,
            )));
    painter.layout();

    // 文字的高度:painter.height
    return painter.height < fontSize ? fontSize : painter.height;
  }
}
