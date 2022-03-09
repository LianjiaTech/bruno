

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

  void setSelectIndex(int index) {
    selectIndex = index;
    notifyListeners();
  }

  void show() {
    isShow = true;
    notifyListeners();
  }

  void hide() {
    isShow = false;
    notifyListeners();
  }
}

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

  void closeMoreWindow() {
    _closeController.add(CloseWindowEvent());
  }
}
