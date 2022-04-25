import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_drawing/path_drawing.dart';

///Radar chart
///雷达图表
///提供方便的绘制雷达图表的功能。
///基础的属性修改如雷达图的边数[sidesCount]，半径大小[radius]，旋转角度[rotateAngle]等。
///对绘制的效果也支持一定程度上的定制，参考[BrnRadarChartDataProvider],[BrnRadarChartStyle]。
class BrnRadarChart extends MultiChildRenderObjectWidget {
  ///雷达图半径（多边形外接圆的半径）,默认50
  final double radius;

  ///雷达数据的维度（多边形的边数>=3），默认值 5
  final int sidesCount;

  ///数据可划分的区间个数。默认值 3
  final int levelCount;

  ///数据的最大值，默认 10
  final double maxValue;

  ///数据的最小值，默认 0
  final double minValue;

  ///标签和雷达图顶点的间距，默认值4
  final double markerMargin;

  ///背景多边形轴颜色，默认 Color(0xFFCCCCCC)
  final Color axisLineColor;

  ///是否展示中间十字交叉线，默认 false
  final bool crossedAxisLine;

  ///提供绘制雷达图所需要的数据
  final BrnRadarChartDataProvider provider;

  ///控制带动画效果绘制时的绘制快慢，默认 1.0
  final double animateProgress;

  ///整个雷达图旋转角度，默认0
  final double rotateAngle;

  ///每个标注文案的偏移量，必须和 [sidesCount] 保持一致。
  final List<Offset>? offset;

  ///The default preset chart styles ordered in priority of usage.
  static const List<BrnRadarChartStyle> defaultRadarChartStyles = [
    BrnRadarChartStyle(
      strokeColor: Color(0xff0984f9),
      areaColor: Color(0x1a2196F3),
      dotted: true,
      dotColor: Color(0xff0984f9),
    ),
    BrnRadarChartStyle(
      strokeColor: Color(0xff01d57d),
      areaColor: Color(0x1a01d57d),
      dotted: true,
      dotColor: Color(0xff01d57d),
    ),
    BrnRadarChartStyle(
      strokeColor: Color(0xfffac958),
      areaColor: Color(0x1afac958),
      dotted: true,
      dotColor: Color(0xfffac958),
    ),
    BrnRadarChartStyle(
      strokeColor: Color(0xff6edeee),
      areaColor: Color(0x1a6edeee),
      dotted: true,
      dotColor: Color(0xff6edeee),
    ),
    BrnRadarChartStyle(
      strokeColor: Color(0xfff79631),
      areaColor: Color(0x1af79631),
      dotted: true,
      dotColor: Color(0xfff79631),
    ),
    BrnRadarChartStyle(
      strokeColor: Color(0xfff7779c),
      areaColor: Color(0x1af7779c),
      dotted: true,
      dotColor: Color(0xfff7779c),
    ),
  ];

  BrnRadarChart({
    Key? key,
    required this.provider,
    required MarkerBuilder builder,
    this.radius = 50,
    this.levelCount = 3,
    this.maxValue = 10,
    this.minValue = 0,
    this.markerMargin = 4,
    this.sidesCount = 5,
    this.offset,
    this.axisLineColor = const Color(0xFFCCCCCC),
    this.crossedAxisLine = false,
    this.animateProgress = 1.0,
    this.rotateAngle = 0,
  })  : assert(minValue < maxValue),
        assert(sidesCount >= 3),
        super(
            key: key,
            children: () {
              List<Widget> children = [];
              for (int i = 0; i < sidesCount; i++) {
                children.add(builder(i));
              }
              return children;
            }());

  ///The default style named constructor which is designed with Bruno style.
  ///The [data] length should be less than the [defaultRadarChartStyles]'s length
  ///or you should use the default constructor.
  BrnRadarChart.defaultStyle({
    Key? key,
    this.radius = 50,
    this.levelCount = 3,
    this.maxValue = 10,
    this.minValue = 0,
    this.markerMargin = 4,
    this.sidesCount = 5,
    this.rotateAngle = 0,
    this.crossedAxisLine = false,
    this.offset,
    required List<String> tagNames,
    required List<List<double>> data,
  })  : assert(sidesCount >= 3),
        assert(tagNames.length == sidesCount),
        assert(minValue < maxValue),
        assert(data.length <= defaultRadarChartStyles.length),
        this.animateProgress = 1.0,
        this.axisLineColor = const Color(0xFFCCCCCC),
        this.provider = DefaultRadarProvider(data),
        super(
            key: key,
            children: () {
              List<Widget> children = [];
              for (int i = 0; i < sidesCount; i++) {
                children.add(Container(
                  constraints: BoxConstraints(
                    maxWidth: 60,
                    maxHeight: 32,
                  ),
                  child: Text(
                    tagNames[i],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ));
              }
              return children;
            }());

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderRadarChart(
      radius: radius,
      markerMargin: markerMargin,
      sideCount: sidesCount,
      maxValue: maxValue,
      levelCount: levelCount,
      provider: provider,
      axisLineColor: axisLineColor,
      crossedAxisLine: crossedAxisLine,
      animateProgress: animateProgress,
      rotateAngle: rotateAngle,
      offset: offset ?? List.filled(sidesCount, Offset.zero),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderRadarChart renderObject) {
    renderObject
      ..radius = radius
      ..markerMargin = markerMargin
      ..sideCount = sidesCount
      ..maxValue = maxValue
      ..levelCount = levelCount
      ..axisLineColor = axisLineColor
      ..crossedAxisLine = crossedAxisLine
      ..animateProgress = animateProgress
      ..rotateAngle = rotateAngle
      ..offset = offset ?? List.filled(sidesCount, Offset.zero)
      ..dataProvider = provider;
  }
}

class BrnRadarChartParentData extends ContainerBoxParentData<RenderBox> {}

///Drawing the radar outline and positioning the children around the radar with some computation logic.
class RenderRadarChart extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, BrnRadarChartParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, BrnRadarChartParentData> {
  Paint _radarPainter;
  Paint _axisPainter;
  bool _hasVisualOverflow = false;
  Offset _overflowOffset = Offset.zero;
  Offset _centerOffset = Offset.zero;

  double _radius;
  double _markerMargin;
  int _sideCount;
  double _maxValue;
  int _levelCount;
  Color _axisLineColor;
  bool _crossedAxiLine;
  double _rotateAngle;
  List<Offset> _offset;

  BrnRadarChartDataProvider _dataProvider;

  RenderRadarChart({
    required double radius,
    required double markerMargin,
    required int sideCount,
    required double maxValue,
    required double rotateAngle,
    required List<Offset> offset,
    required BrnRadarChartDataProvider provider,
    required int levelCount,
    required Color axisLineColor,
    required bool crossedAxisLine,
    required double animateProgress,
  })  : _radius = radius,
        _markerMargin = markerMargin,
        _maxValue = maxValue,
        _radarPainter = Paint()..isAntiAlias = true,
        _axisPainter = Paint()
          ..isAntiAlias = true
          ..style = PaintingStyle.stroke,
        _levelCount = levelCount,
        _dataProvider = provider,
        _axisLineColor = axisLineColor,
        _crossedAxiLine = crossedAxisLine,
        _rotateAngle = rotateAngle,
        _offset = offset,
        _animateProgress = animateProgress,
        _sideCount = sideCount;

  double _animateProgress;

  double get animateProgress => _animateProgress;

  set animateProgress(double value) {
    if (value == _animateProgress) return;
    _animateProgress = value;
    markNeedsPaint();
  }

  double get radius => _radius;

  set radius(double value) {
    if (value == _radius) return;
    _radius = value;
    markNeedsLayout();
  }

  double get markerMargin => _markerMargin;

  set markerMargin(double value) {
    if (value == _markerMargin) return;
    _markerMargin = value;
    markNeedsLayout();
  }

  int get sideCount => _sideCount;

  set sideCount(int value) {
    if (value == _sideCount) return;
    _sideCount = value;
    markNeedsLayout();
  }

  double get maxValue => _maxValue;

  set maxValue(double value) {
    if (value == _maxValue) return;
    _maxValue = value;
    markNeedsPaint();
  }

  int get levelCount => _levelCount;

  set levelCount(int value) {
    if (value == _levelCount) return;
    _levelCount = value;
    markNeedsPaint();
  }

  BrnRadarChartDataProvider get dataProvider => _dataProvider;

  set dataProvider(BrnRadarChartDataProvider value) {
    if (value == _dataProvider) return;
    _dataProvider = value;
    markNeedsPaint();
  }

  Color get axisLineColor => _axisLineColor;

  set axisLineColor(Color value) {
    if (value == _axisLineColor) return;
    _axisLineColor = value;
    markNeedsPaint();
  }

  double get rotateAngle => _rotateAngle;

  set rotateAngle(double value) {
    if (value == _rotateAngle) return;
    _rotateAngle = value;
    markNeedsLayout();
  }

  List<Offset> get offset => _offset;

  set offset(List<Offset> value) {
    if (value == _offset) return;
    _offset = value;
    markNeedsLayout();
  }

  bool get crossedAxisLine => _crossedAxiLine;

  set crossedAxisLine(bool value) {
    if (value == _crossedAxiLine) return;
    _crossedAxiLine = value;
    markNeedsPaint();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! BrnRadarChartParentData) {
      child.parentData = BrnRadarChartParentData();
    }
  }

  double _getIntrinsicDimensionHorizontal(
      double mainChildSizeGetter(RenderBox child)) {
    double x;
    double maxX = 0, minX = 0;
    RenderBox? child = firstChild;
    //多边形的中心为原点
    int i = 0;
    while (child != null) {
      final BrnRadarChartParentData childParentData =
          child.parentData as BrnRadarChartParentData;
      double angle = (2 * pi * i / _sideCount + _rotateAngle) % (2 * pi);
      x = _radius * sin(angle);
      if (x >= 0) {
        if (angle == 0 || angle == pi) {
          x = x + mainChildSizeGetter(child) / 2;
        } else if (angle == pi / 2) {
          x = x + _markerMargin + mainChildSizeGetter(child);
        } else {
          x = x + mainChildSizeGetter(child) + _markerMargin * sin(angle);
        }
      } else {
        if (angle == pi * 3 / 2) {
          x = x - _markerMargin - mainChildSizeGetter(child);
        } else {
          x = x - mainChildSizeGetter(child) + _markerMargin * sin(angle);
        }
      }
      x = x + _offset[i].dx;
      minX = min(x, minX);
      maxX = max(x, maxX);
      child = childParentData.nextSibling;
    }
    return maxX - minX;
  }

  double _getIntrinsicDimensionVertical(
      double mainChildSizeGetter(RenderBox child)) {
    double y;
    double maxY = 0, minY = 0;
    RenderBox? child = firstChild;
    //多边形的中心为原点
    int i = 0;
    while (child != null) {
      final BrnRadarChartParentData childParentData =
          child.parentData as BrnRadarChartParentData;
      double angle = (2 * pi * i / _sideCount + _rotateAngle) % (2 * pi);
      y = _radius * cos(angle);

      if (y >= 0) {
        if (angle == 0) {
          y = y + mainChildSizeGetter(child) + _markerMargin;
        } else if (angle == pi / 2) {
          y = y + mainChildSizeGetter(child) / 2;
        } else {
          y = y + mainChildSizeGetter(child) + _markerMargin * cos(angle);
        }
      } else {
        if (angle == pi) {
          y = y - mainChildSizeGetter(child) - _markerMargin;
        } else if (angle == pi * 3 / 2) {
          y = y - mainChildSizeGetter(child) / 2;
        } else {
          y = y - mainChildSizeGetter(child) + _markerMargin * cos(angle);
        }
      }
      y = y + _offset[i].dy;
      minY = min(y, minY);
      maxY = max(y, maxY);
      child = childParentData.nextSibling;
    }
    return maxY - minY;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _getIntrinsicDimensionHorizontal(
        (RenderBox child) => child.getMinIntrinsicWidth(height));
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _getIntrinsicDimensionHorizontal(
        (RenderBox child) => child.getMaxIntrinsicWidth(height));
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _getIntrinsicDimensionVertical(
        (RenderBox child) => child.getMinIntrinsicHeight(width));
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _getIntrinsicDimensionVertical(
        (RenderBox child) => child.getMaxIntrinsicHeight(width));
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToHighestActualBaseline(baseline);
  }

  @override
  void performLayout() {
    _hasVisualOverflow = false;
    double x, y;
    double maxX = 0, minX = 0;
    double maxY = 0, minY = 0;
    RenderBox? child = firstChild;
    //多边形的中心为原点
    int i = 0;
    while (child != null) {
      final BrnRadarChartParentData childParentData =
          child.parentData as BrnRadarChartParentData;
      BoxConstraints childConstraints = constraints.loosen();
      child.layout(childConstraints, parentUsesSize: true);
      final Size childSize = child.size;
      double angle = (2 * pi * i / _sideCount + _rotateAngle) % (2 * pi);
      x = _radius * sin(angle);
      y = _radius * cos(angle);
      if (y >= 0) {
        if (angle == 0) {
          y = y + childSize.height + _markerMargin * cos(angle);
        } else if (angle == pi / 2) {
          y = y + childSize.height / 2;
        } else {
          y = y + childSize.height + _markerMargin * cos(angle);
        }
      } else {
        if (angle == pi) {
          y = y - childSize.height + _markerMargin * cos(angle);
        } else if (angle == pi * 3 / 2) {
          y = y - child.size.height / 2;
        } else {
          y = y - childSize.height + _markerMargin * cos(angle);
        }
      }
      y = y + _offset[i].dy;

      if (x >= 0) {
        if (angle == 0 || angle == pi) {
          x = x + child.size.width / 2;
        } else if (angle == pi / 2) {
          x = x + _markerMargin + childSize.width;
        } else {
          x = x + childSize.width + _markerMargin * sin(angle);
        }
      } else {
        if (angle == pi * 3 / 2) {
          x = x - _markerMargin - child.size.width;
        } else {
          x = x - childSize.width + _markerMargin * sin(angle);
        }
      }
      x = x + _offset[i].dx;
      minX = min(x, minX);
      maxX = max(x, maxX);
      minY = min(y, minY);
      maxY = max(y, maxY);
      child = childParentData.nextSibling;
      i++;
    }
    Size intrinsicSize = Size(maxX - minX, maxY - minY);
    size = constraints.constrain(intrinsicSize);
    if (intrinsicSize.width > constraints.maxWidth ||
        intrinsicSize.height > constraints.maxHeight) {
      _hasVisualOverflow = true;
    }
    _overflowOffset = Offset(
        intrinsicSize.width - size.width > 0
            ? intrinsicSize.width - size.width
            : 0,
        intrinsicSize.height - size.height > 0
            ? intrinsicSize.height - size.height
            : 0);
    _centerOffset = Offset(-(maxX + minX) / 2, (maxY + minY) / 2);
    child = firstChild;
    i = 0;
    while (child != null) {
      double angle = (2 * pi * i / _sideCount + _rotateAngle) % (2 * pi);
      double x = _radius * sin(angle); //在以多边形中心为原点的坐标
      double y = _radius * cos(angle); //在以多边形中心为原点的坐标
      final BrnRadarChartParentData childParentData =
          child.parentData as BrnRadarChartParentData;

      //转换到左上角为原点中的坐标
      if (y >= 0) {
        if (angle == 0) {
          y = size.height / 2 - y - child.size.height - _markerMargin;
        } else if (angle == pi / 2) {
          y = size.height / 2 - y - child.size.height / 2;
        } else {
          y = size.height / 2 -
              y -
              child.size.height -
              _markerMargin * cos(angle);
        }
      } else {
        if (angle == pi) {
          y = size.height / 2 - y + _markerMargin;
        } else if (angle == pi * 3 / 2) {
          y = size.height / 2 - y - child.size.height / 2;
        } else {
          y = size.height / 2 - y - _markerMargin * cos(angle);
        }
      }

      if (x >= 0) {
        if (angle == 0 || angle == pi) {
          x = size.width / 2 + x - child.size.width / 2;
        } else if (angle == pi / 2) {
          x = size.width / 2 + x + _markerMargin;
        } else {
          x = size.width / 2 + x + _markerMargin * sin(angle);
        }
      } else {
        if (angle == pi * 3 / 2) {
          x = size.width / 2 + x - _markerMargin - child.size.width;
        } else {
          x = size.width / 2 +
              x -
              child.size.width +
              _markerMargin * sin(angle);
        }
      }
      childParentData.offset = Offset(x, y) + _offset[i] + _centerOffset;
      child = childParentData.nextSibling;
      i++;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
    Canvas canvas = context.canvas;
    canvas.save();
    Rect rect = offset & size;
    canvas.clipRect(rect);
    canvas.save();
    canvas.translate(rect.left, rect.top);
    canvas.save();
    double translateX = rect.width / 2;
    double translateY = rect.height / 2;
    //translate the canvas's top left to widget'center since flutter canvas rotate pivot can only be the top left.
    canvas.translate(
        translateX + _centerOffset.dx, translateY + _centerOffset.dy);
    canvas.rotate(_rotateAngle);
    _drawBackground(canvas, rect.size, translateX, translateY);
    _drawRadar(canvas);
    canvas.restore();
    assert(() {
      if (_hasVisualOverflow) {
        _paintOverflowIndicator(canvas);
      }
      return true;
    }());
    canvas.restore();
    canvas.restore();
  }

  void _drawBackground(
    Canvas canvas,
    Size size,
    double translateX,
    double translateY,
  ) {
    _axisPainter..color = _axisLineColor;
    _axisPainter..strokeWidth = 0.5;
    //calculate the side length of polygon.
    double centralAngle = 2 * pi / _sideCount;
    if (_crossedAxiLine) {
      for (int i = 0; i < _sideCount; i++) {
        canvas.save();
        canvas.rotate(2 * pi * i / _sideCount);
        Path path = Path();
        path
          ..moveTo(0, 0)
          ..lineTo(0, -_radius);
        canvas.drawPath(
            dashPath(
              path,
              dashArray: CircularIntervalList([10, 5]),
            ),
            _axisPainter);
        canvas.restore();
      }
    }

    for (int i = 1; i <= _levelCount; i++) {
      double r = _radius * i / _levelCount;
      double sideLength = 2 * r * sin(centralAngle / 2);
      double dx = sideLength * sin((pi - centralAngle) / 2);
      double dy = sideLength * cos((pi - centralAngle) / 2);
      //calculate the two adjacent vertex's coordinates after translation.
      double px1 = size.width / 2 - translateX;
      double py1 = size.height / 2 - r - translateY;
      double px2 = px1 + dx;
      double py2 = py1 + dy;
      //draw the polygon
      for (int i = 0; i < _sideCount; i++) {
        canvas.save();
        canvas.rotate(2 * pi * i / _sideCount);
        Path path = Path();
        path
          ..moveTo(px1, py1)
          ..lineTo(px2, py2);
        canvas.drawPath(path, _axisPainter);
        canvas.restore();
      }
    }
  }

  void _drawRadar(Canvas canvas) {
    int radarCount = _dataProvider.getRadarCount();
    for (int radarIndex = 0; radarIndex < radarCount; radarIndex++) {
      BrnRadarChartStyle radarStyle = _dataProvider.getRadarStyle(radarIndex);
      _radarPainter
        ..isAntiAlias = true
        ..color = radarStyle.strokeColor
        ..strokeWidth = radarStyle.strokeWidth;
      List<double> values = _dataProvider.getRadarValues(radarIndex);
      Path path = Path();
      double percent = values[0] / _maxValue;
      double angle = 0;
      if (percent > 1) {
        percent = 1;
      } else if (percent < 0) {
        percent = 0;
      }
      double x, y;
      List<Offset> dotPosition = [];
      x = _radius * percent * sin(angle) * _animateProgress;
      y = -_radius * percent * cos(angle) * _animateProgress;
      dotPosition.add(Offset(x, y));
      path.moveTo(x, y);
      for (int i = 1; i < _sideCount; i++) {
        angle = 2 * pi * i / _sideCount;
        percent = values[i] / _maxValue;
        x = _radius * percent * sin(angle) * _animateProgress;
        y = -_radius * percent * cos(angle) * _animateProgress;
        path.lineTo(x, y);
        dotPosition.add(Offset(x, y));
      }
      path.close();
      _radarPainter.style = PaintingStyle.stroke;
      canvas.drawPath(path, _radarPainter);
      _radarPainter
        ..color = radarStyle.areaColor
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, _radarPainter);

      if (radarStyle.dotted) {
        for (int i = 0; i < dotPosition.length; i++) {
          _radarPainter.color = Colors.white;
          canvas.drawCircle(
              dotPosition[i], radarStyle.dotRadius + 2, _radarPainter);
          _radarPainter.color = radarStyle.dotColor ?? radarStyle.strokeColor;
          canvas.drawCircle(
              dotPosition[i], radarStyle.dotRadius, _radarPainter);
        }
      }
    }
  }

  void _paintOverflowIndicator(Canvas canvas) {
    TextStyle _indicatorTextStyle = TextStyle(
      color: Color(0xFF900000),
      fontSize: 7.5,
      fontWeight: FontWeight.w800,
    );
    TextSpan span = TextSpan(
      text:
          'Size overflowed ，need more width ${_overflowOffset.dx.abs().toStringAsFixed(2)} pixels and height ${_overflowOffset.dy.abs().toStringAsFixed(2)} pixels',
      style: _indicatorTextStyle,
    );
    TextPainter textPainter = TextPainter();
    textPainter
      ..text = span
      ..textDirection = TextDirection.ltr
      ..layout(maxWidth: size.width);
    Rect rect = Rect.fromLTWH(0, 0, size.width, textPainter.height);
    Paint paint = Paint()..color = Colors.yellow;
    canvas.drawRect(rect, paint);
    textPainter.paint(canvas, Offset.zero);
  }
}

///A provider that supplies data to draw radar chart.It could be a list of grouped data that means you can
///put different radar charts in one table.
abstract class BrnRadarChartDataProvider {
  ///Return radar charts' count
  int getRadarCount();

  ///Get the radar drawing style of the radar chart according to the specified index.
  BrnRadarChartStyle getRadarStyle(int radarIndex);

  ///Get the radar drawing values of the radar chart according to the specified index.
  ///The values determine radar's vertexes.The length must be same as [BrnRadarChart.sidesCount].
  ///The value must range from [BrnRadarChart.minValue] to [BrnRadarChart.maxValue].
  ///Put values to the list by clockwise order, start from 12 o'clock.
  List<double> getRadarValues(int radarIndex);
}

///A builder of providing marker widgets for convenience.
typedef MarkerBuilder = Widget Function(int index);

/// A style contains the properties needed to paint a radar chart.
class BrnRadarChartStyle {
  ///The stroke color of the radar's outline.
  final Color strokeColor;

  ///The stroke width of the radar's outline.
  final double strokeWidth;

  ///The color of the radar covered area.
  final Color areaColor;

  ///Determine whether show dotted vertex of radar.
  final bool dotted;

  ///The color of the dotted vertexes.
  final Color? dotColor;

  ///The radius of the dotted circle.
  final double dotRadius;

  const BrnRadarChartStyle({
    required this.strokeColor,
    required this.areaColor,
    this.strokeWidth = 3,
    this.dotted = false,
    this.dotColor,
    this.dotRadius = 3,
  });
}

///The default BrnRadarChartDataProvider which using the default designed style.
class DefaultRadarProvider extends BrnRadarChartDataProvider {
  final List<List<double>> dataList;

  DefaultRadarProvider(this.dataList);

  @override
  int getRadarCount() => dataList.length;

  @override
  BrnRadarChartStyle getRadarStyle(int radarIndex) {
    if (radarIndex >= BrnRadarChart.defaultRadarChartStyles.length) {
      return BrnRadarChartStyle(
        strokeColor: Color(0xff0984f9),
        areaColor: Color(0x1a2196F3),
        dotted: true,
        dotColor: Color(0xff0984f9),
      );
    }
    return BrnRadarChart.defaultRadarChartStyles[radarIndex];
  }

  @override
  List<double> getRadarValues(int radarIndex) {
    return dataList[radarIndex];
  }
}
