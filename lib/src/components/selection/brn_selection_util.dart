import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';
import 'package:bruno/src/utils/brn_tools.dart';

const double DESIGN_SELECTION_HEIGHT = 268;
const double DESIGN_BOTTOM_HEIGHT = 82;
const double DESIGN_SCREEN_HEIGHT = 812;

/// 筛选组件工具类
class BrnSelectionUtil {
  /// 处理兄弟结点为未选中状态，将自己置为选中状态
  static void processBrotherItemSelectStatus(
      BrnSelectionEntity selectionEntity) {
    if (BrnSelectionFilterType.checkbox == selectionEntity.filterType) {
      selectionEntity.isSelected = !selectionEntity.isSelected;
      List<BrnSelectionEntity>? allBrothers = selectionEntity.parent?.children;
      if (!BrunoTools.isEmpty(allBrothers)) {
        for (BrnSelectionEntity entity in allBrothers!) {
          if (entity != selectionEntity) {
            if (entity.filterType == BrnSelectionFilterType.radio) {
              entity.isSelected = false;
            }

            if (entity.filterType == BrnSelectionFilterType.date) {
              entity.isSelected = false;
              entity.value = null;
            }
          }
        }
      }
    }
    if (BrnSelectionFilterType.radio == selectionEntity.filterType) {
      selectionEntity.parent?.clearChildSelection();
      selectionEntity.isSelected = true;
    }

    if (BrnSelectionFilterType.date == selectionEntity.filterType) {
      selectionEntity.parent?.clearChildSelection();

      /// 日期类型时在外部 Picker 点击确定时设置 选中状态
      selectionEntity.isSelected = true;
    }
  }

  /// 筛选项最多不超过三层,故直接写代码判断,本质为深度优先搜索。
  static int getTotalLevel(BrnSelectionEntity entity) {
    int level = 0;
    BrnSelectionEntity rootEntity = entity;
    while (rootEntity.parent != null) {
      rootEntity = rootEntity.parent!;
    }

    if (rootEntity.children.isNotEmpty) {
      level = level > 1 ? level : 1;
      for (BrnSelectionEntity firstLevelEntity in rootEntity.children) {
        if (firstLevelEntity.children.isNotEmpty) {
          level = level > 2 ? level : 2;
          for (BrnSelectionEntity secondLevelEntity
              in firstLevelEntity.children) {
            if (secondLevelEntity.children.isNotEmpty) {
              level = 3;
              break;
            }
          }
        }
      }
    }
    return level;
  }

  /// 返回状态为选中的子节点
  static List<BrnSelectionEntity> currentSelectListForEntity(
      BrnSelectionEntity entity) {
    List<BrnSelectionEntity> list = [];
    for (BrnSelectionEntity entity in entity.children) {
      if (entity.isSelected) {
        list.add(entity);
      }
    }
    return list;
  }

  /// 判断列表中是否有range类型
  static bool hasRangeItem(List<BrnSelectionEntity> list) {
    for (BrnSelectionEntity entity in list) {
      if (BrnSelectionFilterType.range == entity.filterType ||
          BrnSelectionFilterType.dateRange == entity.filterType ||
          BrnSelectionFilterType.dateRangeCalendar == entity.filterType ||
          BrnSelectionWindowType.range == entity.filterShowType) {
        return true;
      }
    }
    return false;
  }

  /// 判断列表中是否有range类型
  static BrnSelectionEntity? getFilledCustomInputItem(
      List<BrnSelectionEntity> list) {
    BrnSelectionEntity? filledCustomInputItem;
    for (BrnSelectionEntity entity in list) {
      if (entity.isSelected &&
          (BrnSelectionFilterType.range == entity.filterType ||
              BrnSelectionFilterType.dateRange == entity.filterType ||
              BrnSelectionFilterType.dateRangeCalendar == entity.filterType) &&
          entity.customMap != null) {
        filledCustomInputItem = entity;
        break;
      }
      if (entity.children.isNotEmpty) {
        filledCustomInputItem = getFilledCustomInputItem(entity.children);
      }
      if (filledCustomInputItem != null) {
        break;
      }
    }
    return filledCustomInputItem;
  }

  /// 确定当前 Item 在第几层级
  static int getCurrentListIndex(BrnSelectionEntity? currentItem) {
    int listIndex = -1;
    if (currentItem != null) {
      listIndex = 0;
      var parent = currentItem.parent;
      while (parent != null) {
        listIndex++;
        parent = parent.parent;
      }
    }
    return listIndex;
  }

  ///
  /// [entity] 传入当前点击的 Item
  /// !!! 在设置 isSelected = true之前进行 check。
  /// 返回 true 符合条件，false 不符合条件
  static bool checkMaxSelectionCount(BrnSelectionEntity entity) {
    return entity.getLimitedRootSelectedChildCount() <
        entity.getLimitedRootMaxSelectedCount();
  }

  /// 设置数据为未选中状态
  static void resetSelectionDatas(BrnSelectionEntity entity) {
    entity.isSelected = false;
    entity.customMap = Map();
    for (BrnSelectionEntity subEntity in entity.children) {
      resetSelectionDatas(subEntity);
    }
  }
}
