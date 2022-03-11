import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/material.dart';

///[index]这个属性主要是为了给左边的时间轴画部件来用的
///[timeAxisSize]时间轴的大小必须要的。
///
///线条顶部小圆点的大小
const double _roundSize = 12;

/// 线条和小圆点之间的间距
const double _roundSpace = 4;

/// 在[contentWidget]的左侧自动添加 竖向步骤条的组件
///
/// 支持[isDashLine]是否为虚线，在虚线的情况下，支持设置虚线每一段的间隔[dashSpace]和每个虚线段的长度[dashLength].
///
/// 线的顶端是图片，支持[iconWidget]配置。
///
/// 常用情况：
///    快递时间节点、跟进时间节点、日历时间节点等等
///
/// 如果不想显示分割线，那么可以将[lineColor] 设置为透明色
///
/// 该组件支持设置为灰色模式[isGrey]，在灰色模式下 线条颜色和icon颜色都是灰色
///
/// 布局步骤同[CustomPaint],因此[iconWidget]和[contentWidget]是顶部对齐的。
/// 如果想要设置icon的偏移，可以通过[iconTopPadding]设置
///
/// 最后一个的竖线不显示
///  ListView.builder(
///      shrinkWrap: true,
///      physics: NeverScrollableScrollPhysics(),
///      itemCount: 5,
///      itemBuilder: (context, index) {
///          if (index == 4) {
///             return BrnStepLineWidget(
///                     lineWidth: 1,
///                     lineColor: Colors.transparent,
///                     contentWidget: Container(
///                       height: 50,
///                       color: getRandomColor(),
///                     ),
///                   );
///                 }
///          return BrnStepLineWidget(
///                   lineWidth: 1,
///                   contentWidget: Container(
///                     height: 50,
///                     color: getRandomColor(),
///                ),
///          );
///   },
/// ),
///
/// 最后一个的竖线有颜色变化
///  ListView.builder(
///      shrinkWrap: true,
///      physics: NeverScrollableScrollPhysics(),
///      itemCount: 5,
///      itemBuilder: (context, index) {
///           if (index == 4) {
///              return BrnStepLineWidget(
///                     lineWidth: 1,
///                     lineColor: <Color>[
///                       Color(0xFF0984F9),
///                       Colors.red,
///                     ],
///                     contentWidget: Container(
///                       height: 60,
///                       color: getRandomColor(),
///                     ),
///               );
///           }
///          return BrnStepLineWidget(
///                   lineWidth: 1,
///                   contentWidget: Container(
///                     height: 50,
///                     color: getRandomColor(),
///                ),
///          );
///   },
/// ),
///
class BrnStepLine extends StatefulWidget {
  ///整体是否是灰色，true 则使用normalColor，否则使用highlightColor
  final bool isGrey;

  ///边框线的颜色：必须是Color 或者 List<Color>，如果为null，则会根据isGrey来使用normalColor或highlightColor
  final dynamic lineColor;

  /// 边框包裹的widget
  final Widget contentWidget;

  /// 线的宽度
  final double lineWidth;

  /// icon距离顶部的padding
  final double iconTopPadding;

  /// 是否画虚线
  final bool isDashLine;

  /// 每段虚线的长度
  final double dashLength;

  /// 每段虚线的间隔
  final double dashSpace;

  /// contentWidget距离左侧的padding
  final double contentLeftPadding;

  /// 普通状态(isGrey=true)的颜色，默认值： Color(0xffeeeeee)
  final Color? normalColor;

  /// 高亮状态(isGrey=false)的颜色，默认值，主题色
  final Color? highlightColor;

  /// 自定义icon的widget
  final Widget? iconWidget;

  const BrnStepLine({
    Key? key,
    required this.contentWidget,
    this.isGrey = false,
    this.lineColor,
    this.lineWidth = 2,
    this.iconTopPadding = 0,
    this.isDashLine = false,
    this.dashLength = 4,
    this.dashSpace = 4,
    this.contentLeftPadding = 12,
    this.normalColor,
    this.highlightColor,
    this.iconWidget,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BrnStepLineState();
  }
}

class _BrnStepLineState extends State<BrnStepLine> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: _BrnStepLinePainter(
            paintWidth: widget.lineWidth,
            iconTopPadding: widget.iconTopPadding,
            lineColor: _buildLineColor(),
            isDash: widget.isDashLine,
            dashLength: widget.dashLength,
            dashSpace: widget.dashSpace,
          ),
          child: Container(
            padding: EdgeInsets.only(left: widget.contentLeftPadding),
            child: Container(
              child: widget.contentWidget,
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: widget.iconTopPadding),
            child: widget.iconWidget ??
                (widget.isGrey ? _buildGreyCircle() : _buildHighLightCircle())),
      ],
    );
  }

  List<Color> _buildLineColor() {
    List<Color> lineColor = [];

    if (widget.lineColor != null) {
      if (widget.lineColor is Color) {
        lineColor.clear();
        lineColor.add(widget.lineColor);
        return lineColor;
      } else if (widget.lineColor is List<Color>) {
        lineColor.clear();
        lineColor.addAll(widget.lineColor);
        return lineColor;
      } else {
        lineColor.clear();
        lineColor.add(widget.highlightColor ??
            BrnThemeConfigurator.instance
                .getConfig()
                .commonConfig
                .brandPrimary);
        return lineColor;
      }
    } else {
      if (widget.isGrey) {
        return [widget.normalColor ?? const Color(0xffeeeeee)];
      }
      return [
        widget.highlightColor ??
            BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary
      ];
    }
  }

  Widget _buildGreyCircle() {
    return _buildColorCircleWidget(
        widget.normalColor ?? const Color(0xffeeeeee));
  }

  Widget _buildHighLightCircle() {
    return _buildColorCircleWidget(widget.highlightColor ??
        BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary);
  }

  Widget _buildColorCircleWidget(Color color) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.2),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}

class _BrnStepLinePainter extends CustomPainter {
  final List<Color> lineColor;

  /// 边框的宽度
  final double paintWidth;

  /// icon距离顶部的padding
  final double iconTopPadding;

  /// 是否绘制虚线
  final bool isDash;

  /// 虚线的间隔
  final double dashSpace;

  /// 虚线的长度
  final double dashLength;

  _BrnStepLinePainter(
      {required this.lineColor,
      this.paintWidth = 1,
      required this.iconTopPadding,
      required this.isDash,
      required this.dashSpace,
      required this.dashLength});

  final Paint _paint = Paint()
    ..strokeCap = StrokeCap.round // 画笔笔触类型
    ..isAntiAlias = true; // 是否启动抗锯齿;

  @override
  void paint(Canvas canvas, Size size) {
    _paint.style = PaintingStyle.stroke; // 画线模式
    _paint.strokeWidth = paintWidth;

    /// 总长度 16是icon的长度 4是线条不通栏
    double height = size.height - 16 - 4;
    if (height <= 0) {
      return;
    }
    if (!isDash) {
      _drawFillLine(height, canvas);
    } else {
      _drawDashLine(canvas, size);
    }
  }

  void _drawDashLine(Canvas canvas, Size size) {
    //起始的位置 icon的大小+线条间距+自定义的padding设置
    double ori = _roundSize + _roundSpace + iconTopPadding;
    double temp = ori;
    //线条总长度 child的大小-上下的通栏-icon
    double height = size.height - ori - _roundSpace;
    //一共多少段
    int count = (height / (dashLength + dashSpace)).ceil();

    for (int i = 0, n = count; i < n; i++) {
      Path path = Path();
      path.moveTo(_roundSize / 2, temp);
      if (temp + dashLength < size.height - _roundSpace) {
        temp += dashLength;

        path.lineTo(_roundSize / 2, temp);
        canvas.drawPath(path, _paint..color = lineColor[0]);
        if (temp + dashSpace < size.height - _roundSpace) {
          temp += dashSpace;
          path.lineTo(_roundSize / 2, temp);
          canvas.drawPath(path, _paint..color = Colors.transparent);
        } else {
          path.lineTo(_roundSize / 2, size.height - _roundSpace);
          canvas.drawPath(path, _paint..color = Colors.transparent);
        }
      } else {
        path.lineTo(_roundSize / 2, size.height - _roundSpace);
        canvas.drawPath(path, _paint..color = lineColor[0]);
      }
    }
  }

  void _drawFillLine(double height, Canvas canvas) {
    double selection = height / lineColor.length;

    /// 起始的位置 12是icon的长度 4是线条不通栏 化线的起点：icon的长度+自定义的icon的偏移量
    double temp = 12 + 4 + iconTopPadding;
    for (int i = 0, n = lineColor.length; i < n; ++i) {
      _paint.color = lineColor[i];
      Path _path = Path();
      _path.moveTo(6, temp);
      _path.lineTo(6, temp + selection);
      temp += selection;
      canvas.drawPath(_path, _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
