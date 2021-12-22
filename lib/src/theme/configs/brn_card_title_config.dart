import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// 卡片标题 配置类
class BrnCardTitleConfig extends BrnBaseConfig {
  BrnCardTitleConfig({
    this.titleWithHeightTextStyle,
    this.detailTextStyle,
    this.accessoryTextStyle,
    this.cardTitlePadding,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.alignment,
    this.cardBackgroundColor,
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// 标题外边距间距
  ///
  /// EdgeInsets.only(
  ///   top: [BrnCommonConfig.vSpacingXl],
  ///   bottom: [BrnCommonConfig.vSpacingMd],
  /// )
  EdgeInsets? cardTitlePadding;

  /// 标题文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeHead],
  ///   fontWeight: FontWeight.w600,
  ///   height: 25 / 18,
  /// )
  BrnTextStyle? titleWithHeightTextStyle;

  /// 标题文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? titleTextStyle;

  /// 标题右边的副标题文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? subtitleTextStyle;

  /// 详情文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? detailTextStyle;

  /// 辅助文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? accessoryTextStyle;

  /// 对齐方式
  /// 默认为 [PlaceholderAlignment.middle]
  PlaceholderAlignment? alignment;

  /// 卡片背景
  /// 默认为 [BrnCommonConfig.fillBase]
  Color? cardBackgroundColor;

  /// cardTitleConfig  获取逻辑详见 [BrnThemeConfigurator.getConfig] 方法
  @override
  void initThemeConfig(
    String configId, {
    BrnCommonConfig? currentLevelCommonConfig,
  }) {
    super.initThemeConfig(
      configId,
      currentLevelCommonConfig: currentLevelCommonConfig,
    );

    BrnCardTitleConfig? cardTitleConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .cardTitleConfig;

    cardBackgroundColor ??= commonConfig.fillBase;
    cardTitlePadding ??= EdgeInsets.only(
      left: cardTitleConfig?.cardTitlePadding?.left ?? 0,
      top: commonConfig.vSpacingXl ?? 0,
      right: cardTitleConfig?.cardTitlePadding?.right ?? 0,
      bottom: commonConfig.vSpacingMd ?? 0,
    );
    titleWithHeightTextStyle = cardTitleConfig?.titleWithHeightTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeHead,
      ).merge(titleWithHeightTextStyle),
    );
    titleTextStyle = cardTitleConfig?.titleTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeHead,
      ).merge(titleTextStyle),
    );
    subtitleTextStyle = cardTitleConfig?.subtitleTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(subtitleTextStyle),
    );
    accessoryTextStyle = cardTitleConfig?.accessoryTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextSecondary,
        fontSize: commonConfig.fontSizeHead,
      ).merge(accessoryTextStyle),
    );
    detailTextStyle = cardTitleConfig?.detailTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(detailTextStyle),
    );
    alignment ??= cardTitleConfig?.alignment;
  }

  BrnCardTitleConfig copyWith({
    EdgeInsets? cardTitlePadding,
    BrnTextStyle? titleWithHeightTextStyle,
    BrnTextStyle? titleTextStyle,
    BrnTextStyle? subtitleTextStyle,
    BrnTextStyle? detailTextStyle,
    BrnTextStyle? accessoryTextStyle,
    PlaceholderAlignment? alignment,
    Color? cardBackgroundColor,
  }) {
    return BrnCardTitleConfig(
      cardTitlePadding: cardTitlePadding ?? this.cardTitlePadding,
      titleWithHeightTextStyle:
          titleWithHeightTextStyle ?? this.titleWithHeightTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      detailTextStyle: detailTextStyle ?? this.detailTextStyle,
      accessoryTextStyle: accessoryTextStyle ?? this.accessoryTextStyle,
      alignment: alignment ?? this.alignment,
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
    );
  }

  BrnCardTitleConfig merge(BrnCardTitleConfig? other) {
    if (other == null) return this;
    return copyWith(
      cardTitlePadding: other.cardTitlePadding,
      titleWithHeightTextStyle:
          titleWithHeightTextStyle?.merge(other.titleWithHeightTextStyle) ??
              other.titleWithHeightTextStyle,
      titleTextStyle:
          titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle?.merge(other.subtitleTextStyle) ??
          other.subtitleTextStyle,
      detailTextStyle: detailTextStyle?.merge(other.detailTextStyle) ??
          other.detailTextStyle,
      accessoryTextStyle: accessoryTextStyle?.merge(other.accessoryTextStyle) ??
          other.accessoryTextStyle,
      alignment: other.alignment,
      cardBackgroundColor: other.cardBackgroundColor,
    );
  }
}
