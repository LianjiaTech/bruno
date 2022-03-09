

import 'package:flutter/material.dart';

class BrnProgressChartPainter extends CustomPainter {
  /// 进度值
  final double value;

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
      this.colors = const [Color(0xFF1545FD), Color(0xFF0984F9)],
      this.backgroundColor = const Color(0x7A90C9FF),
      this.radius = 4,
      this.alwaysShowRadius = true});

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = this.backgroundColor
      ..style = PaintingStyle.fill;

    Rect backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);
    if (this.alwaysShowRadius) {
      RRect backgroundRRect = RRect.fromRectAndCorners(backgroundRect,
          bottomRight: Radius.circular(value < 1 ? 0 : this.radius),
          topRight: Radius.circular(value < 1 ? 0 : this.radius));
      canvas.drawRRect(backgroundRRect, backgroundPaint);
    } else {
      canvas.drawRect(backgroundRect, backgroundPaint);
    }

    Rect progressBarRect = Rect.fromLTWH(0, 0, size.width * value, size.height);

    RRect progressBarRRect = RRect.fromRectAndCorners(progressBarRect,
        bottomRight: Radius.circular(
            1 == value && false == this.alwaysShowRadius ? 0 : this.radius),
        topRight: Radius.circular(
            1 == value && false == this.alwaysShowRadius ? 0 : this.radius));

    Shader progressBarShader = LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp,
            colors: (this.colors.length > 1)
                ? this.colors
                : [this.colors[0], this.colors[0]])
        .createShader(progressBarRect);
    Paint progressBarPaint = Paint()..shader = progressBarShader;

    canvas.drawRRect(progressBarRRect, progressBarPaint);
  }

  @override
  bool shouldRepaint(BrnProgressChartPainter oldDelegate) {
    return this.value != oldDelegate.value;
  }
}
