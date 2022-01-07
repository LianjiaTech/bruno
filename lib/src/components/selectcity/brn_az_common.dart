import 'package:flutter/material.dart';

/// ISuspension Bean.
abstract class ISuspensionBean {
  bool isShowSuspension = false;
  String name = "";
  String tag = ""; //Suspension Tag
}

/// AzListView Header.
class AzListViewHeader {
  AzListViewHeader({
    required this.height,
    required this.builder,
    this.tag = "↑",
  });

  final int height;
  final String tag;
  final WidgetBuilder builder;
}

/// Suspension Util.
class SuspensionUtil {
  /// sort list  by suspension tag.
  /// 根据[A-Z]排序。
  static void sortListBySuspensionTag(List<ISuspensionBean>? list) {
    if (list == null || list.isEmpty) return;
    list.sort((a, b) {
      if (a.tag == "@" || b.tag == "#") {
        return -1;
      } else if (a.tag == "#" || b.tag == "@") {
        return 1;
      } else {
        return a.tag.compareTo(b.tag);
      }
    });
  }

  /// get index data list by suspension tag.
  /// 获取索引列表。
  static List<String> getTagIndexList(List<ISuspensionBean>? list) {
    List<String> indexData = [];
    if (list != null && list.isNotEmpty) {
      String? tempTag;
      for (int i = 0, length = list.length; i < length; i++) {
        String tag = list[i].tag;
        if (tag.length > 2) tag = tag.substring(0, 2);
        if (tempTag != tag) {
          indexData.add(tag);
          tempTag = tag;
        }
      }
    }
    return indexData;
  }

  /// set show suspension status.
  static void setShowSuspensionStatus(List<ISuspensionBean>? list) {
    if (list == null || list.isEmpty) return;
    String? tempTag;
    for (int i = 0, length = list.length; i < length; i++) {
      String? tag = list[i].tag;
      if (tempTag != tag) {
        tempTag = tag;
        list[i].isShowSuspension = true;
      } else {
        list[i].isShowSuspension = false;
      }
    }
  }
}
