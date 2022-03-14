import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_default_config_utils.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';

/// 强化数字展示组件配置
class BrnEnhanceNumberCardConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultEnhanceNumberInfoConfig]
  BrnEnhanceNumberCardConfig({
    double? runningSpace,
    double? itemRunningSpace,
    BrnTextStyle? titleTextStyle,
    BrnTextStyle? descTextStyle,
    double? dividerWidth,
    String configId: GLOBAL_CONFIG_ID,
  })  : _runningSpace = runningSpace,
        _itemRunningSpace = itemRunningSpace,
        _titleTextStyle = titleTextStyle,
        _descTextStyle = descTextStyle,
        _dividerWidth = dividerWidth,
        super(configId: configId);

  /// 如果超过一行，行间距
  double? _runningSpace;

  double get runningSpace =>
      _runningSpace ??
      BrnDefaultConfigUtils.defaultEnhanceNumberInfoConfig.runningSpace;

  /// Item的上半部分和下半部分的间距
  double? _itemRunningSpace;

  double get itemRunningSpace =>
      _itemRunningSpace ??
      BrnDefaultConfigUtils.defaultEnhanceNumberInfoConfig.itemRunningSpace;

  double? _dividerWidth;

  double get dividerWidth =>
      _dividerWidth ??
      BrnDefaultConfigUtils.defaultEnhanceNumberInfoConfig.dividerWidth;
  BrnTextStyle? _titleTextStyle;

  BrnTextStyle get titleTextStyle =>
      _titleTextStyle ??
      BrnDefaultConfigUtils.defaultEnhanceNumberInfoConfig.titleTextStyle;
  BrnTextStyle? _descTextStyle;

  BrnTextStyle get descTextStyle =>
      _descTextStyle ??
      BrnDefaultConfigUtils.defaultEnhanceNumberInfoConfig.descTextStyle;

  @override
  void initThemeConfig(
    String configId, {
    BrnCommonConfig? currentLevelCommonConfig,
  }) {
    super.initThemeConfig(
      configId,
      currentLevelCommonConfig: currentLevelCommonConfig,
    );

    BrnEnhanceNumberCardConfig userConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .enhanceNumberCardConfig;

    _runningSpace ??= userConfig._runningSpace;
    _itemRunningSpace ??= userConfig._itemRunningSpace;
    _dividerWidth ??= userConfig._dividerWidth;
    _titleTextStyle = userConfig.titleTextStyle.merge(
      BrnTextStyle(color: commonConfig.colorTextBase).merge(_titleTextStyle),
    );
    _descTextStyle = userConfig.descTextStyle.merge(
      BrnTextStyle(color: commonConfig.colorTextSecondary)
          .merge(_descTextStyle),
    );
  }

  BrnEnhanceNumberCardConfig copyWith({
    double? runningSpace,
    double? itemRunningSpace,
    double? dividerWidth,
    BrnTextStyle? titleTextStyle,
    BrnTextStyle? descTextStyle,
  }) {
    return BrnEnhanceNumberCardConfig(
      runningSpace: runningSpace ?? _runningSpace,
      itemRunningSpace: itemRunningSpace ?? _itemRunningSpace,
      dividerWidth: dividerWidth ?? _dividerWidth,
      titleTextStyle: titleTextStyle ?? _titleTextStyle,
      descTextStyle: descTextStyle ?? _descTextStyle,
    );
  }

  BrnEnhanceNumberCardConfig merge(BrnEnhanceNumberCardConfig? other) {
    if (other == null) return this;
    return copyWith(
      runningSpace: other._runningSpace,
      itemRunningSpace: other._itemRunningSpace,
      dividerWidth: other._dividerWidth,
      titleTextStyle: titleTextStyle.merge(other._titleTextStyle),
      descTextStyle: descTextStyle.merge(other._descTextStyle),
    );
  }
}
