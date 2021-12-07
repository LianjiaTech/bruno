import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// 选择器配置
class BrnPickerConfig extends BrnBaseConfig {
  ///遵循外部主题配置，Bruno默认配置[BrnDefaultConfigUtils.defaultPickerConfig]
  BrnPickerConfig(
      {this.backgroundColor,
      this.cancelTextStyle,
      this.confirmTextStyle,
      this.titleTextStyle,
      this.pickerHeight,
      this.titleHeight,
      this.itemHeight,
      this.itemTextStyle,
      this.itemTextSelectedStyle,
      this.dividerColor,
      this.cornerRadius,
      String configId: BrnThemeConfigurator.GLOBAL_CONFIG_ID})
      : super(configId: configId);

  /// DatePicker's background color. value is [PICKER_BACKGROUND_COLOR]
  Color backgroundColor;

  /// cancel text style
  /// Default style is TextStyle(color:[BrnCommonConfig.colorTextBase],fontSize:[BrnCommonConfig.fontSizeSubHead]).
  BrnTextStyle cancelTextStyle;

  /// confirm text style
  /// Default style is TextStyle(color:[BrnCommonConfig.brandPrimary],fontSize:[BrnCommonConfig.fontSizeSubHead]).
  BrnTextStyle confirmTextStyle;

  /// title style
  /// Default style is TextStyle(color:[BrnCommonConfig.colorTextBase],fontSize:[BrnCommonConfig.fontSizeSubHead],fontWidget:FontWeight.w600).
  BrnTextStyle titleTextStyle;

  /// The value of DatePicker's height.
  /// default value is [PICKER_HEIGHT]
  double pickerHeight;

  /// The value of DatePicker's title height.
  /// default value is [PICKER_TITLE_HEIGHT]
  double titleHeight;

  /// The value of DatePicker's column height.
  /// default value is [PICKER_ITEM_HEIGHT]
  double itemHeight;

  /// The value of DatePicker's column [TextStyle].
  /// Default style is TextStyle(color:[BrnCommonConfig.colorTextBase],fontSize:[BrnCommonConfig.fontSizeHead]).
  BrnTextStyle itemTextStyle;

  /// The value of DatePicker's column selected [TextStyle].
  /// Default style is TextStyle(color:[BrnCommonConfig.brandPrimary],fontSize:[BrnCommonConfig.fontSizeHead],fontWidget:FontWeight.w600).
  BrnTextStyle itemTextSelectedStyle;

  Color dividerColor;
  double cornerRadius;

  @override
  void initThemeConfig(String configId, {BrnCommonConfig currentLevelCommonConfig}) {
    super.initThemeConfig(configId, currentLevelCommonConfig: currentLevelCommonConfig);

    /// 用户全局组件配置
    BrnPickerConfig pickerConfig =
        BrnThemeConfigurator.instance.getConfig(configId: configId).pickerConfig;

    this.backgroundColor ??= pickerConfig.backgroundColor;
    this.pickerHeight ??= pickerConfig.pickerHeight;
    this.titleHeight ??= pickerConfig.titleHeight;
    this.itemHeight ??= pickerConfig.itemHeight;
    this.dividerColor ??= pickerConfig.dividerColor;
    this.cornerRadius ??= pickerConfig.cornerRadius;

    this.titleTextStyle = pickerConfig.titleTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.titleTextStyle));

    this.cancelTextStyle = pickerConfig.cancelTextStyle
        .merge(
            BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeSubHead))
        .merge(this.cancelTextStyle);

    this.confirmTextStyle = pickerConfig.confirmTextStyle.merge(
        BrnTextStyle(color: commonConfig.brandPrimary, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.confirmTextStyle));

    this.itemTextStyle = pickerConfig.itemTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeHead)
            .merge(this.itemTextStyle));

    this.itemTextSelectedStyle = pickerConfig.itemTextSelectedStyle.merge(
        BrnTextStyle(color: commonConfig.brandPrimary, fontSize: commonConfig.fontSizeHead)
            .merge(this.itemTextSelectedStyle));
  }

  BrnPickerConfig copyWith(
      {Color backgroundColor,
      BrnTextStyle cancelTextStyle,
      BrnTextStyle confirmTextStyle,
      BrnTextStyle titleTextStyle,
      double pickerHeight,
      double titleHeight,
      double itemHeight,
      BrnTextStyle itemTextStyle,
      BrnTextStyle itemTextSelectedStyle,
      Color dividerColor,
      double cornerRadius}) {
    return BrnPickerConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cancelTextStyle: cancelTextStyle ?? this.cancelTextStyle,
      confirmTextStyle: confirmTextStyle ?? this.confirmTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      pickerHeight: pickerHeight ?? this.pickerHeight,
      titleHeight: titleHeight ?? this.titleHeight,
      itemHeight: itemHeight ?? this.itemHeight,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      itemTextSelectedStyle: itemTextSelectedStyle ?? this.itemTextSelectedStyle,
      dividerColor: dividerColor ?? this.dividerColor,
      cornerRadius: cornerRadius ?? this.cornerRadius,
    );
  }

  BrnPickerConfig merge(BrnPickerConfig other) {
    if (other == null) return this;
    return copyWith(
        backgroundColor: other.backgroundColor,
        cancelTextStyle:
            this.cancelTextStyle?.merge(other.cancelTextStyle) ?? other.cancelTextStyle,
        confirmTextStyle:
            this.confirmTextStyle?.merge(other.confirmTextStyle) ?? other.confirmTextStyle,
        titleTextStyle: this.titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
        pickerHeight: other.pickerHeight,
        titleHeight: other.titleHeight,
        itemHeight: other.itemHeight,
        itemTextStyle: this.itemTextStyle?.merge(other.itemTextStyle) ?? other.itemTextStyle,
        itemTextSelectedStyle: this.itemTextSelectedStyle?.merge(other.itemTextSelectedStyle) ??
            other.itemTextSelectedStyle,
        dividerColor: other.dividerColor,
        cornerRadius: other.cornerRadius);
  }
}
