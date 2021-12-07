import 'dart:ui';

import 'package:bruno/src/theme/brn_theme.dart';
import 'package:flutter/material.dart';

/// TabBar配置类
class BrnTabBarConfig extends BrnBaseConfig {
  ///遵循外部主题配置，Bruno默认配置[BrnDefaultConfigUtils.defaultNumberInfoConfig]
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
    String configId: BrnThemeConfigurator.GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// Tabbar的整体高度
  /// default value is 50
  double tabHeight;

  /// 指示器的高度
  /// default value is 2
  double indicatorHeight;

  /// 指示器的宽度
  /// default value is 24
  double indicatorWidth;

  /// 选中Tab文本的样式
  /// default value is TextStyle(color:[BrnCommonConfig.brandPrimary],fontSize:[BrnCommonConfig.fontSizeSubHead])
  BrnTextStyle labelStyle;

  /// 未选中Tab文本的样式
  /// default value is TextStyle(color:[BrnCommonConfig.colorTextBase],fontSize:[BrnCommonConfig.fontSizeSubHead])
  BrnTextStyle unselectedLabelStyle;

  /// 背景色
  /// default value is [BrnCommonConfig.fillBase]
  Color backgroundColor;

  /// 标签字体样式
  /// default value is BrnTextStyle(color: [BrnCommonConfig.colorTextBase], fontSize: [BrnCommonConfig.fontSizeCaption])
  BrnTextStyle tagNormalTextStyle;

  /// 标签背景色
  /// default value is [BrnCommonConfig.brandPrimary].withAlpha(0x14),
  Color tagNormalBgColor;

  /// 标签字体样式
  /// default value is BrnTextStyle(color:[BrnCommonConfig.brandPrimary], fontSize: [BrnCommonConfig.fontSizeCaption])
  BrnTextStyle tagSelectedTextStyle;

  /// 标签选中背景色
  /// default value is [BrnCommonConfig.fillBody]
  Color tagSelectedBgColor;

  /// tag圆角
  /// default value is [BrnCommonConfig.radiusSm]
  double tagRadius;

  /// tag间距
  /// default value is 12
  double tagSpacing;

  /// 每行的tag数
  /// default value is 4
  int preLineTagCount;

  /// tag高度
  /// default value is 32
  double tagHeight;

  @override
  void initThemeConfig(String configId, {BrnCommonConfig currentLevelCommonConfig}) {
    super.initThemeConfig(configId, currentLevelCommonConfig: currentLevelCommonConfig);

    BrnTabBarConfig tabBarConfig =
        BrnThemeConfigurator.instance.getConfig(configId: configId).tabBarConfig;

    this.tabHeight ??= tabBarConfig.tabHeight;
    this.indicatorHeight ??= tabBarConfig.indicatorHeight;
    this.indicatorWidth ??= tabBarConfig.indicatorWidth;

    this.labelStyle = tabBarConfig.labelStyle.merge(
        BrnTextStyle(color: commonConfig.brandPrimary, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.labelStyle));

    this.unselectedLabelStyle = tabBarConfig.unselectedLabelStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.unselectedLabelStyle));

    this.backgroundColor ??= tabBarConfig.backgroundColor;

    this.tagNormalTextStyle = tabBarConfig.tagNormalTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeCaption)
            .merge(this.tagNormalTextStyle));

    this.tagSelectedTextStyle = tabBarConfig.tagSelectedTextStyle.merge(
        BrnTextStyle(color: commonConfig.brandPrimary, fontSize: commonConfig.fontSizeCaption)
            .merge(this.tagSelectedTextStyle));

    this.tagNormalBgColor ??= tabBarConfig.tagNormalBgColor;
    this.tagSelectedBgColor ??= tabBarConfig.tagSelectedBgColor;
    this.tagRadius ??= commonConfig.radiusSm;
    this.tagSpacing ??= tabBarConfig.tagSpacing;
    this.preLineTagCount ??= tabBarConfig.preLineTagCount;
    this.tagHeight ??= tabBarConfig.tagHeight;
  }

  BrnTabBarConfig copyWith({
    double tabHeight,
    double indicatorHeight,
    double indicatorWidth,
    BrnTextStyle labelStyle,
    BrnTextStyle unselectedLabelStyle,
    Color backgroundColor,
    BrnTextStyle tagNormalTextStyle,
    Color tagNormalColor,
    BrnTextStyle tagSelectedTextStyle,
    Color tagSelectedColor,
    double tagRadius,
    double tagSpacing,
    int preLineTagSize,
    double tagHeight,
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

  BrnTabBarConfig merge(BrnTabBarConfig other) {
    if (other == null) return this;
    return copyWith(
      tabHeight: other.tabHeight,
      indicatorHeight: other.indicatorHeight,
      indicatorWidth: other.indicatorWidth,
      labelStyle: this.labelStyle?.merge(other.labelStyle) ?? other.labelStyle,
      unselectedLabelStyle: this.unselectedLabelStyle?.merge(other.unselectedLabelStyle) ??
          other.unselectedLabelStyle,
      backgroundColor: other.backgroundColor,
      tagNormalTextStyle:
          this.tagNormalTextStyle?.merge(other.tagNormalTextStyle) ?? other.tagNormalTextStyle,
      tagNormalColor: other.tagNormalBgColor,
      tagSelectedTextStyle: this.tagSelectedTextStyle?.merge(other.tagSelectedTextStyle) ??
          other.tagSelectedTextStyle,
      tagSelectedColor: other.tagSelectedBgColor,
      tagRadius: other.tagRadius,
      tagSpacing: other.tagSpacing,
      preLineTagSize: other.preLineTagCount,
      tagHeight: other.tagHeight,
    );
  }
}
