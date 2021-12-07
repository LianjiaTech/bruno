import 'package:bruno/src/theme/brn_theme.dart';

/// 强化数字展示组件配置
class BrnEnhanceNumberCardConfig extends BrnBaseConfig {
  ///遵循外部主题配置，Bruno默认配置[BrnDefaultConfigUtils.defaultNumberInfoConfig]
  BrnEnhanceNumberCardConfig({
    this.runningSpace,
    this.itemRunningSpace,
    this.titleTextStyle,
    this.descTextStyle,
    this.dividerWidth,
    String configId: BrnThemeConfigurator.GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  ///如果超过一行，行间距
  double runningSpace;

  ///Item的上半部分和下半部分的间距
  double itemRunningSpace;

  double dividerWidth;

  BrnTextStyle titleTextStyle;

  BrnTextStyle descTextStyle;

  @override
  void initThemeConfig(String configId, {BrnCommonConfig currentLevelCommonConfig}) {
    super.initThemeConfig(configId, currentLevelCommonConfig: currentLevelCommonConfig);

    BrnEnhanceNumberCardConfig userConfig =
        BrnThemeConfigurator.instance.getConfig(configId: configId).enhanceNumberCardConfig;

    this.runningSpace ??= userConfig.runningSpace;
    this.itemRunningSpace ??= userConfig.itemRunningSpace;
    this.dividerWidth ??= userConfig.dividerWidth;

    this.titleTextStyle = userConfig.titleTextStyle
        .merge(BrnTextStyle(color: commonConfig.colorTextBase).merge(this.titleTextStyle));

    this.descTextStyle = userConfig.descTextStyle
        .merge(BrnTextStyle(color: commonConfig.colorTextSecondary).merge(this.descTextStyle));
  }

  BrnEnhanceNumberCardConfig copyWith({
    double runningSpace,
    double itemRunningSpace,
    double dividerWidth,
    BrnTextStyle titleTextStyle,
    BrnTextStyle descTextStyle,
  }) {
    return BrnEnhanceNumberCardConfig(
      runningSpace: runningSpace ?? this.runningSpace,
      itemRunningSpace: itemRunningSpace ?? this.itemRunningSpace,
      dividerWidth: dividerWidth ?? this.dividerWidth,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      descTextStyle: descTextStyle ?? this.descTextStyle,
    );
  }

  BrnEnhanceNumberCardConfig merge(BrnEnhanceNumberCardConfig other) {
    if (other == null) return this;
    return copyWith(
      runningSpace: other.runningSpace,
      itemRunningSpace: other.itemRunningSpace,
      dividerWidth: other.dividerWidth,
      titleTextStyle: titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
      descTextStyle: descTextStyle?.merge(other.descTextStyle) ?? other.descTextStyle,
    );
  }
}
