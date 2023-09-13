

import 'dart:async';

import 'package:flutter/material.dart';

class BrnTabbarController extends ChangeNotifier {
  ///
  /// 更多选项距离顶部距离
  ///
  double? top;

  ///
  /// 是否显示更多选项弹框
  ///
  bool isShow = false;

  ///
  /// 屏幕高度
  ///
  double? screenHeight;

  ///
  /// 展开更多图层
  ///
  OverlayEntry? entry;

  ///
  /// 选中的角标
  ///
  int selectIndex = 0;

  /// 设置选中的位置
  /// [index] 选中的位置
  void setSelectIndex(int index) {
    selectIndex = index;
    notifyListeners();
  }

  /// 设置更多选项弹出
  void show() {
    isShow = true;
    notifyListeners();
  }

  /// 设置更多选项隐藏
  void hide() {
    isShow = false;
    notifyListeners();
  }
}

/// 关闭更多弹框事件
class CloseWindowEvent {
  bool? isShow = false;

  CloseWindowEvent({this.isShow});
}

///
/// 提供给外部用于控制更多弹框的关闭
///
class BrnCloseWindowController {
  ///
  /// 展开更多弹框是否显示
  ///
  bool isShow = false;

  StreamController<CloseWindowEvent> _closeController =
      StreamController.broadcast();

  StreamController<CloseWindowEvent> getCloseController() {
    return _closeController;
  }

  ///
  /// 同步弹框展开状态
  ///
  void syncWindowState(bool state) {
    isShow = state;
  }

  /// 关闭 "更多" 弹框
  void closeMoreWindow() {
    _closeController.add(CloseWindowEvent());
  }
}
