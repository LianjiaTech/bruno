import 'package:bruno/src/utils/brn_event_bus.dart';
import 'package:flutter/material.dart';


class BrnSelectionListViewController extends ChangeNotifier {

  /// 菜单索引
  int menuIndex;

  /// 是否显示下拉筛选列表
  bool isShow;

  /// 下拉筛选列表顶部坐标
  double? listViewTop;

  /// 屏幕高度，暂时没用到
  double? screenHeight;

  /// 显示下拉筛选列表的图层
  OverlayEntry? entry;

  BrnSelectionListViewController({
    this.menuIndex = -1,
    this.isShow = false,
  });

  /// 显示下拉筛选列表
  void show(int index) {
    isShow = true;
    menuIndex = index;
    notifyListeners();
  }

  /// 隐藏下拉筛选列表
  void hide() {
    isShow = false;
    entry?.remove();
    entry = null;
    notifyListeners();
  }
}

/// 筛选控制器
class BrnSelectionViewController {

  /// 关闭筛选弹窗
  void closeSelectionView() {
    EventBus.instance.fire(CloseSelectionViewEvent());
  }

  /// 主动刷新 menu 菜单标题
  void refreshSelectionTitle() {
    EventBus.instance.fire(RefreshMenuTitleEvent());
  }
}

/// 筛选事件
abstract class BaseSelectionEvent {}

/// 刷新菜单标题事件
class RefreshMenuTitleEvent extends BaseSelectionEvent {}

/// 关闭筛选弹窗事件
class CloseSelectionViewEvent extends BaseSelectionEvent {}
