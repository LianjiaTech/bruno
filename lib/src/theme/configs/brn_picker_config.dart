import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_default_config_utils.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// 选择器配置
class BrnPickerConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultPickerConfig]
  BrnPickerConfig({
    Color? backgroundColor,
    BrnTextStyle? cancelTextStyle,
    BrnTextStyle? confirmTextStyle,
    BrnTextStyle? titleTextStyle,
    double? pickerHeight,
    double? titleHeight,
    double? itemHeight,
    BrnTextStyle? itemTextStyle,
    BrnTextStyle? itemTextSelectedStyle,
    Color? dividerColor,
    double? cornerRadius,
    String configId = GLOBAL_CONFIG_ID,
  })  : _backgroundColor = backgroundColor,
        _cancelTextStyle = cancelTextStyle,
        _confirmTextStyle = confirmTextStyle,
        _titleTextStyle = titleTextStyle,
        _pickerHeight = pickerHeight,
        _titleHeight = titleHeight,
        _itemHeight = itemHeight,
        _itemTextStyle = itemTextStyle,
        _itemTextSelectedStyle = itemTextSelectedStyle,
        _dividerColor = dividerColor,
        _cornerRadius = cornerRadius,
        super(configId: configId);

  /// 日期选择器的背景色
  /// 默认为 [PICKER_BACKGROUND_COLOR]
  Color? _backgroundColor;

  /// 取消文字的样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? _cancelTextStyle;

  /// 确认文字的样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? _confirmTextStyle;

  /// 标题文字的样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWidget:FontWeight.w600,
  /// )
  BrnTextStyle? _titleTextStyle;

  /// 日期选择器的高度
  /// 默认为 [PICKER_HEIGHT]
  double? _pickerHeight;

  /// 日期选择器标题的高度
  /// 默认为 [PICKER_TITLE_HEIGHT]
  double? _titleHeight;

  /// 日期选择器列表的高度
  /// 默认为 [PICKER_ITEM_HEIGHT]
  double? _itemHeight;

  /// 日期选择器列表的文字样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeHead],
  /// )
  BrnTextStyle? _itemTextStyle;

  /// 日期选择器列表选中的文字样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeHead],
  ///   fontWidget: FontWeight.w600,
  /// )
  BrnTextStyle? _itemTextSelectedStyle;

  Color? _dividerColor;
  double? _cornerRadius;

  Color get backgroundColor =>
      _backgroundColor ??
      BrnDefaultConfigUtils.defaultPickerConfig.backgroundColor;

  BrnTextStyle get cancelTextStyle =>
      _cancelTextStyle ??
      BrnDefaultConfigUtils.defaultPickerConfig.cancelTextStyle;

  BrnTextStyle get confirmTextStyle =>
      _confirmTextStyle ??
      BrnDefaultConfigUtils.defaultPickerConfig.confirmTextStyle;

  BrnTextStyle get titleTextStyle =>
      _titleTextStyle ??
      BrnDefaultConfigUtils.defaultPickerConfig.titleTextStyle;

  double get pickerHeight =>
      _pickerHeight ?? BrnDefaultConfigUtils.defaultPickerConfig.pickerHeight;

  double get titleHeight =>
      _titleHeight ?? BrnDefaultConfigUtils.defaultPickerConfig.titleHeight;

  double get itemHeight =>
      _itemHeight ?? BrnDefaultConfigUtils.defaultPickerConfig.itemHeight;

  BrnTextStyle get itemTextStyle =>
      _itemTextStyle ?? BrnDefaultConfigUtils.defaultPickerConfig.itemTextStyle;

  BrnTextStyle get itemTextSelectedStyle =>
      _itemTextSelectedStyle ??
      BrnDefaultConfigUtils.defaultPickerConfig.itemTextSelectedStyle;

  Color get dividerColor =>
      _dividerColor ?? BrnDefaultConfigUtils.defaultPickerConfig.dividerColor;

  double get cornerRadius =>
      _cornerRadius ?? BrnDefaultConfigUtils.defaultPickerConfig.cornerRadius;

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
    BrnPickerConfig pickerConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .pickerConfig;

    _backgroundColor ??= pickerConfig.backgroundColor;
    _pickerHeight ??= pickerConfig.pickerHeight;
    _titleHeight ??= pickerConfig.titleHeight;
    _itemHeight ??= pickerConfig.itemHeight;
    _dividerColor ??= pickerConfig.dividerColor;
    _cornerRadius ??= pickerConfig.cornerRadius;
    _titleTextStyle = pickerConfig.titleTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_titleTextStyle),
    );
    _cancelTextStyle = pickerConfig.cancelTextStyle
        .merge(
          BrnTextStyle(
            color: commonConfig.colorTextBase,
            fontSize: commonConfig.fontSizeSubHead,
          ),
        )
        .merge(_cancelTextStyle);
    _confirmTextStyle = pickerConfig.confirmTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_confirmTextStyle),
    );
    _itemTextStyle = pickerConfig.itemTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeHead,
      ).merge(_itemTextStyle),
    );
    _itemTextSelectedStyle = pickerConfig.itemTextSelectedStyle.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeHead,
      ).merge(_itemTextSelectedStyle),
    );
  }

  BrnPickerConfig copyWith({
    Color? backgroundColor,
    BrnTextStyle? cancelTextStyle,
    BrnTextStyle? confirmTextStyle,
    BrnTextStyle? titleTextStyle,
    double? pickerHeight,
    double? titleHeight,
    double? itemHeight,
    BrnTextStyle? itemTextStyle,
    BrnTextStyle? itemTextSelectedStyle,
    Color? dividerColor,
    double? cornerRadius,
  }) {
    return BrnPickerConfig(
      backgroundColor: backgroundColor ?? _backgroundColor,
      cancelTextStyle: cancelTextStyle ?? _cancelTextStyle,
      confirmTextStyle: confirmTextStyle ?? _confirmTextStyle,
      titleTextStyle: titleTextStyle ?? _titleTextStyle,
      pickerHeight: pickerHeight ?? _pickerHeight,
      titleHeight: titleHeight ?? _titleHeight,
      itemHeight: itemHeight ?? _itemHeight,
      itemTextStyle: itemTextStyle ?? _itemTextStyle,
      itemTextSelectedStyle: itemTextSelectedStyle ?? _itemTextSelectedStyle,
      dividerColor: dividerColor ?? _dividerColor,
      cornerRadius: cornerRadius ?? _cornerRadius,
    );
  }

  BrnPickerConfig merge(BrnPickerConfig? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other._backgroundColor,
      cancelTextStyle: cancelTextStyle.merge(other._cancelTextStyle),
      confirmTextStyle: confirmTextStyle.merge(other._confirmTextStyle),
      titleTextStyle: titleTextStyle.merge(other._titleTextStyle),
      pickerHeight: other._pickerHeight,
      titleHeight: other._titleHeight,
      itemHeight: other._itemHeight,
      itemTextStyle: itemTextStyle.merge(other._itemTextStyle),
      itemTextSelectedStyle:
          itemTextSelectedStyle.merge(other._itemTextSelectedStyle),
      dividerColor: other._dividerColor,
      cornerRadius: other._cornerRadius,
    );
  }
}
