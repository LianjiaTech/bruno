import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';

/// 组件配置基类
abstract class BrnBaseConfig {
  BrnBaseConfig({
    String configId = GLOBAL_CONFIG_ID,
    bool autoFlatConfig = false,
  }) : _configId = configId {
    if (autoFlatConfig) {
      initThemeConfig(configId);
    }
  }

  String get configId => _configId;
  String _configId;
  BrnCommonConfig? _currentLevelCommonConfig;

  /// 部分代码示意如下：
  ///
  /// ```dart
  /// cardTitleConfig.detailTextStyle.merge(
  ///   BrnTextStyle(
  ///     color: commonConfig.colorTextBase,
  ///     fontSize: commonConfig.fontSizeBase,
  ///   ).merge(detailTextStyle),
  /// );
  ///
  /// - 以 `commonConfig` 字段为基础 merge `detailTextStyle`。
  ///   `detailTextStyle` 字段优先级高，当detailTextStyle中字段（如 color）为 null 时
  ///   会使用 `commonConfig.colorTextBase`。
  /// - 以默认上一级配置为基础 merge 第一步的结果，当第一步中字段（如 color）为空时，
  ///   使用上一层级配置的 color (`cardTitleConfig.detailTextStyle.color`)。
  void initThemeConfig(
    String configId, {
    BrnCommonConfig? currentLevelCommonConfig,
  }) {
    _currentLevelCommonConfig = currentLevelCommonConfig;
  }

  /// 当自定义组件的配置时调用
  /// 根据自定义时传入的 [configId] 对配置字段打平
  void initThemeConfigPersonal() {
    initThemeConfig(configId);
  }

  BrnCommonConfig get commonConfig =>
      _currentLevelCommonConfig ??
      BrnThemeConfigurator.instance
          .getConfig(configId: configId)
          .commonConfig;
}
