import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BrnBarChartScaleStyle {
  /// 刻度标志内容(y轴仅适用于内容为数值类型的，x轴不限制)
  String title;

  /// y轴获取的值，只读
  double get titleValue {
    if (title.isEmpty) {
      return 0;
    } else {
      return double.parse(title);
    }
  }

  /// 刻度标志样式
  TextStyle? titleStyle;

  /// 与最大数值的比率，用来计算绘制刻度的位置使用。
  double? positionRetioy;

  /// 下面标注文案独属y轴使用，目前还没有x轴扩展需求，x轴设置下面参数无效，后期有需要再扩展
  /// 两个刻度之间的标注文案（向前绘制即x轴在该刻度左侧绘制，y轴在该刻度下面绘制）,不需要的话不设置
  String? centerSubTitle;

  /// 标注文案样式，centerSubTitle有内容时有效
  TextStyle? centerSubTextStyle;

  /// 标注文案位置是否是在左侧，false表示在右侧，centerSubTitle有内容时有效
  bool isLeft;

  /// create BrnBarChartScaleStyle
  BrnBarChartScaleStyle(
      {required this.title,
      this.titleStyle,
      this.centerSubTitle,
      this.centerSubTextStyle,
      this.positionRetioy,
      this.isLeft = true});
}

class BrnBarDataBean {
  /// x轴坐标显示字段
  String x;

  /// y轴坐标显示字段
  String y;

  /// y轴的值
  double value;

  BrnBarDataBean({
    this.x = '',
    this.value = 0,
    this.y = '',
  });
}

/// 每条线的定义
class BrnBarBean {
  /// 名称
  String? name;

  ///x轴的字体样式
  TextStyle? xTitleStyle;

  ///是否显示x轴的文字，用来处理多个线条绘制的时候，同一x轴坐标不需要绘制多次，则只需要将多条线中一个标记绘制即可
  bool isDrawX;

  ///线宽
  double lineWidth;

  ///线条点的特殊处理，如果内容不为空，则在点上面会绘制一个圆点，这个是圆点半径参数
  double pointRadius;

  ///标记是否为曲线
  bool isCurve;

  ///点集合
  List<BrnBarDataBean>? points;

  ///曲线或折线的颜色
  Color lineColor;

  ///填充色
  List<Color>? colors;

  ///占位图是否需要打断线条绘制，如果打断的话这个点的y值将没有意义，只有x轴有效，如果不打断的话，y轴值有效
  bool placehoderImageBreak;

  ///用户当前进行位置的小图标（比如一个小锁），默认没有只显示y轴的值，如果有内容则显示这个小图标，
  ui.Image? placehoderImage;

  /// create BrnBarBean
  BrnBarBean(
      {this.name,
      this.xTitleStyle,
      this.isDrawX = false,
      this.lineWidth = 2,
      this.pointRadius = 0,
      this.isCurve = false,
      this.points,
      this.lineColor = Colors.purple,
      this.colors,
      this.placehoderImageBreak = true,
      this.placehoderImage});
}

/// 柱状图标示文本展示规则
enum BrnBarShowTextType {
  /// 总是展示
  always,

  /// 不展示
  none,

  /// 选中时展示
  whenSelected,
}
