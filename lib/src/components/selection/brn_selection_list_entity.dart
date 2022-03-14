import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';

class BrnSelectionEntityListBean {
  List<BrnSelectionEntity>? list;

  BrnSelectionEntityListBean(this.list);

  static BrnSelectionEntityListBean? fromJson(Map<String, dynamic>? map) {
    if (map == null || map['list'] == null) return null;
    BrnSelectionEntityListBean bean = BrnSelectionEntityListBean(null);
    bean.list = (map['list'] as List)
        .map((o) => BrnSelectionEntity.fromMap(o))
        .toList();
    return bean;
  }
}
