

import 'package:bruno/src/components/form/utils/brn_form_util.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_form_config.dart';
import 'package:flutter/material.dart';

///
/// 可组合title类型录入项
///
/// 包括"标题"、"副标题"、"错误信息提示"、"必填项提示"、"添加/删除按钮"、"消息提示"、
/// "多选项"等元素
///
// ignore: must_be_immutable
class BrnBaseTitle extends StatefulWidget {
  /// 标题
  final String title;

  /// 子标题
  final String? subTitle;

  /// 是否必填项
  final bool isRequire;

  /// 是否可编辑
  final bool isEdit;

  /// 错误提示文案
  final String error;

  /// 录入项提示（问号图标&文案） 用户点击时触发onTip回调。
  /// 1. 若赋值为 空字符串（""）时仅展示"问号"图标，
  /// 2. 若赋值为非空字符串时 展示"问号图标&文案"，
  /// 3. 若不赋值或赋值为null时 不显示提示项
  /// 默认值为 3
  final String? tipLabel;

  /// 标题Widget
  final Widget? titleWidget;

  /// 子标题Widget
  final Widget? subTitleWidget;

  /// 右侧自定义操作区
  final Widget? customActionWidget;

  /// 点击"？"图标回调
  final VoidCallback? onTip;

  /// 背景色
  final Color? backgroundColor;

  /// form配置
  BrnFormItemConfig? themeData;

  BrnBaseTitle({
    Key? key,
    this.title = "",
    this.subTitle,
    this.isRequire = false,
    this.isEdit = true,
    this.error = "",
    this.tipLabel,
    this.titleWidget,
    this.subTitleWidget,
    this.customActionWidget,
    this.onTip,
    this.backgroundColor,
    this.themeData,
  }) : super(key: key) {
    this.themeData ??= BrnFormItemConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .formItemConfig
        .merge(this.themeData);
    this.themeData = this.themeData!.merge(
        BrnFormItemConfig(backgroundColor: backgroundColor));
  }

  @override
  State<StatefulWidget> createState() {
    return BrnTitleState();
  }
}

class BrnTitleState extends State<BrnBaseTitle> {
  @override
  void initState() {
    super.initState();
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
                  padding: BrnFormUtil.titleEdgeInsetsForHead(
                      widget.isRequire, widget.themeData!),
                  child: Row(
                    children: <Widget>[
                      // 必填项符号
                      BrnFormUtil.buildRequireWidget(widget.isRequire),

                      // 主标题
                      getTitleWidget(),

                      // 问号提示
                      BrnFormUtil.buildTipLabelWidget(
                          widget.tipLabel, widget.onTip, widget.themeData!),
                    ],
                  ),
                ),

                // 自定义操作区
                Offstage(
                  offstage: (widget.customActionWidget == null),
                  child: widget.customActionWidget ?? const SizedBox.shrink(),
                ),
              ],
            ),
          ),

          // 副标题
          Offstage(
            offstage: (widget.subTitle == null || widget.subTitle!.isEmpty),
            child: getSubTitleWidget(),
          ),

          // 错误提示
          BrnFormUtil.buildErrorWidget(widget.error, widget.themeData!)
        ],
      ),
    );
  }

  Widget getTitleWidget() {
    if (widget.titleWidget != null) {
      return widget.titleWidget!;
    } else {
      return BrnFormUtil.buildTitleWidget(widget.title, widget.themeData!);
    }
  }

  Widget getSubTitleWidget() {
    if (widget.subTitleWidget != null) {
      return Container(
        padding: BrnFormUtil.subTitleEdgeInsets(widget.themeData!),
        child: widget.subTitleWidget,
      );
    } else {
      return Container(
          padding: BrnFormUtil.subTitleEdgeInsets(widget.themeData!),
          child: Text(
            widget.subTitle ?? "",
            style: BrnFormUtil.getSubTitleTextStyle(widget.themeData!),
          ));
    }
  }
}
