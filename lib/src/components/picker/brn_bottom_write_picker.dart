import 'package:bruno/src/components/picker/base/brn_picker_title_config.dart';
import 'package:bruno/src/components/picker/brn_bottom_picker.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/material.dart';

///取消输入事件回调
typedef BrnBottomWritePickerClickCallback = Future<void>? Function(
    String? content);

///确认输入事件回调
typedef BrnBottomWritePickerConfirmClickCallback = Future<void>? Function(
    BuildContext dialogContext, String? content);

class BrnBottomWritePicker extends StatefulWidget {
  /// 弹窗左边自定义文案，默认 '取消'
  final String? leftTag;

  /// 弹窗自定义标题
  final String title;

  /// 弹窗右边自定义文案，默认 '确认'
  final String? rightTag;

  /// 输入框默认提示文案，默认'请输入'
  final String? hintText;

  /// 输入框最大能输入的字符长度，默认 200
  final int maxLength;

  /// 取消输入事件回调
  final BrnBottomWritePickerClickCallback? onCancel;

  /// 确认输入内容事件回调
  final BrnBottomWritePickerConfirmClickCallback? onConfirm;

  /// 弹窗右边文案颜色
  final Color? rightTextColor;

  /// 光标颜色
  final Color? cursorColor;

  /// 默认文本
  final String? defaultText;

  /// 用于对 TextField  更精细的控制，若传入该字段，[defaultText] 参数将失效，可使用 TextEditingController.text 进行赋值。
  final TextEditingController? textEditingController;

  const BrnBottomWritePicker(
      {this.maxLength = 200,
      this.hintText,
      this.leftTag,
      this.title = "",
      this.rightTag,
      this.onCancel,
      this.onConfirm,
      this.rightTextColor,
      this.cursorColor,
      this.defaultText,
      this.textEditingController});

  @override
  State<StatefulWidget> createState() {
    return _BottomWritePickerState();
  }

  static void show(BuildContext context,
      {int maxLength = 200,
      String? hintText,
      String? leftTag,
      String title = "",
      String? rightTag,
      BrnBottomWritePickerClickCallback? onCancel,
      BrnBottomWritePickerConfirmClickCallback? onConfirm,
      bool confirmDismiss = false,
      bool cancelDismiss = true,
      Color? rightTextColor,
      Color? cursorColor,
      String? defaultText,
      TextEditingController? textEditingController}) {
    final ThemeData theme = Theme.of(context);
    showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          final Widget pageChild = BrnBottomWritePicker(
            maxLength: maxLength,
            hintText: hintText ?? BrnIntl.of(context).localizedResource.pleaseEnter,
            leftTag: leftTag ?? BrnIntl.of(context).localizedResource.cancel,
            title: title,
            rightTag: rightTag ?? BrnIntl.of(context).localizedResource.ok,
            onConfirm: onConfirm,
            onCancel: onCancel,
            rightTextColor: rightTextColor ??
                BrnThemeConfigurator.instance
                    .getConfig()
                    .commonConfig
                    .brandPrimary,
            cursorColor: cursorColor ??
                BrnThemeConfigurator.instance
                    .getConfig()
                    .commonConfig
                    .brandPrimary,
            defaultText: defaultText,
            textEditingController: textEditingController,
          );
          return Theme(data: theme, child: pageChild);
        });
  }
}

class _BottomWritePickerState extends State<BrnBottomWritePicker> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    if (_controller == null) {
      if (widget.defaultText != null && widget.defaultText!.isNotEmpty) {
        _controller = TextEditingController.fromValue(TextEditingValue(
            text: widget.defaultText!,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: widget.defaultText!.length))));
      } else {
        _controller = TextEditingController();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BrnBottomPickerWidget(
      contentWidget: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
        color: Colors.white,
        child: TextField(
            style: TextStyle(
                fontSize: 16,
                color: BrnThemeConfigurator.instance
                    .getConfig()
                    .commonConfig
                    .colorTextBase),
            controller: _controller,
            autofocus: true,
            maxLines: 8,
            maxLength: widget.maxLength,
            cursorColor: widget.cursorColor,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                  fontSize: 16,
                  color: BrnThemeConfigurator.instance
                      .getConfig()
                      .commonConfig
                      .colorTextHint),
              counterStyle: TextStyle(
                  fontSize: 16,
                  color: BrnThemeConfigurator.instance
                      .getConfig()
                      .commonConfig
                      .colorTextHint),
              hintText: widget.hintText ?? BrnIntl.of(context).localizedResource.pleaseEnter,
            )),
      ),
      pickerTitleConfig: BrnPickerTitleConfig(
        titleContent: widget.title,
      ),
      confirm: _buildRightTag(context),
      cancel: widget.leftTag ?? BrnIntl.of(context).localizedResource.cancel,
      onConfirmPressed: () {
        if (widget.onConfirm != null) {
          widget.onConfirm!(context, _controller?.text);
        }
      },
      onCancelPressed: () {
        if (widget.onCancel != null) {
          widget.onCancel!(_controller?.text);
        }
      },
      barrierDismissible: true,
    );
  }

  //此处返回类型为dynamic，在build的时候，会判读具体类型
  dynamic _buildRightTag(BuildContext context) {
    if (widget.rightTextColor != null) {
      return Text(
        widget.rightTag ?? BrnIntl.of(context).localizedResource.ok,
        style: TextStyle(
          fontSize: 16.0,
          color: widget.rightTextColor,
        ),
      );
    } else {
      return widget.rightTag;
    }
  }
}
