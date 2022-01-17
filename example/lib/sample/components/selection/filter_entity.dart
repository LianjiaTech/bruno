// @dart=2.9

import 'package:bruno/bruno.dart';

class BrnFilterEntity {
  String key;
  String name;
  String defaultValue;
  List<ItemEntity> children;

  BrnFilterEntity.fromJson(Map<String, dynamic> map) {
    key = map['key'] ?? '';
    name = map['title'] ?? '';
    defaultValue = map['defaultValue'] ?? '';
    children = []..addAll((map['children'] as List ?? []).map((o) => ItemEntity.fromJson(o)));
  }
}
