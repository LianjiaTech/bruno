import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_default_config_utils.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';

/// BrnPairInfoTable 的配置文件 全局配置
class BrnPairInfoTableConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultPairInfoTableConfig]
  BrnPairInfoTableConfig({
    double? rowSpacing,
    double? itemSpacing,
    BrnTextStyle? keyTextStyle,
    BrnTextStyle? valueTextStyle,
    BrnTextStyle? linkTextStyle,
    String configId: GLOBAL_CONFIG_ID,
  })  : _rowSpacing = rowSpacing,
        _itemSpacing = itemSpacing,
        _keyTextStyle = keyTextStyle,
        _valueTextStyle = valueTextStyle,
        _linkTextStyle = linkTextStyle,
        super(configId: configId);

  /// 行间距 纵向
  double? _rowSpacing;

  /// BrnInfoModal 属性配置 行间距
  double? _itemSpacing;

  /// BrnInfoModal key文字样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w400,
  /// )
  BrnTextStyle? _keyTextStyle;

  /// BrnInfoModal value文字样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w400,
  /// )
  BrnTextStyle? _valueTextStyle;

  /// BrnInfoModal 链接文字样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontWeight: FontWeight.w400,
  ///   fontSize: [BrnCommonConfig.fontSizeBase]
  /// )
  BrnTextStyle? _linkTextStyle;

  double get rowSpacing =>
      _rowSpacing ??
      BrnDefaultConfigUtils.defaultPairInfoTableConfig.rowSpacing;

  double get itemSpacing =>
      _itemSpacing ??
      BrnDefaultConfigUtils.defaultPairInfoTableConfig.itemSpacing;

  BrnTextStyle get keyTextStyle =>
      _keyTextStyle ??
      BrnDefaultConfigUtils.defaultPairInfoTableConfig.keyTextStyle;

  BrnTextStyle get valueTextStyle =>
      _valueTextStyle ??
      BrnDefaultConfigUtils.defaultPairInfoTableConfig.valueTextStyle;

  BrnTextStyle get linkTextStyle =>
      _linkTextStyle ??
      BrnDefaultConfigUtils.defaultPairInfoTableConfig.linkTextStyle;

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
    BrnPairInfoTableConfig pairInfoTableConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .pairInfoTableConfig;

    _rowSpacing ??= pairInfoTableConfig._rowSpacing;
    _keyTextStyle = pairInfoTableConfig.keyTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextSecondary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_keyTextStyle),
    );
    _valueTextStyle = pairInfoTableConfig.valueTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_valueTextStyle),
    );
    _linkTextStyle = pairInfoTableConfig.linkTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_linkTextStyle),
    );
    _itemSpacing ??= pairInfoTableConfig._itemSpacing;
  }

  BrnPairInfoTableConfig copyWith({
    double? rowSpacing,
    double? itemSpacing,
    BrnTextStyle? keyTextStyle,
    BrnTextStyle? valueTextStyle,
    BrnTextStyle? linkTextStyle,
  }) {
    return BrnPairInfoTableConfig(
      rowSpacing: rowSpacing ?? _rowSpacing,
      itemSpacing: itemSpacing ?? _itemSpacing,
      keyTextStyle: keyTextStyle ?? _keyTextStyle,
      valueTextStyle: valueTextStyle ?? _valueTextStyle,
      linkTextStyle: linkTextStyle ?? _linkTextStyle,
    );
  }

  BrnPairInfoTableConfig merge(BrnPairInfoTableConfig? other) {
    if (other == null) return this;
    return copyWith(
      rowSpacing: other._rowSpacing,
      itemSpacing: other._itemSpacing,
      keyTextStyle: keyTextStyle.merge(other._keyTextStyle),
      valueTextStyle: valueTextStyle.merge(other._valueTextStyle),
      linkTextStyle: linkTextStyle.merge(other._linkTextStyle),
    );
  }
}

class BrnPairRichInfoGridConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultPairRichInfoGridConfig]
  BrnPairRichInfoGridConfig({
    double? rowSpacing,
    double? itemSpacing,
    double? itemHeight,
    BrnTextStyle? keyTextStyle,
    BrnTextStyle? valueTextStyle,
    BrnTextStyle? linkTextStyle,
    String configId: GLOBAL_CONFIG_ID,
  })  : _rowSpacing = rowSpacing,
        _itemSpacing = itemSpacing,
        _itemHeight = itemHeight,
        _keyTextStyle = keyTextStyle,
        _valueTextStyle = valueTextStyle,
        _linkTextStyle = linkTextStyle,
        super(configId: configId);

  /// 行间距 纵向
  double? _rowSpacing;

  /// 元素间距 横向
  double? _itemSpacing;

  /// 元素高度
  double? _itemHeight;

  /// key文字样式
  ///
  /// BrnTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w400,
  /// )
  BrnTextStyle? _keyTextStyle;

  /// value文字样式
  ///
  /// BrnTextStyle(
  ///   fontWeight: FontWeight.w400,
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? _valueTextStyle;

  /// 链接文字样式
  ///
  /// BrnTextStyle(
  ///   fontWeight: FontWeight.w400,
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BrnTextStyle? _linkTextStyle;

  double get rowSpacing =>
      _rowSpacing ??
      BrnDefaultConfigUtils.defaultPairRichInfoGridConfig.rowSpacing;

  double get itemSpacing =>
      _itemSpacing ??
      BrnDefaultConfigUtils.defaultPairRichInfoGridConfig.itemSpacing;

  double get itemHeight =>
      _itemHeight ??
      BrnDefaultConfigUtils.defaultPairRichInfoGridConfig.itemHeight;

  BrnTextStyle get keyTextStyle =>
      _keyTextStyle ??
      BrnDefaultConfigUtils.defaultPairRichInfoGridConfig.keyTextStyle;

  BrnTextStyle get valueTextStyle =>
      _valueTextStyle ??
      BrnDefaultConfigUtils.defaultPairRichInfoGridConfig.valueTextStyle;

  BrnTextStyle get linkTextStyle =>
      _linkTextStyle ??
      BrnDefaultConfigUtils.defaultPairRichInfoGridConfig.linkTextStyle;

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
    BrnPairRichInfoGridConfig pairRichInfoGridConfig = BrnThemeConfigurator
        .instance
        .getConfig(configId: configId)
        .pairRichInfoGridConfig;

    _rowSpacing ??= pairRichInfoGridConfig._rowSpacing;
    _itemSpacing ??= pairRichInfoGridConfig._itemSpacing;
    _itemHeight ??= pairRichInfoGridConfig._itemHeight;
    _keyTextStyle = pairRichInfoGridConfig.keyTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextSecondary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_keyTextStyle),
    );
    _valueTextStyle = pairRichInfoGridConfig.valueTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_valueTextStyle),
    );
    _linkTextStyle = pairRichInfoGridConfig.linkTextStyle.merge(
      BrnTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_linkTextStyle),
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
      rowSpacing: rowSpacing ?? _rowSpacing,
      itemSpacing: itemSpacing ?? _itemSpacing,
      itemHeight: itemHeight ?? _itemHeight,
      keyTextStyle: keyTextStyle ?? _keyTextStyle,
      valueTextStyle: valueTextStyle ?? _valueTextStyle,
      linkTextStyle: linkTextStyle ?? _linkTextStyle,
    );
  }

  BrnPairRichInfoGridConfig merge(BrnPairRichInfoGridConfig? other) {
    if (other == null) return this;
    return copyWith(
      rowSpacing: other._rowSpacing,
      itemSpacing: other._itemSpacing,
      itemHeight: other._itemHeight,
      keyTextStyle: keyTextStyle.merge(other._keyTextStyle),
      valueTextStyle: valueTextStyle.merge(other._valueTextStyle),
      linkTextStyle: linkTextStyle.merge(other._linkTextStyle),
    );
  }
}
