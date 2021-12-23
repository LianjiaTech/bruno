import 'package:flutter/material.dart';

class BrnAppBarTheme {
  const BrnAppBarTheme._();

  /// [BrnAppBar] 高度固定值
  static const double appBarHeight = 44;

  /// AppBar中添加的leading或actionItem的边长
  static const double iconSize = 20;

  /// [BrnIconAction]之间的间距
  static const double iconMargin = 20;

  /// [LeadingIcon]的大小
  static const double iconFullSize = 40;

  /// [BrnAppBar] 标题的文字大小
  static const double titleFontSize = 18;

  /// [BrnAppBar] 中TextAction中的文字大小
  static const double actionFontSize = 14;

  /// [BrnAppBar] 使用[BrnDoubleLeading]添加两个leading时的固定宽度
  static const double doubleLeadingSize = 80;

  /// [Brightness.light] 时使用的文字颜色
  static const Color lightTextColor = Color(0xFF222222);

  /// [Brightness.dark] 时使用的文字颜色
  static const Color darkTextColor = Colors.white;

  /// AppBar title的最大字符数
  static const int maxLength = 8;
}
