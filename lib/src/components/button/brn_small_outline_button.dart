

import 'dart:math';

import 'package:bruno/src/components/button/brn_normal_button.dart';
import 'package:bruno/src/constants/brn_constants.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:flutter/material.dart';

/// 边框 小、次按钮，小灰框，默认按钮确认,支持自定义边框、文字颜色

/// 小的边框按钮
/// 该按钮有一个最小的宽度84，在此基础上，宽度随着文本内容的多少变更
///
/// 按钮是圆角矩形的形状，只支持设置圆角大小[radius],不支持改变形状。
///
/// 按钮也存在可用和不可用两种状态，[isEnable]如果设置为false，那么按钮呈现灰色态，点击事件不响应
///
/// 其他按钮如下：
///  * [BrnSmallMainButton], 小主色调按钮

/// 默认最小宽度
const double _BMinWidth = 84;

/// 默认线宽
const double _BBorderWith = 1;

class BrnSmallOutlineButton extends StatelessWidget {
  /// 按钮显示文案,默认'确认
  final String title;

  /// 点击的回调
  final VoidCallback? onTap;

  ///是否可用，默认为true。false为不可用：置灰、不可点击。
  final bool isEnable;

  /// 边框的颜色，边框颜色，
  final Color? lineColor;

  /// 文字颜色
  final Color? textColor;

  ///圆角
  final double? radius;

  ///宽度
  final double? width;

  ///字体weigh
  final FontWeight fontWeight;

  ///字体大小
  final double fontSize;

  /// 配置样式
  final BrnButtonConfig? themeData;

  /// 传入属性优先级最高，未传入的走默认配置，更多请看[BrnSmallSecondaryOutlineButtonConfig.defaultConfig]
  const BrnSmallOutlineButton({
    Key? key,
    this.title = '确认',
    this.onTap,
    this.isEnable = true,
    this.lineColor,
    this.textColor,
    this.radius,
    this.width,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BrnButtonConfig defaultThemeConfig = themeData ?? BrnButtonConfig();

    defaultThemeConfig = defaultThemeConfig.merge(BrnButtonConfig(
      smallButtonFontSize: fontSize,
      smallButtonRadius: radius,
    ));
    defaultThemeConfig = BrnThemeConfigurator.instance
        .getConfig(configId: defaultThemeConfig.configId)
        .buttonConfig.merge(defaultThemeConfig);

    TextPainter textPainter =
        TextPainter(textScaleFactor: MediaQuery.of(context).textScaleFactor);

    return LayoutBuilder(
      builder: (_, con) {
        TextStyle style = TextStyle(
          fontSize: defaultThemeConfig.smallButtonFontSize,
          fontWeight: fontWeight,
        );

        textPainter.textDirection = TextDirection.ltr;
        textPainter.text = TextSpan(text: title, style: style);
        textPainter.layout(maxWidth: con.maxWidth);
        double textWidth = textPainter.width;
        double _maxWidth = textWidth +
            BrnButtonConstant.horizontalPadding * 2 +
            2 * _BBorderWith;

        double _minWidth = min(_BMinWidth, con.maxWidth);
        if (_maxWidth <= _minWidth) {
          _maxWidth = _minWidth;
        }
        if (_maxWidth > con.maxWidth) {
          _maxWidth = con.maxWidth;
        }

        return BrnNormalButton.outline(
          constraints: BoxConstraints(
            minWidth: this.width ?? _minWidth,
            maxWidth: this.width ?? _maxWidth,
          ),
          borderWith: _BBorderWith,
          radius: defaultThemeConfig.smallButtonRadius,
          text: title,
          disableLineColor: defaultThemeConfig.commonConfig.borderColorBase,
          lineColor: defaultThemeConfig.commonConfig.borderColorBase,
          textColor: textColor ?? defaultThemeConfig.commonConfig.colorTextBase,
          disableTextColor: Color(0xFFCCCCCC),
          isEnable: isEnable,
          alignment: Alignment.center,
          fontWeight: FontWeight.bold,
          fontSize: defaultThemeConfig.smallButtonFontSize,
          onTap: onTap,
          backgroundColor: Colors.white,
          disableBackgroundColor: Color(0xffcccccc).withOpacity(0.1),
        );
      },
    );
  }
}
