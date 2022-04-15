import 'package:bruno/src/components/form/base/brn_form_item_type.dart';
import 'package:bruno/src/components/form/utils/brn_form_util.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_form_config.dart';
import 'package:bruno/src/constants/brn_fonts_constants.dart';
import 'package:flutter/material.dart';

/// 标题类型录入项
// ignore: must_be_immutable
class BrnTitleFormItem extends StatefulWidget {
  /// 录入项的唯一标识，主要用于录入类型页面框架中
  final String? label;

  /// 录入项类型，主要用于录入类型页面框架中
  final String type = BrnInputItemType.labelTitle;

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

  /// 录入项 是否可编辑
  final bool isEdit;

  /// 录入项是否为必填项（展示*图标） 默认为 false 不必填
  final bool isRequire;

  /// 点击"？"图标回调
  final VoidCallback? onTip;

  /// 点击操作区标识
  final String? operationLabel;

  /// 点击回调
  final VoidCallback? onTap;

  /// form配置
  BrnFormItemConfig? themeData;

  BrnTitleFormItem(
      {Key? key,
      this.label,
      this.title = "",
      this.subTitle,
      this.tipLabel,
      this.prefixIconType = BrnPrefixIconType.normal,
      this.error = "",
      this.isEdit = true,
      this.isRequire = false,
      this.onTip,
      this.operationLabel,
      this.onTap,
      this.themeData})
      : super(key: key) {
    this.themeData ??= BrnFormItemConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .formItemConfig
        .merge(this.themeData);
  }

  @override
  BrnTitleFormItemState createState() {
    return BrnTitleFormItemState();
  }
}

class BrnTitleFormItemState extends State<BrnTitleFormItem> {
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
                      // 必填项
                      BrnFormUtil.buildRequireWidget(widget.isRequire),
                      // 主标题
                      Container(
                          child: Text(
                        widget.title,
                        style: BrnFormUtil.getHeadTitleTextStyle(
                            widget.themeData!),
                      )),
                      // 问号提示
                      BrnFormUtil.buildTipLabelWidget(
                          widget.tipLabel, widget.onTip, widget.themeData!),
                    ],
                  ),
                ),

                // 自定义操作区
                Offstage(
                  offstage: (widget.operationLabel == null),
                  child: GestureDetector(
                    onTap: () {
                      if (!BrnFormUtil.isEdit(widget.isEdit)) {
                        return;
                      }

                      BrnFormUtil.notifyTap(context, widget.onTap);
                    },
                    child: Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          widget.operationLabel ?? "",
                          style: TextStyle(
                            color: widget.themeData!.commonConfig.brandPrimary,
                            fontSize: BrnFonts.f16,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),

          // 副标题
          BrnFormUtil.buildSubTitleWidget(widget.subTitle, widget.themeData!),

          // 错误提示
          BrnFormUtil.buildErrorWidget(widget.error, widget.themeData!)
        ],
      ),
    );
  }
}
