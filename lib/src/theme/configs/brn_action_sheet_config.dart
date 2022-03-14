import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_default_config_utils.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// BrnActionSheet 主题配置
class BrnActionSheetConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultActionSheetConfig]
  BrnActionSheetConfig({
    BrnTextStyle? titleStyle,
    BrnTextStyle? itemTitleStyle,
    BrnTextStyle? itemTitleStyleLink,
    BrnTextStyle? itemTitleStyleAlert,
    BrnTextStyle? itemDescStyle,
    BrnTextStyle? itemDescStyleLink,
    BrnTextStyle? itemDescStyleAlert,
    BrnTextStyle? cancelStyle,
    double? topRadius,
    EdgeInsets? contentPadding,
    EdgeInsets? titlePadding,
    String configId = GLOBAL_CONFIG_ID,
  })  : _titleStyle = titleStyle,
        _itemTitleStyle = itemTitleStyle,
        _itemTitleStyleLink = itemTitleStyleLink,
        _itemTitleStyleAlert = itemTitleStyleAlert,
        _itemDescStyle = itemDescStyle,
        _itemDescStyleLink = itemDescStyleLink,
        _itemDescStyleAlert = itemDescStyleAlert,
        _cancelStyle = cancelStyle,
        _topRadius = topRadius,
        _contentPadding = contentPadding,
        _titlePadding = titlePadding,
        super(configId: configId);

  /// ActionSheet 的顶部圆角
  /// 默认值为 [BrnCommonConfig.radiusLg]
  double? _topRadius;

  /// 标题样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? _titleStyle;

  /// 元素标题默认样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize:[BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? _itemTitleStyle;

  /// 元素标题链接样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorLink],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _itemTitleStyleLink;

  /// 元素警示项标题样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandError],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _itemTitleStyleAlert;

  /// 元素描述默认样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _itemDescStyle;

  /// 元素标题描述链接样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorLink],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _itemDescStyleLink;

  /// 元素警示项标题描述样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandError],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _itemDescStyleAlert;

  /// 取消按钮样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? _cancelStyle;

  /// 内容左右间距
  ///
  /// EdgeInsets.symmetric(horizontal: 60, vertical: 12)
  EdgeInsets? _contentPadding;

  /// 标题左右间距
  ///
  /// EdgeInsets.symmetric(horizontal: 60, vertical: 16)
  EdgeInsets? _titlePadding;

  double get topRadius =>
      _topRadius ?? BrnDefaultConfigUtils.defaultActionSheetConfig.topRadius;

  BrnTextStyle get titleStyle =>
      _titleStyle ?? BrnDefaultConfigUtils.defaultActionSheetConfig.titleStyle;

  BrnTextStyle get itemTitleStyle =>
      _itemTitleStyle ??
      BrnDefaultConfigUtils.defaultActionSheetConfig.itemTitleStyle;

  BrnTextStyle get itemTitleStyleLink =>
      _itemTitleStyleLink ??
      BrnDefaultConfigUtils.defaultActionSheetConfig.itemTitleStyleLink;

  BrnTextStyle get itemTitleStyleAlert =>
      _itemTitleStyleAlert ??
      BrnDefaultConfigUtils.defaultActionSheetConfig.itemTitleStyleAlert;

  BrnTextStyle get itemDescStyle =>
      _itemDescStyle ??
      BrnDefaultConfigUtils.defaultActionSheetConfig.itemDescStyle;

  BrnTextStyle get itemDescStyleLink =>
      _itemDescStyleLink ??
      BrnDefaultConfigUtils.defaultActionSheetConfig.itemDescStyleLink;

  BrnTextStyle get itemDescStyleAlert =>
      _itemDescStyleAlert ??
      BrnDefaultConfigUtils.defaultActionSheetConfig.itemDescStyleAlert;

  BrnTextStyle get cancelStyle =>
      _cancelStyle ??
      BrnDefaultConfigUtils.defaultActionSheetConfig.cancelStyle;

  EdgeInsets get contentPadding =>
      _contentPadding ??
      BrnDefaultConfigUtils.defaultActionSheetConfig.contentPadding;

  EdgeInsets get titlePadding =>
      _titlePadding ??
      BrnDefaultConfigUtils.defaultActionSheetConfig.titlePadding;

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
    BrnActionSheetConfig actionSheetConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .actionSheetConfig;

    _titlePadding ??= actionSheetConfig.titlePadding;
    _contentPadding ??= actionSheetConfig.contentPadding;
    _titleStyle = actionSheetConfig.titleStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextSecondary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_titleStyle),
    );
    _itemTitleStyle = actionSheetConfig.itemTitleStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_itemTitleStyle),
    );
    _itemTitleStyleLink = actionSheetConfig.itemTitleStyleLink.merge(
      BrnTextStyle(
        color: commonConfig.colorLink,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_itemTitleStyleLink),
    );
    _itemTitleStyleAlert = actionSheetConfig.itemTitleStyleAlert.merge(
      BrnTextStyle(
        color: commonConfig.brandError,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_itemTitleStyleAlert),
    );
    _itemDescStyle = actionSheetConfig.itemDescStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(_itemDescStyle),
    );
    _itemDescStyleLink = actionSheetConfig.itemDescStyleLink.merge(
      BrnTextStyle(
        color: commonConfig.colorLink,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(_itemDescStyleLink),
    );
    _itemDescStyleAlert = actionSheetConfig.itemDescStyleAlert.merge(
      BrnTextStyle(
        color: commonConfig.brandError,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(_itemDescStyleAlert),
    );
    _cancelStyle = actionSheetConfig.cancelStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_cancelStyle),
    );
    _topRadius ??= commonConfig.radiusLg;
  }

  BrnActionSheetConfig copyWith({
    double? topRadius,
    BrnTextStyle? titleStyle,
    BrnTextStyle? itemTitleStyle,
    BrnTextStyle? itemTitleStyleLink,
    BrnTextStyle? itemTitleStyleAlert,
    BrnTextStyle? itemDescStyle,
    BrnTextStyle? itemDescStyleLink,
    BrnTextStyle? itemDescStyleAlert,
    BrnTextStyle? cancelStyle,
    EdgeInsets? contentPadding,
    EdgeInsets? titlePadding,
  }) {
    return BrnActionSheetConfig(
      titleStyle: titleStyle ?? _titleStyle,
      itemTitleStyle: itemTitleStyle ?? _itemTitleStyle,
      itemTitleStyleLink: itemTitleStyleLink ?? _itemTitleStyleLink,
      itemTitleStyleAlert: itemTitleStyleAlert ?? _itemTitleStyleAlert,
      itemDescStyle: itemDescStyle ?? _itemDescStyle,
      itemDescStyleLink: itemDescStyleLink ?? _itemDescStyleLink,
      itemDescStyleAlert: itemDescStyleAlert ?? _itemDescStyleAlert,
      cancelStyle: cancelStyle ?? _cancelStyle,
      topRadius: topRadius ?? _topRadius,
      contentPadding: contentPadding ?? _contentPadding,
      titlePadding: titlePadding ?? _titlePadding,
    );
  }

  BrnActionSheetConfig merge(BrnActionSheetConfig? other) {
    if (other == null) return this;
    return copyWith(
      titleStyle: titleStyle.merge(other._titleStyle),
      itemTitleStyle: itemTitleStyle.merge(other._itemTitleStyle),
      itemTitleStyleLink: itemTitleStyleLink.merge(other._itemTitleStyleLink),
      itemTitleStyleAlert:
          itemTitleStyleAlert.merge(other._itemTitleStyleAlert),
      itemDescStyle: itemDescStyle.merge(other._itemDescStyle),
      itemDescStyleLink: itemDescStyleLink.merge(other._itemDescStyleLink),
      itemDescStyleAlert: itemDescStyleAlert.merge(other._itemDescStyleAlert),
      cancelStyle: cancelStyle.merge(other._cancelStyle),
      topRadius: other._topRadius,
      contentPadding: other._contentPadding,
      titlePadding: other._titlePadding,
    );
  }
}
