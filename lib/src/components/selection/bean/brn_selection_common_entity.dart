import 'package:bruno/src/components/picker/time_picker/brn_date_picker_constants.dart';
import 'package:bruno/src/components/selection/brn_selection_util.dart';
import 'package:bruno/src/constants/brn_constants.dart';
import 'package:bruno/src/utils/brn_tools.dart';

enum BrnSelectionFilterType {
  /// 未设置
  None,

  /// 不限类型
  UnLimit,

  /// 单选列表、单选项 type 为 radio
  Radio,

  /// 多选列表、多选项 type 为 checkbox
  Checkbox,

  /// 一般的值范围自定义区间 type 为 range
  Range,

  /// 日期选择,普通筛选时使用 CalendarView 展示选择时间，更多情况下使用 DatePicker 选择时间
  Date,

  /// 自定义选择日期区间， type 为 dateRange
  DateRange,

  /// 自定义通过 Calendar 选择日期区间，type 为 dateRangeCalendar
  DateRangeCalendar,

  /// 标签筛选 type 为 customerTag
  CustomHandle,

  /// 更多列表、多选项 无 type
  More,

  /// 去二级页面
  Layer,

  /// 去自定义二级页面
  CustomLayer,
}

/// 筛选弹窗展示风格
enum BrnSelectionWindowType {
  /// 列表类型,使用列表 Item 展示
  List,

  /// 值范围类型,使用 Tag + Range 的 Item 展示
  Range,
}

class BrnSelectionEntity {

  /// 类型 是单选、复选还是有自定义输入
  String type;

  /// 回传给服务器的 key
  String key;

  /// 回传给服务器的 value
  String value;

  /// 默认值
  String defaultValue;

  /// 显示的文案
  String title;

  /// 显示的文案
  String subTitle;

  /// 单位。例如居室、万，适配自定义区间填写的内容
  String unit;

  /// 扩展字段，目前只有min和max
  Map extMap;

  /// 子筛选项
  List<BrnSelectionEntity> children;

  //////////// 以上为接口下发的原始数据字段 ///////////////

  //////////// 下方为组件另需要使用的字段 ///////////////
  /// 是否选中
  bool isSelected;

  /// 自定义输入
  Map<String, String> customMap;

  /// 用于临时存储原有自定义字段数据，在筛选数据变化后未点击【确定】按钮时还原。
  Map originalCustomMap;

  /// 最大可选数量
  int maxSelectedCount;

  /// 父级筛选项
  BrnSelectionEntity parent;

  /// 筛选类型，具体参见 [BrnSelectionFilterType]
  BrnSelectionFilterType filterType;

  /// 筛选弹窗展示风格对应的首字母小写的字符串，例如 `range`、`list`，参见 [BrnSelectionWindowType]
  String showType;

  /// 筛选弹窗展示风格，具体参见 [BrnSelectionWindowType]
  BrnSelectionWindowType filterShowType;

  /// 自定义标题
  String customTitle;

  ///自定义筛选的 title
  bool isCustomTitleHighLight;

  /// 临时字段用于判断是否要将筛选项 [name] 字段拼接展示
  bool canJoinTitle = false;

  BrnSelectionEntity(
      {
      this.key,
      this.value,
      this.defaultValue,
      this.title,
      this.subTitle,
      this.children,
      this.isSelected = false,
      this.unit,
      this.extMap,
      this.customMap,
      this.type,
      this.showType,
      this.maxSelectedCount}) {
    this.filterType = this.parserFilterTypeWithType(this.type);
    this.filterShowType = this.parserShowType(this.showType);
    this.originalCustomMap = Map();

    /// 默认支持最大选中个数为 65535
    this.maxSelectedCount = maxSelectedCount ?? BrnSelectionConstant.MAX_SELECT_COUNT;
  }

  /// 构造简单筛选数据
  BrnSelectionEntity.simple({
    this.key,
    this.value,
    this.title,
    this.type,
  }) {
    this.filterType = this.parserFilterTypeWithType(this.type);
    this.filterShowType = this.parserShowType(this.showType);
    this.originalCustomMap = Map();
    this.isSelected = false;

    /// 默认支持最大选中个数为 65535
    this.maxSelectedCount = maxSelectedCount ?? BrnSelectionConstant.MAX_SELECT_COUNT;
  }

  BrnSelectionEntity.fromJson(Map<String, dynamic> map) {
    if (map == null) return;
    title = map['title'] ?? "";
    subTitle = map['subTitle'] ?? "";
    key = map['key'] ?? "";
    type = map['type'] ?? "";
    defaultValue = map['defaultValue'] ?? "";
    value = map['value'] ?? "";
    if (map['maxSelectedCount'] != null && int.tryParse(map['maxSelectedCount']) != null) {
      maxSelectedCount = int.tryParse(map['maxSelectedCount']);
    } else {
      maxSelectedCount = BrnSelectionConstant.MAX_SELECT_COUNT;
    }
    extMap = map['ext'] ?? {};
    children = List()
      ..addAll((map['children'] as List ?? []).map((o) => BrnSelectionEntity.fromMap(o)));
    filterType = parserFilterTypeWithType(map['type'] ?? "");
    isSelected = false;
  }

  /// 建议使用上面构造函数[BrnSelectionEntity.fromJson]
  static BrnSelectionEntity fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BrnSelectionEntity entity = BrnSelectionEntity();
    entity.title = map['title'] ?? "";
    entity.subTitle = map['subTitle'] ?? "";
    entity.key = map['key'] ?? "";
    entity.type = map['type'] ?? "";
    entity.defaultValue = map['defaultValue'] ?? "";
    entity.value = map['value'] ?? "";
    if (map['maxSelectedCount'] != null && int.tryParse(map['maxSelectedCount']) != null) {
      entity.maxSelectedCount = int.tryParse(map['maxSelectedCount']);
    } else {
      entity.maxSelectedCount = BrnSelectionConstant.MAX_SELECT_COUNT;
    }
    entity.extMap = map['ext'] ?? {};
    entity.children = List()
      ..addAll((map['children'] as List ?? []).map((o) => BrnSelectionEntity.fromMap(o)));
    entity.filterType = entity.parserFilterTypeWithType(map['type'] ?? "");
    return entity;
  }
  
  void configRelationshipAndDefaultValue() {
    configRelationship();
    configDefaultValue();
  }
  
  void configRelationship() {
    if (this.children != null && this.children.length > 0) {
      for (BrnSelectionEntity entity in this.children) {
        entity.parent = this;
      }
      for (BrnSelectionEntity entity in this.children) {
        entity.configRelationship();
      }
    }
  }

  void configDefaultValue() {
    if (this.children != null && this.children.length > 0) {
      for (BrnSelectionEntity entity in this.children) {
        if (!BrunoTools.isEmpty(this.defaultValue)) {
          List<String> values = this.defaultValue.split(',');
          entity.isSelected = values != null && values.contains(entity.value);
        }
      }

      /// 当 default 不在普通 Item 类型中时，尝试填充 同级别 Range Item.
      if (children.where((_) => _.isSelected).toList().length == 0) {
        BrnSelectionEntity rangeEntity = this.children.firstWhere((_) {
          return (_.filterType == BrnSelectionFilterType.Range ||
              _.filterType == BrnSelectionFilterType.DateRange ||
              _.filterType == BrnSelectionFilterType.DateRangeCalendar);
        }, orElse: () {
          return null;
        });
        if (rangeEntity != null && !BrunoTools.isEmpty(this.defaultValue)) {
          List<String> values = this.defaultValue.split(':');
          if (values != null &&
              values.length == 2 &&
              int.tryParse(values[0]) != null &&
              int.tryParse(values[1]) != null) {
            rangeEntity.customMap = {};
            rangeEntity.customMap = {"min": values[0], "max": values[1]};
            rangeEntity.isSelected = true;
          }
        }
      }

      for (BrnSelectionEntity entity in this.children) {
        entity.configDefaultValue();
      }
      if (hasCheckBoxBrother()) {
        isSelected = children.where((_) => _.isSelected).length > 0;
      } else {
        isSelected = isSelected || children.where((_) => _.isSelected).length > 0;
      }
    }
  }

  BrnSelectionWindowType parserShowType(String showType) {
    if (showType == "list") {
      return BrnSelectionWindowType.List;
    } else if (showType == "range") {
      return BrnSelectionWindowType.Range;
    }
    return BrnSelectionWindowType.List;
  }

  BrnSelectionFilterType parserFilterTypeWithType(String type) {
    if (type == null) return BrnSelectionFilterType.None;
    if (type == 'unlimit') {
      return BrnSelectionFilterType.UnLimit;
    } else if (type == "radio") {
      return BrnSelectionFilterType.Radio;
    } else if (type == "checkbox") {
      return BrnSelectionFilterType.Checkbox;
    } else if (type == "range") {
      return BrnSelectionFilterType.Range;
    } else if (type == "customHandle") {
      return BrnSelectionFilterType.CustomHandle;
    } else if (type == "more") {
      return BrnSelectionFilterType.More;
    } else if (type == 'floatinglayer') {
      return BrnSelectionFilterType.Layer;
    } else if (type == 'customfloatinglayer') {
      return BrnSelectionFilterType.CustomLayer;
    } else if (type == 'date') {
      return BrnSelectionFilterType.Date;
    } else if (type == 'daterange') {
      return BrnSelectionFilterType.DateRange;
    } else if (type == 'daterangecalendar') {
      return BrnSelectionFilterType.DateRangeCalendar;
    }
    return BrnSelectionFilterType.None;
  }

  void clearChildSelection() {
    if (this.children != null && this.children.length > 0) {
      for (BrnSelectionEntity entity in this.children) {
        entity.isSelected = false;
        if (entity.filterType == BrnSelectionFilterType.Date) {
          entity.value = null;
        }
        if (entity.filterType == BrnSelectionFilterType.Range ||
            entity.filterType == BrnSelectionFilterType.DateRange ||
            entity.filterType == BrnSelectionFilterType.DateRangeCalendar) {
          entity.customMap = null;
        }
        entity.clearChildSelection();
      }
    }
  }

  List<BrnSelectionEntity> selectedLastColumnList() {
    List<BrnSelectionEntity> list = List();
    if (this.children != null && this.children.length > 0) {
      List<BrnSelectionEntity> firstList = List();
      for (BrnSelectionEntity firstEntity in this.children) {
        if (firstEntity != null &&
            firstEntity.children != null &&
            firstEntity.children.length > 0) {
          List<BrnSelectionEntity> secondList = List();
          for (BrnSelectionEntity secondEntity in firstEntity.children) {
            if (secondEntity != null &&
                secondEntity.children != null &&
                secondEntity.children.length > 0) {
              List<BrnSelectionEntity> thirds =
                  BrnSelectionUtil.currentSelectListForEntity(secondEntity);
              if (thirds.length > 0) {
                list.addAll(thirds);
              } else if (secondEntity.isSelected) {
                secondList.add(secondEntity);
              }
            } else if (secondEntity != null && secondEntity.isSelected) {
              secondList.add(secondEntity);
            }
          }
          list.addAll(secondList);
        } else if (firstEntity != null && firstEntity.isSelected) {
          firstList.add(firstEntity);
        }
      }
      list.addAll(firstList);
    }
    return list;
  }

  List<BrnSelectionEntity> selectedListWithoutUnlimit() {
    List<BrnSelectionEntity> selected = selectedList();
    return selected
            ?.where((_) => !_.isUnLimit())
            ?.where((_) =>
                (_.filterType != BrnSelectionFilterType.Range) ||
                (_.filterType == BrnSelectionFilterType.Range && !BrunoTools.isEmpty(_.customMap)))
            ?.where((_) =>
                (_.filterType != BrnSelectionFilterType.DateRange) ||
                (_.filterType == BrnSelectionFilterType.DateRange &&
                    !BrunoTools.isEmpty(_.customMap)))
            ?.where((_) =>
                (_.filterType != BrnSelectionFilterType.DateRangeCalendar) ||
                (_.filterType == BrnSelectionFilterType.DateRangeCalendar &&
                    !BrunoTools.isEmpty(_.customMap)))
            ?.toList() ??
        List();
  }

  List<BrnSelectionEntity> selectedList() {
    if (BrnSelectionFilterType.More == this.filterType) {
      return this.selectedLastColumnList();
    } else {
      List<BrnSelectionEntity> results = List();
      List<BrnSelectionEntity> firstColumn = BrnSelectionUtil.currentSelectListForEntity(this);
      results.addAll(firstColumn);
      if (firstColumn != null && firstColumn.length > 0) {
        for (BrnSelectionEntity firstEntity in firstColumn) {
          if (firstEntity != null) {
            List<BrnSelectionEntity> secondColumn =
                BrnSelectionUtil.currentSelectListForEntity(firstEntity);
            results.addAll(secondColumn);
            if (secondColumn != null && secondColumn.length > 0) {
              for (BrnSelectionEntity secondEntity in secondColumn) {
                List<BrnSelectionEntity> thirdColumn =
                    BrnSelectionUtil.currentSelectListForEntity(secondEntity);
                results.addAll(thirdColumn);
              }
            }
          }
        }
      }
      return results;
    }
  }

  List<BrnSelectionEntity> allSelectedList() {
    List<BrnSelectionEntity> results = List();
    List<BrnSelectionEntity> firstColumn = BrnSelectionUtil.currentSelectListForEntity(this);
    results.addAll(firstColumn);
    if (firstColumn != null && firstColumn.length > 0) {
      for (BrnSelectionEntity firstEntity in firstColumn) {
        if (firstEntity != null) {
          List<BrnSelectionEntity> secondColumn =
              BrnSelectionUtil.currentSelectListForEntity(firstEntity);
          results.addAll(secondColumn);
          if (secondColumn != null && secondColumn.length > 0) {
            for (BrnSelectionEntity secondEntity in secondColumn) {
              List<BrnSelectionEntity> thirdColumn =
                  BrnSelectionUtil.currentSelectListForEntity(secondEntity);
              results.addAll(thirdColumn);
            }
          }
        }
      }
    }
    return results;
  }

  int getLimitedRootSelectedChildCount() {
    return getSelectedChildCount(getRootEntity(this));
  }

  int getLimitedRootMaxSelectedCount() {
    return getRootEntity(this).maxSelectedCount;
  }

  BrnSelectionEntity getRootEntity(BrnSelectionEntity rootEntity) {
    if (rootEntity.parent == null ||
        rootEntity.parent.maxSelectedCount == BrnSelectionConstant.MAX_SELECT_COUNT) {
      return rootEntity;
    } else {
      return getRootEntity(rootEntity.parent);
    }
  }

  /// 返回最后一层级【选中状态】 Item 的 个数
  int getSelectedChildCount(BrnSelectionEntity entity) {
    if (BrunoTools.isEmpty(entity.children)) return entity.isSelected ? 1 : 0;

    int count = 0;
    for (BrnSelectionEntity child in entity.children) {
      count += getSelectedChildCount(child);
    }
    return count;
  }

  /// 判断当前的筛选 Item 是否为当前层次中第一个被选中的 Item。
  /// 用于展开筛选弹窗时显示选中效果。
  int getIndexInCurrentLevel() {
    if (parent == null || parent.children == null || parent.children.length == 0) return -1;

    for (BrnSelectionEntity entity in parent.children) {
      if (entity == this) {
        return parent.children.indexOf(entity);
      }
    }
    return -1;
  }

  /// 是否在筛选数据的最后一层。 如果最大层次为 3；某个筛选数据层次为 2，但其无子节点。此时认为不在最后一层。
  bool isInLastLevel() {
    if (parent == null || parent.children == null || parent.children.length == 0) return true;

    for (BrnSelectionEntity entity in parent.children) {
      if (entity.children != null && entity.children.length > 0) {
        return false;
      }
    }
    return true;
  }

  /// 检查自己的兄弟结点是否存在 checkbox 类型。
  bool hasCheckBoxBrother() {
    int count =
        parent?.children?.where((f) => f.filterType == BrnSelectionFilterType.Checkbox)?.length;
    return count == null ? false : count > 0;
  }

  /// 在这里简单认为 value 为空【null 或 ''】时为 unlimit.
  bool isUnLimit() {
    return filterType == BrnSelectionFilterType.UnLimit;
  }

  void clearSelectedEntity() {
    List<BrnSelectionEntity> tmp = List();
    BrnSelectionEntity node = this;
    tmp.add(node);
    while (tmp.isNotEmpty) {
      node = tmp.removeLast();
      node.isSelected = false;
      node.children?.forEach((data) {
        tmp.add(data);
      });
    }
  }

  List<BrnSelectionEntity> currentTagListForEntity() {
    List<BrnSelectionEntity> list = List();
    this.children?.forEach((data) {
      if (data.filterType != BrnSelectionFilterType.Range &&
          data.filterType != BrnSelectionFilterType.DateRange &&
          data.filterType != BrnSelectionFilterType.DateRangeCalendar) {
        list.add(data);
      }
    });
    return list;
  }

  List<BrnSelectionEntity> currentShowTagByExpanded(bool isExpanded) {
    List<BrnSelectionEntity> all = currentTagListForEntity();
    return isExpanded ? all : all.sublist(0, currentDefaultTagCountForEntity());
  }

  /// 最终显示tag个数
  int currentDefaultTagCountForEntity() {
    return currentTagListForEntity().length > getDefaultShowCount()
        ? getDefaultShowCount()
        : currentTagListForEntity().length;
  }

  /// 默认展示个数是否大于总tag个数
  bool isOverCurrentTagListSize() {
    return getDefaultShowCount() > currentTagListForEntity().length;
  }

  /// 接口返回默认展示tag个数
  int getDefaultShowCount() {
    int defaultCount = 3;
    if (extMap != null && extMap.containsKey('defaultShowCount')) {
      defaultCount = extMap['defaultShowCount'] ?? 3;
    }
    return defaultCount;
  }

  List<BrnSelectionEntity> currentRangeListForEntity() {
    List<BrnSelectionEntity> list = List();
    this.children.forEach((data) {
      if (data.filterType == BrnSelectionFilterType.Range ||
          data.filterType == BrnSelectionFilterType.DateRange ||
          data.filterType == BrnSelectionFilterType.DateRangeCalendar) {
        list.add(data);
      }
    });
    return list;
  }

  bool isValidRange() {
    if (this.filterType == BrnSelectionFilterType.Range ||
        this.filterType == BrnSelectionFilterType.DateRange ||
        this.filterType == BrnSelectionFilterType.DateRangeCalendar) {
      DateTime minTime = DateTime.parse(DATE_PICKER_MIN_DATETIME);
      DateTime maxTime = DateTime.parse(DATE_PICKER_MAX_DATETIME);
      int limitMin = int.tryParse(extMap['min']?.toString() ?? "") ??
          (this.filterType == BrnSelectionFilterType.DateRange ||
                  this.filterType == BrnSelectionFilterType.DateRangeCalendar
              ? minTime.millisecondsSinceEpoch
              : 0);
      // 日期最大值没设置 默认是2121年01月01日 08:00:00
      int limitMax = int.tryParse(extMap['max']?.toString() ?? "") ??
          (this.filterType == BrnSelectionFilterType.DateRange ||
                  this.filterType == BrnSelectionFilterType.DateRangeCalendar
              ? maxTime.millisecondsSinceEpoch
              : 9999);

      if (customMap != null && customMap.isNotEmpty) {
        String min = customMap['min'] ?? "";
        String max = customMap['max'] ?? "";
        if (min.isEmpty && max.isEmpty) {
          return true;
        }
        int inputMin = int.tryParse(customMap['min'] ?? "");
        int inputMax = int.tryParse(customMap['max'] ?? "");

        if (inputMax != null && inputMin != null) {
          if (inputMin >= limitMin && inputMax <= limitMax && inputMax >= inputMin) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      }
    }
    return true;
  }

  void reverseSelected() {
    this.isSelected = !isSelected;
  }

  int getFirstSelectedChildIndex() {
    return this.children.indexWhere((data) {
      return data.isSelected;
    });
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrnSelectionEntity &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          value == other.value &&
          defaultValue == other.defaultValue &&
          title == other.title &&
          children == other.children &&
          isSelected == other.isSelected &&
          unit == other.unit &&
          extMap == other.extMap &&
          customMap == other.customMap &&
          type == other.type &&
          parent == other.parent &&
          filterType == other.filterType;

  @override
  int get hashCode =>
      key.hashCode ^
      value.hashCode ^
      defaultValue.hashCode ^
      title.hashCode ^
      children.hashCode ^
      isSelected.hashCode ^
      unit.hashCode ^
      extMap.hashCode ^
      customMap.hashCode ^
      type.hashCode ^
      parent.hashCode ^
      filterType.hashCode;
}
