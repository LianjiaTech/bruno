import 'package:bruno/src/theme/brn_theme.dart';
import 'package:bruno/src/theme/configs/brn_all_config.dart';

class BrnThemeConfigurator {
  static const String BRUNO_CONFIG_ID = 'BRUNO_CONFIG_ID';
  static const String GLOBAL_CONFIG_ID = 'GLOBAL_CONFIG_ID';

  static final BrnThemeConfigurator _instance = BrnThemeConfigurator._();
  Map<String, BrnAllThemeConfig> globalConfig = Map();

  BrnThemeConfigurator._();

  static BrnThemeConfigurator get instance {
    return _instance;
  }

  /// 手动注册时，默认注册渠道是 GLOBAL_CONFIG_ID
  void register(BrnAllThemeConfig allThemeConfig, {String configId = GLOBAL_CONFIG_ID}) {
    assert(configId != null);

    /// 先赋值默认配置
    checkAndInitBrunoConfig();

    /// 打平内部字段
    allThemeConfig?.initThemeConfig(configId);

    /// 赋值传入配置
    if (allThemeConfig != null) {
      instance.globalConfig[configId] = allThemeConfig;
    }
  }

  /// 获取合适的配置
  /// 1、获取 configId 对应的全局主题配置，
  /// 2、若获取的为 null，则使用默认的全局配置。
  /// 3、若没有配置 GLOBAL_CONFIG_ID ，则使用 BRUNO 的配置。
  BrnAllThemeConfig getConfig({String configId = GLOBAL_CONFIG_ID}) {
    assert(configId != null);
    checkAndInitBrunoConfig();

    BrnAllThemeConfig allThemeConfig = globalConfig[configId];
    if (allThemeConfig == null) {
      allThemeConfig = globalConfig[GLOBAL_CONFIG_ID];
    }
    if (allThemeConfig == null) {
      allThemeConfig = globalConfig[BRUNO_CONFIG_ID];
    }
    return allThemeConfig;
  }

  /// 检查是否有默认配置
  bool isBrunoConfig() {
    return globalConfig[BRUNO_CONFIG_ID] != null;
  }

  /// 没有默认配置 配置默认配置
  void checkAndInitBrunoConfig() {
    if (!isBrunoConfig()) {
      globalConfig[BRUNO_CONFIG_ID] = BrnDefaultConfigUtils.defaultAllConfig;
    }
  }
}
