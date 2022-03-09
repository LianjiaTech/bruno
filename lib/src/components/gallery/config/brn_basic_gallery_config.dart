import 'package:flutter/material.dart';

abstract class BrnBasicGroupConfig {
  /// 每一个组的标题
  String? title;

  List<BrnBasicItemConfig>? configList;

  BrnBasicGroupConfig({this.title, required this.configList});
}

/// 每一个 item 的配置接口，定制化的需求可以自己实现相关接口
abstract class BrnBasicItemConfig {
  /// 该配置的 groupIndex
  int? groupIndex;

  /// 该配置的 type 信息
  String? type;

  /// 构建查看详情页的 widget
  Widget buildDetailWidget(BuildContext context,
      List<BrnBasicGroupConfig> allConfig, int groupId, int index);

  /// 构建简略页的 widget
  Widget buildSummaryWidget(BuildContext context,
      List<BrnBasicGroupConfig> allConfig, int groupId, int index);
}
