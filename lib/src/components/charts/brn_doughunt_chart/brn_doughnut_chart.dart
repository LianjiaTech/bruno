import 'dart:math';

import 'package:flutter/material.dart';

/// BrnDoughnutDataItem 饼状图展示所使用的数据
/// 设置数据的数值、标题、颜色
class BrnDoughnutDataItem {
  /// 当前区域值
  final double value;

  /// 区域标题
  final String title;

  ///扇形区域颜色
  final Color color;

  /// 当前数据占百分比
  double percentage = 0;

  /// 起始位置
  double startRadius = 0;

  /// 中间位置
  double middleRadius = 0;

  /// 占用位置
  double radius = 0;

  BrnDoughnutDataItem({
    required this.value,
    required this.title,
    this.color = Colors.blueAccent,
  });
}

/// 选中扇形区域后执行的回调
typedef BrnDoughnutSelectCallback = void Function(
    BrnDoughnutDataItem? selectedItem);

class BrnDoughnut extends CustomPainter {
  ///圆心位置
  late Offset circleCenter;

  /// 选中的区域
  final BrnDoughnutDataItem? selectedItem;

  /// 选中区域回调
  final BrnDoughnutSelectCallback? brnDoughnutSelectCallback;

  /// 字体大小
  final double fontSize;

  /// 字体颜色
  final Color fontColor;

  /// 圆环宽度
  final int ringWidth;

  /// 仅在选中时展示 title 为 true 时仅在选中项目时才展示title。
  final bool showTitleWhenSelected;

  /// 数据
  final List<BrnDoughnutDataItem> data;

  /// 计算的数据总量
  double totalValue = 0;

  /// 文本水平间距
  double textHorizontalPadding = 5;

  /// 文本垂直间距
  double textVerticalPadding = 5;

  BrnDoughnut(
      {this.ringWidth = 50,
      required this.data,
      this.fontSize = 12,
      this.fontColor = Colors.white,
      this.selectedItem,
      this.showTitleWhenSelected = false,
      this.brnDoughnutSelectCallback}) {
    double lastEndRadius = 0;
    double totalValue = 0;
    this.data.forEach((BrnDoughnutDataItem item) {
      totalValue += item.value;
    });
    this.data.forEach((BrnDoughnutDataItem item) {
      item.percentage = item.value / totalValue;
      item.startRadius = lastEndRadius;
      item.radius = 2 * pi * item.percentage;
      item.middleRadius = lastEndRadius + pi * item.percentage;
      lastEndRadius = item.startRadius + item.radius;
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    double minLength = size.width < size.height ? size.width : size.height;
    double outterCircleRadius = minLength / 2;
    double innerCircleRadius = outterCircleRadius - this.ringWidth >= 0
        ? outterCircleRadius - this.ringWidth
        : 30.0;

    double indicatorLCircleRadius = outterCircleRadius - 5;
    double indicatorRCircleRadius = outterCircleRadius + 8;

    Rect drawArea = Rect.fromLTWH(0, 0, size.width, size.height);
    Offset center = drawArea.center;
    circleCenter = center;

    this.data.forEach((BrnDoughnutDataItem item) {
      // 画扇形
      Paint _paint = Paint()
        ..color = item.color
        ..strokeCap = StrokeCap.round
        ..isAntiAlias = true
        ..strokeWidth = 2
        ..style = PaintingStyle.fill;

      Rect rect = Rect.fromCircle(center: center, radius: outterCircleRadius);
      if (item.startRadius == selectedItem?.startRadius) {
        rect = Rect.fromCircle(center: center, radius: outterCircleRadius + 5);
      }
      canvas.drawArc(rect, item.startRadius, item.radius, true, _paint);

      // 画文本
      if (this.showTitleWhenSelected == false ||
          item.startRadius == selectedItem?.startRadius) {
        // 画引线
        Offset indicarorLPoint =
            calcOffsetWith(item.middleRadius, indicatorLCircleRadius);
        Offset indicatorRPoint =
            calcOffsetWith(item.middleRadius, indicatorRCircleRadius);
        Offset revisedIndicarorLPoint = Offset(
          indicarorLPoint.dx + center.dx.roundToDouble(),
          indicarorLPoint.dy + center.dy.roundToDouble(),
        );
        Offset revisedIndicatorRPoint = Offset(
          indicatorRPoint.dx + center.dx.roundToDouble(),
          indicatorRPoint.dy + center.dy.roundToDouble(),
        );

        Paint _paintIndicator = Paint()
          ..color = item.color
          ..strokeCap = StrokeCap.round
          ..isAntiAlias = true
          ..strokeWidth = 1
          ..style = PaintingStyle.fill;
        canvas.drawLine(
            revisedIndicarorLPoint, revisedIndicatorRPoint, _paintIndicator);

        /// 画水平线
        Offset indicatorEndOffset = calcHorizontalOffset(
            revisedIndicarorLPoint, revisedIndicatorRPoint);
        canvas.drawLine(
            revisedIndicatorRPoint, indicatorEndOffset, _paintIndicator);

        TextStyle textStyle =
            TextStyle(fontSize: this.fontSize, color: this.fontColor);

        TextPainter textPainter = TextPainter(
            text: TextSpan(text: item.title, style: textStyle),
            textDirection: TextDirection.ltr)
          ..layout(maxWidth: double.infinity, minWidth: 0);

        double textWidth = textPainter.size.width;
        double textHeight = textPainter.size.height;

        //画背景
        Offset baseRectCenter = Offset(
            indicatorEndOffset.dx > revisedIndicatorRPoint.dx
                ? indicatorEndOffset.dx +
                    textWidth / 2 +
                    this.textHorizontalPadding
                : indicatorEndOffset.dx -
                    textWidth / 2 -
                    this.textHorizontalPadding,
            indicatorEndOffset.dy);
        Rect baseRect = Rect.fromCenter(
            center: baseRectCenter,
            width: textWidth + this.textHorizontalPadding * 2,
            height: textHeight + this.textVerticalPadding * 2);
        RRect rRect = RRect.fromRectAndRadius(baseRect, Radius.circular(2));
        Paint textBackgroundPaint = Paint()
          ..color = Colors.black.withOpacity(0.7);
        canvas.drawRRect(rRect, textBackgroundPaint);

        textPainter.paint(
            canvas,
            Offset(baseRect.left + this.textHorizontalPadding,
                baseRect.top + this.textVerticalPadding));
      }
    });

    // 内圈空白
    if (innerCircleRadius > 0) {
      Paint _whitePaint = Paint()
        ..color = Colors.white
        ..strokeCap = StrokeCap.round
        ..isAntiAlias = true
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, innerCircleRadius, _whitePaint);
    }
  }

  Offset calcOffsetWith(double angle, double radius) {
    double dy = (sin(angle) * radius).roundToDouble();
    double dx = (cos(angle) * radius).roundToDouble();
    return Offset(dx, dy);
  }

  Offset calcHorizontalOffset(Offset offset1, Offset offset2) {
    double dx = 0;
    double dy = offset2.dy;
    if (offset1.dx <= offset2.dx) {
      // 向右
      dx = offset2.dx + 10;
    } else {
      dx = offset2.dx - 10;
    }
    return Offset(dx, dy);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool? hitTest(Offset position) {
    int length = data.length;
    for (int i = 0; i < length; i++) {
      BrnDoughnutDataItem item = data[i];
      double radain = pointRadianInSector(position);
      if (item.startRadius < radain &&
          radain < (item.startRadius + item.radius)) {
        if (null != brnDoughnutSelectCallback)
          brnDoughnutSelectCallback!(
              item.startRadius == selectedItem?.startRadius ? null : item);
        break;
      }
    }

    return super.hitTest(position);
  }

  double pointRadianInSector(Offset position) {
    Offset relativePosition =
        Offset(position.dx - circleCenter.dx, position.dy - circleCenter.dy);
    double round = acos(relativePosition.dx /
        sqrt(pow(relativePosition.dx, 2) + pow(relativePosition.dy, 2)));
    double revisedRadian = round;
    if (relativePosition.dy < 0) {
      revisedRadian = 2 * pi - round;
    }
    return revisedRadian;
  }
}

/// BrnDoughnutChart 圆形数据展示组件
/// 可选择使用圆形、环形来展示数据所占总数的百分比
class BrnDoughnutChart extends StatelessWidget {
  /// 宽度。默认值 0
  final double width;

  /// 高度。默认值 0
  final double height;

  /// 选中的项目
  final BrnDoughnutDataItem? selectedItem;

  /// 选中项目时候的回掉
  final BrnDoughnutSelectCallback? selectCallback;

  /// 选中时展示文字大小，默认12
  final double fontSize;

  /// 选中时展示文字颜色，默认Colors.white
  final Color fontColor;

  /// 是否仅在选中时展示 title
  final bool showTitleWhenSelected;

  /// 内边距，默认 EdgeInsets.zero
  final EdgeInsetsGeometry padding;

  /// 圆环宽度，默认 50
  final int ringWidth;

  /// 饼图数据
  final List<BrnDoughnutDataItem> data;

  BrnDoughnutChart(
      {this.width = 0,
      this.height = 0,
      this.padding = EdgeInsets.zero,
      this.ringWidth = 50,
      required this.data,
      this.fontSize = 12,
      this.fontColor = Colors.white,
      this.selectedItem,
      this.showTitleWhenSelected = false,
      this.selectCallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CustomPaint(
        size: Size(this.width, this.height),
        foregroundPainter: BrnDoughnut(
            data: this.data,
            ringWidth: this.ringWidth,
            fontColor: this.fontColor,
            fontSize: this.fontSize,
            selectedItem: this.selectedItem,
            showTitleWhenSelected: this.showTitleWhenSelected,
            brnDoughnutSelectCallback: this.selectCallback),
      ),
    );
  }
}
