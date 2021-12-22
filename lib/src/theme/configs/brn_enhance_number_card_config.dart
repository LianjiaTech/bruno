import 'package:bruno/src/theme/base/brn_base_config.dart';
import 'package:bruno/src/theme/base/brn_text_style.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';

/// 强化数字展示组件配置
class BrnEnhanceNumberCardConfig extends BrnBaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [BrnDefaultConfigUtils.defaultNumberInfoConfig]
  BrnEnhanceNumberCardConfig({
    this.runningSpace,
    this.itemRunningSpace,
    this.titleTextStyle,
    this.descTextStyle,
    this.dividerWidth,
    String configId: GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// 如果超过一行，行间距
  double? runningSpace;

  /// Item的上半部分和下半部分的间距
  double? itemRunningSpace;
  double? dividerWidth;

  BrnTextStyle? titleTextStyle;
  BrnTextStyle? descTextStyle;

  @override
  void initThemeConfig(
    String configId, {
    BrnCommonConfig? currentLevelCommonConfig,
  }) {
    super.initThemeConfig(
      configId,
      currentLevelCommonConfig: currentLevelCommonConfig,
    );

    BrnEnhanceNumberCardConfig? userConfig = BrnThemeConfigurator.instance
        .getConfig(configId: configId)
        .enhanceNumberCardConfig;

    runningSpace ??= userConfig?.runningSpace;
    itemRunningSpace ??= userConfig?.itemRunningSpace;
    dividerWidth ??= userConfig?.dividerWidth;
    titleTextStyle = userConfig?.titleTextStyle?.merge(
      BrnTextStyle(color: commonConfig.colorTextBase).merge(titleTextStyle),
    );
    descTextStyle = userConfig?.descTextStyle?.merge(
      BrnTextStyle(color: commonConfig.colorTextSecondary).merge(descTextStyle),
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
      runningSpace: runningSpace ?? this.runningSpace,
      itemRunningSpace: itemRunningSpace ?? this.itemRunningSpace,
      dividerWidth: dividerWidth ?? this.dividerWidth,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      descTextStyle: descTextStyle ?? this.descTextStyle,
    );
  }

  BrnEnhanceNumberCardConfig merge(BrnEnhanceNumberCardConfig? other) {
    if (other == null) return this;
    return copyWith(
      runningSpace: other.runningSpace,
      itemRunningSpace: other.itemRunningSpace,
      dividerWidth: other.dividerWidth,
      titleTextStyle:
          titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
      descTextStyle:
          descTextStyle?.merge(other.descTextStyle) ?? other.descTextStyle,
    );
  }
}
