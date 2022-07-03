import 'dart:ui';

/// 资源抽象类
abstract class BrnBaseResource {
  String get ok;

  String get cancel;

  String get confirm;

  String get loading;
}

///
/// 中文资源
///
class BrnResourceZh extends BrnBaseResource {

  static Locale locale = Locale('zh', 'CN');

  @override
  String get ok => '确定';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get loading => '加载中...';
}

///
/// en resources
///
class BrnResourceEn extends BrnBaseResource {

  static Locale locale = Locale('en', 'US');

  @override
  String get ok => 'Ok';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get loading => 'Loading ...';
}