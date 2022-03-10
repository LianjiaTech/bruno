import "package:flutter/foundation.dart";
import 'package:flutter/material.dart';

class BrnSelectionDatePickerController extends ChangeNotifier {
  bool isShow; //是否显示下拉筛选列表
  OverlayEntry? entry;

  BrnSelectionDatePickerController({
    this.isShow = false,
    this.entry,
  });

  void show() {
    isShow = true;
  }

  void hide() {
    isShow = false;
    entry?.remove();
    entry = null;
  }
}
