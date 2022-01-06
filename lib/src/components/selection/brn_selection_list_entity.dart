import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';

class BrnSelectionEntityListBean {
  List<BrnSelectionEntity>? list;

  BrnSelectionEntityListBean(this.list);

  static BrnSelectionEntityListBean? fromJson(Map<String, dynamic>? map) {
    if (map == null) return null;
    BrnSelectionEntityListBean bean =
        BrnSelectionEntityListBean((map['list'] ?? []).map((o) => BrnSelectionEntity.fromJson(o)));
    return bean;
  }
}
