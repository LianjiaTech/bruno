import 'package:bruno/src/components/button/brn_icon_button.dart';
import 'package:bruno/src/components/guide/brn_flutter_guide.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/l10n/brn_intl.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

/// 引导组件试，[force] 有蒙层遮挡，[soft] 无蒙层遮挡
enum GuideMode { force, soft }

/// 默认的引导组件包含，强和弱两种交互模式
class BrnTipInfoWidget extends StatelessWidget {

  /// 引导组件的方向
  final GuideDirection direction;

  /// 关闭按钮的回调
  final void Function()? onClose;

  /// 下一步按钮的回调
  final void Function()? onNext;

  /// 跳过按钮的回调
  final void Function()? onSkip;

  /// 引导组件的宽度
  final double width;

  /// 引导组件的高度
  final double? height;

  /// 引导组件的内容
  final BrnTipInfoBean info;

  /// 引导模式
  final GuideMode mode;

  /// 当前的引导步数
  final int currentStepIndex;

  /// 引导步数
  final int stepCount;

  /// 箭头距离指示的边距
  final double? arrowPadding;

  /// 【下一步】的文案
  final String? nextTip;

  const BrnTipInfoWidget(
      {Key? key,
      this.onClose,
      this.onNext,
      this.onSkip,
      required this.width,
      this.height,
      this.currentStepIndex = 0,
      required this.stepCount,
      required this.info,
      this.mode = GuideMode.force,
      required this.direction,
      this.arrowPadding,
      this.nextTip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color borderColor =
        mode == GuideMode.force ? Colors.transparent : Color(0xFFCCCCCC);
    if (direction == GuideDirection.bottomLeft ||
        direction == GuideDirection.bottomRight) {
      return Column(
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          _buildContent(context),
          Container(
            alignment: direction == GuideDirection.bottomLeft
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
            padding: direction == GuideDirection.bottomLeft
                ? EdgeInsets.only(right: arrowPadding ?? 12)
                : EdgeInsets.only(left: arrowPadding ?? 12),
            child: CustomPaint(
              size: Size(14.0, 6.0),
              painter: CustomTrianglePainter(
                direction: Direction.top,
                borderColor: borderColor,
              ),
            ),
          ),
        ],
      );
    }
    if (direction == GuideDirection.topLeft ||
        direction == GuideDirection.topRight) {
      return Column(
        children: <Widget>[
          _buildContent(context),
          Container(
            alignment: direction == GuideDirection.topLeft
                ? Alignment.topRight
                : Alignment.topLeft,
            padding: direction == GuideDirection.topLeft
                ? EdgeInsets.only(right: arrowPadding ?? 12)
                : EdgeInsets.only(left: arrowPadding ?? 12),
            child: CustomPaint(
              size: Size(14.0, 6.0),
              painter: CustomTrianglePainter(
                  borderColor: borderColor, direction: Direction.bottom),
            ),
          ),
        ],
      );
    }
    if (direction == GuideDirection.left) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildContent(context),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 12),
            child: CustomPaint(
              size: Size(6.0, 14.0),
              painter: CustomTrianglePainter(
                  borderColor: borderColor, direction: Direction.right),
            ),
          ),
        ],
      );
    }
    if (direction == GuideDirection.right) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: TextDirection.rtl,
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          _buildContent(context),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 12),
            child: CustomPaint(
              size: Size(6, 14.0),
              painter: CustomTrianglePainter(
                direction: Direction.left,
                borderColor: borderColor,
              ),
            ),
          ),
        ],
      );
    }
    return Row();
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 5.0, //阴影模糊程度
              offset: Offset(0, 2),
              color: Color(0x15000000))
        ],
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        border: mode == GuideMode.force
            ? null
            : Border.all(color: Color(0xFFCCCCCC), width: 0.5),
      ),
      width: width,
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildImage(),
          buildTitle(),
          buildMessage(),
          mode == GuideMode.force ? _buildForceBottom(context) : _buildSoftBottom(context)
        ],
      ),
    );
  }

  Widget buildImage() {
    if (info.imgUrl.isEmpty) return Row();
    double imageSize = width - 16;
    return Padding(
      padding: EdgeInsets.only(top: 14),
      child: Image.network(info.imgUrl,
          width: imageSize, height: imageSize, fit: BoxFit.cover),
    );
  }

  Widget buildTitle() {
    return Container(
      height: 18,
      margin: EdgeInsets.only(top: 14),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Text(
              "${info.title}",
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0XFF222222),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: onClose == null
                ? Row()
                : GestureDetector(
                    onTap: () {
                      onClose!();
                    },
                    child: BrunoTools.getAssetImageWithColor(
                        BrnAsset.iconClose, Colors.black),
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildMessage() {
    if (info.message.isEmpty) return Row();
    return Padding(
      padding: EdgeInsets.only(top: 6),
      child: Text('${info.message}',
          style: TextStyle(fontSize: 14, color: Color(0xFF999999), height: 1.3),
          maxLines: 3),
    );
  }

  Widget _buildSoftBottom(BuildContext context) {
    if (onNext == null && onSkip == null) return Row();
    return Container(
      height: 32,
      margin: EdgeInsets.only(top: 12),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: onSkip != null && currentStepIndex + 1 != stepCount
                ? GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          onSkip!();
                        },
                        child: Text(
                          '${BrnIntl.of(context).localizedResource.skip} (${currentStepIndex + 1}/$stepCount)',
                          style:
                              TextStyle(color: Color(0xFF999999), fontSize: 14),
                        ),
                      ),
                    ))
                : Row(),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: onNext != null
                ? GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(left: 14, right: 14),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: BrnThemeConfigurator.instance
                            .getConfig()
                            .commonConfig
                            .brandPrimary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          onNext!();
                        },
                        child: Text(
                          nextTip ??
                              (stepCount == currentStepIndex + 1
                                  ? BrnIntl.of(context).localizedResource.known
                                  : BrnIntl.of(context).localizedResource.next),
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  )
                : Row(),
          )
        ],
      ),
    );
  }

  Widget _buildForceBottom(BuildContext context) {
    if (onNext == null && onSkip == null) return Row();
    return Container(
      height: 20,
      margin: EdgeInsets.only(top: 12),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: onSkip != null && currentStepIndex + 1 != stepCount
                ? GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          onSkip!();
                        },
                        child: Text(
                          '${BrnIntl.of(context).localizedResource.skip} (${currentStepIndex + 1}/$stepCount)',
                          style:
                              TextStyle(color: Color(0xFF999999), fontSize: 14),
                        ),
                      ),
                    ))
                : Row(),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: onNext != null
                ? GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          onNext!();
                        },
                        child: Text(
                          nextTip ??
                              (stepCount == currentStepIndex + 1
                                  ? BrnIntl.of(context).localizedResource.known
                                  : BrnIntl.of(context).localizedResource.next),
                          style: TextStyle(
                              color: BrnThemeConfigurator.instance
                                  .getConfig()
                                  .commonConfig
                                  .brandPrimary,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  )
                : Row(),
          )
        ],
      ),
    );
  }
}

///
/// 绘制箭头
///
class CustomTrianglePainter extends CustomPainter {
  Color color;
  Color borderColor;
  Direction direction;

  CustomTrianglePainter(
      {this.color = Colors.white,
      this.borderColor = const Color(0XFFCCCCCC),
      required this.direction});

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    paint.strokeWidth = 2.0;
    paint.color = color;
    paint.style = PaintingStyle.fill;
    Paint paintBorder = Paint();
    Path pathBorder = Path();
    paintBorder.strokeWidth = 0.5;
    paintBorder.color = borderColor;
    paintBorder.style = PaintingStyle.stroke;

    switch (direction) {
      case Direction.left:
        path.moveTo(size.width + 1, -1.3);
        path.lineTo(0, size.height / 2);
        path.lineTo(size.width + 1, size.height + 0.5);
        pathBorder.moveTo(size.width, -0.5);
        pathBorder.lineTo(0, size.height / 2 - 0.5);
        pathBorder.lineTo(size.width, size.height);
        break;
      case Direction.right:
        path.moveTo(-1, -1.3);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(-1, size.height + 0.5);
        pathBorder.moveTo(-0, -0.5);
        pathBorder.lineTo(size.width, size.height / 2);
        pathBorder.lineTo(-0, size.height);
        break;
      case Direction.top:
        path.moveTo(0.0, size.height + 1.5);
        path.lineTo(size.width / 2.0, 0.0);
        path.lineTo(size.width, size.height + 1.5);
        pathBorder.moveTo(0.5, size.height + 0.5);
        pathBorder.lineTo(size.width / 2.0, 0);
        pathBorder.lineTo(size.width - 0.5, size.height + 0.5);
        break;
      case Direction.bottom:
        path.moveTo(0.0, -1.5);
        path.lineTo(size.width / 2.0, size.height);
        path.lineTo(size.width, -1.5);
        pathBorder.moveTo(0.0, -0.5);
        pathBorder.lineTo(size.width / 2.0, size.height);
        pathBorder.lineTo(size.width, -0.5);
        break;
    }

    canvas.drawPath(path, paint);
    canvas.drawPath(pathBorder, paintBorder);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
