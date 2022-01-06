import 'package:flutter/material.dart';

/// 区间+输入混合一级筛选Controller

class BrnFlatSelectionController extends ChangeNotifier {
  bool isResetSelectedOptions = false;
  bool isCancelSelectedOptions = false;
  bool isConfirmSelectedOptions = false;

  void resetSelectedOptions() {
    isResetSelectedOptions = true;
    isCancelSelectedOptions = false;
    isConfirmSelectedOptions = false;
    notifyListeners();
  }

  void cancelSelectedOptions() {
    isResetSelectedOptions = false;
    isCancelSelectedOptions = true;
    isConfirmSelectedOptions = false;
    notifyListeners();
  }

  void confirmSelectedOptions() {
    isResetSelectedOptions = false;
    isCancelSelectedOptions = false;
    isConfirmSelectedOptions = true;
    notifyListeners();
  }
}

/// 清空输入框
class FlatClearEvent {}
