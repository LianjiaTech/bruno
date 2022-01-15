

import 'package:bruno/src/components/charts/brn_progress_chart/brn_progress_chart_painter.dart';
import 'package:flutter/material.dart';

/// 在进度条上展示的 Widget
typedef BrnProgressIndicatorBuilder = Widget Function(
    BuildContext context, double value);

/// 一个简单的进度条 Widget，支持数据变化时的动画
class BrnProgressChart extends StatefulWidget {
  /// 宽度，默认0
  final double width;

  /// 高度，默认0
  final double height;

  /// 进度图进度值，默认0.2，必须在 0 到 1 之间
  final double value;

  /// 进度条上自定义Widget的左侧padding，默认值10
  final double indicatorLeftPadding;

  /// 展示默认进度indicator的时候的文本样式，默认 TextStyle(color: Colors.white)
  final TextStyle textStyle;

  /// 自定义进度条上面的Widget，默认显示为文本
  final BrnProgressIndicatorBuilder? brnProgressIndicatorBuilder;

  /// 背景色，默认 Colors.lightBlueAccent
  final Color backgroundColor;

  /// 进度条颜色，默认 [Colors.blueAccent, Colors.blue]
  final List<Color> colors;

  /// 是否展示动画，默认 false
  final bool showAnimation;

  const BrnProgressChart(
      {Key? key,
      this.width = 0,
      this.height = 0,
      this.value = 0.2,
      this.indicatorLeftPadding = 10,
      this.textStyle = const TextStyle(color: Colors.white),
      this.brnProgressIndicatorBuilder,
      this.colors = const [Colors.blueAccent, Colors.blue],
      this.backgroundColor = Colors.lightBlueAccent,
      this.showAnimation = false})
      : assert(0 <= value && value <= 1, 'value 必须在 0 到 1 之间'),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BrnProgressChartState();
  }
}

class BrnProgressChartState extends State<BrnProgressChart>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  AnimationController? _animationController;
  double _value = 0;

  @override
  void initState() {
    super.initState();
    if (widget.showAnimation) {
      _animationController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 250));
      Tween tween = Tween<double>(begin: 0, end: widget.value);
      _animation = tween.animate(_animationController!) as Animation<double>;
      _animation.addListener(() {
        setState(() {
          _value = _animation.value;
        });
      });
      _animationController!.forward();
    } else {
      _value = widget.value;
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Widget _indicatorWidgetBuilder(BuildContext context, double value) {
    return Text(
      '$value',
      style: widget.textStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomPaint(
          size: Size(widget.width, widget.height),
          painter: BrnProgressChartPainter(value: _value),
        ),
        Container(
          width: widget.width,
          height: widget.height,
          padding: EdgeInsets.only(left: widget.indicatorLeftPadding),
          alignment: Alignment.centerLeft,
          child: null != widget.brnProgressIndicatorBuilder
              ? widget.brnProgressIndicatorBuilder!(context, _value)
              : _indicatorWidgetBuilder(context, _value),
        )
      ],
    );
  }
}
