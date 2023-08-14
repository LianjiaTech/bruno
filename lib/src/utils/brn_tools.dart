import 'package:bruno/src/constants/brn_strings_constants.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// 图片加载工具类
class BrunoTools {
  const BrunoTools._();

  /// 将 icon 根据主题色变色后返回
  /// [assetFilePath] assets 资源文件路径
  /// [configId] 主题配置id
  static Image getAssetImageWithBandColor(
    String assetFilePath, {
    String configId = GLOBAL_CONFIG_ID,
  }) {
    final BrnCommonConfig? commonConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .commonConfig;
    if (!assetFilePath.startsWith('assets')) {
      assetFilePath = 'assets/$assetFilePath';
    }
    return getAssetImageWithColor(assetFilePath, commonConfig?.brandPrimary);
  }

  /// 将 icon 根据传入颜色变后返回
  /// [assetFilePath] assets 资源文件路径
  /// [color] 图片着色
  static Image getAssetImageWithColor(String assetFilePath, Color? color) {
    if (!assetFilePath.startsWith('assets')) {
      assetFilePath = 'assets/$assetFilePath';
    }
    return Image.asset(
      assetFilePath,
      color: color,
      package: BrnStrings.flutterPackageName,
      scale: 3.0,
    );
  }

  /// [assetFilePath] assets 资源文件路径
  /// [fit] 图片剪裁模式
  /// [gaplessPlayback] 当图像提供程序更改时，是继续显示旧映像（true），还是暂时显示空白（false）。
  static Image getAssetImage(
    String assetFilePath, {
    BoxFit? fit,
    bool gaplessPlayback = false,
  }) {
    if (!assetFilePath.startsWith('assets')) {
      assetFilePath = 'assets/$assetFilePath';
    }
    return Image.asset(
      assetFilePath,
      package: BrnStrings.flutterPackageName,
      fit: fit,
      scale: 3.0,
      gaplessPlayback: gaplessPlayback,
    );
  }

  /// [assetFilePath] assets 资源文件路径，使用默认 scale
  static Image getAssetScaleImage(String assetFilePath) {
    if (!assetFilePath.startsWith('assets')) {
      assetFilePath = 'assets/$assetFilePath';
    }
    return Image.asset(
      assetFilePath,
      package: BrnStrings.flutterPackageName,
    );
  }

  /// [assetFilePath] assets 资源文件路径
  /// [w] 图片宽度
  /// [h] 图片高度，
  /// [color] 图片着色
  static Image getAssetSizeImage(
    String assetFilePath,
    double w,
    double h, {
    Color? color,
  }) {
    if (!assetFilePath.startsWith('assets')) {
      assetFilePath = 'assets/$assetFilePath';
    }
    return Image.asset(
      assetFilePath,
      package: BrnStrings.flutterPackageName,
//      scale: 3.0,
      width: w,
      height: h,
      color: color,
    );
  }

  /// 从16进制数字字符串，生成Color，例如EDF0F3
  static Color colorFromHexString(String? s) {
    if (s == null || s.length != 6 || int.tryParse(s, radix: 16) == null) {
      return Colors.black;
    }
    return Color(int.parse(s, radix: 16) + 0xFF000000);
  }

  /// 获取本地 [AssetImage]
  /// [assetFilePath] assets资源文件路径
  static ImageProvider getAssetImageProvider(String assetFilePath) {
    if (!assetFilePath.startsWith('assets')) {
      assetFilePath = 'assets/$assetFilePath';
    }

    final AssetImage image = AssetImage(
      assetFilePath,
      package: BrnStrings.flutterPackageName,
    );
    return image;
  }

  /// 根据 TextStyle 计算 text 宽度。
  static Size textSize(String text, TextStyle style) {
    if (isEmpty(text)) return Size(0, 0);
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  /// 判空
  static bool isEmpty(Object? obj) {
    if (obj is String) {
      return obj.isEmpty;
    }
    if (obj is Iterable) {
      return obj.isEmpty;
    }
    if (obj is Map) {
      return obj.isEmpty;
    }
    return obj == null;
  }
}
