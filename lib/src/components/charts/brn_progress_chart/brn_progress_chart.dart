

import 'package:bruno/src/components/charts/brn_progress_chart/brn_progress_chart_painter.dart';
import 'package:flutter/foundation.dart';
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

  /// 动画时长,默认 Duration(milliseconds: 250)
  final Duration duration;

  /// 进度条是否从上次的值开始
  final bool isFromLastValue;

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
      this.showAnimation = false,
      this.isFromLastValue = false,
      this.duration = const Duration(milliseconds: 250),})
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
  late AnimationController _animationController =
      AnimationController(vsync: this);
  double _lastValue = 0;

  bool get _isAnimation => widget.showAnimation;

  void _initAnimation() {
    final double begin = widget.isFromLastValue ? _lastValue : 0;
    final double end = widget.value;
    final Tween<double> tween = Tween<double>(begin: begin, end: end);
    _animationController.duration =
        _isAnimation ? widget.duration : Duration.zero;
    _animation = tween.animate(_animationController);
    _animationController.reset();
    _animationController.forward();
    _lastValue = end;
  }

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void didUpdateWidget(covariant BrnProgressChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (_animationController.isAnimating == true) {
        _animationController.stop();
      }
      _initAnimation();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _value = widget.value;
    return Stack(
      children: <Widget>[
        CustomPaint(
          size: Size(widget.width, widget.height),
          painter: BrnProgressChartPainter(
            value: _value,
            animation: _animation,
            backgroundColor: widget.backgroundColor,
            colors: widget.colors,
          ),
        ),
        Container(
          width: widget.width,
          height: widget.height,
          padding: EdgeInsets.only(left: widget.indicatorLeftPadding),
          alignment: Alignment.centerLeft,
          child: IndicatorWidgetBuilder(
            notifier: _animation,
            value: _value,
            textStyle: widget.textStyle,
            brnProgressIndicatorBuilder: widget.brnProgressIndicatorBuilder,
          ),
        )
      ],
    );
  }
}

class IndicatorWidgetBuilder extends StatefulWidget {
  const IndicatorWidgetBuilder({
    Key? key,
    required this.value,
    required this.textStyle,
    this.notifier,
    this.brnProgressIndicatorBuilder,
  }) : super(key: key);

  final ValueListenable<double>? notifier;
  final double value;
  final TextStyle textStyle;
  final BrnProgressIndicatorBuilder? brnProgressIndicatorBuilder;

  @override
  State<IndicatorWidgetBuilder> createState() => _IndicatorWidgetBuilderState();
}

class _IndicatorWidgetBuilderState extends State<IndicatorWidgetBuilder> {
  late double _value;

  void _changeListener() {
    final double value = widget.notifier?.value ?? widget.value;
    if(!mounted) return;
    setState(() {
      _value = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    widget.notifier?.addListener(_changeListener);
  }

  @override
  void dispose() {
    widget.notifier?.removeListener(_changeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BrnProgressIndicatorBuilder? builder =
        widget.brnProgressIndicatorBuilder;
    return builder?.call(context, _value) ??
        Text('$_value', style: widget.textStyle);
  }
}
