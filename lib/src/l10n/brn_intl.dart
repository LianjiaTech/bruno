import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'brn_resources.dart';

///
/// Bruno 多语言支持
///
class BrnIntl {

  /// 内置支持的语言和资源
  final Map<String, BrnBaseResource> _defaultResourceMap = {'en': BrnResourceEn(), 'zh': BrnResourceZh()};

  /// 缓存当前语言对应的资源，用于无 context 的情况
  static BrnIntl? _current;
  static BrnBaseResource get currentResource {
    assert(_current != null,
        'No instance of BrnIntl was loaded. \n'
        'Try to initialize the BrnLocalizationDelegate before accessing BrnIntl.currentResource.');
    /// 若应用未做本地化，则默认使用 zh-CN 资源
    if(_current == null) {
      _current = BrnIntl(BrnResourceZh.locale);
    }
    return _current!.localizedResource;
  }

  final Locale locale;

  BrnIntl(this.locale);

  /// 获取当前语言下对应的资源，若为 null 则返回 [BrnResourceZh]
  BrnBaseResource get localizedResource {
    // 支持动态资源文件
    BrnBaseResource? resource = _BrnIntlHelper.findIntlResourceOfType<BrnBaseResource>(locale);
    if (resource != null) return resource;
    // 常规的多语言资源加载
    return _defaultResourceMap[locale.languageCode] ?? _defaultResourceMap['zh']!;
  }

  /// 获取[BrnIntl]实例
  static BrnIntl of(BuildContext context) {
    return Localizations.of(context, BrnIntl) ?? BrnIntl(BrnResourceZh.locale);
  }

  /// 获取当前语言下 [BrnBaseResource] 资源
  static BrnBaseResource i10n(BuildContext context) {
    return BrnIntl.of(context).localizedResource;
  }

  /// 应用加载本地化资源
  static Future<BrnIntl> _load(Locale locale) {
    _current = BrnIntl(locale);
    return SynchronousFuture<BrnIntl>(_current!);
  }

  /// 支持非内置的本地化能力
  static void add(Locale locale, BrnBaseResource resource) {
    _BrnIntlHelper.add(locale, resource);
  }

  /// 支持非内置的本地化能力
  static void addAll(Locale locale, List<BrnBaseResource> resources) {
    _BrnIntlHelper.addAll(locale, resources);
  }
}

///
/// 组件多语言适配代理
///
class BrnLocalizationDelegate extends LocalizationsDelegate<BrnIntl> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<BrnIntl> load(Locale locale) {
    debugPrint(runtimeType.toString() +
        ' load: locale = $locale, ${locale.countryCode}, ${locale.languageCode}');
    return BrnIntl._load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<BrnIntl> old) => false;

  /// 需在app入口注册
  static BrnLocalizationDelegate delegate = BrnLocalizationDelegate();
}

///
/// 支持外部动态添加其他语言支的本地化
///
final Map<Locale, Map<Type, dynamic>> _additionalIntls = {};
class _BrnIntlHelper {

  ///
  /// 根据 locale 查找 value 类型为[T]的资源
  ///
  static T? findIntlResourceOfType<T>(Locale locale) {
    Map<Type, dynamic>? res = _additionalIntls[locale];
    if (res != null && res.isNotEmpty) {
      for (var entry in res.entries) {
        if (entry.value is T) {
          return entry.value;
        }
      }
    }
    return null;
  }


  ///
  /// 设置自定义 locale 的资源
  ///
  static void addAll(Locale locale, List<BrnBaseResource> resources) {
    var res = _additionalIntls[locale];
    if (res == null) {
      res = {};
      _additionalIntls[locale] = res;
    }
    for (BrnBaseResource resource in resources) {
      res[resource.runtimeType] = resource;
    }
  }

  ///
  /// 设置自定义 locale 的资源
  ///
  static void add(Locale locale, BrnBaseResource resource) {
    var res = _additionalIntls[locale];
    if (res == null) {
      res = {};
      _additionalIntls[locale] = res;
    }
    res[resource.runtimeType] = resource;
  }
}
