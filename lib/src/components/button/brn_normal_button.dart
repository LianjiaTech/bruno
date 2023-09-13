import 'package:bruno/src/constants/brn_constants.dart';
import 'package:bruno/src/utils/brn_multi_click_util.dart';
import 'package:flutter/material.dart';

const double _BFontSize = 16;
const Color _BTextColor = Colors.white;
const Color _BBackgroundColor = Color(0xFF0984F9);
const Color _BDisableBackgroundColor = Color(0xFFCCCCCC);
const FontWeight _BFontWeight = FontWeight.bold;
const double _BRadius = 6;

/// 通用按钮，支持用户设置背景色、是否可用等属性
/// 若[BrnBigMainButton]、[BrnSmallMainButton]、[BrnBigOutlineButton]不能满足用户需要
/// 可以直接使用该按钮
///
/// [isEnable]如果设置为false，那么按钮呈现灰色态，点击事件不响应
///
/// 默认使用[Text]文本组件，如果用户想要显示其他组件。比如图片等，可以设置[child]属性
///
/// 文本组件需要的样式属性，可以通过[textStyle]设置，也可以通过[fontSize]等单独设置
///
/// 该组件的布局规则参考[Container]的布局规则
/// 该组件的[alignment]的属性默认为null,即使父布局给的约束是无边界(最大宽度或者最大高度是double.infinity.)
/// 组件的尺寸也会和child一样大。
/// 那就是说：不给[alignment]属性设置值，即使把[BrnNormalButton],放到[column]、[ListView]中，
/// 他也会尽可能的小。如果设置了[constraints]属性，那么就会按着[constraints]布局。
///
/// 案例一
/// ```dart
/// BrnNormalButton(
///    text: '主案特别长',
///    onTap: () {
///         BrnToast.show('点击了主按钮', context);
///    },
/// )
/// ```
/// 按钮的大小就是text的大小+内边距的大小
///
/// 案例二
/// ```dart
/// BrnNormalButton(
///    constraints: BoxConstraints.expand(height: 60),
///    text: '主案特别长',
///    onTap: () {
///         BrnToast.show('点击了主按钮', context);
///    },
/// )
/// ```
/// 按钮的大小：宽度充满父布局、高度是60
///
/// 如果给该组件的[alignment]赋值了，父布局的约束是有边界。
/// 该组件的尺寸就是父布局的约束， 并且会按着[alignment]属性来摆放[text]或者[child],比如居中摆放等.
///
/// 案例一
/// ```dart
/// BrnNormalButton(
///    alignment: Alignment.center,
///    text: '主案特别长',
///    onTap: () {
///         BrnToast.show('点击了主按钮', context);
///    },
/// )
/// ```
/// 按钮的大小：宽度充满父布局  文字居中摆放
///
/// * [BrnBigMainButton], 大主色调按钮
/// * [BrnBigOutlineButton], 大边框按钮
/// * [BrnSmallMainButton], 小主色调按钮
/// * [BrnSmallOutlineButton], 小边框按钮
///
class BrnNormalButton extends StatelessWidget {
  /// 按钮是否可用 默认是true
  final bool isEnable;

  /// 按钮点击的回调
  final VoidCallback? onTap;

  /// 按钮显示的文案
  final String text;

  /// 按钮的文字颜色 默认白色[_BTextColor]
  final Color textColor;

  /// 按钮的文字大小 默认[_BFontSize]
  final double fontSize;

  /// 按钮不可用的文字颜色
  final Color? disableTextColor;

  /// 按钮背景色 默认[_BBackgroundColor]
  final Color backgroundColor;

  /// 按钮不可用背景色 默认[_BDisableBackgroundColor]
  final Color disableBackgroundColor;

  /// 按钮内边距 默认水平[_BHorizontalPadding] 垂直[_BVerticalPadding]
  final EdgeInsetsGeometry insertPadding;

  /// 按钮的修饰 默认实色背景
  final Decoration? decoration;

  /// 按钮的显示子节点 优先级高于[text]
  final Widget? child;

  /// 按钮的文本显示样式 优先级高于[textColor]等属性
  final TextStyle? textStyle;

  /// 按钮的文本Weight 默认是[FontWeight.bold]
  final FontWeight fontWeight;

  /// 按钮的布局约束 默认是自适应大小
  final BoxConstraints constraints;

  /// 按钮的内部对齐 默认为null
  final Alignment? alignment;

  /// 按钮圆角大小
  final BorderRadiusGeometry borderRadius;

  /// create BrnNormalButton
  BrnNormalButton({
    Key? key,
    required this.text,
    this.backgroundColor = _BBackgroundColor,
    this.isEnable = true,
    this.onTap,
    this.insertPadding = const EdgeInsets.symmetric(
        vertical: BrnButtonConstant.verticalPadding,
        horizontal: BrnButtonConstant.horizontalPadding),
    this.decoration,
    this.child,
    this.textStyle,
    this.fontWeight = _BFontWeight,
    this.fontSize = _BFontSize,
    this.textColor = _BTextColor,
    this.disableTextColor,
    this.disableBackgroundColor = _BDisableBackgroundColor,
    this.constraints = const BoxConstraints.tightFor(),
    this.borderRadius = const BorderRadius.all(Radius.circular(_BRadius)),
    this.alignment,
  }) : super(key: key);

  BrnNormalButton.outline({
    Key? key,
    Color? disableLineColor,
    Color? lineColor,
    double radius = 6,
    double borderWith = 1.0,
    required this.text,
    this.isEnable = true,
    this.backgroundColor = _BBackgroundColor,
    this.disableBackgroundColor = _BDisableBackgroundColor,
    this.alignment,
    this.child,
    this.onTap,
    this.textColor = _BTextColor,
    this.fontWeight = _BFontWeight,
    this.fontSize = _BFontSize,
    this.disableTextColor,
    this.insertPadding = const EdgeInsets.symmetric(
        vertical: BrnButtonConstant.verticalPadding,
        horizontal: BrnButtonConstant.horizontalPadding),
    this.textStyle,
    this.constraints = const BoxConstraints.tightFor(),
    this.borderRadius = const BorderRadius.all(Radius.circular(_BRadius)),
  })  : decoration = _OutlineBoxDecorationCreator.createOutlineBoxDecoration(
            isEnable: isEnable,
            disableBackgroundColor: disableBackgroundColor,
            disableLineColor: disableLineColor,
            lineColor: lineColor,
            backgroundColor: backgroundColor,
            radius: radius,
            borderWith: borderWith),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (BrnMultiClickUtils.isMultiClick()) {
          return;
        }
        if (isEnable && onTap != null) {
          onTap!();
        }
      },
      child: Container(
        alignment: alignment,
        decoration: decoration ?? _getBoxDecoration(_getBackgroundColor()),
        constraints: constraints,
        padding: insertPadding,
        child: child ??
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: _getTextStyle(),
            ),
      ),
    );
  }

  TextStyle _getTextStyle() {
    if (textStyle != null) {
      return textStyle!;
    }
    Color textColor;
    if (isEnable) {
      textColor = this.textColor;
    } else {
      textColor = this.disableTextColor ?? (this.textColor).withOpacity(0.7);
    }

    return TextStyle(
      fontSize: fontSize,
      color: textColor,
      fontWeight: fontWeight,
    );
  }

  Color _getBackgroundColor() {
    return isEnable ? backgroundColor : disableBackgroundColor;
  }

  BoxDecoration _getBoxDecoration(Color? bgColor) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: borderRadius,
    );
  }
}

class _OutlineBoxDecorationCreator {
  static BoxDecoration createOutlineBoxDecoration({
    required bool isEnable,
    Color? disableLineColor,
    Color? lineColor,
    required Color backgroundColor,
    required Color disableBackgroundColor,
    double radius = 6,
    double borderWith = 1.0,
  }) {
    Color _lineColor = isEnable ? lineColor! : disableLineColor!;
    Color _bgColor = isEnable ? backgroundColor : disableBackgroundColor;

    return BoxDecoration(
        border: Border.all(color: _lineColor, width: borderWith),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: _bgColor);
  }
}
