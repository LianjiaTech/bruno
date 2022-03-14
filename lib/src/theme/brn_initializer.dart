import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_all_config.dart';

/// Bruno 初始化
class BrnInitializer {
  /// 手动注册时，默认注册渠道是 GLOBAL_CONFIG_ID
  static register({
    BrnAllThemeConfig? allThemeConfig,
    String configId = GLOBAL_CONFIG_ID,
  }) {
    /// 配置主题定制
    BrnThemeConfigurator.instance.register(allThemeConfig, configId: configId);
  }
}
