import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';
import 'package:bruno/src/components/selection/brn_selection_util.dart';
import 'package:bruno/src/utils/brn_tools.dart';

abstract class BrnSelectionConverterDelegate {
  /// 统一的数据结构 转换为 用户需要的数据结构，并通过 [BrnSelectionOnSelectionChanged] 回传给用户使用。
  Map<String, String> convertSelectedData(
      List<BrnSelectionEntity> selectedResults);
}

class DefaultSelectionConverter implements BrnSelectionConverterDelegate {
  const DefaultSelectionConverter();

  @override
  Map<String, String> convertSelectedData(
      List<BrnSelectionEntity> selectedResults) {
    return getSelectionParams(selectedResults);
  }
}

class DefaultMoreSelectionConverter implements BrnSelectionConverterDelegate {
  const DefaultMoreSelectionConverter();

  @override
  Map<String, String> convertSelectedData(
      List<BrnSelectionEntity> selectedResults) {
    return getSelectionParams(selectedResults);
  }
}

class DefaultSelectionQuickFilterConverter
    implements BrnSelectionConverterDelegate {
  const DefaultSelectionQuickFilterConverter();

  @override
  Map<String, String> convertSelectedData(
      List<BrnSelectionEntity> selectedResults) {
    return getSelectionParams(selectedResults);
  }
}

/// 注意，此方法仅在初始化筛选项之前调用。如果再筛选之后使用会影响筛选View 的展示以及筛选结果。
Map<String, String> getSelectionParamsWithConfigChild(
    List<BrnSelectionEntity>? selectedResults) {
  Map<String, String> params = Map();
  if (selectedResults == null) return params;
  selectedResults.forEach((f) => f.configRelationshipAndDefaultValue());
  return getSelectionParams(selectedResults);
}

Map<String, String> getSelectionParams(
    List<BrnSelectionEntity>? selectedResults) {
  Map<String, String> params = Map();
  if (selectedResults == null) return params;
  for (BrnSelectionEntity menuItemEntity in selectedResults) {
    if (menuItemEntity.filterType == BrnSelectionFilterType.more) {
      params.addAll(getSelectionParams(menuItemEntity.children));
    } else {
      /// 1、首先找出 自定义范围的筛选项参数。
      BrnSelectionEntity? selectedCustomInputItem =
          BrnSelectionUtil.getFilledCustomInputItem(menuItemEntity.children);
      if (selectedCustomInputItem != null &&
          !BrunoTools.isEmpty(selectedCustomInputItem.customMap)) {
        String? key = selectedCustomInputItem.parent?.key;
        if (!BrunoTools.isEmpty(key)) {
          params[key!] = (selectedCustomInputItem.customMap!["min"] ?? '') +
              ':' +
              (selectedCustomInputItem.customMap!["max"] ?? '');
        }
      }

      /// 2、一次找出层级为 1、2、3 的选中项的参数，递归不好阅读，直接写成 for 嵌套遍历。
      int levelCount = BrnSelectionUtil.getTotalLevel(menuItemEntity);
      if (levelCount == 1) {
        params.addAll(getCurrentSelectionEntityParams(menuItemEntity));
      } else if (levelCount == 2) {
        params.addAll(getCurrentSelectionEntityParams(menuItemEntity));
        menuItemEntity.children.forEach((firstLevelItem) =>
            params.addAll(getCurrentSelectionEntityParams(firstLevelItem)));
      } else if (levelCount == 3) {
        params.addAll(getCurrentSelectionEntityParams(menuItemEntity));
        menuItemEntity.children.forEach((firstLevelItem) {
          params.addAll(getCurrentSelectionEntityParams(firstLevelItem));
          firstLevelItem.children.forEach((secondLevelItem) {
            params.addAll(getCurrentSelectionEntityParams(secondLevelItem));
          });
        });
      }
    }
  }
  return params;
}

Map<String, String> getCurrentSelectionEntityParams(
    BrnSelectionEntity selectionEntity) {
  Map<String, String> params = Map();
  String? parentKey = selectionEntity.key;
  List<String?> selectedEntity = selectionEntity.children
      .where((BrnSelectionEntity f) => f.isSelected)
      .where((BrnSelectionEntity f) => !BrunoTools.isEmpty(f.value))
      .map((BrnSelectionEntity f) => f.value)
      .toList();
  String selectedParams =
      selectedEntity.isEmpty ? '' : selectedEntity.join(',');
  if (!BrunoTools.isEmpty(selectedParams) && !BrunoTools.isEmpty(parentKey)) {
    params[parentKey!] = selectedParams;
  }
  return params;
}
