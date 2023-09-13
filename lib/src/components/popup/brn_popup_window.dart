import 'dart:core';

import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/utils/brn_text_util.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// popup window 位于 targetView 的方向
enum BrnPopupDirection {
  /// 箭头朝上
  top,

  /// 箭头朝下
  bottom
}

/// 通用 Popup Window 提示，带三角号
class BrnPopupWindow extends StatefulWidget {
  /// 依附的组件的 Context
  final BuildContext context;

  /// 箭头的高度，默认 6
  final double arrowHeight;

  /// 要显示的文本
  final String? text;

  /// 依附的组件和 BrnPopUpWindow 组件共同持有的 GlobalKey
  final GlobalKey popKey;

  /// 要显示文本的样式
  final TextStyle? textStyle;

  /// popUpWindow 的背景颜色，使用 [showPopWindow] 方法时，默认值为 Color(0xFF1A1A1A)
  final Color? backgroundColor;

  /// 边框颜色，[showPopWindow] 方法时，默认值为 Colors.transparent
  final Color? borderColor;

  /// 是否有关闭图标，默认为 false，不显示
  final bool isShowCloseIcon;

  /// 距离 targetView 偏移量，默认为 0
  final double offset;

  /// popUpWindow 位于 targetView 的方向，默认为 [BrnPopupDirection.bottom]
  final BrnPopupDirection popDirection;

  /// 自定义 widget
  final Widget? widget;

  /// 容器内边距，默认为 EdgeInsets.only(left: 18, top: 14, right: 18, bottom: 14)
  final EdgeInsets paddingInsets;

  /// 容器圆角，默认为 4
  final double borderRadius;

  /// 是否能多行显，默认 false，单行显示
  final bool canWrap;

  /// 距离 targetView 边线的距离,默认 20
  final double spaceMargin;

  /// 箭头图标水平方向的绝对偏移量，为 null 时则自动计算
  final double? arrowOffset;

  /// popWindow 距离底部的距离小于此值的时候，
  /// 自动将 popWindow 在 targetView 上面弹出
  final double turnOverFromBottom;

  BrnPopupWindow(this.context,
      {Key? key,
      this.text,
      required this.popKey,
      this.arrowHeight = 6.0,
      this.textStyle,
      this.backgroundColor,
      this.isShowCloseIcon = false,
      this.offset = 0,
      this.popDirection = BrnPopupDirection.bottom,
      this.widget,
      this.paddingInsets =
          const EdgeInsets.only(left: 18, top: 14, right: 18, bottom: 14),
      this.borderRadius = 4,
      this.borderColor,
      this.canWrap = false,
      this.spaceMargin = 20,
      this.arrowOffset,
      this.turnOverFromBottom = 50.0})
      : super(key: key);

  /// 显示 popUpWindow
  /// [text] 显示的文本内容
  /// [popKey] 依附的组件和 BrnPopUpWindow 组件共同持有的 GlobalKey
  /// [popDirection] 箭头的方向
  /// [arrowHeight] 箭头的高度，默认 6
  /// [textStyle] 文本样式
  /// [backgroundColor] popUpWindow 的背景颜色，默认 Color(0xFF1A1A1A)
  /// [hasCloseIcon] 是否显示关闭图标，默认为 false，不显示
  /// [offset] 距离 targetView 垂直方向的偏移量
  /// [widget] 自定义 pop 视图
  /// [paddingInsets] 容器内边距，默认为 EdgeInsets.only(left: 18, top: 14, right: 18, bottom: 14)
  /// [borderRadius] 容器圆角，默认为 4
  /// [borderColor] 边框颜色，默认为 Colors.transparent
  /// [borderWidth] 边框宽度，默认为 1
  /// [canWrap] 是否能多行显，默认 false，单行显示
  /// [spaceMargin] 距离 targetView 边线的距离,默认 20
  /// [arrowOffset] 箭头图标水平方向的绝对偏移量，为 null 时则自动计算
  /// [dismissCallback] popUpWindow 消失回调，此回调会在 pop 之后执行
  /// [turnOverFromBottom] popWindow 小于此值的时候，自动将 popWindow 在 targetView 上面弹出，默认 50
  static void showPopWindow(context, String? text, GlobalKey popKey,
      {BrnPopupDirection popDirection = BrnPopupDirection.bottom,
      double arrowHeight = 6.0,
      TextStyle? textStyle =
          const TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
      Color? backgroundColor = const Color(0xFF1A1A1A),
      bool hasCloseIcon = false,
      double offset = 0,
      Widget? widget,
      EdgeInsets paddingInsets =
          const EdgeInsets.only(left: 18, top: 14, right: 18, bottom: 14),
      double borderRadius = 8,
      Color? borderColor = Colors.transparent,
      double borderWidth = 1,
      bool canWrap = false,
      double spaceMargin = 20,
      double? arrowOffset,
      VoidCallback? dismissCallback,
      double turnOverFromBottom = 50.0}) {
    assert(popKey.currentContext != null &&
        popKey.currentContext!.findRenderObject() != null);
    if (popKey.currentContext == null ||
        popKey.currentContext!.findRenderObject() == null) return;
    Navigator.push(
        context,
        BrnPopupRoute(
            child: BrnPopupWindow(
          context,
          arrowHeight: arrowHeight,
          text: text,
          popKey: popKey,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          isShowCloseIcon: hasCloseIcon,
          offset: offset,
          popDirection: popDirection,
          widget: widget,
          paddingInsets: paddingInsets,
          borderRadius: borderRadius,
          borderColor: borderColor ?? Colors.transparent,
          canWrap: canWrap,
          spaceMargin: spaceMargin,
          arrowOffset: arrowOffset,
          turnOverFromBottom: turnOverFromBottom,
        )));
  }

  @override
  _BrnPopupWindowState createState() => _BrnPopupWindowState();
}

class _BrnPopupWindowState extends State<BrnPopupWindow> {
  /// targetView的位置
  Rect _showRect = Rect.zero;

  /// 屏幕的尺寸
  late Size _screenSize;

  /// 箭头和左右侧边线间距
  double _arrowSpacing = 18;

  /// 是否向右侧延伸，true：向右侧延伸，false：向左侧延伸
  bool _expandedRight = true;

  /// popUpWindow在中线两侧的具体位置
  double _left = 0;
  double _right = 0;
  double _top = 0;
  double _bottom = 0;

  /// 箭头展示方向
  late BrnPopupDirection _popDirection;

  /// 去除透明度的边框色
  late Color _borderColor;

  /// 去除透明度的背景颜色
  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    this._showRect = _getWidgetGlobalRect(widget.popKey);
    this._screenSize =PlatformDispatcher.instance.views.first.physicalSize/ PlatformDispatcher.instance.views.first.devicePixelRatio;
    _borderColor = (widget.borderColor ?? Colors.transparent).withAlpha(255);
    _backgroundColor =
        (widget.backgroundColor ?? Colors.transparent).withAlpha(255);
    _popDirection = widget.popDirection;
    _calculateOffset();
  }

  // 获取targetView的位置
  Rect _getWidgetGlobalRect(GlobalKey key) {
    try {
      BuildContext? ctx = key.currentContext;
      RenderObject? renderObject = ctx?.findRenderObject();
      RenderBox renderBox = renderObject as RenderBox;
      var offset = renderBox.localToGlobal(Offset.zero);
      return Rect.fromLTWH(
          offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
    } catch (e) {
      debugPrint('获取尺寸信息异常');
      return Rect.zero;
    }
  }

  // 计算popUpWindow显示的位置
  void _calculateOffset() {
    if (_showRect.center.dx < _screenSize.width / 2) {
      // popUpWindow向右侧延伸
      _expandedRight = true;
      _left = _showRect.left;
    } else {
      // popUpWindow向左侧延伸
      _expandedRight = false;
      _right = _screenSize.width - _showRect.right + widget.spaceMargin;
    }
    if (_popDirection == BrnPopupDirection.bottom) {
      // 在targetView下方
      _top = _showRect.height + _showRect.top + widget.offset;
      if ((_screenSize.height - _top) < widget.turnOverFromBottom) {
        _popDirection = BrnPopupDirection.top;
        _bottom = _screenSize.height - _showRect.top + widget.offset;
      }
    } else if (_popDirection == BrnPopupDirection.top) {
      // 在targetView上方
      _bottom = _screenSize.height - _showRect.top + widget.offset;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      excluding: true,
      child: WillPopScope(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  _buildPopWidget(context),
                  // triangle arrow
                  _buildArrowWidget(),
                ],
              ),
            ),
          ),
          onWillPop: () {
            return Future.value(true);
          }),
    );
  }

  // 绘制箭头
  Widget _buildArrowWidget() {
    return _expandedRight
        ? Positioned(
            left: widget.arrowOffset ??
                _left +
                    (_showRect.width - _arrowSpacing) / 2 -
                    widget.spaceMargin,
            top: _popDirection == BrnPopupDirection.bottom
                ? _top - widget.arrowHeight
                : null,
            bottom: _popDirection == BrnPopupDirection.top
                ? _bottom - widget.arrowHeight
                : null,
            child: CustomPaint(
              size: Size(15.0, widget.arrowHeight),
              painter: _TrianglePainter(
                  isDownArrow: _popDirection == BrnPopupDirection.top,
                  color: _backgroundColor,
                  borderColor: _borderColor),
            ),
          )
        : Positioned(
            right: widget.arrowOffset ??
                _right +
                    (_showRect.width - _arrowSpacing) / 2 -
                    widget.spaceMargin,
            top: _popDirection == BrnPopupDirection.bottom
                ? _top - widget.arrowHeight
                : null,
            bottom: _popDirection == BrnPopupDirection.top
                ? _bottom - widget.arrowHeight
                : null,
            child: CustomPaint(
              size: Size(15.0, widget.arrowHeight),
              painter: _TrianglePainter(
                  isDownArrow: _popDirection == BrnPopupDirection.top,
                  color: _backgroundColor,
                  borderColor: _borderColor),
            ),
          );
  }

  // popWindow的弹出样式
  Widget _buildPopWidget(BuildContext context) {
    // 状态栏高度
    double statusBarHeight = MediaQueryData.fromView(View.of(context)).padding.top;
    return Positioned(
        left: _expandedRight ? _left : null,
        right: _expandedRight ? null : _right,
        top: _popDirection == BrnPopupDirection.bottom ? _top : null,
        bottom: _popDirection == BrnPopupDirection.top ? _bottom : null,
        child: Container(
            padding: widget.paddingInsets,
            decoration: BoxDecoration(
                color: _backgroundColor,
                border: Border.all(color: _borderColor, width: 0.5),
                borderRadius: BorderRadius.circular(widget.borderRadius)),
            constraints: BoxConstraints(
                maxWidth: _expandedRight
                    ? _screenSize.width - _left
                    : _screenSize.width - _right,
                maxHeight: _popDirection == BrnPopupDirection.bottom
                    ? _screenSize.height - _top
                    : _screenSize.height - _bottom - statusBarHeight),
            child: widget.widget == null
                ? SingleChildScrollView(
                    child: widget.canWrap
                        ? RichText(
                            text: TextSpan(children: <InlineSpan>[
                            TextSpan(
                                text: widget.text, style: widget.textStyle),
                            widget.isShowCloseIcon
                                ? WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 6),
                                      child: BrunoTools.getAssetImage(
                                          BrnAsset.iconPopupClose),
                                    ))
                                : TextSpan(text: "")
                          ]))
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  widget.text ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: widget.textStyle,
                                ),
                              ),
                              widget.isShowCloseIcon
                                  ? Padding(
                                      padding: EdgeInsets.only(left: 6),
                                      child: BrunoTools.getAssetImage(
                                          BrnAsset.iconPopupClose),
                                    )
                                  : Text("")
                            ],
                          ))
                : widget.widget));
  }
}

// 绘制箭头
class _TrianglePainter extends CustomPainter {
  bool isDownArrow;
  Color color;
  Color borderColor;

  _TrianglePainter({
    required this.isDownArrow,
    required this.color,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    paint.strokeWidth = 2.0;
    paint.color = color;
    paint.style = PaintingStyle.fill;

    if (isDownArrow) {
      path.moveTo(0.0, -1.5);
      path.lineTo(size.width / 2.0, size.height);
      path.lineTo(size.width, -1.5);
    } else {
      path.moveTo(0.0, size.height + 1.5);
      path.lineTo(size.width / 2.0, 0.0);
      path.lineTo(size.width, size.height + 1.5);
    }

    canvas.drawPath(path, paint);
    Paint paintBorder = Paint();
    Path pathBorder = Path();
    paintBorder.strokeWidth = 0.5;
    paintBorder.color = borderColor;
    paintBorder.style = PaintingStyle.stroke;

    if (isDownArrow) {
      pathBorder.moveTo(0.0, -0.5);
      pathBorder.lineTo(size.width / 2.0, size.height);
      pathBorder.lineTo(size.width, -0.5);
    } else {
      pathBorder.moveTo(0.5, size.height + 0.5);
      pathBorder.lineTo(size.width / 2.0, 0);
      pathBorder.lineTo(size.width - 0.5, size.height + 0.5);
    }

    canvas.drawPath(pathBorder, paintBorder);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BrnPopupRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 200);
  Widget child;

  BrnPopupRoute({required this.child});

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}

/// popup 中每个 Item 被点击时的回调，并决定是否拦截点击事件
/// [index] Item 的索引
/// [item] Item 内容
/// 返回 true 则拦截点击事件，不再走 pop 逻辑
typedef BrnPopupListItemClick = bool Function(int index, String item);

/// popup 用于构造自定义的 Item
/// [index] Item 的索引
/// [item] Item 内容
typedef BrnPopupListItemBuilder = Widget? Function(int index, String item);

/// 基于 PopUpWindow 的 弹窗列表工具类
class BrnPopupListWindow {
  /// 带 itemBuilder 的 Popup List Window
  /// [popKey] 依附的组件和BrnPopUpWindow组件共同持有的GlobalKey
  /// [data] 要显示的文本数据列表
  /// [popDirection] 箭头的方向
  /// [itemBuilder] 自定义 item 构造方法
  /// [onItemClick] item 点击回调
  /// [onItemClickInterceptor] item 点击拦截回调
  /// [onDismiss] popUpWindow消失回调
  static void showButtonPanelPopList(
    context,
    GlobalKey popKey, {
    List<String>? data,
    BrnPopupDirection popDirection = BrnPopupDirection.bottom,
    BrnPopupListItemBuilder? itemBuilder,
    BrnPopupListItemClick? onItemClick,
    VoidCallback? onDismiss,
  }) {
    TextStyle textStyle = TextStyle(
        color: BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase, fontSize: 16);
    double arrowHeight = 6.0;
    Color borderColor = Color(0xffCCCCCC);
    Color backgroundColor = Colors.white;
    double offset = 4;
    double spaceMargin = -10;
    double minWidth = 100;
    double maxWidth = 150;
    double maxHeight = 200;
    double borderRadius = 4;
    bool hasCloseIcon = true;
    assert(popKey.currentContext != null && popKey.currentContext!.findRenderObject() != null);
    if (popKey.currentContext == null || popKey.currentContext!.findRenderObject() == null) return;
    Navigator.push(
        context,
        BrnPopupRoute(
            child: BrnPopupWindow(
          context,
          arrowHeight: arrowHeight,
          popKey: popKey,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          isShowCloseIcon: hasCloseIcon,
          offset: offset,
          widget: BrunoTools.isEmpty(data)
              ? Container(
                  constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                )
              : Container(
                  constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Column(
                        children:
                            _getItems(context, minWidth, maxWidth, itemBuilder, textStyle, data!,
                                (index, item) {
                          if (onItemClick != null) {
                            bool isIntercept = onItemClick(index, item);
                            if (isIntercept) return;
                          }
                          Navigator.pop(context, {'index': index, 'item': item});
                        }),
                      ),
                    ),
                  ),
                ),
          popDirection: popDirection,
          borderRadius: borderRadius,
          borderColor: borderColor,
          spaceMargin: spaceMargin,
        ))).then((result) {
      if (onDismiss != null) {
        onDismiss();
      }
    });
  }

  /// 显示Popup List Window
  /// [popKey] 依附的组件和BrnPopUpWindow组件共同持有的GlobalKey
  /// [data] 要显示的文本数据列表
  /// [popDirection] 箭头的方向
  /// [offset] 距离targetView偏移量
  /// [onItemClick] item 点击回调
  /// [onItemClickInterceptor] item 点击拦截回调
  /// [onDismiss] popUpWindow消失回调
  static void showPopListWindow(context, GlobalKey popKey,
      {List<String>? data,
      BrnPopupDirection popDirection = BrnPopupDirection.bottom,
      double offset = 0,
      double? arrowOffset,
      BrnPopupListItemClick? onItemClick,
      VoidCallback? onDismiss}) {
    assert(popKey.currentContext != null && popKey.currentContext!.findRenderObject() != null);
    if (popKey.currentContext == null || popKey.currentContext!.findRenderObject() == null) return;

    double arrowHeight = 6.0;
    double borderRadius = 4;
    double spaceMargin = 0;
    double minWidth = 100;
    double maxWidth = 150;
    double maxHeight = 200;
    Color borderColor = BrnThemeConfigurator.instance.getConfig().commonConfig.dividerColorBase;
    Color backgroundColor = Colors.white;
    TextStyle textStyle = TextStyle(
        color: BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase, fontSize: 14);
    bool hasCloseIcon = true;

    Navigator.push(
      context,
      BrnPopupRoute(
        child: BrnPopupWindow(
          context,
          arrowHeight: arrowHeight,
          popKey: popKey,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          arrowOffset: arrowOffset,
          isShowCloseIcon: hasCloseIcon,
          offset: offset,
          widget: BrunoTools.isEmpty(data)
              ? Container(
                  constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                )
              : Container(
                  constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Column(
                        children: _getItems(context, minWidth, maxWidth, null, textStyle, data!,
                            (index, item) {
                          if (onItemClick != null) {
                            bool isIntercept = onItemClick(index, item);
                            if (isIntercept) return;
                          }
                          Navigator.pop(context);
                        }),
                      ),
                    ),
                  ),
                ),
          popDirection: popDirection,
          borderRadius: borderRadius,
          borderColor: borderColor,
          spaceMargin: spaceMargin,
        ),
      ),
    ).then((result) {
      if (onDismiss != null) {
        onDismiss();
      }
    });
  }

  static List<Widget> _getItems(
      BuildContext context,
      double minWidth,
      double maxWidth,
      BrnPopupListItemBuilder? itemBuilder,
      TextStyle textStyle,
      List<String> data,
      void Function(int index, String item) onItemClick) {
    double textMaxWidth = _getMaxWidth(textStyle, data);
    if (textMaxWidth + 52 < minWidth) {
      textMaxWidth = minWidth;
    } else if (textMaxWidth + 52 > maxWidth) {
      textMaxWidth = maxWidth;
    } else {
      textMaxWidth = textMaxWidth + 52;
    }
    return data.map((f) {
      return GestureDetector(
          onTap: () {
            onItemClick(data.indexOf(f), f);
          },
          child: Container(
              width: textMaxWidth,
              alignment: Alignment.center,
              color: Colors.transparent,
              padding: EdgeInsets.only(left: 26, right: 26, top: 6, bottom: 6),
              child: _getTextWidget(itemBuilder, data, f, textStyle)));
    }).toList();
  }

  /// 遍历数据，计算每个 Item 内容，返回所有 Item 可展示的最大宽度
  static double _getMaxWidth(TextStyle textStyle, List<String> data) {
    double maxWidth = 0;
    if (!BrunoTools.isEmpty(data)) {
      Size? maxWidthSize;
      for (String entity in data) {
        Size size = BrnTextUtil.textSize(entity, textStyle);
        if (maxWidthSize == null) {
          maxWidthSize = size;
        } else {
          if (maxWidthSize.width < size.width) {
            maxWidthSize = size;
          }
        }
      }
      if (maxWidthSize != null) {
        maxWidth = maxWidthSize.width;
      }
    }
    return maxWidth;
  }

  static Widget _getTextWidget(BrnPopupListItemBuilder? itemBuilder,
      List<String> data, String text, TextStyle textStyle) {
    if (itemBuilder == null) {
      return _getDefaultText(text, textStyle);
    } else {
      return itemBuilder(data.indexOf(text), text) ??
          _getDefaultText(text, textStyle);
    }
  }

  static Text _getDefaultText(String text, TextStyle textStyle) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: textStyle,
    );
  }
}
