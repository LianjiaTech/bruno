import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';

/// BrnPairInfoTable 的配置文件 全局配置
class BrnPairInfoTableConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultPairInfoTableConfig]
  BrnPairInfoTableConfig({
    this.rowSpacing,
    this.itemSpacing,
    this.keyTextStyle,
    this.valueTextStyle,
    this.linkTextStyle,
    String configId: GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// 行间距 纵向
  double? rowSpacing;

  /// BrnInfoModal 属性配置 行间距
  double? itemSpacing;

  /// BrnInfoModal key文字样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w400,
  /// )
  BrnTextStyle? keyTextStyle;

  /// BrnInfoModal value文字样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w400,
  /// )
  BrnTextStyle? valueTextStyle;

  /// BrnInfoModal 链接文字样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontWeight: FontWeight.w400,
  ///   fontSize: [BrnCommonConfig.fontSizeBase]
  /// )
  BrnTextStyle? linkTextStyle;

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
    BrnPairInfoTableConfig? pairInfoTableConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .pairInfoTableConfig;

    rowSpacing ??= pairInfoTableConfig?.rowSpacing;
    keyTextStyle = pairInfoTableConfig?.keyTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextSecondary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(keyTextStyle),
    );
    valueTextStyle = pairInfoTableConfig?.valueTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(valueTextStyle),
    );
    linkTextStyle = pairInfoTableConfig?.linkTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(linkTextStyle),
    );
    itemSpacing ??= pairInfoTableConfig?.itemSpacing;
  }

  BrnPairInfoTableConfig copyWith({
    double? rowSpacing,
    double? itemSpacing,
    BrnTextStyle? keyTextStyle,
    BrnTextStyle? valueTextStyle,
    BrnTextStyle? linkTextStyle,
  }) {
    return BrnPairInfoTableConfig(
      rowSpacing: rowSpacing ?? this.rowSpacing,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      keyTextStyle: keyTextStyle ?? this.keyTextStyle,
      valueTextStyle: valueTextStyle ?? this.valueTextStyle,
      linkTextStyle: linkTextStyle ?? this.linkTextStyle,
    );
  }

  BrnPairInfoTableConfig merge(BrnPairInfoTableConfig? other) {
    if (other == null) return this;
    return copyWith(
      rowSpacing: other.rowSpacing,
      itemSpacing: other.itemSpacing,
      keyTextStyle:
          keyTextStyle?.merge(other.keyTextStyle) ?? other.keyTextStyle,
      valueTextStyle:
          valueTextStyle?.merge(other.valueTextStyle) ?? other.valueTextStyle,
      linkTextStyle:
          linkTextStyle?.merge(other.linkTextStyle) ?? other.linkTextStyle,
    );
  }
}

class BrnPairRichInfoGridConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultPairRichInfoGridConfig]
  BrnPairRichInfoGridConfig({
    this.rowSpacing,
    this.itemSpacing,
    this.itemHeight,
    this.keyTextStyle,
    this.valueTextStyle,
    this.linkTextStyle,
    String configId: GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// 行间距 纵向
  double? rowSpacing;

  /// 元素间距 横向
  double? itemSpacing;

  /// 元素高度
  double? itemHeight;

  /// key文字样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w400,
  /// )
  BrnTextStyle? keyTextStyle;

  /// value文字样式
  ///
  /// BrnTextStyle(
  ///   fontWeight: FontWeight.w400,
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? valueTextStyle;

  /// 链接文字样式
  ///
  /// BrnTextStyle(
  ///   fontWeight: FontWeight.w400,
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? linkTextStyle;

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
    BrnPairRichInfoGridConfig? pairRichInfoGridConfig = BrnThemeConfigurator
        .instance
        .getConfig(configId: configId)
        .pairRichInfoGridConfig;

    rowSpacing ??= pairRichInfoGridConfig?.rowSpacing;
    itemSpacing ??= pairRichInfoGridConfig?.itemSpacing;
    itemHeight ??= pairRichInfoGridConfig?.itemHeight;
    keyTextStyle = pairRichInfoGridConfig?.keyTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextSecondary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(keyTextStyle),
    );
    valueTextStyle = pairRichInfoGridConfig?.valueTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(valueTextStyle),
    );
    linkTextStyle = pairRichInfoGridConfig?.linkTextStyle?.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(linkTextStyle),
    );
  }

  BrnPairRichInfoGridConfig copyWith({
    double? rowSpacing,
    double? itemSpacing,
    double? itemHeight,
    BrnTextStyle? keyTextStyle,
    BrnTextStyle? valueTextStyle,
    BrnTextStyle? linkTextStyle,
    BrnTextStyle? titleTextsStyle,
  }) {
    return BrnPairRichInfoGridConfig(
      rowSpacing: rowSpacing ?? this.rowSpacing,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      itemHeight: itemHeight ?? this.itemHeight,
      keyTextStyle: keyTextStyle ?? this.keyTextStyle,
      valueTextStyle: valueTextStyle ?? this.valueTextStyle,
      linkTextStyle: linkTextStyle ?? this.linkTextStyle,
    );
  }

  BrnPairRichInfoGridConfig merge(BrnPairRichInfoGridConfig? other) {
    if (other == null) return this;
    return copyWith(
      rowSpacing: other.rowSpacing,
      itemSpacing: other.itemSpacing,
      itemHeight: other.itemHeight,
      keyTextStyle:
          keyTextStyle?.merge(other.keyTextStyle) ?? other.keyTextStyle,
      valueTextStyle:
          valueTextStyle?.merge(other.valueTextStyle) ?? other.valueTextStyle,
      linkTextStyle:
          linkTextStyle?.merge(other.linkTextStyle) ?? other.linkTextStyle,
    );
  }
}
