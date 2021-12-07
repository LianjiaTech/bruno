import "package:flutter/foundation.dart";
import 'package:flutter/material.dart';

class BrnSelectionDatePickerController extends ChangeNotifier {
  bool isShow = false; //是否显示下拉筛选列表
  OverlayEntry entry;

  double screenHeight; //显示下拉筛选列表的图层

  void show() {
    isShow = true;
  }

  void hide() {
    isShow = false;
  }
}
