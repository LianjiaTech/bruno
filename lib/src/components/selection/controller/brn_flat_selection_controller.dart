import 'package:flutter/material.dart';

/// 区间+输入混合一级筛选Controller
class BrnFlatSelectionController extends ChangeNotifier {
  bool isResetSelectedOptions = false;
  bool isCancelSelectedOptions = false;
  bool isConfirmSelectedOptions = false;

  /// 控制重置点击事件
  void resetSelectedOptions() {
    isResetSelectedOptions = true;
    isCancelSelectedOptions = false;
    isConfirmSelectedOptions = false;
    notifyListeners();
  }

  /// 控制取消点击事件
  void cancelSelectedOptions() {
    isResetSelectedOptions = false;
    isCancelSelectedOptions = true;
    isConfirmSelectedOptions = false;
    notifyListeners();
  }

  /// 控制确认点击事件
  void confirmSelectedOptions() {
    isResetSelectedOptions = false;
    isCancelSelectedOptions = false;
    isConfirmSelectedOptions = true;
    notifyListeners();
  }
}

/// 清空输入框
class FlatClearEvent {}
