/// @desc   看板卡片中用于描述数据指标的模型，也能用于数据块的定义，内部嵌套了一个itemList



class DBDataNodeModel {
  String? key;
  String? name;
  String? value;
  String? unit;
  String? percent;
  String? order;

  /// If tip.isNullOrEmpty == false, a question icon will be displayed on right of the label.
  /// A tip pop window would be displayed when icon was clicked.
  String? tipTitle;

  List<String>? tipList;

  /// 1: up direction, green label, green arrow
  /// 0: gray label, no arrow
  /// -1: down direction, red label, red arrow
  int? trend;

  List<DBDataNodeModel>? itemList;

  /// section data field
  String? url;
  DBDataNodeModel? total;

  DBDataNodeModel();

  factory DBDataNodeModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return DBDataNodeModel();
    DBDataNodeModel entity = DBDataNodeModel();
    entity.name = json['name'] ?? "";
    entity.key = json['key'] ?? "";
    entity.value = json['value'] ?? "";
    return entity;
  }
}
