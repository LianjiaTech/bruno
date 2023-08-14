import 'dart:async';

import 'package:bindings_compatible/bindings_compatible.dart';
import 'package:flutter/material.dart';

/// 文字跑马灯Widget
// ignore: must_be_immutable
class BrnMarqueeText extends StatefulWidget {
  ///滚动文字（不超过设置的宽度不滚动）
  final String text;

  /// 文字样式
  final TextStyle? textStyle;

  ///滚动方向，水平或者垂直
  final Axis scrollAxis;

  ///空白部分占控件的百分比
  final double ratioOfBlankToScreen;

  ///滚动评率 毫秒（默认100）
  final int timerRest;

  /// 尽量设置宽高，自动算宽|高受布局影响较大
  double width, height;

  BrnMarqueeText({
    required this.text,
    this.width = 0,
    this.height = 0,
    this.timerRest = 100,
    this.textStyle,
    this.scrollAxis = Axis.horizontal,
    this.ratioOfBlankToScreen = 0.25,
  });

  @override
  State<StatefulWidget> createState() {
    return BrnMarqueeTextState();
  }
}

class BrnMarqueeTextState extends State<BrnMarqueeText>
    with SingleTickerProviderStateMixin {
  late ScrollController scroController;
  double blankWidth = 1;
  double blankHeight = 1;
  double position = 0.0;
  Timer? timer;
  final double _moveDistance = 3.0;
  GlobalKey? _key;

  @override
  void initState() {
    super.initState();
    scroController = new ScrollController();
    useWidgetsBinding().addPostFrameCallback((callback) {
      var size = context.findRenderObject()!.paintBounds.size;
      widget.width = (widget.width) > 0 ? widget.width : size.width;
      widget.height = (widget.height) > 0 ? widget.height : size.height;

      _key = GlobalKey();
      if (calculateTextWith(widget.text, widget.textStyle?.fontSize,
              widget.textStyle?.fontWeight, double.infinity, 1, context) >
          widget.width) {
        blankWidth = widget.width * widget.ratioOfBlankToScreen;
        blankHeight = widget.height * widget.ratioOfBlankToScreen;
        setState(() {
          startTimer();
        });
      } else {
        blankWidth = widget.width;
        blankHeight = widget.height;
        setState(() {});
      }
    });
  }

  void startTimer() {
    timer =
        Timer.periodic(new Duration(milliseconds: widget.timerRest), (timer) {
      double maxScrollExtent = scroController.position.maxScrollExtent;
      double pixels = scroController.position.pixels;
      //当animateTo的距离大于最大滑动距离时，则要返回第一个child的特定位置，让末尾正好处于最右侧，然后继续滚动，造成跑马灯的假象
      if (pixels + _moveDistance >= maxScrollExtent) {
        if (widget.scrollAxis == Axis.horizontal) {
          position = (maxScrollExtent - blankWidth - widget.width) / 2 +
              pixels -
              maxScrollExtent;
        } else {
          position = (maxScrollExtent - blankHeight - widget.height) / 2 +
              pixels -
              maxScrollExtent;
        }
        scroController.jumpTo(position);
      }
      position += _moveDistance;
      scroController.animateTo(position,
          duration: new Duration(milliseconds: widget.timerRest),
          curve: Curves.linear);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget getBothEndsChild() {
    if (widget.scrollAxis == Axis.vertical) {
      String newString = widget.text.split("").join("\n");
      return new Center(
        child: new Text(
          newString,
          style: widget.textStyle,
          textAlign: TextAlign.center,
        ),
      );
    }
    return new Center(
        child: new Text(
      widget.text,
      style: widget.textStyle,
    ));
  }

  Widget getCenterChild() {
    if (widget.scrollAxis == Axis.horizontal) {
      return Container(width: blankWidth);
    } else {
      return Container(height: blankHeight);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    scroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      key: _key,
      child: ListView(
        scrollDirection: widget.scrollAxis,
        controller: scroController,
        physics: new NeverScrollableScrollPhysics(),
        children: <Widget>[
          getBothEndsChild(),
          getCenterChild(),
          getBothEndsChild(),
        ],
      ),
    );
  }

  double calculateTextWith(
      String value,
      double? fontSize,
      FontWeight? fontWeight,
      double maxWidth,
      int maxLines,
      BuildContext context) {
    TextPainter painter = TextPainter(

        ///AUTO：华为手机如果不指定locale的时候，该方法算出来的文字高度是比系统计算偏小的。
        locale: Localizations.localeOf(context),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: value,
            style: TextStyle(
              fontWeight: fontWeight,
              fontSize: fontSize,
            )));
    painter.layout(maxWidth: maxWidth);

    ///文字的宽度:painter.width
    return painter.width;
  }
}
