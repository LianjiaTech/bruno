class ItemEntity {
  String? key;
  String name;
  String? value;

  ItemEntity({this.key, this.name = '', this.value});

  ItemEntity.fromJson(Map<String, dynamic> map) : this.name = '' {
    key = map['key'] ?? '';
    name = map['title'] ?? '';
    value = map['value'] ?? '';
  }
}
