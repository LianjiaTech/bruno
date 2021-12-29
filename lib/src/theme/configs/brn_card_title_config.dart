import 'package:bruno/bruno.dart';
import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// 卡片标题 配置类
class BrnCardTitleConfig extends BrnBaseConfig {
  BrnCardTitleConfig({
    BrnTextStyle? titleWithHeightTextStyle,
    BrnTextStyle? detailTextStyle,
    BrnTextStyle? accessoryTextStyle,
    EdgeInsets? cardTitlePadding,
    BrnTextStyle? titleTextStyle,
    BrnTextStyle? subtitleTextStyle,
    PlaceholderAlignment? alignment,
    Color? cardBackgroundColor,
    String configId = GLOBAL_CONFIG_ID,
  })  : _titleWithHeightTextStyle = titleWithHeightTextStyle,
        _detailTextStyle = detailTextStyle,
        _accessoryTextStyle = accessoryTextStyle,
        _cardTitlePadding = cardTitlePadding,
        _titleTextStyle = titleTextStyle,
        _subtitleTextStyle = subtitleTextStyle,
        _alignment = alignment,
        _cardBackgroundColor = cardBackgroundColor,
        super(configId: configId);

  /// 标题外边距间距
  ///
  /// EdgeInsets.only(
  ///   top: [BrnCommonConfig.vSpacingXl],
  ///   bottom: [BrnCommonConfig.vSpacingMd],
  /// )
  EdgeInsets? _cardTitlePadding;

  EdgeInsets get cardTitlePadding =>
      _cardTitlePadding ??
      BrnDefaultConfigUtils.defaultCardTitleConfig.cardTitlePadding;

  /// 标题文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeHead],
  ///   fontWeight: FontWeight.w600,
  ///   height: 25 / 18,
  /// )
  BrnTextStyle? _titleWithHeightTextStyle;

  BrnTextStyle get titleWithHeightTextStyle =>
      _titleWithHeightTextStyle ??
      BrnDefaultConfigUtils.defaultCardTitleConfig.titleWithHeightTextStyle;

  /// 标题文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _titleTextStyle;

  BrnTextStyle get titleTextStyle =>
      _titleTextStyle ??
      BrnDefaultConfigUtils.defaultCardTitleConfig.titleTextStyle;

  /// 标题右边的副标题文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? _subtitleTextStyle;

  BrnTextStyle get subtitleTextStyle =>
      _subtitleTextStyle ??
      BrnDefaultConfigUtils.defaultCardTitleConfig.subtitleTextStyle;

  /// 详情文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? _detailTextStyle;

  BrnTextStyle get detailTextStyle =>
      _detailTextStyle ??
      BrnDefaultConfigUtils.defaultCardTitleConfig.detailTextStyle;

  /// 辅助文本样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? _accessoryTextStyle;

  BrnTextStyle get accessoryTextStyle =>
      _accessoryTextStyle ??
      BrnDefaultConfigUtils.defaultCardTitleConfig.accessoryTextStyle;

  /// 对齐方式
  /// 默认为 [PlaceholderAlignment.middle]
  PlaceholderAlignment? _alignment;

  PlaceholderAlignment get alignment =>
      _alignment ?? BrnDefaultConfigUtils.defaultCardTitleConfig.alignment;

  /// 卡片背景
  /// 默认为 [BrnCommonConfig.fillBase]
  Color? _cardBackgroundColor;

  Color get cardBackgroundColor =>
      _cardBackgroundColor ??
      BrnDefaultConfigUtils.defaultCardTitleConfig.cardBackgroundColor;

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

    BrnCardTitleConfig cardTitleConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .cardTitleConfig;

    _cardBackgroundColor ??= commonConfig.fillBase;
    _cardTitlePadding ??= EdgeInsets.only(
      left: cardTitleConfig.cardTitlePadding.left,
      top: commonConfig.vSpacingXl,
      right: cardTitleConfig.cardTitlePadding.right,
      bottom: commonConfig.vSpacingMd,
    );
    _titleWithHeightTextStyle = cardTitleConfig.titleWithHeightTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeHead,
      ).merge(_titleWithHeightTextStyle),
    );
    _titleTextStyle = cardTitleConfig.titleTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeHead,
      ).merge(_titleTextStyle),
    );
    _subtitleTextStyle = cardTitleConfig.subtitleTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_subtitleTextStyle),
    );
    _accessoryTextStyle = cardTitleConfig.accessoryTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextSecondary,
        fontSize: commonConfig.fontSizeHead,
      ).merge(_accessoryTextStyle),
    );
    _detailTextStyle = cardTitleConfig.detailTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_detailTextStyle),
    );
    _alignment ??= cardTitleConfig._alignment;
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
      cardTitlePadding: cardTitlePadding ?? _cardTitlePadding,
      titleWithHeightTextStyle:
          titleWithHeightTextStyle ?? _titleWithHeightTextStyle,
      titleTextStyle: titleTextStyle ?? _titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? _subtitleTextStyle,
      detailTextStyle: detailTextStyle ?? _detailTextStyle,
      accessoryTextStyle: accessoryTextStyle ?? _accessoryTextStyle,
      alignment: alignment ?? _alignment,
      cardBackgroundColor: cardBackgroundColor ?? _cardBackgroundColor,
    );
  }

  BrnCardTitleConfig merge(BrnCardTitleConfig? other) {
    if (other == null) return this;
    return copyWith(
      cardTitlePadding: other._cardTitlePadding,
      titleWithHeightTextStyle:
          titleWithHeightTextStyle.merge(other._titleWithHeightTextStyle),
      titleTextStyle: titleTextStyle.merge(other._titleTextStyle),
      subtitleTextStyle: subtitleTextStyle.merge(other._subtitleTextStyle),
      detailTextStyle: detailTextStyle.merge(other._detailTextStyle),
      accessoryTextStyle: accessoryTextStyle.merge(other._accessoryTextStyle),
      alignment: other._alignment,
      cardBackgroundColor: other._cardBackgroundColor,
    );
  }
}
