import 'package:bruno/src/constants/brn_strings_constants.dart';
import 'package:flutter/material.dart';

/// 页面或者弹窗中间的圆形加载框，左侧是可定制的加载文案[content]，比如：加载中、提交中等等
///
/// 该组件 并不支持获取 指定时刻的动画值
///
/// 页面中使用
/// Scaffold(
///   appBar: BrnAppBar(
///      title: 'Loading案例',
///   ),
///   body: BrnPageLoading(),
/// )
///
/// 对话框中使用
/// showDialog(
///    context: context,
///    barrierDismissible: barrierDismissible,
///    useRootNavigator: useRootNavigator,
///    builder: (_) {
///       return BrnLoadingDialog(content: content);
///    });
///
/// 其他加载组件:
///  * [LinearProgressIndicator], 线性加载组件.
///  * [RefreshIndicator], 刷新组件。
///  * [BrnLoadingDialog], 加载对话框。

class BrnPageLoading extends StatelessWidget {
  final String content;

  const BrnPageLoading({this.content = BrnStrings.loadingContent});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 130,
        decoration: BoxDecoration(
            color: Color(0xff222222), borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 19,
                width: 19,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(
                  content,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// 通过 [BrnPageLoading] 构建出的加载状态的弹窗，加载动画和加载文字并排展示，且在屏幕中间。可通
/// 过 [BrnLoadingDialog.show] 和 [BrnLoadingDialog.dismiss] 控制弹窗的显示和关闭。不会自动关闭。
class BrnLoadingDialog extends Dialog {
  /// 加载时的提示文案，默认为 `加载中...`
  final String content;

  const BrnLoadingDialog({Key? key, this.content = BrnStrings.loadingContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BrnPageLoading(content: content);
  }

  /// 展示加载弹窗的静态方法。
  ///
  ///  * [context] 上下文
  ///  * [content] 加载时的提示文案
  ///  * [barrierDismissible] 点击蒙层背景是否关闭弹窗，默认为 true，可关闭，详见 [showDialog] 中的 [barrierDismissible]
  ///  * [useRootNavigator] 把弹窗添加到 [context] 中的 rootNavigator 还是最近的 [Navigator]，默认为 true，添加到
  ///    rootNavigator，详见 [showDialog] 中的 [useRootNavigator]。
  static Future<T?> show<T>(
    BuildContext context, {
    String content = BrnStrings.loadingContent,
    bool barrierDismissible = true,
    bool useRootNavigator = true,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        builder: (_) {
          return BrnLoadingDialog(content: content);
        });
  }

  /// 关闭弹窗。
  ///
  ///  * [context] 上下文。
  static void dismiss<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }
}
