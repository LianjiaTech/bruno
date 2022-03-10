import 'package:bruno/src/components/navbar/brn_appbar_theme.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/constants/brn_strings_constants.dart';
import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_default_config_utils.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef BrnWidgetBuilder = Widget Function();

/// Appbar主题配置
class BrnAppBarConfig extends BrnBaseConfig {
  /// BrnAppBar 主题配置，遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultAppBarConfig]
  BrnAppBarConfig({
    Color? backgroundColor,
    double? appBarHeight,
    BrnWidgetBuilder? leadIconBuilder,
    BrnTextStyle? titleStyle,
    BrnTextStyle? actionsStyle,
    int? titleMaxLength,
    double? leftAndRightPadding,
    double? itemSpacing,
    EdgeInsets? titlePadding,
    double? iconSize,
    SystemUiOverlayStyle? systemUiOverlayStyle,
    String configId = GLOBAL_CONFIG_ID,
  })  : _backgroundColor = backgroundColor,
        _appBarHeight = appBarHeight,
        _leadIconBuilder = leadIconBuilder,
        _titleStyle = titleStyle,
        _actionsStyle = actionsStyle,
        _titleMaxLength = titleMaxLength,
        _leftAndRightPadding = leftAndRightPadding,
        _itemSpacing = itemSpacing,
        _titlePadding = titlePadding,
        _iconSize = iconSize,
        _systemUiOverlayStyle = systemUiOverlayStyle,
        super(configId: configId);

  BrnAppBarConfig.dark({
    double? appBarHeight,
    int? titleMaxLength,
    double? leftAndRightPadding,
    double? itemSpacing,
    EdgeInsets? titlePadding,
    double? iconSize,
    String configId = GLOBAL_CONFIG_ID,
  })  : _appBarHeight = appBarHeight,
        _titleMaxLength = titleMaxLength,
        _leftAndRightPadding = leftAndRightPadding,
        _itemSpacing = itemSpacing,
        _titlePadding = titlePadding,
        _iconSize = iconSize,
        super(configId: configId) {
    _backgroundColor = Color(0xff2E313B);
    _leadIconBuilder = () => Image.asset(
          BrnAsset.iconBackWhite,
          package: BrnStrings.flutterPackageName,
          width: BrnAppBarTheme.iconSize,
          height: BrnAppBarTheme.iconSize,
          fit: BoxFit.fitHeight,
        );
    _titleStyle = BrnTextStyle(
      fontSize: BrnAppBarTheme.titleFontSize,
      fontWeight: FontWeight.w600,
      color: BrnAppBarTheme.darkTextColor,
    );
    _actionsStyle = BrnTextStyle(
      color: BrnAppBarTheme.darkTextColor,
      fontSize: BrnAppBarTheme.actionFontSize,
      fontWeight: FontWeight.w600,
    );
    _systemUiOverlayStyle = SystemUiOverlayStyle.light;
  }

  BrnAppBarConfig.light({
    double? appBarHeight,
    int? titleMaxLength,
    double? leftAndRightPadding,
    double? itemSpacing,
    EdgeInsets? titlePadding,
    double? iconSize,
    String configId = GLOBAL_CONFIG_ID,
  })  : _appBarHeight = appBarHeight,
        _titleMaxLength = titleMaxLength,
        _leftAndRightPadding = leftAndRightPadding,
        _itemSpacing = itemSpacing,
        _titlePadding = titlePadding,
        _iconSize = iconSize,
        super(configId: configId) {
    _backgroundColor = Colors.white;
    _leadIconBuilder = () => Image.asset(
          BrnAsset.iconBackBlack,
          package: BrnStrings.flutterPackageName,
          width: BrnAppBarTheme.iconSize,
          height: BrnAppBarTheme.iconSize,
          fit: BoxFit.fitHeight,
        );
    _titleStyle = BrnTextStyle(
      fontSize: BrnAppBarTheme.titleFontSize,
      fontWeight: FontWeight.w600,
      color: BrnAppBarTheme.lightTextColor,
    );
    _actionsStyle = BrnTextStyle(
      color: BrnAppBarTheme.lightTextColor,
      fontSize: BrnAppBarTheme.actionFontSize,
      fontWeight: FontWeight.w600,
    );
    _systemUiOverlayStyle = SystemUiOverlayStyle.dark;
  }

  /// AppBar 的背景色
  Color? _backgroundColor;

  Color get backgroundColor =>
      _backgroundColor ??
      BrnDefaultConfigUtils.defaultAppBarConfig.backgroundColor;

  /// AppBar 的高度
  double? _appBarHeight;

  double get appBarHeight =>
      _appBarHeight ?? BrnDefaultConfigUtils.defaultAppBarConfig.appBarHeight;

  /// 返回按钮的child widget，一般为Image
  BrnWidgetBuilder? _leadIconBuilder;

  BrnWidgetBuilder get leadIconBuilder =>
      _leadIconBuilder ??
      BrnDefaultConfigUtils.defaultAppBarConfig.leadIconBuilder;

  /// 标题样式，仅当直接 title 设置为 String 生效
  ///
  /// **注意**：`fontSize` 必须传大小，否则报错
  BrnTextStyle? _titleStyle;

  BrnTextStyle get titleStyle =>
      _titleStyle ?? BrnDefaultConfigUtils.defaultAppBarConfig.titleStyle;

  /// 右侧文字按钮样式，仅当直接actions里面元素为BrnTextAction类型生效
  ///
  /// **注意**：`fontSize` 必须传大小，否则报错
  ///
  /// BrnTextStyle(
  ///   color: AppBarBrightness(brightness).textColor,
  ///   fontSize: BrnAppBarTheme.actionFontSize,
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _actionsStyle;

  BrnTextStyle get actionsStyle =>
      _actionsStyle ?? BrnDefaultConfigUtils.defaultAppBarConfig.actionsStyle;

  /// AppBar title 的最大字符数 8
  int? _titleMaxLength;

  int get titleMaxLength =>
      _titleMaxLength ??
      BrnDefaultConfigUtils.defaultAppBarConfig.titleMaxLength;

  /// 左右边距
  double? _leftAndRightPadding;

  double get leftAndRightPadding =>
      _leftAndRightPadding ??
      BrnDefaultConfigUtils.defaultAppBarConfig.leftAndRightPadding;

  /// 元素间间距
  double? _itemSpacing;

  double get itemSpacing =>
      _itemSpacing ?? BrnDefaultConfigUtils.defaultAppBarConfig.itemSpacing;

  /// title的padding
  EdgeInsets? _titlePadding;

  EdgeInsets get titlePadding =>
      _titlePadding ?? BrnDefaultConfigUtils.defaultAppBarConfig.titlePadding;

  /// leadIcon 宽高，需要相同
  /// 默认为 20
  double? _iconSize;

  double get iconSize =>
      _iconSize ?? BrnDefaultConfigUtils.defaultAppBarConfig.iconSize;

  /// statusBar 样式
  /// 默认为 [SystemUiOverlayStyle.dark]
  SystemUiOverlayStyle? _systemUiOverlayStyle;

  SystemUiOverlayStyle get systemUiOverlayStyle =>
      _systemUiOverlayStyle ??
      BrnDefaultConfigUtils.defaultAppBarConfig.systemUiOverlayStyle;

  @override
  void initThemeConfig(
    String configId, {
    BrnCommonConfig? currentLevelCommonConfig,
  }) {
    super.initThemeConfig(
      configId,
      currentLevelCommonConfig: currentLevelCommonConfig,
    );

    /// 用户全局组件配置
    BrnAppBarConfig appbarConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .appBarConfig;

    _backgroundColor ??= appbarConfig._backgroundColor;
    _appBarHeight ??= appbarConfig._appBarHeight;
    _leadIconBuilder ??= appbarConfig._leadIconBuilder;
    _titleStyle = appbarConfig.titleStyle.merge(_titleStyle);
    _actionsStyle = appbarConfig.actionsStyle.merge(_actionsStyle);
    _titleMaxLength ??= appbarConfig._titleMaxLength;
    _leftAndRightPadding ??= appbarConfig._leftAndRightPadding;
    _itemSpacing ??= appbarConfig._itemSpacing;
    _titlePadding ??= appbarConfig._titlePadding;
    _iconSize ??= appbarConfig._iconSize;
    _systemUiOverlayStyle ??= appbarConfig._systemUiOverlayStyle;
  }

  BrnAppBarConfig copyWith({
    Color? backgroundColor,
    double? appBarHeight,
    BrnWidgetBuilder? leadIconBuilder,
    BrnTextStyle? titleStyle,
    BrnTextStyle? actionsStyle,
    int? titleMaxLength,
    double? leftAndRightPadding,
    double? itemSpacing,
    EdgeInsets? titlePadding,
    double? iconSize,
    SystemUiOverlayStyle? systemUiOverlayStyle,
  }) {
    return BrnAppBarConfig(
      backgroundColor: backgroundColor ?? _backgroundColor,
      appBarHeight: appBarHeight ?? _appBarHeight,
      leadIconBuilder: leadIconBuilder ?? _leadIconBuilder,
      titleStyle: titleStyle ?? _titleStyle,
      actionsStyle: actionsStyle ?? _actionsStyle,
      titleMaxLength: titleMaxLength ?? _titleMaxLength,
      leftAndRightPadding: leftAndRightPadding ?? _leftAndRightPadding,
      itemSpacing: itemSpacing ?? _itemSpacing,
      titlePadding: titlePadding ?? _titlePadding,
      iconSize: iconSize ?? _iconSize,
      systemUiOverlayStyle: systemUiOverlayStyle ?? _systemUiOverlayStyle,
    );
  }

  BrnAppBarConfig merge(BrnAppBarConfig? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other._backgroundColor,
      appBarHeight: other._appBarHeight,
      leadIconBuilder: other._leadIconBuilder,
      titleStyle: titleStyle.merge(other._titleStyle),
      actionsStyle: actionsStyle.merge(other._actionsStyle),
      titleMaxLength: other._titleMaxLength,
      leftAndRightPadding: other._leftAndRightPadding,
      itemSpacing: other._itemSpacing,
      titlePadding: other._titlePadding,
      iconSize: other._iconSize,
      systemUiOverlayStyle: other._systemUiOverlayStyle,
    );
  }
}
