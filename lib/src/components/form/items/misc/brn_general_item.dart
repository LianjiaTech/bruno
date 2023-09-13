import 'package:bruno/src/components/form/base/brn_form_item_type.dart';
import 'package:bruno/src/components/form/utils/brn_form_util.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BrnGeneralFormItem extends StatefulWidget {
  /// 录入项的唯一标识，主要用于录入类型页面框架中
  final String? label;

  /// 录入项标题
  final String title;

  /// 录入项子标题
  final Widget? titleWidget;

  /// 录入项子标题
  final String? subTitle;

  /// 录入项子标题 widget
  final Widget? subTitleWidget;

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

  /// 右侧操作widget
  final Widget? operateWidget;

  /// 背景色
  final Color? backgroundColor;

  /// form配置
  BrnFormItemConfig? themeData;

  BrnGeneralFormItem({
    Key? key,
    this.label,
    this.title = "",
    this.titleWidget,
    this.subTitle,
    this.subTitleWidget,
    this.tipLabel,
    this.prefixIconType = BrnPrefixIconType.normal,
    this.error = "",
    this.isEdit = true,
    this.isRequire = false,
    this.operateWidget,
    this.onAddTap,
    this.onRemoveTap,
    this.onTip,
    this.backgroundColor,
    this.themeData,
  }) : super(key: key) {
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
  State<StatefulWidget> createState() {
    return BrnGeneralFormItemState();
  }
}

class BrnGeneralFormItemState extends State<BrnGeneralFormItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.themeData!.backgroundColor,
      padding: BrnFormUtil.itemEdgeInsets(widget.themeData!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: BrnFormUtil.titleEdgeInsets(
                    widget.prefixIconType, widget.isRequire, widget.themeData!),
                child: Row(
                  children: <Widget>[
                    Offstage(
                      offstage:
                          widget.prefixIconType == BrnPrefixIconType.normal,
                      child: Container(
                        padding: EdgeInsets.only(right: 6),
                        child: GestureDetector(
                          onTap: () {
                            if (!widget.isEdit) {
                              return;
                            }

                            if (BrnPrefixIconType.add ==
                                widget.prefixIconType) {
                              if (widget.onAddTap != null) {
                                widget.onAddTap!();
                              }
                            } else if (BrnPrefixIconType.remove ==
                                widget.prefixIconType) {
                              if (widget.onRemoveTap != null) {
                                widget.onRemoveTap!();
                              }
                            }
                          },
                          child:
                              BrnFormUtil.getPrefixIcon(widget.prefixIconType),
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: (!widget.isRequire),
                      child: BrnFormUtil.getRequireIcon(widget.isRequire),
                    ),
                    Container(
                        child: widget.titleWidget ??
                            Text(
                              widget.title,
                              style: BrnFormUtil.getTitleTextStyle(
                                  widget.themeData!),
                            )),
                    Offstage(
                      offstage: (widget.tipLabel == null),
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
                              child: Text(
                                widget.tipLabel ?? "",
                                style: BrnFormUtil.getTipsTextStyle(
                                    widget.themeData!),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: widget.operateWidget ?? const SizedBox.shrink(),
              ),
            ],
          ),
          Offstage(
            offstage: ((widget.subTitleWidget == null) &&
                (widget.subTitle == null || widget.subTitle!.isEmpty)),
            child: Container(
                padding: BrnFormUtil.subTitleEdgeInsets(widget.themeData!),
                child: widget.subTitleWidget ??
                    Text(
                      widget.subTitle ?? "",
                      style:
                          BrnFormUtil.getSubTitleTextStyle(widget.themeData!),
                    )),
          ),
          Offstage(
              offstage: (widget.error.isEmpty),
              child: Container(
                  padding: BrnFormUtil.computeErrorEdgeInsets(
                      widget.prefixIconType, widget.isRequire),
                  child: Text(
                    widget.error,
                    style: BrnFormUtil.getErrorTextStyle(widget.themeData!),
                  )))
        ],
      ),
    );
  }
}
