import 'package:bruno/src/components/dialog/brn_dialog.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 可输入文字的弹窗。从上至下依次是 标题[title]、提示信息[message]、输入框，底部左右两个按钮，左边取消，右边确定。
class BrnMiddleInputDialog {
  /// 标题
  final String? title;

  /// 辅助提示信息
  final String? message;

  /// 输入框占位文字
  final String? hintText;

  /// 最多可输入多少字符，默认20个
  final int maxLength;

  /// 取消操作标题，默认 '取消'
  final String? cancelText;

  /// 确定操作标题，默认 '确定'
  final String? confirmText;

  /// 点击确定时的回调，参数为输入框中的字符
  final void Function(String value)? onConfirm;

  /// 点击取消时的回调
  final VoidCallback? onCancel;

  /// 点击蒙层背景，弹窗是否可关闭。默认为 true，可关闭
  final bool barrierDismissible;

  /// 是否自动获取焦点，弹出键盘
  final bool autoFocus;

  /// 可输入的最少行数，默认为1
  final int minLines;

  /// 可输入的最多行数。超过 [maxLines] 指定的行数后，输入内容会变成可滑动
  final int? maxLines;

  /// 焦点控制 [FocusNode]
  final FocusNode? inputFocusNode;

  /// 输入控制器。如果有初始状态的填充文字，可以通过 [inputEditingController] 设置
  final TextEditingController? inputEditingController;

  /// 输入内容格式控制器
  final List<TextInputFormatter>? inputFormatters;

  /// 键盘操作按钮类型,参见系统的 [TextField.textInputAction]，默认为 [TextInputAction.newline]
  final TextInputAction textInputAction;

  /// 点击取消/确认按钮之后，是否自动关闭弹窗，默认为 true，关闭
  final bool dismissOnActionsTap;

  /// 点击取消/确认按钮之后，是否自动关闭弹窗，默认为 true，关闭
  BrnDialogConfig? themeData;

  /// 键盘类型
  final TextInputType? keyboardType;

  BrnMiddleInputDialog(
      {this.title,
      this.message,
      this.hintText,
      this.keyboardType,
      this.maxLength = 20,
      this.maxLines,
      this.minLines = 1,
      this.inputFocusNode,
      this.inputEditingController,
      this.inputFormatters,
      this.textInputAction = TextInputAction.newline,
      this.cancelText,
      this.confirmText,
      this.onConfirm,
      this.onCancel,
      this.dismissOnActionsTap = true,
      this.barrierDismissible = true,
      this.autoFocus = false,
      this.themeData}) {
    this.themeData ??= BrnDialogConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .dialogConfig
        .merge(this.themeData);
  }

  void show(BuildContext context) {
    _doShow(context);
  }

  void _doShow(BuildContext context) {
    String _value = inputEditingController?.text ?? "";
    var dialogMessageWidgets = <Widget>[];
    if (message != null && message!.isNotEmpty) {
      dialogMessageWidgets.add(Flexible(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Align(
            alignment: _getMessageAlign(themeData!.contentTextAlign),
            child: Text(
              message!,
              style: themeData!.contentTextStyle.generateTextStyle(),
              textAlign: themeData!.contentTextAlign,
            ),
          ),
        ),
      ));
      dialogMessageWidgets.add(Container(
        height: 12,
      ));
    }
    List<TextInputFormatter> tmpInputFormatters;
    if (inputFormatters == null) {
      tmpInputFormatters = [LengthLimitingTextInputFormatter(maxLength)];
    } else {
      tmpInputFormatters = []
        ..addAll(inputFormatters!)
        ..add(LengthLimitingTextInputFormatter(maxLength));
    }

    dialogMessageWidgets.add(TextField(
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      textInputAction: this.textInputAction,
      focusNode: inputFocusNode,
      controller: inputEditingController,
      maxLines: maxLines ?? minLines,
      minLines: minLines,
      keyboardType: keyboardType,
      //光标颜色
      cursorColor:
          BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary,
      autofocus: autoFocus,
      //光标圆角弧度
      cursorRadius: Radius.circular(2.0),
      style: TextStyle(
          fontSize: 14,
          color: BrnThemeConfigurator.instance
              .getConfig()
              .commonConfig
              .colorTextBase),
      onChanged: (value) {
        _value = value;
      },
      inputFormatters: tmpInputFormatters,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8.0),
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 14,
            color: BrnThemeConfigurator.instance
                .getConfig()
                .commonConfig
                .colorTextHint),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              width: 0.5,
              color: BrnThemeConfigurator.instance
                  .getConfig()
                  .commonConfig
                  .colorTextHint,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              width: 0.5,
              color: BrnThemeConfigurator.instance
                  .getConfig()
                  .commonConfig
                  .colorTextHint,
            )),
      ),
    ));
    return BrnDialogManager.showConfirmDialog(context,
        cancel: cancelText ?? BrnIntl.of(context).localizedResource.cancel,
        confirm: confirmText ?? BrnIntl.of(context).localizedResource.ok,
        title: title,
        barrierDismissible: barrierDismissible,
        themeData: themeData,
        messageWidget: Padding(
          padding: themeData!.contentPaddingLg,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: dialogMessageWidgets,
          ),
        ), onConfirm: () {
      if (onConfirm != null) onConfirm!(_value);
    }, onCancel: () {
      if (onCancel != null) onCancel!();
    });
  }

  Alignment _getMessageAlign(TextAlign messageTextAlign) {
    if (messageTextAlign == TextAlign.left ||
        messageTextAlign == TextAlign.start) {
      return Alignment.centerLeft;
    }
    if (messageTextAlign == TextAlign.right ||
        messageTextAlign == TextAlign.end) {
      return Alignment.centerRight;
    }
    return Alignment.center;
  }
}
