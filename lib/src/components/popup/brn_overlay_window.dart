import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:bruno/src/components/popup/brn_measure_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// popWindow位于targetView的方向
enum BrnOverlayPopDirection { none, top, bottom, left, right }

/// * 描述: Overlay 工具类。
class BrnOverlayWindow extends StatefulWidget {
  final BuildContext context;

  /// 锚点 Widget 的 key，用于 OverlayWindow 的定位
  final Key targetKey;

  /// OverlayWindow 相对于 key 的展示位置， 默认 bottom
  final BrnOverlayPopDirection popDirection;

  /// 要展示的内容
  final Widget content;

  const BrnOverlayWindow({
    this.context,
    this.targetKey,
    this.popDirection = BrnOverlayPopDirection.bottom,
    this.content,
  });

  @override
  State<StatefulWidget> createState() {
    return _BrnOverlayWindowState();
  }

  /// BrnOverlayWindow 工具方发，用于快速弹出 Overlay，
  /// 返回 [BrnOverlayController] 用于控制 OverlayWindow 的隐藏
  /// [targetKey] 锚点 Widget 的 key，用于 OverlayWindow 的定位
  /// [popDirection] OverlayWindow 相对于 key 的展示位置， 默认 bottom
  /// [content] 要展示的内容
  /// [autoDismissOnTouchOutSide] 点击 OverlayWindow 外部是否自动消失
  /// [onDismiss] OverlayWindow 消失回调
  static BrnOverlayController showOverlayWindow(BuildContext context, Key targetKey,
      {Widget content,
      BrnOverlayPopDirection popDirection,
      bool autoDismissOnTouchOutSide = true,
      Function onDismiss}) {
    assert(content != null);
    assert(targetKey != null);

    if (content == null || targetKey == null) return null;

    BrnOverlayController overlayController;
    OverlayEntry entry = OverlayEntry(builder: (context) {
      return GestureDetector(
          behavior: (autoDismissOnTouchOutSide)
              ? HitTestBehavior.opaque
              : HitTestBehavior.deferToChild,
          onTap: (autoDismissOnTouchOutSide)
              ? () {
                  overlayController?.removeOverlay();
                  if (onDismiss != null) {
                    onDismiss();
                  }
                }
              : null,
          child: BrnOverlayWindow(
            context: context,
            content: content,
            targetKey: targetKey,
            popDirection: popDirection,
          ));
    });

    overlayController = BrnOverlayController._(context, entry)..showOverlay();
    return overlayController;
  }
}

class _BrnOverlayWindowState extends State<BrnOverlayWindow> {
  /// targetView的位置
  Rect _showRect;

  /// 屏幕的尺寸
  Size _screenSize;

  /// overlay 在targetView 四周的偏移位置
  double _left, _right, _top, _bottom;

  /// targetView 的 Size
  Size _targetViewSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    this._showRect = _getWidgetGlobalRect(widget.targetKey);
    this._screenSize = window.physicalSize / window.devicePixelRatio;
    _calculateOffset();
    return _buildContent();
  }

  Widget _buildContent() {
    var contentPart = Material(
        color: Colors.transparent,
        child: MeasureSize(
            onChange: (size) {
              setState(() {
                _targetViewSize = size;
              });
            },
            child: widget.content));
    var placeHolderPart = GestureDetector();
    Widget realContent;

    double marginTop = _showRect.top + (_showRect.height - _targetViewSize.height) / 2;
    if (_screenSize.height - marginTop < _targetViewSize.height) {
      marginTop = max(0, _screenSize.height - _targetViewSize.height);
    }
    marginTop = max(0, marginTop);

    double marginLeft = _showRect.left + (_showRect.width - _targetViewSize.width) / 2;
    if (_screenSize.width - marginLeft < _targetViewSize.width) {
      marginLeft = max(0, _screenSize.width - _targetViewSize.width);
    }
    marginLeft = max(0, marginLeft);

    if (widget.popDirection == BrnOverlayPopDirection.left) {
      realContent = Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
                padding: EdgeInsets.only(top: marginTop),
                alignment: Alignment.topRight,
                child: contentPart),
            flex: _left.toInt(),
          ),
          Expanded(
            child: placeHolderPart,
            flex: (_screenSize.width - _left).toInt(),
          )
        ],
      );
    } else if (widget.popDirection == BrnOverlayPopDirection.right) {
      realContent = Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: placeHolderPart,
            flex: (_right).toInt(),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(top: marginTop),
                alignment: Alignment.topLeft,
                child: contentPart),
            flex: (_screenSize.width - _right).toInt(),
          )
        ],
      );
    } else if (widget.popDirection == BrnOverlayPopDirection.top) {
      realContent = Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
                padding: EdgeInsets.only(top: marginLeft),
                alignment: Alignment.bottomLeft,
                child: contentPart),
            flex: _top.toInt(),
          ),
          Expanded(
            child: placeHolderPart,
            flex: (_screenSize.height - _top).toInt(),
          )
        ],
      );
    } else {
      realContent = Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: placeHolderPart,
            flex: _bottom.toInt(),
          ),
          Expanded(
            child: Container(alignment: Alignment.topLeft, child: contentPart),
            flex: (_screenSize.height - _bottom).toInt(),
          )
        ],
      );
    }
    return realContent;
  }

  ///
  /// 获取targetView的位置
  ///
  Rect _getWidgetGlobalRect(GlobalKey key) {
    if (key == null) {
      return null;
    }
    RenderBox renderBox = key.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  ///
  /// 计算popUpWindow显示的位置
  ///
  void _calculateOffset() {
    _right = _left = _top = _bottom = 0;
    if (widget.popDirection == BrnOverlayPopDirection.left) {
      _left = _showRect.left;
    } else if (widget.popDirection == BrnOverlayPopDirection.right) {
      _right = _showRect.right;
    } else if (widget.popDirection == BrnOverlayPopDirection.bottom) {
      _bottom = _showRect.bottom;
    } else if (widget.popDirection == BrnOverlayPopDirection.top) {
      // 在targetView上方
      _top = _showRect.top;
    }
  }
}

class BrnOverlayController {
  OverlayEntry _entry;

  BuildContext context;
  bool _isOverlayShowing = false;

  bool get isOverlayShowing => _isOverlayShowing;

  BrnOverlayController._(this.context, this._entry);

  showOverlay() {
    Overlay.of(context).insert(_entry);
    _isOverlayShowing = true;
  }

  void removeOverlay() {
    _entry?.remove();
    _entry = null;
    _isOverlayShowing = false;
  }
}
