import 'dart:math';

import 'package:bruno/src/components/charts/broken_line/brn_base_painter.dart';
import 'package:bruno/src/components/charts/broken_line/brn_line_data.dart';
import 'package:bruno/src/components/charts/broken_line/monotone_x.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

/// 折线图 刻度线、X/Y 轴绘制类
class BrnLinePainter extends BrnBasePainter {
  final int lineSelectIndex;
  final int pointSelectIndex;

  /// xy轴线条的宽度
  double xyLineWidth = 0.5;

  /// x轴的颜色
  Color? xDialColor;

  ///y轴的颜色
  Color? yDialColor;

  /// 刻度的宽度或者高度
  final double rulerWidth;

  /// x轴最小值，最大值，用来计算内部绘制点的x轴位置
  double? xDialMin, xDialMax;

  /// y轴最小值，最大值，用来计算内部绘制点的y轴位置
  final double yDialMin, yDialMax;

  /// x轴 刻度
  List<BrnDialItem>? xDialValues;

  /// y轴左侧刻度显示，不传则没有
  List<BrnDialItem>? yDialValues;

  /// x、y轴的辅助线
  bool isShowHintX, isShowHintY;

  /// 辅助线是否为实线，在显示辅助线的时候才有效，false的话为虚线，默认实线
  bool hintLineSolid;

  /// 辅助线颜色
  Color? hintLineColor;

  /// 绘制线条的参数内容
  List<BrnPointsLine> lines;

  /// 是否展示 X、Y 轴刻度文本
  bool isShowXText, isShowYText;

  /// 是否展示 X轴刻度
  final bool isShowXDial;

  /// 是否展示选中点对应的 X、Y 辅助虚线
  final bool showPointDashLine;

  /// 默认的边距
  static const double basePadding = 0;

  /// 默认的边距
  static const double textPadding = 10;

  /// 图标距离 widget 顶部的 padding
  static const double paddingTop = 10;

  double? selectX;
  double? selectY;
  double _startX = 0.0, _endX = 0.0, _startY = 0.0, _endY = 0.0;
  late double _fixedHeight, _fixedWidth;
  late List<LineCanvasModel> _lineCanvasModels;

  List<List<Point>> _linePointPositions = [];

  double get startX => _startX;

  double get startY => _startY;

  double get endX => _endX;

  double get endY => _endY;

  double get fixedHeight => _fixedHeight;

  BrnLinePainter(
    this.lines, {
    required this.lineSelectIndex,
    required this.pointSelectIndex,
    required this.showPointDashLine,
    required this.xDialColor,
    required this.yDialColor,
    required this.rulerWidth,
    required this.xDialMin,
    required this.xDialMax,
    required this.xDialValues,
    required this.yDialMin,
    required this.yDialMax,
    required this.yDialValues,
    required this.isShowHintX,
    required this.isShowHintY,
    required this.hintLineSolid,
    required this.hintLineColor,
    this.isShowXDial = true,
    this.isShowXText = false,
    this.isShowYText = false,
  }) {
    if (xDialValues == null) {
      for (var i = 1; i < lines.length; i++) {
        assert(lines[i - 1].points.length == lines[i].points.length,
            '折线${i - 1}和$i条线的节点数不一致');
      }
    }
    assert(yDialMax > yDialMin, "yDialMax 应该大于 yDialMin");
  }

  /// 返回选中的点
  Point selectedPoint(int lineIndex, int pointIndex) {
    return _linePointPositions[lineIndex][pointIndex];
  }

  /// 根据点击的位置和 point 的 index，遍历寻找出所属的 Line
  int lineIndexCompute(Offset offset, int pointIndex) {
    int index = -1;
    double margin = 15;
    for (List<Point> points in _linePointPositions) {
      if ((offset.dy - points[pointIndex].y).abs() <= margin &&
          (offset.dx - points[pointIndex].x).abs() <= margin) {
        margin = (offset.dy - points[pointIndex].y).abs();
        index = _linePointPositions.indexOf(points);
      }
    }
    return index;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var xyPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = xyLineWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    _init(canvas, size, xyPaint);
    _initPath(canvas, xyPaint);
    _drawXy(canvas, xyPaint); //坐标轴
    _drawSelectPointWithIndex(canvas, xyPaint);
    _drawLine(canvas); //曲线或折线
    _drawPointDisplayText(canvas);
  }

  @override
  bool shouldRepaint(BrnLinePainter oldDelegate) {
    return true;
  }

  ///初始化
  void _init(Canvas canvas, Size size, Paint xyPaint) {
    //初始化参数
    _initValue();
    _initBorder(size);
  }

  void _initValue() {
    xDialColor ??=
        BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase;
    yDialColor ??= BrnThemeConfigurator.instance
        .getConfig()
        .commonConfig
        .colorTextSecondary;
    hintLineColor ??=
        BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase;
    xDialMin ??= 0;
    xDialMax ??= 1;
  }

  ///计算边界
  void _initBorder(Size size) {
    _endX = size.width;
    _startY = size.height;
    if (isShowXText) {
      _endY = 20.0;
    }
    _fixedHeight = _startY - _endY - paddingTop;
    _fixedWidth = _endX - _startX;
  }

  ///计算Path
  void _initPath(Canvas canvas, Paint xyPaint) {
    _lineCanvasModels = [];
    if (lines.isNotEmpty) {
      _linePointPositions.clear();
      // 计算点和线的 数据，用于渲染。
      for (var item in lines) {
        var paths = <Path>[], shadowPaths = <Path>[];
        var pointArr = <Point>[];

        if (item.points.isNotEmpty) {
          Path _path = Path();
          Path _shadowPath = Path();

          if (xDialValues != null && xDialValues!.isNotEmpty) {
            for (var i = 0; i < item.points.length; i++) {
              var xPosition = _startX +
                  ((item.points[i].x - xDialMin!) /
                      (xDialMax! - xDialMin!) *
                      _fixedWidth);
              var yPosition = _startY;
              if (yDialMax != yDialMin) {
                yPosition = _startY -
                    ((item.points[i].y - yDialMin) /
                        (yDialMax - yDialMin) *
                        _fixedHeight);
              }
              pointArr.add(Point(xPosition, yPosition));
            }
          } else {
            var xScaleCount = item.points.length;
            var W = _fixedWidth /
                (xScaleCount > 1 ? (xScaleCount - 1) : 1); //两个点之间的x方向距离
            for (var i = 0; i < item.points.length; i++) {
              var xPosition = _startX + W * i;
              var yPosition = _startY -
                  ((item.points[i].y - yDialMin) /
                      (yDialMax - yDialMin) *
                      _fixedHeight);
              pointArr.add(Point(xPosition, yPosition));
            }
          }

          if (item.isCurve) {
            _path = _getSmoothLinePath(pointArr);

            /// 生成 Shadow path。
            _shadowPath = _getSmoothLinePath(pointArr);
            _shadowPath
              ..lineTo(pointArr[pointArr.length - 1].x as double, _fixedHeight)
              ..lineTo(pointArr[0].x as double, _fixedHeight)
              ..close();
          } else {
            _path.moveTo(pointArr[0].x as double, pointArr[0].y as double);
            _shadowPath.moveTo(
                pointArr[0].x as double, pointArr[0].y as double);
            for (var i = 1; i < pointArr.length; i++) {
              _path.lineTo(pointArr[i].x as double, pointArr[i].y as double);
              _shadowPath.lineTo(
                  pointArr[i].x as double, pointArr[i].y as double);

              if (i == pointArr.length - 1) {
                _shadowPath
                  ..lineTo(
                      pointArr[pointArr.length - 1].x as double, _fixedHeight)
                  ..lineTo(pointArr[0].x as double, _fixedHeight)
                  ..close();
              }
            }
          }
          paths.add(_path);
          shadowPaths.add(_shadowPath);
        }
        _linePointPositions.add(pointArr);
        _lineCanvasModels.add(LineCanvasModel(
            paths: paths,
            pathColor: item.lineColor,
            pathWidth: item.lineWidth,
            shadowPaths: shadowPaths,
            shaderColors: item.shaderColors,
            points: item.isShowPoint ? pointArr : null,
            pointColor: item.pointColor!,
            pointInnerColor: item.pointInnerColor!,
            pointRadius: item.pointRadius,
            pointInnerRadius: item.pointInnerRadius!));
      }
    }
  }

  /// Draws smooth lines between each point.
  Path _getSmoothLinePath(List<Point> points) {
    var targetPoints = <Point>[];
    targetPoints.addAll(points);
    targetPoints.add(Point(
        points[points.length - 1].x * 2, points[points.length - 1].y * 2));
    double? x0, y0, x1, y1, t0;
    var path = Path();
    for (int i = 0; i < targetPoints.length; i++) {
      double? t1;
      var x = targetPoints[i].x;
      var y = targetPoints[i].y;
      if (x == x1 && y == y1) break;
      switch (i) {
        case 0:
          path.moveTo(x as double, y as double);
          break;
        case 1:
          break;
        case 2:
          t1 = MonotoneX.slope3(x0!, y0!, x1!, y1!, x as double, y as double);
          MonotoneX.point(
              path, x0, y0, x1, y1, MonotoneX.slope2(x0, y0, x1, y1, t1), t1);
          break;
        default:
          t1 = MonotoneX.slope3(x0!, y0!, x1!, y1!, x as double, y as double);
          MonotoneX.point(path, x0, y0, x1, y1, t0!, t1);
      }
      x0 = x1;
      y0 = y1;
      x1 = x as double;
      y1 = y as double;
      t0 = t1;
    }
    return path;
  }

  ///x,y轴
  void _drawXy(Canvas canvas, Paint paint) {
    if (isShowHintY) {
      canvas.drawLine(
          Offset(_startX, _startY),
          Offset(_startX, _endY - basePadding),
          paint..color = yDialColor!); //y轴
    }

    if (lines.isNotEmpty) {
      //绘制x轴的文字部分
      if (isShowXDial) {
        _drawXRuler(canvas, paint..color = xDialColor!);
      }
    }
  }

  ///x轴刻度 & 辅助线
  void _drawXRuler(Canvas canvas, Paint paint) {
    double? _selectedPointX = -1.0;
    if (lineSelectIndex >= 0 && pointSelectIndex >= 0) {
        _selectedPointX = _linePointPositions[lineSelectIndex][pointSelectIndex].x as double? ;
    }
    if (xDialValues != null && xDialValues!.isNotEmpty) {
      // 获取刻度长度
      for (var i = 0; i < xDialValues!.length; i++) {
        double _xPosition = _startX +
            (xDialValues![i].value - xDialMin!) /
                (xDialMax! - xDialMin!) *
                _fixedWidth;

        _selectedPointX = _selectedPointX ?? 0.0;
        bool isXRulerSelected = (_selectedPointX - _xPosition).abs() < 1.0;

        ///绘制x轴文本
        var tpX = TextPainter(
            textAlign: TextAlign.center,
            ellipsis: '.',
            text: TextSpan(
                text: xDialValues![i].dialText,
                style: isXRulerSelected
                    ? xDialValues![i].selectedDialTextStyle ??
                        xDialValues![i].dialTextStyle
                    : xDialValues![i].dialTextStyle),
            textDirection: TextDirection.ltr)
          ..layout();
        // 开始绘制刻度
        _drawXRuleByPointPosition(
            tpX,
            canvas,
            _xPosition,
            paint);
      }
    }
  }

  void _drawXRuleByPointPosition(
      TextPainter tpX, Canvas canvas, double xPosition, Paint paint) {
    tpX.paint(canvas, Offset(xPosition - tpX.width / 2, _startY + textPadding));

    // 绘制与 X 轴对应的垂直辅助线
    if (isShowHintY) {
      var tempPath = Path()
        ..moveTo(xPosition, _startY)
        ..lineTo(xPosition, _endY - basePadding);
      if (hintLineSolid) {
        canvas.drawPath(tempPath, paint..color = hintLineColor!);
      } else {
        canvas.drawPath(
          dashPath(
            tempPath,
            dashArray: CircularIntervalList<double>(<double>[4.0, 2.0]),
          ),
          paint..color = hintLineColor!,
        );
      }
    }

    // 绘制 x轴刻度
    if (isShowHintX) {
      canvas.drawLine(Offset(xPosition, _startY),
          Offset(xPosition, _startY + rulerWidth), paint..color = xDialColor!);
    }
  }

  ///曲线或折线
  void _drawLine(Canvas canvas) {
    _lineCanvasModels.forEach((element) {
      //阴影区域
      if (element.shadowPaths != null && element.shaderColors != null) {
        element.shadowPaths!.forEach((shadowPathElement) {
          var shader = LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.clamp,
                  colors: element.shaderColors!)
              .createShader(
                  Rect.fromLTWH(_startX, _endY, _fixedWidth, _fixedHeight));
          canvas
            ..drawPath(
                shadowPathElement,
                Paint()
                  ..shader = shader
                  ..isAntiAlias = true
                  ..style = PaintingStyle.fill);
        });
      }
      //路径
      element.paths.forEach((pathElement) {
        var pathPaint = Paint()
          ..isAntiAlias = true
          ..strokeWidth = element.pathWidth
          ..strokeCap = StrokeCap.round
          ..color = element.pathColor
          ..style = PaintingStyle.stroke;
        canvas.drawPath(pathElement, pathPaint);
      });
      if (element.points != null) {
        //点
        // 画圆环的计算规则是：
        // 圆环宽度 strokeWidth = element.pointRadius - element.pointInnerRadius
        // 实际 drawCircle 半径 outerR = (element.pointRadius - element.pointInnerRadius)/2 + element.pointInnerRadius
        // 内部半径 innerR = element.pointInnerRadius
        element.points!.forEach((pointElement) {
          var pointPaint = Paint()
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.round
            ..color = element.pointColor
            ..strokeWidth = element.pointRadius - element.pointInnerRadius
            ..style = PaintingStyle.stroke; //描边为居中描边
          canvas.drawCircle(
              Offset(pointElement.x as double, pointElement.y as double),
              (element.pointRadius - element.pointInnerRadius) / 2 +
                  element.pointInnerRadius,
              pointPaint);
        });

        //内圆
        int currentLineIndex = _lineCanvasModels.indexOf(element);

        element.points!.forEach((pointElement) {
          int currentPointIndex = element.points!.indexOf(pointElement);
          Color color = Colors.white;

          var pointPaintBg = Paint()
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.round
            ..color = color
            ..style = PaintingStyle.fill;
          canvas.drawCircle(
              Offset(pointElement.x as double, pointElement.y as double),
              element.pointInnerRadius,
              pointPaintBg);

          if (currentLineIndex == lineSelectIndex &&
              currentPointIndex == pointSelectIndex) {
            color = element.pointInnerColor;
          }
          var pointPaint = Paint()
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.round
            ..color = color
            ..style = PaintingStyle.fill;
          canvas.drawCircle(
              Offset(pointElement.x as double, pointElement.y as double),
              element.pointInnerRadius,
              pointPaint);
        });
      }
    });
  }

  _drawSelectPointWithIndex(Canvas canvas, Paint paint) {
    if (lineSelectIndex < 0 || pointSelectIndex < 0) {
      return;
    }

    var x = _linePointPositions[lineSelectIndex][pointSelectIndex].x;
    var xPath = Path()
      ..moveTo(x as double, _startY)
      ..lineTo(x, _endY - basePadding);
    var y = _linePointPositions[lineSelectIndex][pointSelectIndex].y;
    var yPath = Path()
      ..moveTo(_startX, y as double)
      ..lineTo(_endX, y);
    if (showPointDashLine) {
      canvas.drawPath(
        dashPath(
          xPath,
          dashArray: CircularIntervalList<double>(<double>[4.0, 4.0]),
        ),
        paint
          ..color = BrnThemeConfigurator.instance
              .getConfig()
              .commonConfig
              .colorTextBase
          ..strokeWidth = 1.0,
      );

      canvas.drawPath(
        dashPath(
          yPath,
          dashArray: CircularIntervalList<double>(<double>[4.0, 4.0]),
        ),
        paint
          ..color = BrnThemeConfigurator.instance
              .getConfig()
              .commonConfig
              .colorTextBase
          ..strokeWidth = 1.0,
      );
    }
  }

  void _drawPointDisplayText(Canvas canvas) {
    if (_linePointPositions.isNotEmpty) {
      for (int lineIndex = 0;
          lineIndex < _linePointPositions.length;
          lineIndex++) {
        BrnPointsLine item = lines[lineIndex];
        if (item.isShowPointText && item.points.isNotEmpty) {
          var length = item.points.length;
          for (var i = 0; i < length; i++) {
            if (item.points[i].pointText == null ||
                item.points[i].pointText!.isEmpty) {
              continue;
            }
            var tpX = TextPainter(
                textAlign: TextAlign.center,
                ellipsis: '.',
                text: TextSpan(
                    text: '${item.points[i].pointText}',
                    style: item.points[i].pointTextStyle),
                textDirection: TextDirection.ltr)
              ..layout();
            double adjustOffset = _isAdjustPosition(lineIndex,
                    _linePointPositions[lineIndex][i], _linePointPositions)
                ? (20 - tpX.height)
                : -20;
            tpX.paint(
                canvas,
                Offset(
                    (item.points[i].offset.dx) +
                        _linePointPositions[lineIndex][i].x -
                        tpX.width / 2,
                    (item.points[i].offset.dy) +
                        _linePointPositions[lineIndex][i].y +
                        adjustOffset));
          }
        }
      }
    }
  }

  /// 是否需要调整位置
  bool _isAdjustPosition(
      int lineIndex, Point currentPoint, List<List<Point<num>>> lines) {
    List<Point<num>> sameXPoints = _getSameXValuePoints(currentPoint, lines);
    if (sameXPoints.isNotEmpty) {
      if (currentPoint.distanceTo(sameXPoints[0]) == 0) {
        return lineIndex > 0;
      } else if (currentPoint.distanceTo(sameXPoints[0]) < 40) {
        return currentPoint.y > sameXPoints[0].y;
      }
    }
    return false;
  }

  /// 获取相同x值的点
  List<Point<num>> _getSameXValuePoints(
      Point currentPoint, List<List<Point<num>>> lines) {
    List<Point<num>> sameXPoints = [];
    for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
      List<Point<num>> linePoints = lines[lineIndex];
      for (int pointIndex = 0; pointIndex < linePoints.length; pointIndex++) {
        if (currentPoint.x == linePoints[pointIndex].x &&
            currentPoint != linePoints[pointIndex]) {
          sameXPoints.add(linePoints[pointIndex]);
        }
      }
    }
    return sameXPoints;
  }
}

/// 绘制图表的计算之后的结果模型集
class LineCanvasModel {
  final List<Path> paths;
  final Color pathColor;
  final double pathWidth;

  final List<Path>? shadowPaths;
  final List<Color>? shaderColors;

  final List<Point>? points;
  final Color pointColor;
  final double pointRadius;
  final double pointInnerRadius;
  final Color pointInnerColor;
  final bool showPointText;

  const LineCanvasModel({
    required this.paths,
    required this.pathColor,
    required this.pathWidth,
    required this.shadowPaths,
    required this.shaderColors,
    required this.points,
    required this.pointColor,
    required this.pointRadius,
    required this.pointInnerRadius,
    required this.pointInnerColor,
    this.showPointText = false,
  });
}
