import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// BrnActionSheet 主题配置
class BrnActionSheetConfig extends BrnBaseConfig {
  /// 遵循外部主题配置，Bruno默认配置[BrnDefaultConfigUtils.defaultActionSheetConfig]
  BrnActionSheetConfig(
      {this.titleStyle,
      this.itemTitleStyle,
      this.itemTitleStyleLink,
      this.itemTitleStyleAlert,
      this.itemDescStyle,
      this.itemDescStyleLink,
      this.itemDescStyleAlert,
      this.cancelStyle,
      this.topRadius,
      this.contentPadding,
      this.titlePadding,
      String configId: BrnThemeConfigurator.GLOBAL_CONFIG_ID})
      : super(configId: configId);

  /// ActionSheet 的顶部圆角
  /// default value is [BrnCommonConfig.radiusLg]
  double topRadius;

  /// 标题样式
  /// default value is TextStyle(color:[BrnCommonConfig.colorTextSecondary],fontSize:[BrnCommonConfig.fontSizeBase])
  BrnTextStyle titleStyle;

  /// 元素标题默认样式
  /// default value is TextStyle(color:[BrnCommonConfig.colorTextBase],fontSize:[BrnCommonConfig.fontSizeSubHead])
  BrnTextStyle itemTitleStyle;

  /// 元素标题链接样式
  /// default value is TextStyle(color:[BrnCommonConfig.colorLink],fontSize:[BrnCommonConfig.fontSizeSubHead],fontWeight: FontWeight.w600)
  BrnTextStyle itemTitleStyleLink;

  /// 元素警示项标题样式
  /// default value is TextStyle(color:[BrnCommonConfig.brandError],fontSize:[BrnCommonConfig.fontSizeBase],fontWeight: FontWeight.w600)
  BrnTextStyle itemTitleStyleAlert;

  /// 元素描述默认样式
  /// default value is TextStyle(color:[BrnCommonConfig.colorTextBase],fontSize:[BrnCommonConfig.fontSizeCaption],fontWeight: FontWeight.w600)
  BrnTextStyle itemDescStyle;

  /// 元素标题描述链接样式
  /// default value is TextStyle(color:[BrnCommonConfig.colorLink],fontSize:[BrnCommonConfig.fontSizeCaption],fontWeight: FontWeight.w600)
  BrnTextStyle itemDescStyleLink;

  /// 元素警示项标题描述样式
  /// default value is TextStyle(color:[BrnCommonConfig.brandError],fontSize:[BrnCommonConfig.fontSizeCaption],fontWeight: FontWeight.w600)
  BrnTextStyle itemDescStyleAlert;

  /// 取消按钮样式
  /// default value is TextStyle(color:[BrnCommonConfig.colorTextBase],fontSize:[BrnCommonConfig.fontSizeSubHead],fontWeight: FontWeight.w600)
  BrnTextStyle cancelStyle;

  /// 内容左右间距
  /// default value is EdgeInsets.only(top: 12, bottom: 12, left: 60, right: 60)
  EdgeInsets contentPadding;

  /// title 左右间距
  ///default value is EdgeInsets.only(top: 16, bottom: 16, left: 60, right: 60)
  EdgeInsets titlePadding;

  @override
  void initThemeConfig(String configId, {BrnCommonConfig currentLevelCommonConfig}) {
    super.initThemeConfig(configId, currentLevelCommonConfig: currentLevelCommonConfig);

    /// 用户全局组件配置
    BrnActionSheetConfig actionSheetConfig =
        BrnThemeConfigurator.instance.getConfig(configId: configId).actionSheetConfig;

    this.titlePadding ??= actionSheetConfig.titlePadding;

    this.contentPadding ??= actionSheetConfig.contentPadding;

    this.titleStyle = actionSheetConfig.titleStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextSecondary, fontSize: commonConfig.fontSizeBase)
            .merge(this.titleStyle));

    this.itemTitleStyle = actionSheetConfig.itemTitleStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.itemTitleStyle));

    this.itemTitleStyleLink = actionSheetConfig.itemTitleStyleLink.merge(
        BrnTextStyle(color: commonConfig.colorLink, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.itemTitleStyleLink));

    this.itemTitleStyleAlert = actionSheetConfig.itemTitleStyleAlert.merge(
        BrnTextStyle(color: commonConfig.brandError, fontSize: commonConfig.fontSizeBase)
            .merge(this.itemTitleStyleAlert));

    this.itemDescStyle = actionSheetConfig.itemDescStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeCaption)
            .merge(this.itemDescStyle));

    this.itemDescStyleLink = actionSheetConfig.itemDescStyleLink.merge(
        BrnTextStyle(color: commonConfig.colorLink, fontSize: commonConfig.fontSizeCaption)
            .merge(this.itemDescStyleLink));

    this.itemDescStyleAlert = actionSheetConfig.itemDescStyleAlert.merge(
        BrnTextStyle(color: commonConfig.brandError, fontSize: commonConfig.fontSizeCaption)
            .merge(this.itemDescStyleAlert));

    this.cancelStyle = actionSheetConfig.cancelStyle.merge(
        BrnTextStyle(color: commonConfig.colorTextBase, fontSize: commonConfig.fontSizeSubHead)
            .merge(this.cancelStyle));

    this.topRadius ??= commonConfig.radiusLg;
  }

  BrnActionSheetConfig copyWith({
    /// ActionSheet 的顶部圆角
    double topRadius,

    /// 标题样式
    BrnTextStyle titleStyle,

    /// 元素标题默认样式
    BrnTextStyle itemTitleStyle,

    /// 元素标题链接样式
    BrnTextStyle itemTitleStyleLink,

    /// 元素警示项标题样式
    BrnTextStyle itemTitleStyleAlert,

    /// 元素描述默认样式
    BrnTextStyle itemDescStyle,

    /// 元素标题描述链接样式
    BrnTextStyle itemDescStyleLink,

    /// 元素警示项标题描述样式
    BrnTextStyle itemDescStyleAlert,

    /// 取消按钮样式
    BrnTextStyle cancelStyle,
    EdgeInsets contentPadding,
    EdgeInsets titlePadding,
  }) {
    return BrnActionSheetConfig(
        titleStyle: titleStyle ?? this.titleStyle,
        itemTitleStyle: itemTitleStyle ?? this.itemTitleStyle,
        itemTitleStyleLink: itemTitleStyleLink ?? this.itemTitleStyleLink,
        itemTitleStyleAlert: itemTitleStyleAlert ?? this.itemTitleStyleAlert,
        itemDescStyle: itemDescStyle ?? this.itemDescStyle,
        itemDescStyleLink: itemDescStyleLink ?? this.itemDescStyleLink,
        itemDescStyleAlert: itemDescStyleAlert ?? this.itemDescStyleAlert,
        cancelStyle: cancelStyle ?? this.cancelStyle,
        topRadius: topRadius ?? this.topRadius,
        contentPadding: contentPadding ?? this.contentPadding,
        titlePadding: titlePadding ?? this.titlePadding);
  }

  BrnActionSheetConfig merge(BrnActionSheetConfig other) {
    if (other == null) return this;
    return copyWith(
      titleStyle: this.titleStyle?.merge(other.titleStyle) ?? other.titleStyle,
      itemTitleStyle: this.itemTitleStyle?.merge(other.itemTitleStyle) ?? other.itemTitleStyle,
      itemTitleStyleLink:
          this.itemTitleStyleLink?.merge(other.itemTitleStyleLink) ?? other.itemTitleStyleLink,
      itemTitleStyleAlert:
          this.itemTitleStyleAlert?.merge(other.itemTitleStyleAlert) ?? other.itemTitleStyleAlert,
      itemDescStyle: this.itemDescStyle?.merge(other.itemDescStyle) ?? other.itemDescStyle,
      itemDescStyleLink:
          this.itemDescStyleLink?.merge(other.itemDescStyleLink) ?? other.itemDescStyleLink,
      itemDescStyleAlert:
          this.itemDescStyleAlert?.merge(other.itemDescStyleAlert) ?? other.itemDescStyleAlert,
      cancelStyle: this.cancelStyle?.merge(other.cancelStyle) ?? other.cancelStyle,
      topRadius: other.topRadius,
      contentPadding: other.contentPadding,
      titlePadding: other.titlePadding,
    );
  }
}
