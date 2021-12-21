import 'dart:math';

import 'package:flutter/material.dart';

/// 位置枚举
enum BrnToastGravity {
  /// 底部显示
  bottom,

  /// 居中显示
  center,

  /// 顶部显示
  top,
}

/// toast 显示时长
class BrnLength {
  BrnLength._();

  /// toast 显示较短时间（1s）
  static const int short = 1;

  /// toast 显示较长时间（3s）
  static const int long = 3;
}

/// 通用的Toast组件
class BrnToast {
  static _ToastView? preToastView;

  /// 显示在中间。如不设置duration则会自动根据内容长度来计算（更友好，最长5秒）
  static void showInCenter(
      {required String text, required BuildContext context, int? duration}) {
    show(
      text,
      context,
      duration: duration,
      gravity: BrnToastGravity.center,
    );
  }

  /// 显示Toast，如不设置duration则会自动根据内容长度来计算（更友好，最长5秒）
  static void show(
    String text,
    BuildContext context, {
    int? duration,
    Color? background,
    TextStyle? textStyle,
    double? radius,
    Image? preIcon,
    double? verticalOffset,
    VoidCallback? onDismiss,
    BrnToastGravity? gravity,
  }) {
    final OverlayState? overlayState = Overlay.of(context);
    if (overlayState == null) return;

    preToastView?._dismiss();
    preToastView = null;

    final double _systemVerticalOffset = getSystemVerticalOffset(
      context: context,
      gravity: gravity,
    );

    /// 自动根据内容长度决定显示时长，更加人性化
    final int autoDuration =
        duration ?? min(text.length * 0.06 + 0.8, 5.0).ceil();
    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) {
        return _ToastWidget(
          widget: ToastChild(
            background: background,
            radius: radius,
            msg: text,
            leading: preIcon,
            textStyle: textStyle,
            gravity: gravity,
            verticalOffset: verticalOffset,
            systemVerticalOffset: _systemVerticalOffset,
          ),
        );
      },
    );
    _ToastView toastView = _ToastView(
      overlayState: overlayState,
      overlayEntry: overlayEntry,
    );
    preToastView = toastView;
    toastView._show(
      duration: Duration(seconds: autoDuration),
      onDismiss: onDismiss,
    );
  }

  /// 获取默认设置的垂直间距
  static double getSystemVerticalOffset(
      {required BuildContext context, BrnToastGravity? gravity}) {
    final double verticalOffset;
    switch (gravity) {
      case BrnToastGravity.bottom:
        verticalOffset = MediaQuery.of(context).viewInsets.bottom + 50;
        break;
      case BrnToastGravity.top:
        verticalOffset = MediaQuery.of(context).viewInsets.top + 50;
        break;
      case BrnToastGravity.center:
      default:
        verticalOffset = 0;
    }
    return verticalOffset;
  }
}

class _ToastView {
  late OverlayState overlayState;
  late OverlayEntry overlayEntry;
  bool _isVisible = false;

  _ToastView({
    required this.overlayState,
    required this.overlayEntry,
  });

  void _show({required Duration duration, VoidCallback? onDismiss}) async {
    _isVisible = true;
    overlayState.insert(overlayEntry);
    Future.delayed(duration, () {
      _dismiss();
      onDismiss?.call();
    });
  }

  void _dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    overlayEntry.remove();
  }
}

class ToastChild extends StatelessWidget {
  const ToastChild({
    Key? key,
    required this.msg,
    required this.systemVerticalOffset,
    this.background,
    this.radius,
    this.leading,
    this.gravity,
    this.verticalOffset,
    this.textStyle,
  }) : super(key: key);

  Alignment get alignment {
    if (verticalOffset != null) {
      return Alignment.topCenter;
    }
    switch (gravity) {
      case BrnToastGravity.bottom:
        return Alignment.bottomCenter;
      case BrnToastGravity.top:
        return Alignment.topCenter;
      case BrnToastGravity.center:
      default:
        return Alignment.center;
    }
  }

  EdgeInsets? get padding {
    if (verticalOffset != null) {
      return EdgeInsets.only(top: verticalOffset!);
    }
    switch (gravity) {
      case BrnToastGravity.bottom:
        return EdgeInsets.only(bottom: systemVerticalOffset);
      case BrnToastGravity.top:
        return EdgeInsets.only(top: systemVerticalOffset);
      case BrnToastGravity.center:
      default:
        return null;
    }
  }

  final String msg;
  final double systemVerticalOffset;
  final Color? background;
  final double? radius;
  final Image? leading;
  final BrnToastGravity? gravity;
  final double? verticalOffset;
  final TextStyle? textStyle;

  InlineSpan get leadingSpan {
    if (leading == null) {
      return const TextSpan(text: "");
    }
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Padding(padding: const EdgeInsets.only(right: 6), child: leading!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: padding,
        alignment: alignment,
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
            color: background ?? const Color(0xFF222222),
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
          child: RichText(
            text: TextSpan(children: <InlineSpan>[
              leadingSpan,
              TextSpan(text: msg, style: textStyle),
            ]),
          ),
        ),
      ),
    );
  }
}

class _ToastWidget extends StatelessWidget {
  const _ToastWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Widget widget;

  /// 使用IgnorePointer，方便手势透传过去
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Material(color: Colors.transparent, child: widget),
    );
  }
}
