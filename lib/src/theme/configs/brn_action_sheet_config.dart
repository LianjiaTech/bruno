import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';
import 'package:flutter/material.dart';

/// BrnActionSheet 主题配置
class BrnActionSheetConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultActionSheetConfig]
  BrnActionSheetConfig({
    this.titleStyle,
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
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// ActionSheet 的顶部圆角
  /// 默认值为 [BrnCommonConfig.radiusLg]
  double? topRadius;

  /// 标题样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? titleStyle;

  /// 元素标题默认样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize:[BrnCommonConfig.fontSizeSubHead],
  /// )
  BrnTextStyle? itemTitleStyle;

  /// 元素标题链接样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorLink],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? itemTitleStyleLink;

  /// 元素警示项标题样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandError],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? itemTitleStyleAlert;

  /// 元素描述默认样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? itemDescStyle;

  /// 元素标题描述链接样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorLink],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? itemDescStyleLink;

  /// 元素警示项标题描述样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandError],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? itemDescStyleAlert;

  /// 取消按钮样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BrnTextStyle? cancelStyle;

  /// 内容左右间距
  ///
  /// EdgeInsets.symmetric(horizontal: 60, vertical: 12)
  EdgeInsets? contentPadding;

  /// 标题左右间距
  ///
  /// EdgeInsets.symmetric(horizontal: 60, vertical: 16)
  EdgeInsets? titlePadding;

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
    BrnActionSheetConfig? actionSheetConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .actionSheetConfig;

    titlePadding ??= actionSheetConfig?.titlePadding;
    contentPadding ??= actionSheetConfig?.contentPadding;
    titleStyle = actionSheetConfig?.titleStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextSecondary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(titleStyle),
    );
    itemTitleStyle = actionSheetConfig?.itemTitleStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(itemTitleStyle),
    );
    itemTitleStyleLink = actionSheetConfig?.itemTitleStyleLink?.merge(
      BrnTextStyle(
        color: commonConfig.colorLink,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(itemTitleStyleLink),
    );
    itemTitleStyleAlert = actionSheetConfig?.itemTitleStyleAlert?.merge(
      BrnTextStyle(
        color: commonConfig.brandError,
        fontSize: commonConfig.fontSizeBase,
      ).merge(itemTitleStyleAlert),
    );
    itemDescStyle = actionSheetConfig?.itemDescStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(itemDescStyle),
    );
    itemDescStyleLink = actionSheetConfig?.itemDescStyleLink?.merge(
      BrnTextStyle(
        color: commonConfig.colorLink,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(itemDescStyleLink),
    );
    itemDescStyleAlert = actionSheetConfig?.itemDescStyleAlert?.merge(
      BrnTextStyle(
        color: commonConfig.brandError,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(itemDescStyleAlert),
    );
    cancelStyle = actionSheetConfig?.cancelStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(cancelStyle),
    );
    topRadius ??= commonConfig.radiusLg;
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
      titlePadding: titlePadding ?? this.titlePadding,
    );
  }

  BrnActionSheetConfig merge(BrnActionSheetConfig? other) {
    if (other == null) return this;
    return copyWith(
      titleStyle: titleStyle?.merge(other.titleStyle) ?? other.titleStyle,
      itemTitleStyle:
          itemTitleStyle?.merge(other.itemTitleStyle) ?? other.itemTitleStyle,
      itemTitleStyleLink: itemTitleStyleLink?.merge(other.itemTitleStyleLink) ??
          other.itemTitleStyleLink,
      itemTitleStyleAlert:
          itemTitleStyleAlert?.merge(other.itemTitleStyleAlert) ??
              other.itemTitleStyleAlert,
      itemDescStyle:
          itemDescStyle?.merge(other.itemDescStyle) ?? other.itemDescStyle,
      itemDescStyleLink: itemDescStyleLink?.merge(other.itemDescStyleLink) ??
          other.itemDescStyleLink,
      itemDescStyleAlert: itemDescStyleAlert?.merge(other.itemDescStyleAlert) ??
          other.itemDescStyleAlert,
      cancelStyle: cancelStyle?.merge(other.cancelStyle) ?? other.cancelStyle,
      topRadius: other.topRadius,
      contentPadding: other.contentPadding,
      titlePadding: other.titlePadding,
    );
  }
}
