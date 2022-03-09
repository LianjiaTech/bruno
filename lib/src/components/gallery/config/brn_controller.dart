

import 'package:flutter/material.dart';

/// 控制页面刷新，并跳转到指定的 index
class BrnGalleryController extends ChangeNotifier {
  int groupId = 0;
  int indexId = 0;

  /// 页面刷新，跳转到指定的 index
  /// [groupId] 第几组图片
  /// [indexId] 组内的第几张
  void refresh(int groupId, int indexId) {
    this.groupId = groupId;
    this.indexId = indexId;
    notifyListeners();
  }
}
