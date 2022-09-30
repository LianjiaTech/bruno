import 'dart:math';

import 'package:bruno/src/components/charts/broken_line/brn_line_data.dart';
import 'package:bruno/src/components/charts/broken_line/brn_line_painter.dart';
import 'package:bruno/src/components/charts/broken_line/brn_line_y_painter.dart';
import 'package:flutter/material.dart';

/// 适用于需要折线图，曲线图的场景
/// 支持数据过多时左右滑动查看数据
/// 支持 X、Y 轴自定义展示文本内容
class BrnBrokenLine extends StatefulWidget {
  /// 表格宽高
  final Size size;

  /// 绘制线条的参数内容
  final List<BrnPointsLine> lines;

  /// 图标内容区域 padding(不包含坐标轴)，默认 EdgeInsets.only(left: 10, right: 10)
  final EdgeInsets contentPadding;

  /// 绘制的背景色
  final Color? backgroundColor;

  /// xy轴线条的宽度，默认 2
  final double xyDialLineWidth;

  /// xy轴的颜色
  final Color? xDialColor, yDialColor;

  /// x轴最小值，最大值，用来计算内部绘制点的x轴位置
  final double? xDialMin, xDialMax;

  /// y轴最小值，最大值，用来计算内部绘制点的y轴位置
  final double yDialMin, yDialMax;

  /// 刻度的宽度或者高度，默认 4
  final double dialWidth;

  /// y轴左侧刻度显示，不传则没有
  final List<BrnDialItem>? yDialValues;

  /// x 轴刻度
  final List<BrnDialItem>? xDialValues;

  /// x轴的辅助线是否展示，默认 true
  final bool isShowXHintLine;

  /// y轴的辅助线是否展示，默认 false
  final bool isShowYHintLine;

  /// 辅助线是否为实线，在显示辅助线的时候才有效，false的话为虚线，默认true，实线
  final bool isHintLineSolid;

  /// 辅助线颜色
  final Color? hintLineColor;

  /// 是否展示 x 坐标刻度，默认 false
  final bool isShowXDialText;

  /// 是否展示 y 坐标刻度，默认 false
  final bool isShowYDialText;

  /// Y 轴辅助线向右偏移量，默认 20
  final double yHintLineOffset;

  /// 选中数据点时，是否展示数据点辅助线。默认 true
  final bool showPointDashLine;

  /// 提示 widget 是否自动消失。默认为 true
  final bool isTipWindowAutoDismiss;

  /// 是否绘制 x 刻度
  final bool isShowXDial;

  BrnBrokenLine({
    Key? key,
    required this.size,
    required this.lines,
    this.contentPadding = const EdgeInsets.only(left: 10, right: 10),
    this.backgroundColor,
    this.xyDialLineWidth = 2,
    this.xDialColor,
    this.yDialColor,
    this.yHintLineOffset = 20.0,
    this.showPointDashLine = true,
    this.dialWidth = 4,
    this.xDialMin,
    this.xDialMax,
    this.xDialValues,
    required this.yDialMin,
    required this.yDialMax,
    this.yDialValues,
    this.isShowXHintLine = true,
    this.isShowYHintLine = false,
    this.isHintLineSolid = true,
    this.hintLineColor,
    this.isTipWindowAutoDismiss = true,
    this.isShowXDialText = false,
    this.isShowYDialText = false,
    this.isShowXDial = true
  }) : super(key: key) {
    // 设置自定义 X 轴时，检查 x 轴的最大、最小刻度范围
    if (xDialValues != null) {
      assert(xDialMin != null);
      assert(xDialMax != null);
    }
  }

  @override
  State<StatefulWidget> createState() => BrnBrokenLineState();
}

class BrnBrokenLineState extends State<BrnBrokenLine> {
  int pointSelectIndex = -1;
  int lineSelectIndex = -1;

  @override
  Widget build(BuildContext context) {
    var _lineWithXPainter = BrnLinePainter(
      widget.lines,
      lineSelectIndex: lineSelectIndex,
      pointSelectIndex: pointSelectIndex,
      showPointDashLine: widget.showPointDashLine,
      xDialColor: widget.xDialColor,
      yDialColor: widget.yDialColor,
      rulerWidth: widget.dialWidth,
      xDialMin: widget.xDialMin,
      xDialMax: widget.xDialMax,
      xDialValues: widget.xDialValues,
      yDialMin: widget.yDialMin,
      yDialMax: widget.yDialMax,
      yDialValues: widget.yDialValues,
      isShowHintX: widget.isShowXHintLine,
      isShowHintY: widget.isShowYHintLine,
      hintLineSolid: widget.isHintLineSolid,
      hintLineColor: widget.hintLineColor,
      isShowXText: widget.isShowXDialText,
      isShowXDial: widget.isShowXDial,
    );
    var yPainter = BrnLineYPainter(
      widget.lines,
      yHintLineOffset: widget.yHintLineOffset,
      lineSelectIndex: lineSelectIndex,
      pointSelectIndex: pointSelectIndex,
      xColor: widget.xDialColor,
      yColor: widget.yDialColor,
      rulerWidth: widget.dialWidth,
      yMin: widget.yDialMin,
      yMax: widget.yDialMax,
      yDialValues: widget.yDialValues,
      isShowXHintLine: widget.isShowXHintLine,
      isShowYHintLine: widget.isShowYHintLine,
      isHintLineSolid: widget.isHintLineSolid,
      hintLineColor: widget.hintLineColor,
      isShowXDialText: widget.isShowXDialText,
      isShowYDialText: widget.isShowYDialText,
    );
    //y 轴宽度 = Y 轴刻度宽度+ chartLeftPadding（SingleChildScrollView padding）+ y 轴偏移量 yAxisWidth
    var yWidth =
        widget.size.width + widget.contentPadding.left + widget.yHintLineOffset;
    return Stack(
      children: [
        CustomPaint(
          size: Size(yWidth, widget.size.height),
          painter: widget.backgroundColor == null ? yPainter : null,
          foregroundPainter: widget.backgroundColor != null ? yPainter : null,
          child: widget.backgroundColor != null
              ? Container(
                  width: widget.size.width,
                  height: widget.size.height,
                  color: widget.backgroundColor,
                )
              : null,
        ),
        Padding(
          padding: EdgeInsets.only(left: widget.yHintLineOffset),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                left: widget.contentPadding.left,
                bottom: 25,
                right: widget.contentPadding.right),
            scrollDirection: Axis.horizontal,
            child: GestureDetector(
              onPanDown: (DragDownDetails e) {
                for (var i = 0; i < widget.lines[0].points.length; i++) {
                  int lineIndex =
                      _lineWithXPainter.lineIndexCompute(e.localPosition, i);
                  if (lineIndex >= 0) {
                    lineSelectIndex = lineIndex;
                    pointSelectIndex = i;
                    Point selectedPoint = _lineWithXPainter.selectedPoint(
                        lineSelectIndex, pointSelectIndex);
                    _fillLeftTopPoint(
                        widget.lines[lineSelectIndex].points[pointSelectIndex]
                            .lineTouchData,
                        _lineWithXPainter.startX,
                        _lineWithXPainter.endX,
                        _lineWithXPainter.startY,
                        _lineWithXPainter.endY,
                        _lineWithXPainter.fixedHeight,
                        selectedPoint);
                    setState(() {});
                  }
                }
              },
              onLongPressUp: () {
                if (widget.isTipWindowAutoDismiss) {
                  pointSelectIndex = -1;
                  lineSelectIndex = -1;
                  setState(() {});
                }
              },
              onTapUp: (tapUpDetail) {
                if (widget.isTipWindowAutoDismiss) {
                  pointSelectIndex = -1;
                  lineSelectIndex = -1;
                  setState(() {});
                }
              },
              child: Stack(children: [
                CustomPaint(
                  size: widget.size,
                  painter:
                      widget.backgroundColor == null ? _lineWithXPainter : null,
                  foregroundPainter:
                      widget.backgroundColor != null ? _lineWithXPainter : null,
                  child: widget.backgroundColor != null
                      ? Container(
                          width: widget.size.width,
                          height: widget.size.height,
                          color: widget.backgroundColor,
                        )
                      : null,
                ),
                (lineSelectIndex >= 0 && pointSelectIndex >= 0)
                    ? _buildTouchTipWidget(
                        widget.lines[lineSelectIndex].points[pointSelectIndex])
                    : const SizedBox.shrink(),
              ]),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTouchTipWidget(BrnPointData pointData) {
    Widget touchTipWidget;
    BrnLineTouchData? selectLinePoint = pointData.lineTouchData;
    if (pointData.isClickable && selectLinePoint.onTouch != null) {
      var content = selectLinePoint.onTouch!();
      if (content is String) {
        touchTipWidget = Positioned(
          top: selectLinePoint.y,
          left: selectLinePoint.x,
          child: Container(
            height: selectLinePoint.tipWindowSize.height,
            width: selectLinePoint.tipWindowSize.width,
            padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
            child: Center(child: Text(content)),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFDDDDDD), width: 0.5),
              borderRadius: BorderRadius.circular(3.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: Offset(0.0, 2.0), //阴影xy轴偏移量
                  blurRadius: 4.0, //阴影模糊程度
                )
              ],
            ),
          ),
        );
      } else if (content is Widget) {
        touchTipWidget = Positioned(
            top: selectLinePoint.y,
            left: selectLinePoint.x,
            child: Container(
                height: selectLinePoint.tipWindowSize.height,
                width: selectLinePoint.tipWindowSize.width,
                child: content));
      } else {
        touchTipWidget = const SizedBox.shrink();
      }
    } else {
      touchTipWidget = const SizedBox.shrink();
    }

    return touchTipWidget;
  }

  void _fillLeftTopPoint(
      BrnLineTouchData lineTouchData,
      double startX,
      double endX,
      double startY,
      double endY,
      double fixedHeight,
      Point selectedPoint) {
    if (pointSelectIndex < 0 && lineSelectIndex < 0) {
      lineTouchData.x = -1.0;
      lineTouchData.y = -1.0;
    }

    double padding = 10;

    var selectX = selectedPoint.x;
    var selectY = selectedPoint.y;
    double y = 0;
    double x = 0;
    if (selectY <= (startY - endY) / 2) {
      y = selectY + padding;
    } else {
      y = selectY - (lineTouchData.tipWindowSize.height) - padding;
    }

    if (selectX <= (endX - startX) / 2) {
      x = selectX + padding;
    } else {
      x = selectX - (lineTouchData.tipWindowSize.width) - padding;
    }

    lineTouchData.x = x + lineTouchData.tipOffset.dx;
    lineTouchData.y = y + lineTouchData.tipOffset.dy;
  }
}
