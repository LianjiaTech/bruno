import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';
import 'package:bruno/src/components/selection/brn_selection_util.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_common_item_widget.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_list_widget.dart';
import 'package:bruno/src/components/toast/brn_toast.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BrnSelectionSingleListWidget extends StatefulWidget {
  List<BrnSelectionEntity> _selectedItems;
  int focusedIndex = -1;
  List<BrnSelectionEntity> items;
  Color backgroundColor;
  Color selectedBackgroundColor;
  int flex;
  SingleListItemSelect singleListItemSelect;
  int currentListIndex;
  double maxHeight;
  BrnSelectionConfig themeData;

  BrnSelectionSingleListWidget({
    @required this.items,
    this.maxHeight = 0,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.flex,
    this.focusedIndex,
    this.singleListItemSelect,
    this.themeData,
  }) {
    if (items == null) {
      items = List();
    } else {
      /// 自定义 Item 不在 list 样式中显示
      items = items
          .where((_) =>
              _.filterType != BrnSelectionFilterType.Range &&
              _.filterType != BrnSelectionFilterType.Date &&
              _.filterType != BrnSelectionFilterType.DateRange &&
              _.filterType != BrnSelectionFilterType.DateRangeCalendar)
          .toList();
    }

    /// 当前 Items 所在的层级
    currentListIndex = BrnSelectionUtil.getCurrentListIndex(items.length > 0 ? items[0] : null);

    _selectedItems = items?.where((f) => f.isSelected)?.toList();
    if (_selectedItems == null) {
      _selectedItems = List();
    }
  }

  @override
  _BrnSelectionSingleListWidgetState createState() => _BrnSelectionSingleListWidgetState();

  List<BrnSelectionEntity> getSelectedItems() {
    return _selectedItems;
  }
}

class _BrnSelectionSingleListWidgetState extends State<BrnSelectionSingleListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Container(
        constraints: (widget.maxHeight == null || widget.maxHeight == 0)
            ? BoxConstraints.expand()
            : BoxConstraints(maxHeight: widget.maxHeight),
        color: widget.backgroundColor,
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 0),
          scrollDirection: Axis.vertical,
          itemCount: widget.items.length,
          separatorBuilder: (BuildContext context, int index) => Container(),
          itemBuilder: (BuildContext context, int index) {
            BrnSelectionEntity item = widget.items[index];

            /// 点击筛选，展开弹窗时，默认展示上次选中的筛选项。
            bool isCurrentFocused = isItemFocused(index, item);

            return BrnSelectionCommonItemWidget(
              item: item,
              themeData: widget.themeData,
              backgroundColor: widget.backgroundColor,
              selectedBackgroundColor: widget.selectedBackgroundColor,
              isCurrentFocused: isCurrentFocused,
              isMoreSelectionListType: false,
              isFirstLevel: (1 == widget.currentListIndex) ? true : false,
              itemSelectFunction: (BrnSelectionEntity entity) {
                if ((entity.filterType == BrnSelectionFilterType.Checkbox && !entity.isSelected) ||
                    entity.filterType != BrnSelectionFilterType.Checkbox) {
                  if (entity.hasCheckBoxBrother()) {
                    if (entity.isUnLimit() &&
                            entity.parent.children.where((f) => f.isSelected).length > 0 ||
                        entity.parent.children.where((f) => f.isSelected && f.isUnLimit()).length >
                            0) {
                      ///点击的是不限类型，且不限类型同级别已经有选中的 Item 则不用检查数量。
                      /// 不限类型已经选中，选择非不限类型时，什么也不做，
                    } else if (entity.isInLastLevel() &&
                        !BrnSelectionUtil.checkMaxSelectionCount(entity)) {
                      BrnToast.show("您选择的筛选条件数量已达上限", context);
                      return;
                    }
                  } else {
                    if (!BrnSelectionUtil.checkMaxSelectionCount(entity)) {
                      BrnToast.show("您选择的筛选条件数量已达上限", context);
                      return;
                    }
                  }
                }
                _processFilterData(entity);
                widget.singleListItemSelect(widget.currentListIndex, index, entity);
              },
            );
          },
        ),
      ),
    );
  }

  bool isItemFocused(int itemIndex, BrnSelectionEntity item) {
    bool isFocused = widget.focusedIndex == itemIndex;
    if (!isFocused && item.isSelected && item.isInLastLevel()) {
      isFocused = true;
    }
    return isFocused;
  }

  /// Item 点击之后的数据处理
  void _processFilterData(BrnSelectionEntity selectedEntity) {
    if (null == selectedEntity) {
      return;
    }

    int totalLevel = BrnSelectionUtil.getTotalLevel(selectedEntity);
    if (selectedEntity.isUnLimit()) {
      selectedEntity.parent.clearChildSelection();
    }

    /// 设置选中数据。
    /// 当选中的数据不是最后一列时，相当于不选中数据
    /// 当选中为不限类型时，不再设置选中状态。
    if (totalLevel == 1) {
      configOneLevelList(selectedEntity);
    } else {
      configMultiLevelList(selectedEntity, widget.currentListIndex);
    }

    /// Warning !!!
    /// （两列、三列时）第一列节点是否被选中取决于它的子节点是否被选中，
    /// 只有当它子节点被选中时才会认为第一列的节点相应被选中。
    if (widget.items != null && widget.items.length > 0) {
      widget.items[0].parent?.isSelected =
          widget.items[0].parent.children.where((BrnSelectionEntity f) => f.isSelected).length > 0;
    }

    for (BrnSelectionEntity item in widget.items) {
      if (item.isSelected) {
        if (!widget._selectedItems.contains(item)) {
          widget._selectedItems.add(item);
        }
      } else {
        if (widget._selectedItems.contains(item)) {
          widget._selectedItems.remove(item);
        }
      }
    }
  }

  void configOneLevelList(BrnSelectionEntity selectedEntity) {
    if (BrnSelectionFilterType.Radio == selectedEntity.filterType) {
      /// 单选，清除同一级别选中的状态，则其他的设置为未选中。
      selectedEntity.parent.clearChildSelection();
      selectedEntity.isSelected = true;
    } else if (BrnSelectionFilterType.Checkbox == selectedEntity.filterType) {
      /// 选中【不限】清除同一级别其他的状态
      if (selectedEntity.isUnLimit()) {
        selectedEntity.parent.clearChildSelection();
        selectedEntity.isSelected = true;
      } else {
        ///清除【不限】类型。
        var brotherItems;
        if (selectedEntity.parent == null) {
          brotherItems = widget.items;
        } else {
          brotherItems = selectedEntity.parent.children;
        }
        for (BrnSelectionEntity entity in brotherItems) {
          if (entity.isUnLimit()) {
            entity.isSelected = false;
          }
        }
        selectedEntity.isSelected = !selectedEntity.isSelected;
      }
    }
  }

  void configMultiLevelList(BrnSelectionEntity selectedEntity, int currentListIndex) {
    /// 单选，清除同一级别选中的状态，则其他的设置为未选中。
    if (BrnSelectionFilterType.Radio == selectedEntity.filterType) {
      selectedEntity.parent?.children?.where((f) => f != selectedEntity)?.forEach((f) {
        f.clearChildSelection();
        f.isSelected = false;
      });
      selectedEntity.isSelected = true;
    } else if (BrnSelectionFilterType.Checkbox == selectedEntity.filterType) {
      /// 选中【不限】清除同一级别其他的状态
      if (selectedEntity.isUnLimit()) {
        selectedEntity.parent?.children?.where((f) => f != selectedEntity)?.forEach((f) {
          f.clearChildSelection();
          f.isSelected = false;
        });
        selectedEntity.isSelected = true;
      } else {
        ///清除【不限】类型。
        var brotherItems;
        if (selectedEntity.parent == null) {
          brotherItems = widget.items;
        } else {
          brotherItems = selectedEntity.parent.children;
        }
        for (BrnSelectionEntity entity in brotherItems) {
          if (entity.isUnLimit()) {
            entity.clearChildSelection();
            entity.isSelected = false;
          }
        }
        selectedEntity.isSelected = !selectedEntity.isSelected;
      }
    }
  }
}
