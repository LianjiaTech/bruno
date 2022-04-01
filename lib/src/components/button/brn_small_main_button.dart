import 'dart:math';

import 'package:bruno/src/components/button/brn_normal_button.dart';
import 'package:bruno/src/constants/brn_constants.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:flutter/material.dart';

///
/// 小的主色调按钮
/// 该按钮有一个最小的宽度84，在此基础上，宽度随着文本内容的多少变更
/// 因此 会根据文案的多少来计算长度
///
/// 按钮是圆角矩形的形状，只支持设置圆角大小[radius],不支持改变形状。
///
/// 按钮也存在可用和不可用两种状态，[isEnable]如果设置为false，那么按钮呈现灰色态，点击事件不响应
///
/// 按钮内间距是EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6)
///
/// 其他按钮如下：
///  * [BrnSmallOutlineButton], 小主色调按钮
///
///

/// 默认最小宽度
const double _BMinWidth = 84;

class BrnSmallMainButton extends StatelessWidget {
  /// 按钮显示文案,默认'确认'
  final String title;

  ///点击回调
  final VoidCallback? onTap;

  ///是否可用，默认为true。false为不可用：置灰、不可点击。
  final bool isEnable;
  final Color? bgColor;
  final Color textColor;
  final FontWeight fontWeight;
  final double? fontSize;
  final double? radius;
  final double? maxWidth;
  final double? width;

  /// 配置样式
  final BrnButtonConfig? themeData;

  /// 传入属性优先级最高，未传入的走默认配置，更多请看[BrnSmallMainButtonConfig.defaultConfig]
  const BrnSmallMainButton({
    Key? key,
    this.title = '确认',
    this.onTap,
    this.isEnable = true,
    this.bgColor,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.w600,
    this.fontSize,
    this.radius,
    this.maxWidth,
    this.width,
    this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BrnButtonConfig defaultThemeConfig = themeData ?? BrnButtonConfig();
    defaultThemeConfig = defaultThemeConfig.merge(BrnButtonConfig(
        smallButtonFontSize: fontSize, smallButtonRadius: radius));

    defaultThemeConfig = BrnThemeConfigurator.instance
        .getConfig(configId: defaultThemeConfig.configId)
        .buttonConfig
        .merge(defaultThemeConfig);

    TextPainter textPainter = TextPainter(textScaleFactor: MediaQuery.of(context).textScaleFactor);

    return LayoutBuilder(
      builder: (_, con) {
        TextStyle style = TextStyle(
          fontSize: defaultThemeConfig.smallButtonFontSize,
          fontWeight: fontWeight,
          color: textColor,
        );
        textPainter.textDirection = TextDirection.ltr;
        textPainter.text = TextSpan(text: title, style: style);
        textPainter.layout(maxWidth: con.maxWidth);
        double textWidth = textPainter.width;
        //按钮本身大小
        double _maxWidth = textWidth + BrnButtonConstant.horizontalPadding * 2;
        double _minWidth = min(_BMinWidth, con.maxWidth);

        //保证最小宽度是 （84、可用空间）的最小值
        if (_maxWidth <= _minWidth) {
          _maxWidth = _minWidth;
        } else {
          //外部要求最大宽度
          if (maxWidth != null) {
            if (_maxWidth > maxWidth!) {
              _maxWidth = maxWidth!;
            }
          }
        }

        if (_maxWidth > con.maxWidth) {
          _maxWidth = con.maxWidth;
        }

        return BrnNormalButton(
          isEnable: isEnable,
          constraints: BoxConstraints(
            minWidth: this.width ?? _minWidth,
            maxWidth: this.width ?? _maxWidth,
          ),
          alignment: Alignment.center,
          text: title,
          backgroundColor:
              bgColor ?? defaultThemeConfig.commonConfig.brandPrimary,
          disableBackgroundColor: Color(0xFFCCCCCC),
          borderRadius: BorderRadius.all(Radius.circular(defaultThemeConfig.smallButtonRadius)),
          onTap: onTap,
          textStyle: style,
        );
      },
    );
  }
}
