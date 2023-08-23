import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/material.dart';

///常见的阴影卡片，减少了冗余代码
///
///在此组件的基础上，用户可以参考[BoxShadow]的参数来合理的设置阴影效果[offset]、[spreadRadius]、[spreadRadius]
///
///和系统的[Card]组件相似，是对Container组件的封装
///
class BrnShadowCard extends StatelessWidget {
  ///背景色 默认Color(0xfffafafa)
  final Color color;

  ///阴影颜色 默认Color(0xffeeeeee)
  final Color shadowColor;

  ///阴影偏移量 默认是0
  final Offset offset;

  ///内边距 默认是0
  final EdgeInsetsGeometry padding;

  ///圆角 默认4.0
  final double circular;

  ///子 Widget
  final Widget child;

  ///阴影模糊程度 默认5.0
  final double blurRadius;

  ///阴影扩散程度 默认0
  final double spreadRadius;

  ///边框的宽度 默认0.5
  final double borderWidth;

  /// create BrnShadowCard
  BrnShadowCard(
      {required this.child,
      this.color = const Color(0xfffafafa),
      this.shadowColor = const Color(0xffeeeeee),
      this.padding = const EdgeInsets.all(0),
      this.circular = 4.0,
      this.blurRadius = 5.0,
      this.spreadRadius = 0,
      this.offset = Offset.zero,
      this.borderWidth = 0.5});

  @override
  Widget build(BuildContext context) {
    double tempBorderWidth = 0;
    if (this.borderWidth > 0) {
      tempBorderWidth = this.borderWidth;
    }
    return Container(
      padding: padding,
      child: this.child,
      decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.all(Radius.circular(circular)),
          border: tempBorderWidth != 0
              ? Border.all(
                  color: BrnThemeConfigurator.instance
                      .getConfig()
                      .commonConfig
                      .dividerColorBase,
                  width: tempBorderWidth)
              : Border.all(style: BorderStyle.none),
          boxShadow: [
            BoxShadow(
                color: this.shadowColor,
                offset: this.offset, //阴影xy轴偏移量
                blurRadius: this.blurRadius, //阴影模糊程度
                spreadRadius: this.spreadRadius //阴影扩散程度
                )
          ]),
    );
  }
}
