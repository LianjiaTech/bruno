import 'package:bruno/src/theme/base/brn_default_config_utils.dart';
import 'package:bruno/src/theme/configs/brn_all_config.dart';

const String BRUNO_CONFIG_ID = 'BRUNO_CONFIG_ID';
const String GLOBAL_CONFIG_ID = 'GLOBAL_CONFIG_ID';

class BrnThemeConfigurator {
  BrnThemeConfigurator._() {
    _checkAndInitBrunoConfig();
  }

  static final BrnThemeConfigurator _instance = BrnThemeConfigurator._();

  static BrnThemeConfigurator get instance {
    return _instance;
  }

  Map<String, BrnAllThemeConfig> globalConfig = <String, BrnAllThemeConfig>{};

  /// 手动注册时，默认注册渠道是 GLOBAL_CONFIG_ID
  void register(
    BrnAllThemeConfig? allThemeConfig, {
    String configId = GLOBAL_CONFIG_ID,
  }) {
    // 打平内部字段
    if (allThemeConfig != null) {
      // 赋值传入配置
      globalConfig[configId] = allThemeConfig..initThemeConfig(configId);
    }
  }

  /// 获取合适的配置
  /// 1、获取 configId 对应的全局主题配置，
  /// 2、若获取的为 null，则使用默认的全局配置。
  /// 3、若没有配置 GLOBAL_CONFIG_ID ，则使用 BRUNO 的配置。
  BrnAllThemeConfig getConfig({String configId = GLOBAL_CONFIG_ID}) {
    BrnAllThemeConfig? allThemeConfig = globalConfig[configId] ??
        globalConfig[GLOBAL_CONFIG_ID] ??
        globalConfig[BRUNO_CONFIG_ID];
    assert(allThemeConfig != null, 'No suitable config found.');
    return allThemeConfig!;
  }

  /// 检查是否有默认配置
  bool isBrunoConfig() => globalConfig[BRUNO_CONFIG_ID] != null;

  /// 没有默认配置 配置默认配置
  void _checkAndInitBrunoConfig() {
    if (!isBrunoConfig()) {
      globalConfig[BRUNO_CONFIG_ID] = BrnDefaultConfigUtils.defaultAllConfig;
    }
  }
}
