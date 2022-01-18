import 'package:bruno/src/components/charts/broken_line/brn_base_painter.dart';
import 'package:bruno/src/components/charts/broken_line/brn_line_data.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_drawing/path_drawing.dart';

/// 默认边距
const double _basePadding = 0;

/// 图表内容距离 widget 顶部的 padding
const double _contentTopPadding = 10;

class BrnLineYPainter extends BrnBasePainter {
  final int lineSelectIndex;
  final int pointSelectIndex;

  /// xy轴线条的宽度
  double xyLineWidth = 0.5;

  /// x轴的颜色
  Color? xColor;

  /// y轴的颜色
  Color? yColor;

  /// y轴刻度的偏移量
  final double yHintLineOffset;

  /// 刻度的宽度或者高度
  double rulerWidth;

  /// y轴最大值，用来计算内部绘制点的y轴位置
  final double yMin, yMax;

  /// y轴左侧刻度显示，不传则没有
  final List<BrnDialItem>? yDialValues;

  /// x、y轴的辅助线
  bool isShowXHintLine, isShowYHintLine;

  /// 辅助线是否为实线，在显示辅助线的时候才有效，false的话为虚线，默认实线
  bool isHintLineSolid;

  /// 辅助线颜色
  Color? hintLineColor;

  /// 绘制线条的参数内容
  List<BrnPointsLine> lines;

  bool isShowXDialText, isShowYDialText;

  double? selectX;
  double? selectY;
  double _startX = 0.0, _endX = 0.0, _startY = 0.0, _endY = 0.0;
  late double _fixedHeight;

  BrnLineYPainter(
    this.lines, {
    required this.lineSelectIndex,
    required this.pointSelectIndex,
    required this.yHintLineOffset,
    required this.xColor,
    required this.yColor,
    required this.rulerWidth,
    required this.yMin,
    required this.yMax,
    required this.yDialValues,
    required this.isShowXHintLine,
    required this.isShowYHintLine,
    required this.isHintLineSolid,
    required this.hintLineColor,
    required this.isShowXDialText,
    required this.isShowYDialText,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var xyPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = xyLineWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    _init(canvas, size, xyPaint);
  }

  @override
  bool shouldRepaint(BrnLineYPainter oldDelegate) {
    return true;
  }

  ///初始化
  void _init(Canvas canvas, Size size, Paint xyPaint) {
    //初始化参数
    _initValue();
    _initBorder(size);
    _drawXy(canvas, xyPaint); //坐标轴
  }

  void _initValue() {
    xColor ??=
        BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase;
    yColor ??= BrnThemeConfigurator.instance
        .getConfig()
        .commonConfig
        .colorTextSecondary;
    hintLineColor ??=
        BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase;
  }

  /// 计算边界
  void _initBorder(Size size) {
    _endX = size.width;
    _startY = size.height;

    /// 如果展示y刻度文本，则左侧默认预留 20 像素高度展示x刻度
    if (isShowYDialText) {
      _startX = yHintLineOffset;
    }

    /// 如果展示x刻度文本，则底部预留 20 像素高度展示x刻度
    if (isShowXDialText) {
      _endY = 20.0;
    }
    _fixedHeight = _startY - _endY - _contentTopPadding;
  }

  /// x,y轴
  void _drawXy(Canvas canvas, Paint paint) {
    if (isShowXHintLine) {
      canvas.drawLine(Offset(_startX, _startY),
          Offset(_endX + _basePadding, _startY), paint..color = xColor!); //x轴
    }
    if (isShowYHintLine) {
      canvas.drawLine(Offset(_startX, _startY),
          Offset(_startX, _endY - _basePadding), paint..color = yColor!); //y轴
    }
    _drawYRuler(canvas, paint);
  }

  /// 绘制y轴 & 辅助线
  void _drawYRuler(Canvas canvas, Paint paint) {
    if (yDialValues == null) {
      return;
    }
    for (var i = 0; i < yDialValues!.length; i++) {
      var ydialValue = yDialValues![i];

      // 绘制y轴文本
      var yLength = (ydialValue.value - yMin) / (yMax - yMin) * _fixedHeight;
      var textY = TextPainter(
          textAlign: TextAlign.right,
          ellipsis: '.',
          maxLines: 1,
          text: TextSpan(
              text: '${ydialValue.dialText}', style: ydialValue.dialTextStyle),
          textDirection: TextDirection.rtl)
        ..layout();
      textY.paint(
          canvas,
          Offset(
              _startX -
                  (textY.width > yHintLineOffset
                      ? yHintLineOffset
                      : textY.width) -
                  6,
              _startY - yLength - textY.height / 2));

      if (isShowXHintLine && yLength != 0) {
        // x轴辅助线
        var hitXPath = Path();
        hitXPath
          ..moveTo(_startX, _startY - yLength)
          ..lineTo(_startX + _endX - yHintLineOffset, _startY - yLength);
        if (isHintLineSolid) {
          canvas.drawPath(hitXPath, paint..color = hintLineColor!);
        } else {
          canvas.drawPath(
            dashPath(
              hitXPath,
              dashArray:
                  CircularIntervalList<double>(<double>[4.0, 4.0]), //虚线和间隔
            ),
            paint..color = hintLineColor!,
          );
        }
      }

      // y轴刻度
      if (isShowYHintLine) {
        canvas.drawLine(
            Offset(_startX, _startY - yLength),
            Offset(_startX + rulerWidth, _startY - yLength),
            paint..color = yColor!);
      }
    }
  }
}
