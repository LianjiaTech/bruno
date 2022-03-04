import 'dart:math';
import 'dart:ui' as ui;

import 'package:bruno/src/components/charts/radar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///漏斗图
///漏斗图有两种样式
///  ______________        ______________
///  \____文案____/        |____文案_____/
///   ___________     +    ____________
///   \__文案___/          |____文案___/
///   第一种，是两边都向中间缩短的漏斗[FunnelShape.leftAndRight]。
///   第二种，是只有一边向中间缩短的漏斗[FunnelShape.leftOrRight]。
///   通过[inputTextStyle]来控制样式。
///   在漏斗的两层layer之间或者左右可以插入标签markers，它们可以是一些常见的Widget，如[Text]，在参数[children]中提供。
///   通过[alignment]可以控制标签的插入位置。
///   使用[layerMargin]可以控制两层layer之间的间距。
///   每层layer支持自定义图案绘制，绘制参考[BrnFunnelLayerPainter]类定义
class BrnFunnelChart extends MultiChildRenderObjectWidget {
  ///漏斗的最大宽度，一般是漏斗最上层的宽度
  final double maxLayerWidth;

  ///漏斗的最小宽度，一般是漏斗最下层的宽度
  final double minLayerWidth;

  ///漏斗每层的高度
  final double layerHeight;

  ///漏斗每层之间的距离
  final double layerMargin;

  ///漏斗的层数
  final int layerCount;

  ///漏斗类型
  final FunnelShape shape;

  ///漏斗标签的个数，如果和[layerCount]相等说明是一对一的关系。如果比[layerCount]少一，说明描述的事layer之间的关系。
  ///除此之外的情形将会被认为是错误参数
  final int markerCount;

  ///漏斗标签marker的偏移量
  final Offset childOffset;

  ///漏斗标签marker的摆放位置
  final MarkerAlignment alignment;

  ///用于每层layer的绘制，可以继承[BrnFunnelLayerPainter]对每层的绘制进行定制
  final BrnFunnelLayerPainter layerPainter;

  ///Bruno风格的每层layer预设的颜色值，按顺序使用颜色值。实际层数超过该数量需要自行定义。
  static const List<Color> defaultLayerColors = [
    Color(0xFF3575FC),
    Color(0xFF0984F9),
    Color(0xFF6BB7FF),
    Color(0xFF93CAFF),
    Color(0xFFB5DBFF),
  ];

  BrnFunnelChart({
    Key? key,
    required this.layerCount,
    required this.markerCount,
    required this.layerPainter,
    required MarkerBuilder builder,
    this.shape = FunnelShape.leftAndRight,
    this.maxLayerWidth = 200,
    this.minLayerWidth = 0,
    this.layerHeight = 40,
    this.layerMargin = 0,
    this.childOffset = Offset.zero,
    this.alignment = MarkerAlignment.right,
  })  : assert(maxLayerWidth >= minLayerWidth),
        assert(layerCount - markerCount == 0 || layerCount - markerCount == 1),
        assert(() {
          if (shape == FunnelShape.leftOrRight &&
              alignment == MarkerAlignment.center) {
            debugPrint(
                '当shape为FunnelShape.LeftOrRight时，alignment为MarkerAlignment.center无效');
          }
          return true;
        }()),
        super(
            key: key,
            children: () {
              List<Widget> children = [];
              for (int i = 0; i < markerCount; i++) {
                children.add(builder(i));
              }
              return children;
            }());

  ///漏斗图默认Bruno风格的命名构造函数，[layerCount]不能大于[defaultLayerColors.length]。
  BrnFunnelChart.defaultStyle({
    Key? key,
    required this.layerCount,
    required this.markerCount,
    required MarkerBuilder builder,
    this.maxLayerWidth = 200,
    this.minLayerWidth = 0,
    this.layerHeight = 40,
    this.layerMargin = 0,
    this.childOffset = Offset.zero,
  })  : this.layerPainter = BrnDefaultFunnelLayerPainter(),
        this.shape = FunnelShape.leftAndRight,
        this.alignment = MarkerAlignment.right,
        assert(layerCount <= defaultLayerColors.length && layerCount >= 0),
        assert(maxLayerWidth >= minLayerWidth),
        assert(layerCount - markerCount == 0 || layerCount - markerCount == 1),
        super(
            key: key,
            children: () {
              List<Widget> children = [];
              for (int i = 0; i < markerCount; i++) {
                children.add(builder(i));
              }
              return children;
            }());

  @override
  RenderObject createRenderObject(BuildContext context) {
    return BrnFunnelRender(
      layerHeight: layerHeight,
      maxLayerWidth: maxLayerWidth,
      minLayerWidth: minLayerWidth,
      layerMargin: layerMargin,
      layerCount: layerCount,
      childOffset: childOffset,
      alignment: alignment,
      shape: shape,
      layerPainter: layerPainter,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderFunnelChart renderObject) {
    renderObject
      ..childOffset = childOffset
      ..maxLayerWidth = maxLayerWidth
      ..minLayerWidth = minLayerWidth
      ..layerHeight = layerHeight
      ..layerMargin = layerMargin
      ..layerCount = layerCount
      ..alignment = alignment
      ..layerPainter = layerPainter;
  }
}

class BrnFunnelChartParentData extends ContainerBoxParentData<RenderBox> {}

abstract class RenderFunnelChart extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, BrnFunnelChartParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, BrnFunnelChartParentData> {
  RenderFunnelChart({
    required double layerMargin,
    required double layerHeight,
    required int layerCount,
    required double maxLayerWidth,
    required double minLayerWidth,
    required Offset childOffset,
    required MarkerAlignment alignment,
    required BrnFunnelLayerPainter layerPainter,
  })  : _layerMargin = layerMargin,
        _layerHeight = layerHeight,
        _layerCount = layerCount,
        _maxLayerWidth = maxLayerWidth,
        _minLayerWidth = minLayerWidth,
        _childOffset = childOffset,
        _alignment = alignment,
        _layerPainter = layerPainter;

  MarkerAlignment _alignment;

  MarkerAlignment get alignment => _alignment;

  set alignment(MarkerAlignment value) {
    if (value == _alignment) return;
    _alignment = value;
    markNeedsLayout();
  }

  BrnFunnelLayerPainter get layerPainter => _layerPainter;

  BrnFunnelLayerPainter _layerPainter;

  set layerPainter(BrnFunnelLayerPainter value) {
    if (value == _layerPainter) return;
    _layerPainter = value;
    markNeedsPaint();
  }

  double get layerMargin => _layerMargin;

  double _layerMargin;

  set layerMargin(double value) {
    if (value == _layerMargin) return;
    _layerMargin = value;
    markNeedsLayout();
  }

  double get layerHeight => _layerHeight;

  double _layerHeight;

  set layerHeight(double value) {
    if (value == _layerHeight) return;
    _layerHeight = value;
    markNeedsLayout();
  }

  int get layerCount => _layerCount;

  int _layerCount;

  set layerCount(int value) {
    if (value == _layerCount) return;
    _layerCount = value;
    markNeedsLayout();
  }

  double get maxLayerWidth => _maxLayerWidth;

  double _maxLayerWidth;

  set maxLayerWidth(double value) {
    if (value == _maxLayerWidth) return;
    _maxLayerWidth = value;
    markNeedsLayout();
  }

  double get minLayerWidth => _minLayerWidth;

  double _minLayerWidth;

  set minLayerWidth(double value) {
    if (value == _minLayerWidth) return;
    _minLayerWidth = value;
    markNeedsLayout();
  }

  Offset get childOffset => _childOffset;

  Offset _childOffset;

  set childOffset(Offset value) {
    if (value == _childOffset) return;
    _childOffset = value;
    markNeedsLayout();
  }

  Offset centerOffset(Offset other) {
    final double centerX = other.dx / 2.0;
    final double centerY = other.dy / 2.0;
    return Offset(centerX, centerY);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    paintFunnel(context, offset);
    defaultPaint(context, offset);
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! BrnFunnelChartParentData)
      child.parentData = BrnFunnelChartParentData();
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return getIntrinsicDimensionHorizontal(
        height, (RenderBox child) => child.getMinIntrinsicWidth(height))!;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return getIntrinsicDimensionHorizontal(
        height, (RenderBox child) => child.getMinIntrinsicWidth(height))!;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return getIntrinsicDimensionVertical(
        width, (RenderBox child) => child.getMinIntrinsicHeight(width));
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return getIntrinsicDimensionVertical(
        width, (RenderBox child) => child.getMaxIntrinsicHeight(width));
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToHighestActualBaseline(baseline);
  }

  double? getIntrinsicDimensionHorizontal(
      double height, double mainChildSizeGetter(RenderBox child));

  double getIntrinsicDimensionVertical(
      double width, double mainChildSizeGetter(RenderBox child));

  void paintFunnel(PaintingContext context, Offset offset);
}

///漏斗图RenderObject
class BrnFunnelRender extends RenderFunnelChart {
  static const double HALF_PIXEL = 0.5;

  BrnFunnelRender({
    required double layerHeight,
    required double layerMargin,
    required int layerCount,
    required double maxLayerWidth,
    required double minLayerWidth,
    required Offset childOffset,
    bool? gradient,
    List<Color>? layerColors,
    required MarkerAlignment alignment,
    required BrnFunnelLayerPainter layerPainter,
    required FunnelShape shape,
  })  : _shape = shape,
        _paint = Paint()..isAntiAlias = true,
        super(
          layerCount: layerCount,
          layerHeight: layerHeight,
          layerMargin: layerMargin,
          maxLayerWidth: maxLayerWidth,
          minLayerWidth: minLayerWidth,
          childOffset: childOffset,
          alignment: alignment,
          layerPainter: layerPainter,
        );

  FunnelShape _shape;
  Paint _paint;

  bool _hasVisualOverflow = false;
  late Offset _overflowOffset;
  late Offset _centerOffset;

  @override
  double? getIntrinsicDimensionHorizontal(
      double height, double mainChildSizeGetter(RenderBox child)) {
    double? extent = maxLayerWidth;
    double intrinsicHeight = getIntrinsicDimensionVertical(null, null);
    RenderBox? child = firstChild;
    if (_alignment == MarkerAlignment.center) {
      while (child != null) {
        final BrnFunnelChartParentData childParentData =
            child.parentData as BrnFunnelChartParentData;
        extent = max(extent!, mainChildSizeGetter(child));
        child = childParentData.nextSibling;
      }
    } else {
      double top, bottom, left;
      int num = 0;
      while (child != null) {
        top = (num + 0.5) * layerHeight + num * layerMargin + childOffset.dy;
        bottom = top + layerMargin + layerHeight;
        left = (intrinsicHeight - bottom) *
                (maxLayerWidth - minLayerWidth) /
                intrinsicHeight +
            minLayerWidth +
            childOffset.dx;

        if (child == firstChild) {
          extent = max(extent!, left + mainChildSizeGetter(child));
        }
        num++;
        BrnFunnelChartParentData childParentData =
            child.parentData as BrnFunnelChartParentData;
        child = childParentData.nextSibling;
      }
    }
    return extent;
  }

  @override
  double getIntrinsicDimensionVertical(
      double? width, double mainChildSizeGetter(RenderBox child)?) {
    return layerCount * layerHeight + (layerCount - 1) * layerMargin;
  }

  @override
  void performLayout() {
    _hasVisualOverflow = false;
    double intrinsicWidth = maxLayerWidth;
    double intrinsicHeight = layerHeight * layerCount +
        (childCount >= layerCount
            ? layerMargin * childCount
            : layerMargin * (layerCount - 1));

    RenderBox? child = firstChild;
    late double top, bottom, left, right;
    int num = 0;
    while (child != null) {
      if (alignment == MarkerAlignment.center) {
        top = (num + 1) * layerHeight + num * layerMargin + childOffset.dy;
      } else {
        top = (num + 0.5) * layerHeight + num * layerMargin + childOffset.dy;
      }

      if (alignment == MarkerAlignment.center) {
        bottom = top + layerMargin;
      } else {
        bottom = top + layerMargin + layerHeight;
      }

      if (alignment == MarkerAlignment.center) {
        left = 0 + childOffset.dx;
        right = constraints.maxWidth;
      } else if (alignment == MarkerAlignment.right) {
        left = (intrinsicHeight - bottom) *
                (maxLayerWidth - minLayerWidth) /
                (2 * intrinsicHeight) +
            (minLayerWidth + maxLayerWidth) / 2 +
            childOffset.dx;
        right = constraints.maxWidth;
      } else if (alignment == MarkerAlignment.left) {
        left = 0;
        right = constraints.maxWidth -
            maxLayerWidth +
            bottom * (maxLayerWidth - minLayerWidth) / (2 * intrinsicHeight) +
            childOffset.dx;
      }

      final BrnFunnelChartParentData childParentData =
          child.parentData as BrnFunnelChartParentData;
      late BoxConstraints childConstraints;
      if (alignment == MarkerAlignment.center) {
        childConstraints = BoxConstraints(
            minWidth: 0,
            maxWidth: constraints.maxWidth,
            minHeight: 0,
            maxHeight: layerMargin);
      } else if (alignment == MarkerAlignment.right) {
        childConstraints = BoxConstraints(
            minWidth: 0,
            maxWidth: right - left > 0 ? right - left : 0,
            minHeight: 0,
            maxHeight: layerMargin + layerHeight);
      } else if (alignment == MarkerAlignment.left) {
        childConstraints = BoxConstraints(
            minWidth: 0,
            maxWidth: right - left > 0 ? right - left : 0,
            minHeight: 0,
            maxHeight: layerMargin + layerHeight);
      }
      child.layout(childConstraints, parentUsesSize: true);
      final Size childSize = child.size;
      if (alignment == MarkerAlignment.center) {
        intrinsicWidth = max(intrinsicWidth, childSize.width);
      } else if (alignment == MarkerAlignment.right) {
        intrinsicWidth = max(intrinsicWidth, left + childSize.width);
      } else if (alignment == MarkerAlignment.left) {
        intrinsicWidth = max(
            intrinsicWidth,
            maxLayerWidth +
                childSize.width -
                bottom *
                    (maxLayerWidth - minLayerWidth) /
                    (2 * intrinsicHeight));
      }
      num++;
      child = childParentData.nextSibling;
    }
    Size intrinsicSize = Size(intrinsicWidth, intrinsicHeight);
    if (intrinsicSize.width > constraints.maxWidth ||
        intrinsicSize.height > constraints.maxHeight) {
      _hasVisualOverflow = true;
    }
    size = constraints.constrain(intrinsicSize);
    _centerOffset = centerOffset(size - intrinsicSize as ui.Offset);
    if (_centerOffset.dx >= 0 && _centerOffset.dy >= 0) {
      //当实际尺寸比必须尺寸大时，需要居中偏移一下
      if (alignment == MarkerAlignment.left) {
        _centerOffset = _centerOffset * -1;
      } else if (alignment == MarkerAlignment.center) {
        _centerOffset = _centerOffset * 0;
      }
    } else {
      _centerOffset = Offset.zero;
    }
    _overflowOffset = Offset(
        intrinsicSize.width - size.width > 0
            ? intrinsicSize.width - size.width
            : 0,
        intrinsicSize.height - size.height > 0
            ? intrinsicSize.height - size.height
            : 0);
    num = 0;
    child = firstChild;
    while (child != null) {
      final BrnFunnelChartParentData childParentData =
          child.parentData as BrnFunnelChartParentData;
      if (alignment == MarkerAlignment.center) {
        childParentData.offset =
            Offset(0, ((num * layerMargin) + (num + 1) * layerHeight)) +
                _centerOffset;
      } else if (alignment == MarkerAlignment.right) {
        top = (num + 0.5) * layerHeight + num * layerMargin + childOffset.dy;
        bottom = top + layerMargin + layerHeight;
        left = (intrinsicHeight - bottom) *
                (maxLayerWidth - minLayerWidth) /
                (2 * intrinsicHeight) +
            (minLayerWidth + maxLayerWidth) / 2 +
            childOffset.dx;
        childParentData.offset = Offset(left, top) + _centerOffset;
      } else if (alignment == MarkerAlignment.left) {
        top = (num + 0.5) * layerHeight + num * layerMargin + childOffset.dy;
        bottom = top + layerMargin + layerHeight;
        right = size.width -
            maxLayerWidth +
            (bottom) * (maxLayerWidth - minLayerWidth) / (2 * intrinsicHeight) +
            childOffset.dx;
        left = right - child.size.width;
        childParentData.offset = Offset(left, top) + _centerOffset;
      }
      num++;
      child = childParentData.nextSibling;
    }
  }

  @override
  void paintFunnel(PaintingContext context, Offset offset) {
    Canvas canvas = context.canvas;
    canvas.save();
    Rect rect = (offset + _centerOffset) & size;
    canvas.clipRect(rect);
    _paint.blendMode = BlendMode.srcOver;
    canvas.saveLayer(rect, _paint);
    canvas.translate(rect.left, rect.top);

    //绘制漏斗layer
    for (int i = 0; i < layerCount; i++) {
      late Offset topLeft, bottomRight;
      if (alignment == MarkerAlignment.center) {
        topLeft = Offset((size.width - maxLayerWidth) / 2,
            i * layerHeight + i * layerMargin);
        bottomRight = Offset((size.width + maxLayerWidth) / 2,
            (i + 1) * layerHeight + i * layerMargin);
        //绘制背景
      } else if (alignment == MarkerAlignment.right) {
        topLeft = Offset(0, i * layerHeight + i * layerMargin);
        bottomRight =
            Offset(maxLayerWidth, (i + 1) * layerHeight + i * layerMargin);
      } else if (alignment == MarkerAlignment.left) {
        topLeft = Offset(
            size.width - maxLayerWidth, i * layerHeight + i * layerMargin);
        bottomRight =
            Offset(size.width, (i + 1) * layerHeight + i * layerMargin);
      }
      //绘制layer背景色
      if (!layerPainter.isGradient(i)) {
        //单色背景
        _paint.color = layerPainter.getLayerColors(i)[0];
        canvas.drawRect(Rect.fromPoints(topLeft, bottomRight), _paint);
      } else {
        //渐变背景
        ui.Gradient gradient = ui.Gradient.linear(
            topLeft, bottomRight, layerPainter.getLayerColors(i));
        _paint.shader = gradient;
        canvas.drawRect(Rect.fromPoints(topLeft, bottomRight), _paint);
      }

      //绘制layer文案
      late double safeLeft, safeTop, safeRight, safeBottom;
      if (_shape == FunnelShape.leftAndRight) {
        safeTop = i * layerHeight + i * layerMargin;
        if (alignment == MarkerAlignment.right) {
          safeLeft = ((i + 1) * layerHeight + i * layerMargin) *
              (maxLayerWidth - minLayerWidth) /
              (size.height * 2);
          safeRight = maxLayerWidth -
              ((i + 1) * layerHeight + i * layerMargin) *
                  (maxLayerWidth - minLayerWidth) /
                  (size.height * 2);
        } else if (alignment == MarkerAlignment.left) {
          safeLeft = size.width -
              maxLayerWidth +
              ((i + 1) * layerHeight + i * layerMargin) *
                  (maxLayerWidth - minLayerWidth) /
                  (size.height * 2);
          safeRight = size.width -
              ((i + 1) * layerHeight + i * layerMargin) *
                  (maxLayerWidth - minLayerWidth) /
                  (size.height * 2);
        } else {
          safeLeft = (size.width - maxLayerWidth) / 2 +
              ((i + 1) * layerHeight + i * layerMargin) *
                  (maxLayerWidth - minLayerWidth) /
                  (size.height * 2);
          safeRight = (size.width + maxLayerWidth) / 2 -
              ((i + 1) * layerHeight + i * layerMargin) *
                  (maxLayerWidth - minLayerWidth) /
                  (size.height * 2);
        }
        safeBottom = safeTop + layerHeight;
      } else {
        safeTop = i * layerHeight + i * layerMargin;
        safeBottom = safeTop + layerHeight;

        if (alignment == MarkerAlignment.right) {
          safeLeft = 0;
          safeRight = maxLayerWidth -
              ((i + 1) * layerHeight + i * layerMargin) *
                  (maxLayerWidth - minLayerWidth) /
                  (size.height * 2);
        } else if (alignment == MarkerAlignment.left) {
          safeLeft = size.width -
              maxLayerWidth +
              ((i + 1) * layerHeight + i * layerMargin) *
                  (maxLayerWidth - minLayerWidth) /
                  (size.height * 2);
          safeRight = maxLayerWidth;
        } else {
          safeLeft = 0;
          safeRight = maxLayerWidth;
        }
      }
      layerPainter.paintLayer(
          canvas, safeLeft, safeTop, safeRight, safeBottom, i);
    }
    _paint
      ..blendMode = BlendMode.dstOut
      ..style = PaintingStyle.fill
      ..shader = null;
    late double topLeftX;
    if (alignment == MarkerAlignment.center) {
      topLeftX = (size.width - maxLayerWidth) / 2;
    } else if (alignment == MarkerAlignment.right) {
      topLeftX = 0;
    } else if (alignment == MarkerAlignment.left) {
      topLeftX = size.width - maxLayerWidth;
    }

    Path path;
    if (_shape == FunnelShape.leftAndRight ||
        alignment == MarkerAlignment.left) {
      path = Path();
      //这里为什么都加了HALF_PIXEL，是因为裁剪的时候边缘会留下一定像素的误差。
      //这里的解决方式就是提高半个像素的裁剪范围
      //https://github.com/flutter/flutter/issues/70592
      //高版本flutter无此问题
      path.moveTo(topLeftX - HALF_PIXEL, -HALF_PIXEL);
      path.lineTo(topLeftX - HALF_PIXEL, size.height + HALF_PIXEL);
      path.lineTo((maxLayerWidth - minLayerWidth) / 2 + topLeftX,
          size.height + HALF_PIXEL);
      path.close();
      canvas.drawPath(path, _paint);
    }

    if (_shape == FunnelShape.leftAndRight ||
        alignment == MarkerAlignment.right) {
      path = Path();
      path.moveTo(maxLayerWidth + topLeftX + HALF_PIXEL, -HALF_PIXEL);
      path.lineTo(
          maxLayerWidth + topLeftX + HALF_PIXEL, size.height + HALF_PIXEL);
      path.lineTo((maxLayerWidth + minLayerWidth) / 2 + topLeftX,
          size.height + HALF_PIXEL);
      path.close();
      canvas.drawPath(path, _paint);
    }

    assert(() {
      if (_hasVisualOverflow) {
        _paintOverflowIndicator(canvas, size);
      }
      return true;
    }());
    canvas.restore();
    canvas.restore(); //restore和save次数要一致
  }

  void _paintOverflowIndicator(Canvas canvas, Size size) {
    TextStyle _indicatorTextStyle = TextStyle(
      color: Color(0xFF900000),
      fontSize: 7.5,
      fontWeight: FontWeight.w800,
    );
    TextSpan span = TextSpan(
      text:
          'Space insufficient to draw，need more width ${_overflowOffset.dx} and height ${_overflowOffset.dy}',
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

///漏斗每层绘制接口类，自定义每层绘制继承该类。示例查看[BrnDefaultFunnelLayerPainter]。
abstract class BrnFunnelLayerPainter {
  ///该层layer的颜色是否渐变
  bool isGradient(int layerIndex);

  ///该层layer的颜色值
  List<Color> getLayerColors(int layerIndex);

  ///当需要绘制Layer的时候，会调用该方法。子类在该方法里实现自己的绘制逻辑。
  ///[canvas] 提供的画布，对画布进行旋转裁剪等特殊操作，一定要调用[canvas.save()]操作。
  ///[left],[top],[right],[bottom]是提供给调用者绘制的一个安全区域，超过这个区域限制，可能会被截断
  ///[layerIndex] 漏斗的layer index。
  void paintLayer(Canvas canvas, double left, double top, double right,
      double bottom, int layerIndex);
}

///漏斗图默认LayerPainter,在漏斗每层layer中间绘制文案，每层的颜色值使用Bruno预设的颜色。
class BrnDefaultFunnelLayerPainter extends BrnFunnelLayerPainter {
  ///每层漏斗文案TextStyle
  final TextStyle textStyle;

  ///漏斗每一层的标题文案，长度应该与[layerCount]一致。
  final List<String> titles;

  TextPainter _textPainter;

  BrnDefaultFunnelLayerPainter({
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 14),
    this.titles = const <String>[],
  }) : _textPainter = TextPainter()..textDirection = TextDirection.ltr;

  @override
  void paintLayer(Canvas canvas, double left, double? top, double right,
      double bottom, int layerIndex) {
    if (layerIndex >= titles.length) {
      return;
    }
    //绘制每层标题
    TextSpan span = TextSpan(text: titles[layerIndex], style: textStyle);
    _textPainter
      ..text = span
      ..layout();
    _textPainter.paint(
      canvas,
      Offset((left + right - _textPainter.width) / 2,
          (top! + bottom - _textPainter.height) / 2),
    );
  }

  @override
  List<ui.Color> getLayerColors(int layerIndex) {
    if (layerIndex >= BrnFunnelChart.defaultLayerColors.length) {
      //超过最大支持的layer层数
      return [Colors.white];
    }
    return [BrnFunnelChart.defaultLayerColors[layerIndex]];
  }

  @override
  bool isGradient(int layerIndex) {
    return false;
  }
}

///漏斗图表的形状
enum FunnelShape {
  ///两边从上往下都缩小
  leftAndRight,

  ///一边从上往下缩小
  leftOrRight,
}

///漏斗标签的摆放位置
enum MarkerAlignment {
  ///标签在漏斗的右边.
  right,

  ///标签在漏斗的左边.
  left,

  ///标签在漏斗相邻的两层之间
  center,
}
