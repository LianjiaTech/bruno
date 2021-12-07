import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_common_config.dart';

/// 组件配置基类
abstract class BrnBaseConfig {
  String configId;

  BrnCommonConfig _currentLevelCommonConfig;

  BrnBaseConfig(
      {this.configId = BrnThemeConfigurator.GLOBAL_CONFIG_ID, bool autoFlatConfig = false}) {
    if (autoFlatConfig) {
      initThemeConfig(configId);
    }
  }

  /// 部分代码示意如下：
  /// cardTitleConfig.detailTextStyle.merge(BrnTextStyle(
  ///       color: commonConfig.colorTextBase,
  ///       fontSize: commonConfig.fontSizeBase,
  ///     ).merge(detailTextStyle));
  /// 第一步 以commonConfig字段为基础merge detailTextStyle  detailTextStyle 字段优先级高
  /// 当detailTextStyle中字段(如：color)为null时会使用commonConfig.colorTextBase
  /// 第二步 以默认上一级配置为基础merge  第一步结果，当第一步中字段(如：color)为空时 ,
  /// 使用上一层级配置的color(cardTitleConfig.detailTextStyle.color)
  void initThemeConfig(String configId, {BrnCommonConfig currentLevelCommonConfig}) {
    _currentLevelCommonConfig = currentLevelCommonConfig;
  }

  /// 当自定义组件的配置时调用
  /// 根据自定义时传入的configId对配置字段打平
  void initThemeConfigPersonal() {
    initThemeConfig(configId);
  }

  BrnCommonConfig get commonConfig =>
      _currentLevelCommonConfig ??
      BrnThemeConfigurator.instance.getConfig(configId: configId).commonConfig;
}
