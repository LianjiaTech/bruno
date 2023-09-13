import 'dart:async';

import 'package:flutter/material.dart';

/// * * * * * * * * * * *
/// * 描述: 可以放心 dismiss 的 Dialog 工具类，
/// * 可基于该类进行二次封装，类似 [BrnLoadingDialog] 的 show、dismiss 方法
/// *
/// * 注意：若想删除指定 Dialog，必须在 show、dismiss 方法时传 tag，
/// * * * * * * * * * * *
class BrnSafeDialog {
  static const String _safeDialogDefaultTag = '_safeDialogDefaultTag';

  /// 根据 tag 区分是某一类 Dialog 的队列状态
  static Map<String, List<_SafeDialogRoute>> _dialogStates = {};

  /// 用于关闭某个 Dialog，仅移除对应 tag 列表中最后入栈的 Dialog
  /// [tag]: 用于移除对应 tag 的 Dialog
  ///
  /// 注意，
  /// 1、直接 remove 不会调用 push future 的 then 回调,使用 Completer 转发；
  /// 2、当 router 不在队列队列中时会抛异常，catch 并打印异常日志。
  static void dismiss<T extends Object?>({
    required BuildContext context,
    String tag = _safeDialogDefaultTag,
    T? result,
  }) {
    List<_SafeDialogRoute> typeStates = (_dialogStates[tag] ??= []);
    if (typeStates.isNotEmpty) {
      try {
        _SafeDialogRoute _safeDialogRoute = typeStates.removeLast();
        Navigator.removeRoute(context, _safeDialogRoute);
        if (!_safeDialogRoute.completer.isCompleted) {
          _safeDialogRoute.completer.complete(result);
        }
      } catch (e) {
        /// TODO 可能会抛出异常, 直接打印到日志区
        print(e);
      }
    }
  }

  /// 展示 Dialog
  /// [tag] : 用于标记 Dialog 类型
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    String tag = _safeDialogDefaultTag,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) {
    assert(debugCheckHasMaterialLocalizations(context));
    final CapturedThemes themes = InheritedTheme.capture(
      from: context,
      to: Navigator.of(
        context,
        rootNavigator: useRootNavigator,
      ).context,
    );

    _SafeDialogRoute<T> safeDialogRoute = _SafeDialogRoute<T>(
      context: context,
      builder: builder,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      settings: routeSettings,
      themes: themes,
    );

    // Notice:
    // 关键点, 手动管理 Router
    // 将结果通过 Completer 转发出去
    _dialogStates[tag] ??= [];
    _dialogStates[tag]?.add(safeDialogRoute);
    Future<T?> future =
        Navigator.of(context, rootNavigator: useRootNavigator).push<T>(safeDialogRoute);
    future.then((result) {
      _dialogStates[tag]?.remove(safeDialogRoute);
      if (!safeDialogRoute.completer.isCompleted) {
        safeDialogRoute.completer.complete(result);
      }
    });
    return safeDialogRoute.completer.future;
  }
}

/// 基于 DialogRoute 简单封装了 Completer，用于 Route 结果的转发
class _SafeDialogRoute<T> extends DialogRoute<T> {

  /// 转发 Route 结果
  final Completer<T?> completer = Completer<T?>();

  _SafeDialogRoute({
    required BuildContext context,
    required WidgetBuilder builder,
    CapturedThemes? themes,
    Color? barrierColor = Colors.black54,
    bool barrierDismissible = true,
    String? barrierLabel,
    bool useSafeArea = true,
    RouteSettings? settings,
  })  : super(
    context:context,
    builder: builder,
    themes: themes,
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
    settings: settings,
  );
}