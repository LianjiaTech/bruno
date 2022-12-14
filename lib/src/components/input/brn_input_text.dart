import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 输入框输入变化的监听
typedef BrnInputTextChangeCallback = Function(String input);

/// 输入框提交的监听
typedef BrnInputTextSubmitCallback = Function(String input);

/// 输入完成点击键盘监听
typedef BrnInputTextEditingCompleteCallback = Function(String input);

///  根据输入内容动态算高
///  为了解决text输入的时候高度计算的问题
///  支持设置最大最小高度
///  支持设置输入最大字数限制
///  支持最大最小行数限制

class BrnInputText extends StatelessWidget {
  /// 搜索框输入内容改变时候的回调函数
  final BrnInputTextChangeCallback? onTextChange;

  /// 点击确定后的回调
  final BrnInputTextSubmitCallback? onSubmit;

  /// 容器的最大高度，默认 200
  final double maxHeight;

  /// 最小的高度，默认 50
  final double minHeight;

  /// 整个容器的背景颜色，默认 Colors.white
  final Color bgColor;

  /// 输入框的hint文字，默认为"请输入..."
  final String? hint;

  /// 输入框的初始值，默认为""
  /// 不能定义为String，兼容example调用的传值
  final String textString;

  /// 用于对 TextField  更精细的控制，若传入该字段，[textString] 参数将失效，可使用 TextEditingController.text 进行赋值。
  final TextEditingController? textEditingController;

  /// 最大字数，默认200
  final int maxLength;

  /// 最少几行，默认1
  final int minLines;

  /// 文字距离边框的边距，默认 EdgeInsets.zero
  final EdgeInsetsGeometry padding;

  /// 最大hint行数
  final int? maxHintLines;

  /// 搜索框的焦点控制器
  final FocusNode? focusNode;


  /// 键盘输入行为， 默认为 TextInputAction.done
  final TextInputAction textInputAction;

  /// 光标展示
  final bool? autoFocus;

  /// 背景圆角
  final double? borderRadius;

  /// 边框颜色
  final Color? borderColor;

  BrnInputText({
    this.onTextChange,
    this.onSubmit,
    this.maxHeight = 200,
    this.minHeight = 50,
    this.bgColor = Colors.white,
    this.maxLength = 200,
    this.minLines = 1,
    this.hint,
    this.maxHintLines,
    this.padding = EdgeInsets.zero,
    this.textString = "",
    this.autoFocus,
    this.textEditingController,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.borderRadius,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return _inputText(context);
  }

  Widget _inputText(BuildContext context) {
    String textData = textString;
    if (textString.runes.length > maxLength) {
      var sRunes = textData.runes;
      textData = String.fromCharCodes(sRunes, 0, maxLength);
    }
    var _controller = textEditingController;
    if (_controller == null) {
      if (textData.isNotEmpty) {
        _controller = TextEditingController.fromValue(TextEditingValue(
            text: textData,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream, offset: textData.length))));
      } else {
        _controller = TextEditingController();
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor ?? Colors.transparent),
        // ignore: deprecated_member_use_from_same_package
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
      padding: padding,
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        minHeight: minHeight,
      ),
      child: TextField(
        // 新增保持光标一直在文字最后
        controller: _controller,
        keyboardType: TextInputType.multiline,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        maxLines: null,
        autofocus: autoFocus ?? true,
        focusNode: focusNode,
        minLines: minLines,
        textAlign: TextAlign.left,
        textInputAction: textInputAction,
        style: TextStyle(
            fontSize: 16,
            color: BrnThemeConfigurator.instance
                .getConfig()
                .commonConfig
                .colorTextBase),
        buildCounter: (
          BuildContext context, {
          required int currentLength,
          required int? maxLength,
          required bool isFocused,
        }) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "$currentLength",
                style: TextStyle(
                  color: (currentLength == 0
                      ? Color(0xffcccccc)
                      : BrnThemeConfigurator.instance
                          .getConfig()
                          .commonConfig
                          .colorTextSecondary),
                  fontSize: 16,
                ),
              ),
              Text(
                "/$maxLength",
                style: TextStyle(
                  color: Color(0xffcccccc),
                  fontSize: 16,
                ),
              ),
            ],
          );
        },
        decoration: InputDecoration(
          hintText: hint ?? BrnIntl.of(context).localizedResource.pleaseEnter,
          hintMaxLines: maxHintLines,
          hintStyle: TextStyle(fontSize: 16.0, color: Color(0xFFCCCCCC)),
          contentPadding: EdgeInsets.all(0),
          border: InputBorder.none,
          isDense: true,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
        ),
        onSubmitted: (text) {
          if (onSubmit != null) {
            onSubmit!(text);
          }
        },

        onChanged: (text) {
          if (onTextChange != null) {
            onTextChange!(text);
          }
        },
      ),
    );
  }
}
