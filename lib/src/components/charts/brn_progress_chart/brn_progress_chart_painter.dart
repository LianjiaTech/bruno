

import 'package:flutter/material.dart';

/// 绘制 BrnProgressChart 进度条
class BrnProgressChartPainter extends CustomPainter {
  /// 进度值
  final double value;

  /// 动画
  final Animation<double>? animation;

  /// 背景色
  final Color backgroundColor;

  /// 进度条颜色数组
  final List<Color> colors;

  /// 圆角大小
  final double radius;

  /// 是否在进度值为最大的时候也展示圆角
  final bool alwaysShowRadius;

  BrnProgressChartPainter(
      {this.value = 0.2,
      this.animation,
      this.colors = const [Color(0xFF1545FD), Color(0xFF0984F9)],
      this.backgroundColor = const Color(0x7A90C9FF),
      this.radius = 4,
      this.alwaysShowRadius = true})
      : super(repaint: animation){
    assert(colors.isNotEmpty, 'colors must not be empty');
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double curValue = animation?.value ?? this.value;
    Paint backgroundPaint = Paint()
      ..color = this.backgroundColor
      ..style = PaintingStyle.fill;

    Rect backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);
    if (this.alwaysShowRadius) {
      RRect backgroundRRect = RRect.fromRectAndCorners(backgroundRect,
          bottomRight: Radius.circular(curValue < 1 ? 0 : this.radius),
          topRight: Radius.circular(curValue < 1 ? 0 : this.radius));
      canvas.drawRRect(backgroundRRect, backgroundPaint);
    } else {
      canvas.drawRect(backgroundRect, backgroundPaint);
    }

    Rect progressBarRect = Rect.fromLTWH(0, 0, size.width * curValue, size.height);

    RRect progressBarRRect = RRect.fromRectAndCorners(progressBarRect,
        bottomRight: Radius.circular(
            1 == curValue && false == this.alwaysShowRadius ? 0 : this.radius),
        topRight: Radius.circular(
            1 == curValue && false == this.alwaysShowRadius ? 0 : this.radius));
    final bool isNotSingleColor = colors.length > 1;
    Paint progressBarPaint = Paint();
    if (isNotSingleColor) {
      progressBarPaint.shader = LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              tileMode: TileMode.clamp,
              colors: colors)
          .createShader(progressBarRect);
    } else {
      progressBarPaint.color = colors[0];
    }

    canvas.drawRRect(progressBarRRect, progressBarPaint);
  }

  @override
  bool shouldRepaint(BrnProgressChartPainter oldDelegate) {
    return false;
  }
}
