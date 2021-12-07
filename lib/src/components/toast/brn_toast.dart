import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

/// 通用的Toast组件
class BrnToast {
  static const LENGTH_SHORT = 1;
  static const LENGTH_LONG = 2;
  static const BOTTOM = 0;
  static const CENTER = 1;
  static const TOP = 2;

  static _ToastView preToastView;


  /// 显示在中间。如不设置duration则会自动根据内容长度来计算（更友好，最长5秒）
  static void showInCenter(String text, BuildContext context, {int duration}) {
    show(text, context, duration: duration, gravity: CENTER);
  }

  /// 显示Toast，如不设置duration则会自动根据内容长度来计算（更友好，最长5秒）
  static void show(String text, BuildContext context,
      {int duration,
      int gravity = BOTTOM,
      Color backgroundColor = const Color(0xFF222222),
      textStyle = const TextStyle(fontSize: 16, color: Colors.white),
      double backgroundRadius = 8,
      Image preIcon,
      double verticalOffset,
      VoidCallback onDismiss}) {
    OverlayState overlayState = Overlay.of(context);
    if (text == null || context == null || overlayState == null) {
      return;
    }
    preToastView?._dismiss();
    preToastView = null;

    verticalOffset = getRealVerticalOffset(verticalOffset, gravity, context);
    // 自动根据内容长度决定显示时长，更加人性化
    int aiDuration = duration ?? min(text.length * 0.06 + 0.8, 5.0).ceil();

    _ToastView toastView = _ToastView();
    toastView.overlayState = overlayState;
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return _buildToastLayout(
          context, backgroundColor, backgroundRadius, preIcon, text, textStyle, gravity,
          verticalOffset: verticalOffset);
    });
    toastView._overlayEntry = overlayEntry;
    preToastView = toastView;
    toastView._show(aiDuration, onDismiss: onDismiss);
  }

  static double getRealVerticalOffset(double verticalOffset, int gravity, BuildContext context) {
    if (gravity == BrnToast.TOP) {
      verticalOffset = (verticalOffset ?? 0) + MediaQuery.of(context).viewInsets.top + 50;
    } else if (gravity == BrnToast.BOTTOM) {
      verticalOffset = (verticalOffset ?? 0) + MediaQuery.of(context).viewInsets.bottom + 50;
    } else {
      verticalOffset = 0;
    }
    return verticalOffset;
  }
}

_ToastWidget _buildToastLayout(BuildContext context, Color background, double backgroundRadius,
    Image preIcon, String msg, TextStyle textStyle, int gravity,
    {double verticalOffset}) {
  Alignment alignment = Alignment.center;
  EdgeInsets padding;
  if (gravity == BrnToast.BOTTOM) {
    alignment = Alignment.bottomCenter;
    padding = EdgeInsets.only(bottom: verticalOffset);
  } else if (gravity == BrnToast.TOP) {
    alignment = Alignment.topCenter;
    padding = EdgeInsets.only(top: verticalOffset);
  }

  return _ToastWidget(
      widget: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
            padding: padding,
            alignment: alignment,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(backgroundRadius),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
              child: RichText(
                text: TextSpan(children: <InlineSpan>[
                  preIcon != null
                      ? WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.only(right: 6),
                            child: preIcon,
                          ))
                      : TextSpan(text: ""),
                  TextSpan(text: msg, style: textStyle),
                ]),
              ),
            )),
      ),
      gravity: gravity);
}

class _ToastView {
  OverlayState overlayState;
  OverlayEntry _overlayEntry;
  bool _isVisible = false;

  _show(int duration, {VoidCallback onDismiss}) async {
    _isVisible = true;
    overlayState.insert(_overlayEntry);
    await Future.delayed(Duration(seconds: duration == null ? BrnToast.LENGTH_SHORT : duration));
    _dismiss();
    if (onDismiss != null) {
      onDismiss();
    }
  }

  _dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class _ToastWidget extends StatelessWidget {
  final Widget widget;
  final int gravity;

  _ToastWidget({
    Key key,
    @required this.widget,
    @required this.gravity,
  }) : super(key: key);

  // 使用IgnorePointer，方便手势透传过去
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Material(
        color: Colors.transparent,
        child: widget,
      ),
    );
  }
}
