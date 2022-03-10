import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/material.dart';

/// 描述: 自定义界面元素中的虚线分割线
///
/// 适用场景
/// 1、界面元素中的分割线
///
/// 2、分割线样式的装饰

/// 分割线所在位置
enum BrnDashedLinePosition {
  /// 头部
  trailing,

  /// 尾部
  leading,
}

/// 默认虚线方向
const Axis _normalAxis = Axis.horizontal;

/// 默认虚线长度
const double _normalDashedLength = 8;

/// 默认虚线厚度
const double _normalDashedThickness = 1;

/// 默认间距
const double _normalDashedSpacing = 4;

/// 默认位置，头部
const BrnDashedLinePosition _normalPosition = BrnDashedLinePosition.leading;

/// 虚线分割线
class BrnDashedLine extends StatelessWidget {
  /// 虚线方向，默认值[_normalAxis]
  final Axis axis;

  /// 虚线长度，默认值[_normalDashedLength]
  final double dashedLength;

  /// 虚线厚度，默认值[_normalDashedThickness]
  final double dashedThickness;

  /// 虚线间距，默认值[_normalDashedSpacing]
  final double dashedSpacing;

  /// 颜色，默认值[_normalColor]
  final Color? color;

  /// 虚线的Widget
  final Widget contentWidget;

  /// 距离边缘的位置（偏移量），默认值为0
  final double dashedOffset;

  /// 分割线所在位置，默认值[_normalPosition]
  final BrnDashedLinePosition position;

  BrnDashedLine({
    Key? key,
    required this.contentWidget,
    this.axis = _normalAxis,
    this.dashedLength = _normalDashedLength,
    this.dashedThickness = _normalDashedThickness,
    this.dashedSpacing = _normalDashedSpacing,
    this.color,
    this.dashedOffset = 0.0,
    this.position = _normalPosition,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BrnDashedPainter(
          axis: this.axis,
          dashedLength: this.dashedLength,
          dashedThickness: this.dashedThickness,
          dashedSpacing: this.dashedSpacing,
          color: this.color,
          dashedOffset: this.dashedOffset,
          position: this.position),
      child: this.contentWidget,
    );
  }
}

class BrnDashedPainter extends CustomPainter {
  /// 虚线方向
  final Axis axis;

  /// 虚线长度
  final double dashedLength;

  /// 虚线厚度
  final double dashedThickness;

  /// 虚线间距
  final double dashedSpacing;

  /// 颜色
  final Color? color;

  /// 距离边缘的位置
  final double? dashedOffset;

  /// 分割线所在位置
  final BrnDashedLinePosition? position;

  BrnDashedPainter({
    this.axis = _normalAxis,
    this.dashedLength = _normalDashedLength,
    this.dashedThickness = _normalDashedThickness,
    this.dashedSpacing = _normalDashedSpacing,
    this.color,
    this.dashedOffset = 0.0,
    this.position = _normalPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint() // 创建一个画笔并配置其属性
      ..strokeWidth = this.dashedThickness // 画笔的宽度
      ..isAntiAlias = true // 是否抗锯齿
      ..color = this.color ??
          BrnThemeConfigurator.instance
              .getConfig()
              .commonConfig
              .dividerColorBase; // 画笔颜色

    var maxWidth = size.width; // size获取到宽度
    var maxHeight = size.height; // size获取到宽度
    if (this.axis == Axis.horizontal) {
      // 水平方向
      double startX = 0;
      final space = (this.dashedSpacing + this.dashedLength);
      double height = 0;
      if (this.position == BrnDashedLinePosition.leading) {
        // 头部
        height = dashedOffset! + this.dashedThickness / 2;
      } else {
        // 尾部
        height = size.height - dashedOffset! - this.dashedThickness / 2;
      }
      while (startX < maxWidth) {
        if ((maxWidth - startX) < this.dashedLength) {
          canvas.drawLine(Offset(startX, height),
              Offset(startX + (maxWidth - startX), height), paint);
        } else {
          canvas.drawLine(Offset(startX, height),
              Offset(startX + this.dashedLength, height), paint);
        }
        startX += space;
      }
    } else {
      // 垂直方向
      double startY = 0;
      final space = (this.dashedSpacing + this.dashedLength);
      double width = 0;
      if (this.position == BrnDashedLinePosition.leading) {
        // 头部
        width = dashedOffset! + this.dashedThickness / 2;
      } else {
        // 尾部
        width = size.width - dashedOffset! - this.dashedThickness / 2;
      }
      while (startY < maxHeight) {
        if ((maxHeight - startY) < this.dashedLength) {
          canvas.drawLine(Offset(width, startY),
              Offset(width, startY + (maxHeight - startY)), paint);
        } else {
          canvas.drawLine(Offset(width, startY),
              Offset(width, startY + this.dashedLength), paint);
        }
        startY += space;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
