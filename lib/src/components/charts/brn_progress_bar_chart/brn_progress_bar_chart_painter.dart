import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

/// 遍历每个柱状数据的回调
typedef BarItemEnumeratorCallback = void Function(
    int barBundleIndex,
    BrnProgressBarBundle barBundle,
    int barGroupIndex,
    BrnProgressBarItem barItem);

/// 点击柱状数据的回调
typedef BrnProgressBarChartSelectCallback = void Function(
    BrnProgressBarItem? barItem);

/// 点击柱状数据的拦截器
typedef bool OnBarItemClickInterceptor(
    int barBundleIndex,
    BrnProgressBarBundle barBundle,
    int barGroupIndex,
    BrnProgressBarItem barItem);

/// 柱状图样式
enum BarChartStyle {
  ///竖直
  vertical,

  ///水平
  horizontal,
}

//坐标轴样式
enum AxisStyle {
  ///无线条
  axisStyleNone,

  ///虚线
  axisStyleDot,

  ///实线
  axisStyleSolid,
}

/// 坐标轴项目
class AxisItem {
  /// 展示的文本
  final String showText;

  /// 文本大小
  late Size textSize;

  AxisItem({required this.showText});
}

/// ChartAxis 图表的坐标轴样式
/// 可对坐标轴的刻度样式、线条样式、偏移量等数据进行设置
class ChartAxis {
  final List<AxisItem> axisItemList;

  /// 是否有刻度
  final bool hasMark;

  /// 实线/虚线/无
  final AxisStyle axisStyle;

  /// 两个刻度间距
  double? space;
  double maxTextHeight = 0;
  double maxTextWidth = 0;

  /// 0/刻度偏移量
  double leadingSpace = 30;
  TextStyle textStyle = TextStyle(color: Color(0x999999), fontSize: 12);

  ChartAxis({
    required this.axisItemList,
    this.hasMark = true,
    this.axisStyle = AxisStyle.axisStyleSolid,
  });
}

const _showBarValueTextStyle =
    TextStyle(color: Color(0xff222222), fontSize: 12);

/// 数据图表的数据源
/// 可对数据的数值、展示文本、选中状态的文字以及柱形的样式进行设置
class BrnProgressBarItem {
  /// 柱状数据的描述文本
  final String? text;

  /// 柱状数据的值
  final double value;

  /// 柱状数据的参考值，展示在当前柱状图的后面
  final double? hintValue;

  ///选中时气泡文字
  final String? selectedHintText;

  /// 展示柱形的值
  final String? showBarValueText;

  /// 展示柱形值文本样式
  final TextStyle showBarValueTextStyle;
  late double percentage;
  double? hintPercentage;
  Rect? barRect;
  Rect? barHintRect;
  late Offset barGroupAxisCenter;

  BrnProgressBarItem(
      {this.text,
      required this.value,
      this.hintValue,
      this.selectedHintText,
      this.showBarValueText,
      this.showBarValueTextStyle = _showBarValueTextStyle});
}

const List<Color> _defaultColor = [Color(0xff1545FD), Color(0xff0984F9)];
const List<Color> _defaultHintColor = [Color(0xffEAF4FE), Color(0xffEAF4FE)];

/// BrnProgressBarBundle 数据图表的数据集
/// 每一个bundle对应一组数据
class BrnProgressBarBundle {
  final List<BrnProgressBarItem> barList;
  final List<Color> colors;
  final List<Color> hintColors;

  BrnProgressBarBundle(
      {required this.barList,
      this.colors = _defaultColor,
      this.hintColors = _defaultHintColor});
}

/// 数据图表的绘制类
/// 根据参数对 x y 坐标轴以及柱状图进行绘制
class BrnProgressBarChartPainter extends CustomPainter {
  /// 柱状图的样式
  final BarChartStyle barChartStyle;

  /// x轴
  final ChartAxis xAxis;

  /// y轴
  final ChartAxis yAxis;

  /// 柱形数据
  final List<BrnProgressBarBundle> barBundleList;

  /// 条形间距
  final double barGroupSpace;

  /// 单个柱形宽度
  final double singleBarWidth;

  /// 柱状图的最大值，柱状图的宽/高会依此值计算
  final double barMaxValue;
  final bool drawX;
  final bool drawY;
  final bool drawBar;

  /// 是否可点击回调
  final OnBarItemClickInterceptor? onBarItemClickInterceptor;

  /// 选中柱状图时条形文案颜色
  final Color selectedHintTextColor;

  /// 选中柱状图时条形文案背景颜色
  final Color selectedHintTextBackgroundColor;
  final BrnProgressBarItem? selectedBarItem;
  final BrnProgressBarChartSelectCallback? brnProgressBarChartSelectCallback;

  Color unselectedColor = Color(0xffDAEDFE);

  /// 内容区域
  Rect contentRect = Rect.zero;

  /// x轴区域
  Rect xAxisRect = Rect.zero;

  /// y轴区域
  Rect yAxisRect = Rect.zero;

  /// 最大数据
  double maxValue = 0;

  final double _yTextAxisSpace = 10;
  final double _yTextMaxWidth = 50;
  final double _xAxisHeight = 22;

  BrnProgressBarChartPainter(
      {required this.barChartStyle,
      required this.xAxis,
      required this.yAxis,
      required this.barBundleList,
      required this.barGroupSpace,
      required this.singleBarWidth,
      required this.barMaxValue,
      this.drawX = true,
      this.drawY = true,
      this.drawBar = true,
      this.onBarItemClickInterceptor,
      this.selectedHintTextColor = Colors.white,
      this.selectedHintTextBackgroundColor = const Color(0xcc000000),
      this.selectedBarItem,
      this.brnProgressBarChartSelectCallback});

  @override
  void paint(Canvas canvas, Size size) {
    _prepareData(canvas, size);
    if (this.drawX) _drawXAxisIn(canvas, this.xAxisRect);
    if (this.drawY) _drawYAxisIn(canvas, this.yAxisRect);
    if (this.barChartStyle == BarChartStyle.horizontal) {
      if (this.drawBar) _drawBarsHorizontal(canvas, this.contentRect);
    } else if (this.barChartStyle == BarChartStyle.vertical) {
      if (this.drawBar) _drawBarsVertical(canvas, this.contentRect);
    }
  }

  static double maxYAxisWidth(ChartAxis yAxis) {
    Size getTextAreaSize(String text, TextStyle textStyle) {
      TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: textStyle),
        textDirection: TextDirection.ltr,
        maxLines: 2,
      )..layout(maxWidth: 50, minWidth: 0);

      double textWidth = textPainter.size.width;
      double textHeight = textPainter.size.height;

      return Size(textWidth, textHeight);
    }

    if (yAxis.axisItemList.length > 0) {
      //确定y轴文本最大宽度，以及每个文本大小
      yAxis.axisItemList.forEach((AxisItem item) {
        Size textSize = getTextAreaSize(item.showText, yAxis.textStyle);
        item.textSize = textSize;
        if (textSize.width > yAxis.maxTextWidth)
          yAxis.maxTextWidth = textSize.width;
      });
    }
    return yAxis.maxTextWidth + 10;
  }

  void _prepareData(Canvas canvas, Size size) {
    if (this.yAxis.axisItemList.length > 0) {
      //确定y轴文本最大宽度，以及每个文本大小
      this.yAxis.axisItemList.forEach((AxisItem item) {
        Size textSize =
            this.getTextAreaSize(item.showText, this.yAxis.textStyle);
        item.textSize = textSize;
        if (textSize.width > this.yAxis.maxTextWidth)
          this.yAxis.maxTextWidth = textSize.width;
      });

      this.yAxisRect = Rect.fromLTWH(
          0,
          0,
          this.yAxis.maxTextWidth + _yTextAxisSpace,
          size.height -
              (0 == this.xAxis.axisItemList.length ? 0 : this._xAxisHeight));
    }

    if (!this.drawY)
      this.yAxisRect = Rect.fromLTWH(
          0,
          0,
          0,
          size.height -
              (0 == this.xAxis.axisItemList.length ? 0 : this._xAxisHeight));

    this.xAxisRect = Rect.fromPoints(
        this.yAxisRect.bottomRight, Offset(size.width, size.height));

    if (this.barBundleList.length > 0) {
      this.contentRect =
          Rect.fromPoints(this.yAxisRect.topRight, this.xAxisRect.topRight);
    }

    // 找到柱状图最大值
    if (0 != this.barMaxValue) {
      this.maxValue = this.barMaxValue;
    } else {
      this.barBundleList.forEach((BrnProgressBarBundle barbundle) {
        barbundle.barList.forEach((BrnProgressBarItem barItem) {
          if (barItem.value > this.maxValue) this.maxValue = barItem.value;
        });
      });
    }

    //计算每个柱状图形的 rect 并保存
    if (!this.drawBar) return; // 不画柱形，不对柱形进行计算
    int barBundleCount = this.barBundleList.length;
    this.barItemEnumerator((int barBundleIndex, BrnProgressBarBundle barBundle,
        int barGroupIndex, BrnProgressBarItem barItem) {
      barItem.percentage = barItem.value / this.maxValue;

      if (null != barItem.hintValue) {
        barItem.hintPercentage = barItem.hintValue! / this.maxValue;
      }

      if (BarChartStyle.horizontal == this.barChartStyle) {
        //水平方向的柱状图
        Offset leftTop = Offset(
            this.yAxisRect.right,
            (barBundleCount * this.singleBarWidth + this.barGroupSpace) *
                    barGroupIndex +
                this.yAxis.leadingSpace);
        double width = this.contentRect.width * barItem.percentage;
        double height = this.singleBarWidth;
        Rect barRect = Rect.fromLTWH(leftTop.dx, leftTop.dy, width, height);
        barItem.barRect = barRect;

        // 条形组的坐标轴中间Offset，此处目前仅考虑有一组条形值的情况
        barItem.barGroupAxisCenter = barItem.barRect!.centerLeft;

        // BarHintRect
        if (null != barItem.hintPercentage) {
          double hintWidth = this.contentRect.width * barItem.hintPercentage!;
          Rect barHintRect =
              Rect.fromLTWH(leftTop.dx, leftTop.dy, hintWidth, height);
          barItem.barHintRect = barHintRect;
        }
      } else if (BarChartStyle.vertical == this.barChartStyle) {
        //竖直方向柱状图
        Offset leftBottom = Offset(
            this.yAxisRect.width +
                this.xAxis.leadingSpace +
                barBundleIndex * this.singleBarWidth +
                (barBundleCount * this.singleBarWidth + this.barGroupSpace) *
                    barGroupIndex,
            this.xAxisRect.top);
        double width = this.singleBarWidth;
        double height = this.contentRect.height * barItem.percentage;
        Rect barRect =
            Rect.fromLTWH(leftBottom.dx, leftBottom.dy - height, width, height);
        barItem.barRect = barRect;

        // 条形组的坐标轴中间Offset
        barItem.barGroupAxisCenter = Offset(
            this.yAxisRect.width +
                this.xAxis.leadingSpace +
                (barBundleCount * this.singleBarWidth + this.barGroupSpace) *
                    barGroupIndex +
                (barBundleCount * this.singleBarWidth) / 2,
            this.xAxisRect.top);

        // BarHintRect
        if (null != barItem.hintPercentage) {
          double hintHeight = this.contentRect.height * barItem.hintPercentage!;
          Rect barHintRect = Rect.fromLTWH(
              leftBottom.dx, leftBottom.dy - hintHeight, width, hintHeight);
          barItem.barHintRect = barHintRect;
        }
      }
    });
  }

  void _drawDashLineOn(
      Canvas canvas, Offset lineStart, Offset lineEnd, Color color) {
    Paint dashPaint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    Path linePath = Path()
      ..moveTo(lineStart.dx, lineStart.dy)
      ..lineTo(lineEnd.dx, lineEnd.dy);
    canvas.drawPath(
        dashPath(
          linePath,
          dashArray: CircularIntervalList<double>(<double>[4.0, 4.0]),
        ),
        dashPaint);
  }

  void _drawXAxisIn(Canvas canvas, Rect xAxisRect) {
    if (0 == this.xAxis.axisItemList.length) return;
    if (AxisStyle.axisStyleSolid == this.xAxis.axisStyle) {
      Offset xLineStart = xAxisRect.topLeft;
      Offset xLineEnd = xAxisRect.topRight;
      Paint xAxisPaint = Paint()..color = Color(0xff222222);
      canvas.drawLine(xLineStart, xLineEnd, xAxisPaint);
    } else if (AxisStyle.axisStyleDot == this.xAxis.axisStyle) {
      Offset xLineStart = xAxisRect.topLeft;
      Offset xLineEnd = xAxisRect.topRight;
      _drawDashLineOn(canvas, xLineStart, xLineEnd, Color(0xff222222));
    }

    if (BarChartStyle.horizontal == this.barChartStyle) {
      int xAxisItemCount = this.xAxis.axisItemList.length;
      double perWidth = xAxisRect.width / xAxisItemCount;
      Paint markLinkePaint = Paint()..color = Color(0xff222222);

      for (int xAxisItemIndex = 0;
          xAxisItemIndex < xAxisItemCount;
          xAxisItemIndex++) {
        //当前坐标
        Offset currentOffset = Offset(
            xAxisRect.topLeft.dx + perWidth * (xAxisItemIndex + 1),
            xAxisRect.topLeft.dy);

        //坐标刻度竖线
        canvas.drawLine(currentOffset,
            Offset(currentOffset.dx, currentOffset.dy + 3), markLinkePaint);

        // 坐标刻度虚线
        _drawDashLineOn(canvas, Offset(currentOffset.dx, currentOffset.dy),
            Offset(currentOffset.dx, 0), Colors.black.withOpacity(0.09));

        // 坐标文本
        AxisItem axisItem = this.xAxis.axisItemList[xAxisItemIndex];
        TextPainter textPainter = TextPainter(
            text: TextSpan(
                text: axisItem.showText,
                style: TextStyle(fontSize: 12, color: Color(0xff999999))),
            textDirection: TextDirection.ltr)
          ..layout(maxWidth: double.infinity, minWidth: 0);

        double textWidth = textPainter.size.width;

        textPainter.paint(canvas,
            Offset(currentOffset.dx - textWidth / 2, currentOffset.dy + 5));
      }
    } else if (BarChartStyle.vertical == this.barChartStyle) {
      Paint markLinkePaint = Paint()..color = Color(0xff222222);
      this.barItemEnumerator((int barBundleIndex,
          BrnProgressBarBundle barBundle,
          int barGroupIndex,
          BrnProgressBarItem barItem) {
        if (0 == barBundleIndex) {
          ///坐标刻度竖线
          canvas.drawLine(
              barItem.barGroupAxisCenter,
              Offset(barItem.barGroupAxisCenter.dx,
                  barItem.barGroupAxisCenter.dy + 3),
              markLinkePaint);
          AxisItem axisItem = this.xAxis.axisItemList[barGroupIndex];
          TextPainter textPainter = TextPainter(
              text: TextSpan(
                  text: axisItem.showText,
                  style: TextStyle(fontSize: 12, color: Color(0xff999999))),
              textDirection: TextDirection.ltr)
            ..layout(maxWidth: double.infinity, minWidth: 0);

          double textWidth = textPainter.size.width;

          textPainter.paint(
              canvas,
              Offset(barItem.barGroupAxisCenter.dx - textWidth / 2,
                  barItem.barGroupAxisCenter.dy + 5));
        }
      });
    }
  }

  void _drawYAxisIn(Canvas canvas, Rect yAxisRect) {
    if (0 == this.yAxis.axisItemList.length) return;
    if (AxisStyle.axisStyleSolid == this.yAxis.axisStyle) {
      Offset yLineStart = yAxisRect.bottomRight;
      Offset yLineEnd = yAxisRect.topRight;
      Paint yAxisPaint = Paint()..color = Color(0xff222222);
      canvas.drawLine(yLineStart, yLineEnd, yAxisPaint);
    } else if (AxisStyle.axisStyleDot == this.xAxis.axisStyle) {
      Offset yLineStart = yAxisRect.bottomRight;
      Offset yLineEnd = yAxisRect.topRight;
      _drawDashLineOn(canvas, yLineStart, yLineEnd, Color(0xff222222));
    }
    if (BarChartStyle.horizontal == this.barChartStyle) {
      // 绘制Y轴文字内容
      this.barItemEnumerator((int barBundleIndex,
          BrnProgressBarBundle barBundle,
          int barGroupIndex,
          BrnProgressBarItem barItem) {
        // 对应 Y 轴项目
        AxisItem axisItem = this.yAxis.axisItemList[barGroupIndex];
        Size textSize = axisItem.textSize;
        Offset textRectCenter = Offset(
            barItem.barGroupAxisCenter.dx -
                textSize.width / 2 -
                this._yTextAxisSpace,
            barItem.barGroupAxisCenter.dy);
        Rect textRect = Rect.fromCenter(
            center: textRectCenter,
            width: textSize.width,
            height: textSize.height);
        TextPainter(
            text: TextSpan(
                text: axisItem.showText,
                style: TextStyle(fontSize: 12, color: Color(0xff999999))),
            textDirection: TextDirection.ltr)
          ..layout(maxWidth: double.infinity, minWidth: 0)
          ..paint(canvas, textRect.topLeft);
      });
    } else if (BarChartStyle.vertical == this.barChartStyle) {
      // 竖直
      int yAxisItemDount = this.yAxis.axisItemList.length;
      double perWidth = this.yAxisRect.height / yAxisItemDount;
      List<AxisItem> reversedAxisItemList =
          this.yAxis.axisItemList.reversed.toList();
      for (int yAxisItemIndex = 0;
          yAxisItemIndex < yAxisItemDount;
          yAxisItemIndex++) {
        AxisItem axisItem = reversedAxisItemList[yAxisItemIndex];
        Size textSize = axisItem.textSize;
        Offset yAxisItemOffset =
            Offset(this.yAxisRect.right, perWidth * yAxisItemIndex);
        Offset textRectCenter = Offset(
            yAxisItemOffset.dx - textSize.width / 2 - this._yTextAxisSpace,
            yAxisItemOffset.dy);
        Rect textRect = Rect.fromCenter(
            center: textRectCenter,
            width: textSize.width,
            height: textSize.height);
        TextPainter(
            text: TextSpan(
                text: axisItem.showText,
                style: TextStyle(fontSize: 12, color: Color(0xff999999))),
            textDirection: TextDirection.ltr)
          ..layout(maxWidth: double.infinity, minWidth: 0)
          ..paint(canvas, textRect.topLeft);

        // Y 轴虚线
        _drawDashLineOn(
            canvas,
            yAxisItemOffset,
            Offset(yAxisItemOffset.dx + this.contentRect.width,
                yAxisItemOffset.dy),
            Colors.black.withOpacity(0.09));
      }
    }
  }

  void barItemEnumerator(BarItemEnumeratorCallback barItemEnumeratorCallback) {
    int barBundleCount = this.barBundleList.length;
    for (int barBundleIndex = 0;
        barBundleIndex < barBundleCount;
        barBundleIndex++) {
      BrnProgressBarBundle barBundle = this.barBundleList[barBundleIndex];
      int barNumber = barBundle.barList.length;
      for (int barGroupIndex = 0; barGroupIndex < barNumber; barGroupIndex++) {
        BrnProgressBarItem barItem = barBundle.barList[barGroupIndex];
        barItemEnumeratorCallback(
            barBundleIndex, barBundle, barGroupIndex, barItem);
      }
    }
  }

  void _drawBarsVertical(Canvas canvas, Rect contentRect) {
    this.barItemEnumerator((int barBundleIndex, BrnProgressBarBundle barBundle,
        int barGroupIndex, BrnProgressBarItem barItem) {
      // 绘制 hintbar
      if (null != barItem.barHintRect) {
        Shader hintShader = LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp,
                colors: barBundle.hintColors)
            .createShader(barItem.barHintRect!);

        Paint hintBarPaint = Paint()
          ..shader = hintShader
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1.5
          ..style = PaintingStyle.fill;

        canvas.drawRect(barItem.barHintRect!, hintBarPaint);
      }

      RRect barRRect = RRect.fromRectAndCorners(barItem.barRect!,
          topRight: Radius.circular(4), topLeft: Radius.circular(4));
      if (this.selectedBarItem != null) {
        // 有选中的柱形，选中柱形保持原样，未选中的置灰
        Shader shader;
        if (this.selectedBarItem!.barRect == barItem.barRect) {
          // 选中的柱形
          shader = LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  tileMode: TileMode.clamp,
                  colors: barBundle.colors)
              .createShader(barItem.barRect!);
        } else {
          // 未选中需要置灰的柱形
          shader = LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  tileMode: TileMode.clamp,
                  colors: <Color>[this.unselectedColor, this.unselectedColor])
              .createShader(barItem.barRect!);
        }
        Paint barPaint = Paint()
          ..shader = shader
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1.5
          ..style = PaintingStyle.fill;
        canvas.drawRRect(barRRect, barPaint);
        if (this.selectedBarItem!.barRect == barItem.barRect) {
          // 选中柱形的虚线以及 HintText
          this._drawDashLineOn(canvas, barItem.barRect!.bottomCenter,
              Offset(barItem.barRect!.bottomCenter.dx, 0), Color(0xff222222));
        }
      } else {
        Shader shader = LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp,
                colors: barBundle.colors)
            .createShader(barItem.barRect!);
        Paint barPaint = Paint()
          ..shader = shader
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1.5
          ..style = PaintingStyle.fill;

        canvas.drawRRect(barRRect, barPaint);
      }
    });

    // 柱形顶部文案，避免柱形遮挡在此绘制
    this.barItemEnumerator((int barBundleIndex, BrnProgressBarBundle barBundle,
        int barGroupIndex, BrnProgressBarItem barItem) {
      if (null != barItem.showBarValueText) {
        TextPainter textPainter = TextPainter(
            text: TextSpan(
                text: barItem.showBarValueText!,
                style: barItem.showBarValueTextStyle),
            textDirection: TextDirection.ltr)
          ..layout(maxWidth: double.infinity, minWidth: 0);
        double textWidth = textPainter.size.width;
        double textHeight = textPainter.size.height;
        Offset textOffset = Offset(barItem.barRect!.center.dx - textWidth / 2,
            barItem.barRect!.top - textHeight - 2);
        textPainter.paint(canvas, textOffset);
      }
    });

    //最后画选中柱形的提示文字，否则可能被遮挡
    if (null != this.selectedBarItem) {
      // 画选中文字 Start
      TextPainter selectedBarTextPainter = TextPainter(
          text: TextSpan(
              text: selectedBarItem!.selectedHintText ??
                  (selectedBarItem!.text ?? ''),
              style:
                  TextStyle(fontSize: 12, color: this.selectedHintTextColor)),
          textDirection: TextDirection.ltr)
        ..layout(maxWidth: double.infinity, minWidth: 0);
      double textWidth = selectedBarTextPainter.size.width;
      double textHeight = selectedBarTextPainter.size.height;

      Offset selectedBarTextBgCenterOffset;
      if (selectedBarItem!.barRect!.bottomCenter.dx + 10 + textWidth + 10 * 2 >
          this.contentRect.right) {
        // 需要显示在左侧
        selectedBarTextBgCenterOffset = Offset(
            selectedBarItem!.barRect!.bottomCenter.dx - 10 - 10 - textWidth / 2,
            16.0 + 16.0);
      } else {
        // 需要显示在右侧
        selectedBarTextBgCenterOffset = Offset(
            selectedBarItem!.barRect!.bottomCenter.dx + 10 + 10 + textWidth / 2,
            16.0 + 16.0);
      }

      // 文本背景区域超出整个图形范围
      if (textHeight / 2 + 8 > selectedBarTextBgCenterOffset.dy) {
        selectedBarTextBgCenterOffset =
            Offset(selectedBarTextBgCenterOffset.dx, textHeight / 2 + 8);
      }

      // 画选中文字背景
      Paint selectTextBgPaint = Paint()
        ..color = this.selectedHintTextBackgroundColor
        ..style = PaintingStyle.fill;
      RRect selectTextBgRRect = RRect.fromRectAndRadius(
          Rect.fromCenter(
              center: selectedBarTextBgCenterOffset,
              width: textWidth + 10 * 2,
              height: textHeight + 8 * 2),
          Radius.circular(2));
      canvas.drawRRect(selectTextBgRRect, selectTextBgPaint);
      selectedBarTextPainter.paint(
          canvas,
          Offset(selectedBarTextBgCenterOffset.dx - textWidth / 2,
              selectedBarTextBgCenterOffset.dy - textHeight / 2));

      // 画选中文字 End
    }
  }

  void _drawBarsHorizontal(Canvas canvas, Rect contentRect) {
    this.barItemEnumerator((int barBundleIndex, BrnProgressBarBundle barBundle,
        int barGroupIndex, BrnProgressBarItem barItem) {
      // 绘制 hintbar
      if (null != barItem.barHintRect) {
        Shader hintShader = LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                tileMode: TileMode.clamp,
                colors: barBundle.hintColors)
            .createShader(barItem.barHintRect!);
        Paint hintBarPaint = Paint()
          ..shader = hintShader
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1.5
          ..style = PaintingStyle.fill;

        canvas.drawRect(barItem.barHintRect!, hintBarPaint);
      }

      // 绘制柱状图形
      RRect barRRect = RRect.fromRectAndCorners(barItem.barRect!,
          topRight: Radius.circular(4), bottomRight: Radius.circular(4));

      Shader shader = LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              tileMode: TileMode.clamp,
              colors: barBundle.colors)
          .createShader(barItem.barRect!);
      Paint barPaint = Paint()
        ..shader = shader
        ..isAntiAlias = true
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 1.5
        ..style = PaintingStyle.fill;

      canvas.drawRRect(barRRect, barPaint);

      // 绘制柱状图上的数值
      TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 12);
      this.barItemEnumerator((int barBundleIndex,
          BrnProgressBarBundle barBundle,
          int barGroupIndex,
          BrnProgressBarItem barItem) {
        TextPainter textPainter = TextPainter(
            text: TextSpan(text: barItem.text ?? '', style: textStyle),
            textDirection: TextDirection.ltr)
          ..layout(maxWidth: double.infinity, minWidth: 0);
        double textHeight = textPainter.size.height;
        Offset textOffset = Offset(barItem.barGroupAxisCenter.dx + 10,
            barItem.barGroupAxisCenter.dy - textHeight / 2);
        textPainter.paint(canvas, textOffset);
      });
    });
  }

  Size getTextAreaSize(String text, TextStyle textStyle) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 2,
    )..layout(maxWidth: _yTextMaxWidth, minWidth: 0);

    double textWidth = textPainter.size.width;
    double textHeight = textPainter.size.height;

    return Size(textWidth, textHeight);
  }

  @override
  bool? hitTest(Offset position) {
    if (this.brnProgressBarChartSelectCallback != null &&
        BarChartStyle.vertical == this.barChartStyle) {
      this.barItemEnumerator((int barBundleIndex,
          BrnProgressBarBundle barBundle,
          int barGroupIndex,
          BrnProgressBarItem barItem) {
        if (this.brnProgressBarChartSelectCallback != null &&
            barItem.barRect!.contains(position)) {
          if (this.onBarItemClickInterceptor == null ||
              true ==
                  this.onBarItemClickInterceptor!(
                      barBundleIndex, barBundle, barGroupIndex, barItem)) {
            this.brnProgressBarChartSelectCallback!(
                barItem.barRect == this.selectedBarItem?.barRect
                    ? null
                    : barItem);
          }
        }
      });
    }

    return super.hitTest(position);
  }

  @override
  bool shouldRepaint(BrnProgressBarChartPainter oldDelegate) {
    return true;
  }
}
