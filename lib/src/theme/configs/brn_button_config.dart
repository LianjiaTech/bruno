import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';

/// 按钮基础配置
class BrnButtonConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultButtonConfig]
  BrnButtonConfig({
    this.bigButtonRadius,
    this.bigButtonHeight,
    this.bigButtonFontSize,
    this.smallButtonRadius,
    this.smallButtonHeight,
    this.smallButtonFontSize,
    String configId = GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// 默认为 6
  double? bigButtonRadius;

  /// 默认为 48
  double? bigButtonHeight;

  /// 默认为 16
  double? bigButtonFontSize;

  /// 默认为 4
  double? smallButtonRadius;

  /// 默认为 32
  double? smallButtonHeight;

  /// 默认为 14
  double? smallButtonFontSize;

  @override
  void initThemeConfig(
    String configId, {
    BrnCommonConfig? currentLevelCommonConfig,
  }) {
    super.initThemeConfig(
      configId,
      currentLevelCommonConfig: currentLevelCommonConfig,
    );

    BrnButtonConfig? userConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .buttonConfig;

    bigButtonRadius ??= userConfig?.bigButtonRadius;
    bigButtonHeight ??= userConfig?.bigButtonHeight;
    bigButtonFontSize ??= userConfig?.bigButtonFontSize;
    smallButtonRadius ??= userConfig?.smallButtonRadius;
    smallButtonHeight ??= userConfig?.smallButtonHeight;
    smallButtonFontSize ??= userConfig?.smallButtonFontSize;
  }

  BrnButtonConfig copyWith({
    double? bigButtonRadius,
    double? bigButtonHeight,
    double? bigButtonFontSize,
    double? smallButtonRadius,
    double? smallButtonHeight,
    double? smallButtonFontSize,
  }) {
    return BrnButtonConfig(
      bigButtonRadius: bigButtonRadius ?? this.bigButtonRadius,
      bigButtonHeight: bigButtonHeight ?? this.bigButtonHeight,
      bigButtonFontSize: bigButtonFontSize ?? this.bigButtonFontSize,
      smallButtonRadius: smallButtonRadius ?? this.smallButtonRadius,
      smallButtonHeight: smallButtonHeight ?? this.smallButtonHeight,
      smallButtonFontSize: smallButtonFontSize ?? this.smallButtonFontSize,
    );
  }

  BrnButtonConfig merge(BrnButtonConfig? other) {
    if (other == null) return this;
    return copyWith(
      bigButtonRadius: other.bigButtonRadius,
      bigButtonHeight: other.bigButtonHeight,
      bigButtonFontSize: other.bigButtonFontSize,
      smallButtonRadius: other.smallButtonRadius,
      smallButtonHeight: other.smallButtonHeight,
      smallButtonFontSize: other.smallButtonFontSize,
    );
  }
}
