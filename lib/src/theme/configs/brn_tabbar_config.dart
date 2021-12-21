import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// TabBar配置类
class BrnTabBarConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.tabBarConfig]
  BrnTabBarConfig({
    this.tabHeight,
    this.indicatorHeight,
    this.indicatorWidth,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.backgroundColor,
    this.tagNormalTextStyle,
    this.tagNormalBgColor,
    this.tagSelectedTextStyle,
    this.tagSelectedBgColor,
    this.tagRadius,
    this.tagSpacing,
    this.preLineTagCount,
    this.tagHeight,
    String configId: GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// TabBar 的整体高度
  /// 默认为 50
  double? tabHeight;

  /// 指示器的高度
  /// 默认为 2
  double? indicatorHeight;

  /// 指示器的宽度
  /// 默认为 24
  double? indicatorWidth;

  /// 选中 Tab 文本的样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? labelStyle;

  /// 未选中 Tab 文本的样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? unselectedLabelStyle;

  /// 背景色
  /// 默认为 [BrnCommonConfig.fillBase]
  Color? backgroundColor;

  /// 标签字体样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  /// )
  BrnTextStyle? tagNormalTextStyle;

  /// 标签背景色
  /// 默认为 [BrnCommonConfig.brandPrimary].withAlpha(0x14),
  Color? tagNormalBgColor;

  /// 标签字体样式
  ///
  /// BrnTextStyle(
  ///   color:[BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  /// )
  BrnTextStyle? tagSelectedTextStyle;

  /// 标签选中背景色
  /// 默认为 [BrnCommonConfig.fillBody]
  Color? tagSelectedBgColor;

  /// tag圆角
  /// 默认为 [BrnCommonConfig.radiusSm]
  double? tagRadius;

  /// tag间距
  /// 默认为 12
  double? tagSpacing;

  /// 每行的tag数
  /// 默认为 4
  int? preLineTagCount;

  /// tag高度
  /// 默认为 32
  double? tagHeight;

  @override
  void initThemeConfig(
    String configId, {
    BrnCommonConfig? currentLevelCommonConfig,
  }) {
    super.initThemeConfig(
      configId,
      currentLevelCommonConfig: currentLevelCommonConfig,
    );

    BrnTabBarConfig? tabBarConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .tabBarConfig;

    tabHeight ??= tabBarConfig?.tabHeight;
    indicatorHeight ??= tabBarConfig?.indicatorHeight;
    indicatorWidth ??= tabBarConfig?.indicatorWidth;
    labelStyle = tabBarConfig?.labelStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(labelStyle),
    );
    unselectedLabelStyle = tabBarConfig?.unselectedLabelStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(unselectedLabelStyle),
    );
    backgroundColor ??= tabBarConfig?.backgroundColor;
    tagNormalTextStyle = tabBarConfig?.tagNormalTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(tagNormalTextStyle),
    );
    tagSelectedTextStyle = tabBarConfig?.tagSelectedTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(tagSelectedTextStyle),
    );
    tagNormalBgColor ??= tabBarConfig?.tagNormalBgColor;
    tagSelectedBgColor ??= tabBarConfig?.tagSelectedBgColor;
    tagRadius ??= commonConfig.radiusSm;
    tagSpacing ??= tabBarConfig?.tagSpacing;
    preLineTagCount ??= tabBarConfig?.preLineTagCount;
    tagHeight ??= tabBarConfig?.tagHeight;
  }

  BrnTabBarConfig copyWith({
    double? tabHeight,
    double? indicatorHeight,
    double? indicatorWidth,
    BrnTextStyle? labelStyle,
    BrnTextStyle? unselectedLabelStyle,
    Color? backgroundColor,
    BrnTextStyle? tagNormalTextStyle,
    Color? tagNormalColor,
    BrnTextStyle? tagSelectedTextStyle,
    Color? tagSelectedColor,
    double? tagRadius,
    double? tagSpacing,
    int? preLineTagSize,
    double? tagHeight,
  }) {
    return BrnTabBarConfig(
      tabHeight: tabHeight ?? this.tabHeight,
      indicatorHeight: indicatorHeight ?? this.indicatorHeight,
      indicatorWidth: indicatorWidth ?? this.indicatorWidth,
      labelStyle: labelStyle ?? this.labelStyle,
      unselectedLabelStyle: unselectedLabelStyle ?? this.unselectedLabelStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      tagNormalTextStyle: tagNormalTextStyle ?? this.tagNormalTextStyle,
      tagNormalBgColor: tagNormalColor ?? this.tagNormalBgColor,
      tagSelectedTextStyle: tagSelectedTextStyle ?? this.tagSelectedTextStyle,
      tagSelectedBgColor: tagSelectedColor ?? this.tagSelectedBgColor,
      tagRadius: tagRadius ?? this.tagRadius,
      tagSpacing: tagSpacing ?? this.tagSpacing,
      preLineTagCount: preLineTagSize ?? this.preLineTagCount,
      tagHeight: tagHeight ?? this.tagHeight,
    );
  }

  BrnTabBarConfig merge(BrnTabBarConfig? other) {
    if (other == null) return this;
    return copyWith(
      tabHeight: other.tabHeight,
      indicatorHeight: other.indicatorHeight,
      indicatorWidth: other.indicatorWidth,
      labelStyle: labelStyle?.merge(other.labelStyle) ?? other.labelStyle,
      unselectedLabelStyle:
          unselectedLabelStyle?.merge(other.unselectedLabelStyle) ??
              other.unselectedLabelStyle,
      backgroundColor: other.backgroundColor,
      tagNormalTextStyle: tagNormalTextStyle?.merge(other.tagNormalTextStyle) ??
          other.tagNormalTextStyle,
      tagNormalColor: other.tagNormalBgColor,
      tagSelectedTextStyle:
          tagSelectedTextStyle?.merge(other.tagSelectedTextStyle) ??
              other.tagSelectedTextStyle,
      tagSelectedColor: other.tagSelectedBgColor,
      tagRadius: other.tagRadius,
      tagSpacing: other.tagSpacing,
      preLineTagSize: other.preLineTagCount,
      tagHeight: other.tagHeight,
    );
  }
}
