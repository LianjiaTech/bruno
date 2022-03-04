import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/painting.dart';

/// 将标签属性转为对应的 style
class BrnConvertUtil {
  const BrnConvertUtil._();

  /// 将标签 color 转为 颜色
  static Color? generateColorByString(
    String hexColor, {
    Color defaultColor = const Color(0xffffffff),
  }) {
    Color? color =
        BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary;
    if (hexColor.isEmpty) return color;
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    hexColor = hexColor.replaceAll('0X', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }

    try {
      color = Color(int.parse(hexColor, radix: 16));
    } catch (_) {}
    return color ?? defaultColor;
  }

  /// 将标签字体转为合适的字体
  static FontWeight generateFontWidgetByString(String fontWeight) {
    FontWeight defaultWeight = FontWeight.normal;
    switch (fontWeight) {
      case 'Bold':
        defaultWeight = FontWeight.w600;
        break;
      case 'Medium':
        defaultWeight = FontWeight.w500;
        break;
      case 'Light':
        defaultWeight = FontWeight.w300;
        break;
    }
    return defaultWeight;
  }

  /// 将标签字体大小转为合适大小的字体
  static double generateFontSize(String size) {
    double defaultSize = 13;
    try {
      defaultSize = double.parse(size);
    } catch (_) {}
    return defaultSize;
  }
}
