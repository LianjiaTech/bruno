import 'package:bruno/src/theme/configs/brn_dialog_config.dart';
import 'package:flutter/material.dart';

class BrnDialogUtils {
  /// dialog标题配置
  static TextStyle getDialogTitleStyle(BrnDialogConfig themeData) {
    return themeData.titleTextStyle.generateTextStyle();
  }

  /// dialog圆角配置
  static double getDialogRadius(BrnDialogConfig themeData) {
    return themeData.radius;
  }
}
