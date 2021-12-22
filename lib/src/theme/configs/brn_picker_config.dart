import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// 选择器配置
class BrnPickerConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultPickerConfig]
  BrnPickerConfig({
    this.backgroundColor,
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
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// 日期选择器的背景色
  /// 默认为 [PICKER_BACKGROUND_COLOR]
  Color? backgroundColor;

  /// 取消文字的样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? cancelTextStyle;

  /// 确认文字的样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? confirmTextStyle;

  /// 标题文字的样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWidget:FontWeight.w600,
  /// )
  BrnTextStyle? titleTextStyle;

  /// 日期选择器的高度
  /// 默认为 [PICKER_HEIGHT]
  double? pickerHeight;

  /// 日期选择器标题的高度
  /// 默认为 [PICKER_TITLE_HEIGHT]
  double? titleHeight;

  /// 日期选择器列表的高度
  /// 默认为 [PICKER_ITEM_HEIGHT]
  double? itemHeight;

  /// 日期选择器列表的文字样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeHead],
  /// )
  BrnTextStyle? itemTextStyle;

  /// 日期选择器列表选中的文字样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeHead],
  ///   fontWidget: FontWeight.w600,
  /// )
  BrnTextStyle? itemTextSelectedStyle;

  Color? dividerColor;
  double? cornerRadius;

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
    BrnPickerConfig? pickerConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .pickerConfig;

    backgroundColor ??= pickerConfig?.backgroundColor;
    pickerHeight ??= pickerConfig?.pickerHeight;
    titleHeight ??= pickerConfig?.titleHeight;
    itemHeight ??= pickerConfig?.itemHeight;
    dividerColor ??= pickerConfig?.dividerColor;
    cornerRadius ??= pickerConfig?.cornerRadius;
    titleTextStyle = pickerConfig?.titleTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(titleTextStyle),
    );
    cancelTextStyle = pickerConfig?.cancelTextStyle
        ?.merge(
          BrnTextStyle(
            color: commonConfig.colorTextBase,
            fontSize: commonConfig.fontSizeSubHead,
          ),
        )
        .merge(cancelTextStyle);
    confirmTextStyle = pickerConfig?.confirmTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(confirmTextStyle),
    );
    itemTextStyle = pickerConfig?.itemTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeHead,
      ).merge(itemTextStyle),
    );
    itemTextSelectedStyle = pickerConfig?.itemTextSelectedStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeHead,
      ).merge(itemTextSelectedStyle),
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
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cancelTextStyle: cancelTextStyle ?? this.cancelTextStyle,
      confirmTextStyle: confirmTextStyle ?? this.confirmTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      pickerHeight: pickerHeight ?? this.pickerHeight,
      titleHeight: titleHeight ?? this.titleHeight,
      itemHeight: itemHeight ?? this.itemHeight,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      itemTextSelectedStyle:
          itemTextSelectedStyle ?? this.itemTextSelectedStyle,
      dividerColor: dividerColor ?? this.dividerColor,
      cornerRadius: cornerRadius ?? this.cornerRadius,
    );
  }

  BrnPickerConfig merge(BrnPickerConfig? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      cancelTextStyle: cancelTextStyle?.merge(other.cancelTextStyle) ??
          other.cancelTextStyle,
      confirmTextStyle: confirmTextStyle?.merge(other.confirmTextStyle) ??
          other.confirmTextStyle,
      titleTextStyle:
          titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
      pickerHeight: other.pickerHeight,
      titleHeight: other.titleHeight,
      itemHeight: other.itemHeight,
      itemTextStyle:
          itemTextStyle?.merge(other.itemTextStyle) ?? other.itemTextStyle,
      itemTextSelectedStyle:
          itemTextSelectedStyle?.merge(other.itemTextSelectedStyle) ??
              other.itemTextSelectedStyle,
      dividerColor: other.dividerColor,
      cornerRadius: other.cornerRadius,
    );
  }
}
