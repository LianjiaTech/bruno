import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/material.dart';

/// 脉冲组件, 样式为循环扩大的小圆点
class PulseWidget extends StatefulWidget {
  final double width;
  final double height;

  const PulseWidget({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  _PulseWidgetState createState() => _PulseWidgetState();
}

class _PulseWidgetState extends State<PulseWidget>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _alphaAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 1400),
      upperBound: 1,
      lowerBound: 0,
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 700),
      upperBound: 1,
      lowerBound: 0,
      vsync: this,
    );
    _alphaAnimation = Tween(begin: 0.0, end: 2.0).animate(_fadeController);
    _scaleController.repeat();
    _fadeController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: FadeTransition(
              opacity: _alphaAnimation,
              child: ScaleTransition(
                scale: _scaleController,
                child: CustomPaint(
                  painter: CirclePainter(BrnThemeConfigurator.instance
                      .getConfig()
                      .commonConfig
                      .brandPrimary),
                  size: Size(widget.width, widget.height),
                ),
              ),
            ),
          ),
          Positioned(
            top: widget.width / 4,
            left: widget.width / 4,
            bottom: widget.width / 4,
            right: widget.width / 4,
            child: CustomPaint(
              painter: CirclePainter(BrnThemeConfigurator.instance
                  .getConfig()
                  .commonConfig
                  .brandPrimary),
              size: Size(widget.width / 2, widget.height / 2),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}

class CirclePainter extends CustomPainter {
  final Color color;

  CirclePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
