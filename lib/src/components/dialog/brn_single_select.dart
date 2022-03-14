import 'package:bruno/src/components/dialog/brn_dialog_utils.dart';
import 'package:bruno/src/components/line/brn_line.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_dialog_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

import 'brn_dialog.dart';

typedef BrnSingleSelectOnSubmitCallback = Function(String? data);
typedef BrnSingleSelectOnItemClickCallback = void Function(
    BuildContext dialogContext, int index);

/// 单选列表弹框
class BrnSingleSelectDialog extends Dialog {
  /// 用于控制是否可以响应点击外部关闭弹窗，true 关闭，false 不关闭，默认 true
  final bool isClose;

  /// 弹窗标题
  final String title;

  /// 描述文案，优先级较 messageWidget 低，优先使用 messageWidget
  final String? messageText;

  /// 描述widget
  final Widget? messageWidget;

  /// 时间区间最大值
  final List<String> conditions;

  /// 确定/提交 按钮文案，默认 '提交'
  final String submitText;

  /// 提交按钮点击回调
  final BrnSingleSelectOnSubmitCallback? onSubmitClick;

  /// item 点击回调
  final BrnSingleSelectOnItemClickCallback? onItemClick;

  /// 提交按钮背景颜色
  final Color? submitBgColor;

  /// 选中的选项名称
  final String? checkedItem;

  /// 单选列表底部自定义 Widget
  final Widget? customWidget;

  /// 内容是否可滑动。默认为 true
  final bool isCustomFollowScroll;

  /// 是否在点击时让 Diallog 消失，默认为 true
  final bool canDismissOnConfirmClick;

  const BrnSingleSelectDialog(
      {this.isClose: true,
      this.title: "",
      this.messageText,
      this.messageWidget,
      required this.conditions,
      this.submitText: "提交",
      this.submitBgColor,
      this.onSubmitClick,
      this.onItemClick,
      this.checkedItem,
      this.customWidget,
      this.canDismissOnConfirmClick = true,
      this.isCustomFollowScroll = true});

  @override
  Widget build(BuildContext context) {
    return BrnSingleSelectDialogWidget(
        isClose: isClose,
        title: title,
        messageText: messageText,
        messageWidget: messageWidget,
        conditions: conditions,
        submitText: submitText,
        onSubmitClick: onSubmitClick,
        onItemClick: onItemClick,
        submitBgColor: submitBgColor,
        checkedItem: checkedItem,
        customWidget: customWidget,
        canDismissOnConfirmClick: canDismissOnConfirmClick,
        isCustomFollowScroll: isCustomFollowScroll);
  }
}

// ignore: must_be_immutable
class BrnSingleSelectDialogWidget extends StatefulWidget {
  final bool isClose;
  final String title;
  final String? messageText;
  final Widget? messageWidget;
  final List<String>? conditions;
  final String submitText;
  final BrnSingleSelectOnSubmitCallback? onSubmitClick;
  final BrnSingleSelectOnItemClickCallback? onItemClick; //可供埋点需求用
  final Color? submitBgColor;
  String? checkedItem; // 选择项目

  final Widget? customWidget;

  final bool isCustomFollowScroll;

  final bool canDismissOnConfirmClick;

  BrnDialogConfig? themeData;

  BrnSingleSelectDialogWidget(
      {this.isClose = true,
      this.title = "",
      this.messageText,
      this.messageWidget,
      this.conditions,
      this.submitText = "",
      this.submitBgColor,
      this.onSubmitClick,
      this.onItemClick,
      this.checkedItem,
      this.customWidget,
      this.isCustomFollowScroll = true,
      this.canDismissOnConfirmClick = true,
      this.themeData}) {
    this.themeData ??= BrnDialogConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: themeData!.configId)
        .dialogConfig
        .merge(themeData);
  }

  @override
  State<StatefulWidget> createState() {
    return BrnSingleSelectDialogWidgetState();
  }
}

class BrnSingleSelectDialogWidgetState
    extends State<BrnSingleSelectDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x33999999),
        body: Container(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints(maxWidth: 300),
              decoration: BoxDecoration(
                //背景
                color: widget.themeData?.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(
                    BrnDialogUtils.getDialogRadius(
                        widget.themeData!))), //设置四周圆角 角度
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 28, 20, 12),
                        child: Text(
                          widget.title,
                          style: BrnDialogUtils.getDialogTitleStyle(
                              widget.themeData!),
                        ),
                      ),
                      _generateContentWidget(),
                      Container(
                        constraints: BoxConstraints(maxHeight: 300),
                        child: widget.isCustomFollowScroll
                            ? SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            _buildItem(context, index),
                                        itemCount:
                                            widget.conditions?.length ?? 0),
                                    widget.customWidget != null
                                        ? Container(
                                            child: widget.customWidget,
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20, top: 12),
                                          )
                                        : Container(
                                            width: 0,
                                            height: 0,
                                          ),
                                  ],
                                ),
                              )
                            : Column(
                                children: <Widget>[
                                  Expanded(
                                    child: ListView.builder(
                                        itemBuilder: (context, index) =>
                                            _buildItem(context, index),
                                        itemCount:
                                            widget.conditions?.length ?? 0),
                                  ),
                                  widget.customWidget != null
                                      ? Container(
                                          child: widget.customWidget,
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20, top: 12),
                                        )
                                      : Container(
                                          width: 0,
                                          height: 0,
                                        ),
                                ],
                              ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
                          child: InkWell(
                            child: Container(
                                decoration: BoxDecoration(
                                  //背景
                                  color: BrnThemeConfigurator.instance
                                      .getConfig()
                                      .commonConfig
                                      .brandPrimary,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(6.0)), //设置四周圆角 角度
                                ),
                                alignment: Alignment.center,
                                height: 48,
                                color: widget.submitBgColor,
                                child: Text(widget.submitText,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 18))),
                            onTap: () {
                              if (widget.canDismissOnConfirmClick) {
                                Navigator.of(context).pop();
                              }
                              if (widget.onSubmitClick != null) {
                                widget.onSubmitClick!(widget.checkedItem);
                              }
                            },
                          ))
                    ],
                  ),
                  widget.isClose
                      ? Positioned(
                          right: 0.0,
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: BrunoTools.getAssetImage(
                                    BrnAsset.iconPickerClose),
                              )))
                      : Container()
                ],
              ),
            )));
  }

  /// 内容widget 以 messageWidget 为准，
  /// 若无则以 messageText 生成widget 填充，
  /// 都没设置则为空 Container
  Widget _generateContentWidget() {
    if (widget.messageWidget != null)
      return Padding(
        padding: EdgeInsets.only(bottom: 8, left: 20, right: 20),
        child: widget.messageWidget,
      );

    if (!BrunoTools.isEmpty(widget.messageText)) {
      return Padding(
        padding: EdgeInsets.only(bottom: 8, left: 20, right: 20),
        child: Text(
          widget.messageText!,
          style: cContentTextStyle,
        ),
      );
    }
    return Container();
  }


  Widget _buildItem(BuildContext context, int index) {
    if (widget.conditions == null) {
      return Container();
    } else {
      return Container(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      for (dynamic item in widget.conditions!) {
                        if (widget.conditions![index] == item) {
                          if (widget.onItemClick != null &&
                              widget.checkedItem != item) {
                            widget.onItemClick!(context, index);
                          }
                          widget.checkedItem = item;
                          break;
                        }
                      }
                    });
                  },
                  child: Text(widget.conditions![index],
                      style: TextStyle(
                          fontWeight:
                              widget.conditions![index] == widget.checkedItem
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                          fontSize: 16,
                          color: widget.conditions![index] == widget.checkedItem
                              ? BrnThemeConfigurator.instance
                                  .getConfig()
                                  .commonConfig
                                  .brandPrimary
                              : BrnThemeConfigurator.instance
                                  .getConfig()
                                  .commonConfig
                                  .colorTextBase)),
                )),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: 44,
                    child: widget.checkedItem == widget.conditions![index]
                        ? BrunoTools.getAssetImageWithBandColor(
                            BrnAsset.iconSingleSelected)
                        : BrunoTools.getAssetImage(BrnAsset.iconUnSelect),
                  ),
                  onTap: () {
                    if (widget.onItemClick != null) {
                      widget.onItemClick!(context, index);
                    }
                    setState(() {
                      widget.checkedItem = widget.conditions![index];
                    });
                  },
                )
              ],
            ),
          ),
          index != widget.conditions!.length - 1
              ? Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0), child: BrnLine())
              : Container()
        ],
      ));
    }
  }
}
