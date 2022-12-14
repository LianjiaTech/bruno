import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';

class ChangeLocalEvent extends Notification{
  static Locale locale = Locale('zh', 'CN');
}

class ResourceDe extends BrnResourceEn {

  static Locale locale = Locale('de', 'DE');

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'bestätigen';

  @override
  String get loading => 'Wird geladen';

  @override
  String get ok => 'Ok';

}