import 'package:bruno/src/theme/brn_theme.dart';

/// 按钮基础配置
class BrnButtonConfig extends BrnBaseConfig {
  ///遵循外部主题配置，Bruno默认配置[BrnDefaultConfigUtils.defaultButtonConfig]
  BrnButtonConfig({
    this.bigButtonRadius,
    this.bigButtonHeight,
    this.bigButtonFontSize,
    this.smallButtonRadius,
    this.smallButtonHeight,
    this.smallButtonFontSize,
    String configId = BrnThemeConfigurator.GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// default value is 6
  double bigButtonRadius;

  /// default value is 48
  double bigButtonHeight;

  /// default value is 16
  double bigButtonFontSize;

  /// default value is 4
  double smallButtonRadius;

  /// default value is 32
  double smallButtonHeight;

  /// default value is 14
  double smallButtonFontSize;

  @override
  void initThemeConfig(String configId, {BrnCommonConfig currentLevelCommonConfig}) {
    super.initThemeConfig(configId, currentLevelCommonConfig: currentLevelCommonConfig);

    BrnButtonConfig userConfig =
        BrnThemeConfigurator.instance.getConfig(configId: configId).buttonConfig;

    this.bigButtonRadius ??= userConfig?.bigButtonRadius;
    this.bigButtonHeight ??= userConfig?.bigButtonHeight;
    this.bigButtonFontSize ??= userConfig?.bigButtonFontSize;
    this.smallButtonRadius ??= userConfig?.smallButtonRadius;
    this.smallButtonHeight ??= userConfig?.smallButtonHeight;
    this.smallButtonFontSize ??= userConfig?.smallButtonFontSize;
  }

  BrnButtonConfig copyWith(
      {double bigButtonRadius,
      double bigButtonHeight,
      double bigButtonFontSize,
      double smallButtonRadius,
      double smallButtonHeight,
      double smallButtonFontSize}) {
    return BrnButtonConfig(
      bigButtonRadius: bigButtonRadius ?? this.bigButtonRadius,
      bigButtonHeight: bigButtonHeight ?? this.bigButtonHeight,
      bigButtonFontSize: bigButtonFontSize ?? this.bigButtonFontSize,
      smallButtonRadius: smallButtonRadius ?? this.smallButtonRadius,
      smallButtonHeight: smallButtonHeight ?? this.smallButtonHeight,
      smallButtonFontSize: smallButtonFontSize ?? this.smallButtonFontSize,
    );
  }

  BrnButtonConfig merge(BrnButtonConfig other) {
    if (other == null) return this;
    return copyWith(
        bigButtonRadius: other.bigButtonRadius,
        bigButtonHeight: other.bigButtonHeight,
        bigButtonFontSize: other.bigButtonFontSize,
        smallButtonRadius: other.smallButtonRadius,
        smallButtonHeight: other.smallButtonHeight,
        smallButtonFontSize: other.smallButtonFontSize);
  }
}
