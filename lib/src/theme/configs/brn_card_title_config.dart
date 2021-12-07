import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// 卡片标题 配置类
class BrnCardTitleConfig extends BrnBaseConfig {
  /// 标题外边距间距
  /// EdgeInsets.only(top: [BrnCommonConfig.vSpacingXl],bottom: [BrnCommonConfig.vSpacingMd])
  EdgeInsets cardTitlePadding;

  /// 标题文本样式
  /// BrnTextStyle(fontSize: [BrnCommonConfig.fontSizeHead],height: 25 / 18,fontWeight: FontWeight.w600,color: [BrnCommonConfig.colorTextBase]）
  BrnTextStyle titleWithHeightTextStyle;

  /// 标题文本样式
  /// BrnTextStyle(fontSize: [BrnCommonConfig.fontSizeHead],fontWeight: FontWeight.w600,color: [BrnCommonConfig.colorTextBase]）
  BrnTextStyle titleTextStyle;

  /// 标题右边的副标题文本样式
  /// TextStyle(fontSize: [BrnCommonConfig.fontSizeBase],color: [BrnCommonConfig.colorTextSecondary])
  BrnTextStyle subtitleTextStyle;

  /// 详情文本样式
  /// TextStyle(fontSize: [BrnCommonConfig.fontSizeBase], color: [BrnCommonConfig.colorTextBase])
  BrnTextStyle detailTextStyle;

  /// 辅助文本样式
  /// TextStyle(fontSize: [BrnCommonConfig.fontSizeBase],color: [BrnCommonConfig.colorTextSecondary],)
  BrnTextStyle accessoryTextStyle;

  /// 对齐方式
  /// PlaceholderAlignment.middle
  PlaceholderAlignment alignment;

  /// 卡片背景
  /// [BrnCommonConfig.fillBase]
  Color cardBackgroundColor;

  BrnCardTitleConfig(
      {this.titleWithHeightTextStyle,
      this.detailTextStyle,
      this.accessoryTextStyle,
      this.cardTitlePadding,
      this.titleTextStyle,
      this.subtitleTextStyle,
      this.alignment,
      this.cardBackgroundColor,
      String configId = BrnThemeConfigurator.GLOBAL_CONFIG_ID})
      : super(configId: configId);

  /// cardTitleConfig  获取逻辑详见 [BrnThemeConfigurator.getConfig] 方法
  @override
  void initThemeConfig(String configId, {BrnCommonConfig currentLevelCommonConfig}) {
    super.initThemeConfig(configId, currentLevelCommonConfig: currentLevelCommonConfig);

    BrnCardTitleConfig cardTitleConfig =
        BrnThemeConfigurator.instance.getConfig(configId: configId).cardTitleConfig;

    this.cardBackgroundColor ??= commonConfig.fillBase;

    if (this.cardTitlePadding == null) {
      this.cardTitlePadding = EdgeInsets.only(
          left: cardTitleConfig.cardTitlePadding.left,
          top: commonConfig.vSpacingXl,
          right: cardTitleConfig.cardTitlePadding.right,
          bottom: commonConfig.vSpacingMd);
    }

    this.titleWithHeightTextStyle = cardTitleConfig.titleWithHeightTextStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeHead)
            .merge(this.titleWithHeightTextStyle));

    this.titleTextStyle = cardTitleConfig.titleTextStyle.merge(BrnTextStyle(
      color: commonConfig.colorTextBase,
      fontSize: commonConfig.fontSizeHead,
    ).merge(this.titleTextStyle));

    this.subtitleTextStyle = cardTitleConfig.subtitleTextStyle.merge(BrnTextStyle(
      color: commonConfig.colorTextBase,
      fontSize: commonConfig.fontSizeBase,
    ).merge(this.subtitleTextStyle));

    this.accessoryTextStyle = cardTitleConfig.accessoryTextStyle.merge(BrnTextStyle(
      color: commonConfig.colorTextSecondary,
      fontSize: commonConfig.fontSizeHead,
    ).merge(this.accessoryTextStyle));

    this.detailTextStyle = cardTitleConfig.detailTextStyle.merge(BrnTextStyle(
      color: commonConfig.colorTextBase,
      fontSize: commonConfig.fontSizeBase,
    ).merge(this.detailTextStyle));

    this.alignment ??= cardTitleConfig.alignment;
  }

  BrnCardTitleConfig copyWith(
      {EdgeInsets cardTitlePadding,
      BrnTextStyle titleWithHeightTextStyle,
      BrnTextStyle titleTextStyle,
      BrnTextStyle subtitleTextStyle,
      BrnTextStyle detailTextStyle,
      BrnTextStyle accessoryTextStyle,
      PlaceholderAlignment alignment,
      Color cardBackgroundColor}) {
    return BrnCardTitleConfig(
        cardTitlePadding: cardTitlePadding ?? this.cardTitlePadding,
        titleWithHeightTextStyle: titleWithHeightTextStyle ?? this.titleWithHeightTextStyle,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
        detailTextStyle: detailTextStyle ?? this.detailTextStyle,
        accessoryTextStyle: accessoryTextStyle ?? this.accessoryTextStyle,
        alignment: alignment ?? this.alignment,
        cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor);
  }

  BrnCardTitleConfig merge(BrnCardTitleConfig other) {
    if (other == null) return this;
    return copyWith(
      cardTitlePadding: other.cardTitlePadding,
      titleWithHeightTextStyle:
          this.titleWithHeightTextStyle?.merge(other.titleWithHeightTextStyle) ??
              other.titleWithHeightTextStyle,
      titleTextStyle: this.titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
      subtitleTextStyle:
          this.subtitleTextStyle?.merge(other.subtitleTextStyle) ?? other.subtitleTextStyle,
      detailTextStyle: this.detailTextStyle?.merge(other.detailTextStyle) ?? other.detailTextStyle,
      accessoryTextStyle:
          this.accessoryTextStyle?.merge(other.accessoryTextStyle) ?? other.accessoryTextStyle,
      alignment: other.alignment,
      cardBackgroundColor: other.cardBackgroundColor,
    );
  }
}
