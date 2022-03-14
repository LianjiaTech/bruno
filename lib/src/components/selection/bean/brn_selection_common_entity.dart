import 'package:bruno/src/components/picker/time_picker/brn_date_picker_constants.dart';
import 'package:bruno/src/components/selection/brn_selection_util.dart';
import 'package:bruno/src/constants/brn_constants.dart';
import 'package:bruno/src/utils/brn_tools.dart';

enum BrnSelectionFilterType {
  /// 未设置
  none,

  /// 不限类型
  unLimit,

  /// 单选列表、单选项 type 为 radio
  radio,

  /// 多选列表、多选项 type 为 checkbox
  checkbox,

  /// 一般的值范围自定义区间 type 为 range
  range,

  /// 日期选择,普通筛选时使用 CalendarView 展示选择时间，更多情况下使用 DatePicker 选择时间
  date,

  /// 自定义选择日期区间， type 为 dateRange
  dateRange,

  /// 自定义通过 Calendar 选择日期区间，type 为 dateRangeCalendar
  dateRangeCalendar,

  /// 标签筛选 type 为 customerTag
  customHandle,

  /// 更多列表、多选项 无 type
  more,

  /// 去二级页面
  layer,

  /// 去自定义二级页面
  customLayer,
}

/// 筛选弹窗展示风格
enum BrnSelectionWindowType {
  /// 列表类型,使用列表 Item 展示
  list,

  /// 值范围类型,使用 Tag + Range 的 Item 展示
  range,
}

class BrnSelectionEntity {
  /// 类型 是单选、复选还是有自定义输入
  String? type;

  /// 回传给服务器的 key
  String? key;

  /// 回传给服务器的 value
  String? value;

  /// 默认值
  String? defaultValue;

  /// 显示的文案
  String title;

  /// 显示的文案
  String? subTitle;

  /// 扩展字段，目前只有min和max
  Map extMap;

  /// 子筛选项
  List<BrnSelectionEntity> children;

  //////////// 以上为接口下发的原始数据字段 ///////////////

  //////////// 下方为组件另需要使用的字段 ///////////////
  /// 是否选中
  bool isSelected;

  /// 自定义输入
  Map<String, String>? customMap;

  /// 用于临时存储原有自定义字段数据，在筛选数据变化后未点击【确定】按钮时还原。
  late Map originalCustomMap;

  /// 最大可选数量
  int maxSelectedCount;

  /// 父级筛选项
  BrnSelectionEntity? parent;

  /// 筛选类型，具体参见 [BrnSelectionFilterType]
  late BrnSelectionFilterType filterType;

  /// 筛选弹窗展示风格对应的首字母小写的字符串，例如 `range`、`list`，参见 [BrnSelectionWindowType]
  String? showType;

  /// 筛选弹窗展示风格，具体参见 [BrnSelectionWindowType]
  BrnSelectionWindowType? filterShowType;

  /// 自定义标题
  String? customTitle;

  ///自定义筛选的 title 是否高亮
  bool isCustomTitleHighLight;

  /// 临时字段用于判断是否要将筛选项 [name] 字段拼接展示
  bool canJoinTitle = false;

  BrnSelectionEntity(
      {this.key,
      this.value,
      this.defaultValue,
      this.title = '',
      this.subTitle,
      this.children = const [],
      this.isSelected = false,
      this.extMap = const {},
      this.customMap,
      this.type,
      this.showType,
      this.isCustomTitleHighLight = false,
      this.maxSelectedCount = BrnSelectionConstant.maxSelectCount}) {
    this.filterType = parserFilterTypeWithType(this.type);
    this.filterShowType = parserShowType(this.showType);
    this.originalCustomMap = Map();
  }

  /// 构造简单筛选数据
  BrnSelectionEntity.simple({
    this.key,
    this.value,
    this.title = '',
    this.type,
  })  : this.maxSelectedCount = BrnSelectionConstant.maxSelectCount,
        this.isCustomTitleHighLight = false,
        this.isSelected = false,
        this.children = [],
        this.extMap = {} {
    this.filterType = parserFilterTypeWithType(this.type);
    this.filterShowType = parserShowType(this.showType);
    this.originalCustomMap = Map();
    this.isSelected = false;
  }

  /// 建议使用 [BrnSelectionEntity.fromJson]
  static BrnSelectionEntity fromMap(Map<String, dynamic> map) {
    BrnSelectionEntity entity = BrnSelectionEntity();
    entity.title = map['title'] ?? '';
    entity.subTitle = map['subTitle'] ?? '';
    entity.key = map['key'] ?? '';
    entity.type = map['type'] ?? '';
    entity.defaultValue = map['defaultValue'] ?? "";
    entity.value = map['value'] ?? "";
    if (map['maxSelectedCount'] != null &&
        int.tryParse(map['maxSelectedCount']) != null) {
      entity.maxSelectedCount = int.tryParse(map['maxSelectedCount']) ??
          BrnSelectionConstant.maxSelectCount;
    } else {
      entity.maxSelectedCount = BrnSelectionConstant.maxSelectCount;
    }
    entity.extMap = map['ext'] ?? {};
    if (map['children'] != null && map['children'] is List) {
      entity.children = []..addAll(
          (map['children'] as List).map((o) => BrnSelectionEntity.fromMap(o)));
    }
    entity.filterType = entity.parserFilterTypeWithType(map['type'] ?? "");
    return entity;
  }

  BrnSelectionEntity.fromJson(Map<dynamic, dynamic>? map)
      : this.title = '',
        this.maxSelectedCount = BrnSelectionConstant.maxSelectCount,
        this.isCustomTitleHighLight = false,
        this.isSelected = false,
        this.children = [],
        this.extMap = {} {
    if (map == null) return;
    title = map['title'] ?? '';
    subTitle = map['subTitle'] ?? '';
    key = map['key'] ?? '';
    type = map['type'] ?? '';
    defaultValue = map['defaultValue'] ?? '';
    value = map['value'] ?? '';
    if (map['maxSelectedCount'] != null &&
        int.tryParse(map['maxSelectedCount']) != null) {
      maxSelectedCount = int.tryParse(map['maxSelectedCount']) ??
          BrnSelectionConstant.maxSelectCount;
    }
    extMap = map['ext'] ?? {};
    children = []..addAll(
        (map['children'] ?? []).map((o) => BrnSelectionEntity.fromJson(o)));
    filterType = parserFilterTypeWithType(map['type'] ?? '');
    isSelected = false;
  }

  void configRelationshipAndDefaultValue() {
    configRelationship();
    configDefaultValue();
  }

  void configRelationship() {
    if (children.length > 0) {
      for (BrnSelectionEntity entity in children) {
        entity.parent = this;
      }
      for (BrnSelectionEntity entity in children) {
        entity.configRelationship();
      }
    }
  }

  void configDefaultValue() {
    if (children.length > 0) {
      for (BrnSelectionEntity entity in children) {
        if (!BrunoTools.isEmpty(defaultValue)) {
          List<String> values = defaultValue!.split(',');
          entity.isSelected = values.contains(entity.value);
        }
      }

      /// 当 default 不在普通 Item 类型中时，尝试填充 同级别 Range Item.
      if (children.where((_) => _.isSelected).toList().length == 0) {
        List<BrnSelectionEntity> rangeItems = this.children.where((_) {
          return (_.filterType == BrnSelectionFilterType.range ||
              _.filterType == BrnSelectionFilterType.dateRange ||
              _.filterType == BrnSelectionFilterType.dateRangeCalendar);
        }).toList();
        BrnSelectionEntity? rangeEntity;
        if (rangeItems.isNotEmpty) {
          rangeEntity = rangeItems[0];
        }
        if (rangeEntity != null && !BrunoTools.isEmpty(defaultValue)) {
          List<String> values = defaultValue!.split(':');
          if (values.length == 2 &&
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
        isSelected =
            isSelected || children.where((_) => _.isSelected).length > 0;
      }
    }
  }

  BrnSelectionWindowType parserShowType(String? showType) {
    if (showType == "list") {
      return BrnSelectionWindowType.list;
    } else if (showType == "range") {
      return BrnSelectionWindowType.range;
    }
    return BrnSelectionWindowType.list;
  }

  BrnSelectionFilterType parserFilterTypeWithType(String? type) {
    if (type == 'unlimit') {
      return BrnSelectionFilterType.unLimit;
    } else if (type == "radio") {
      return BrnSelectionFilterType.radio;
    } else if (type == "checkbox") {
      return BrnSelectionFilterType.checkbox;
    } else if (type == "range") {
      return BrnSelectionFilterType.range;
    } else if (type == "customHandle") {
      return BrnSelectionFilterType.customHandle;
    } else if (type == "more") {
      return BrnSelectionFilterType.more;
    } else if (type == 'floatinglayer') {
      return BrnSelectionFilterType.layer;
    } else if (type == 'customfloatinglayer') {
      return BrnSelectionFilterType.customLayer;
    } else if (type == 'date') {
      return BrnSelectionFilterType.date;
    } else if (type == 'daterange') {
      return BrnSelectionFilterType.dateRange;
    } else if (type == 'daterangecalendar') {
      return BrnSelectionFilterType.dateRangeCalendar;
    }
    return BrnSelectionFilterType.none;
  }

  void clearChildSelection() {
    if (children.length > 0) {
      for (BrnSelectionEntity entity in children) {
        entity.isSelected = false;
        if (entity.filterType == BrnSelectionFilterType.date) {
          entity.value = null;
        }
        if (entity.filterType == BrnSelectionFilterType.range ||
            entity.filterType == BrnSelectionFilterType.dateRange ||
            entity.filterType == BrnSelectionFilterType.dateRangeCalendar) {
          entity.customMap = Map();
        }
        entity.clearChildSelection();
      }
    }
  }

  List<BrnSelectionEntity> selectedLastColumnList() {
    List<BrnSelectionEntity> list = [];
    if (this.children.length > 0) {
      List<BrnSelectionEntity> firstList = [];
      for (BrnSelectionEntity firstEntity in this.children) {
        if (firstEntity.children.length > 0) {
          List<BrnSelectionEntity> secondList = [];
          for (BrnSelectionEntity secondEntity in firstEntity.children) {
            if (secondEntity.children.length > 0) {
              List<BrnSelectionEntity> thirds =
                  BrnSelectionUtil.currentSelectListForEntity(secondEntity);
              if (thirds.length > 0) {
                list.addAll(thirds);
              } else if (secondEntity.isSelected) {
                secondList.add(secondEntity);
              }
            } else if (secondEntity.isSelected) {
              secondList.add(secondEntity);
            }
          }
          list.addAll(secondList);
        } else if (firstEntity.isSelected) {
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
        .where((_) => !_.isUnLimit())
        .where((_) =>
            (_.filterType != BrnSelectionFilterType.range) ||
            (_.filterType == BrnSelectionFilterType.range &&
                !BrunoTools.isEmpty(_.customMap)))
        .where((_) =>
            (_.filterType != BrnSelectionFilterType.dateRange) ||
            (_.filterType == BrnSelectionFilterType.dateRange &&
                !BrunoTools.isEmpty(_.customMap)))
        .where((_) =>
            (_.filterType != BrnSelectionFilterType.dateRangeCalendar) ||
            (_.filterType == BrnSelectionFilterType.dateRangeCalendar &&
                !BrunoTools.isEmpty(_.customMap)))
        .toList();
  }

  List<BrnSelectionEntity> selectedList() {
    if (BrnSelectionFilterType.more == this.filterType) {
      return this.selectedLastColumnList();
    } else {
      List<BrnSelectionEntity> results = [];
      List<BrnSelectionEntity> firstColumn =
          BrnSelectionUtil.currentSelectListForEntity(this);
      results.addAll(firstColumn);
      if (firstColumn.length > 0) {
        for (BrnSelectionEntity firstEntity in firstColumn) {
          List<BrnSelectionEntity> secondColumn =
              BrnSelectionUtil.currentSelectListForEntity(firstEntity);
          results.addAll(secondColumn);
          if (secondColumn.length > 0) {
            for (BrnSelectionEntity secondEntity in secondColumn) {
              List<BrnSelectionEntity> thirdColumn =
                  BrnSelectionUtil.currentSelectListForEntity(secondEntity);
              results.addAll(thirdColumn);
            }
          }
        }
      }
      return results;
    }
  }

  List<BrnSelectionEntity> allSelectedList() {
    List<BrnSelectionEntity> results = [];
    List<BrnSelectionEntity> firstColumn =
        BrnSelectionUtil.currentSelectListForEntity(this);
    results.addAll(firstColumn);
    if (firstColumn.length > 0) {
      for (BrnSelectionEntity firstEntity in firstColumn) {
        List<BrnSelectionEntity> secondColumn =
            BrnSelectionUtil.currentSelectListForEntity(firstEntity);
        results.addAll(secondColumn);
        if (secondColumn.length > 0) {
          for (BrnSelectionEntity secondEntity in secondColumn) {
            List<BrnSelectionEntity> thirdColumn =
                BrnSelectionUtil.currentSelectListForEntity(secondEntity);
            results.addAll(thirdColumn);
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
        rootEntity.parent!.maxSelectedCount ==
            BrnSelectionConstant.maxSelectCount) {
      return rootEntity;
    } else {
      return getRootEntity(rootEntity.parent!);
    }
  }

  /// 返回最后一层级【选中状态】 Item 的 个数
  int getSelectedChildCount(BrnSelectionEntity entity) {
    if (BrunoTools.isEmpty(entity.children)) {
      return entity.isSelected ? 1 : 0;
    }

    int count = 0;
    for (BrnSelectionEntity child in entity.children) {
      count += getSelectedChildCount(child);
    }
    return count;
  }

  /// 判断当前的筛选 Item 是否为当前层次中第一个被选中的 Item。
  /// 用于展开筛选弹窗时显示选中效果。
  int getIndexInCurrentLevel() {
    if (parent == null || parent!.children.length == 0) return -1;

    for (BrnSelectionEntity entity in parent!.children) {
      if (entity == this) {
        return parent!.children.indexOf(entity);
      }
    }
    return -1;
  }

  /// 是否在筛选数据的最后一层。 如果最大层次为 3；某个筛选数据层次为 2，但其无子节点。此时认为不在最后一层。
  bool isInLastLevel() {
    if (parent == null || parent!.children.length == 0) return true;

    for (BrnSelectionEntity entity in parent!.children) {
      if (entity.children.length > 0) {
        return false;
      }
    }
    return true;
  }

  /// 检查自己的兄弟结点是否存在 checkbox 类型。
  bool hasCheckBoxBrother() {
    int? count = parent?.children
        .where((f) => f.filterType == BrnSelectionFilterType.checkbox)
        .length;
    return count == null ? false : count > 0;
  }

  /// 在这里简单认为 value 为空【null 或 ''】时为 unlimit.
  bool isUnLimit() {
    return filterType == BrnSelectionFilterType.unLimit;
  }

  void clearSelectedEntity() {
    List<BrnSelectionEntity> tmp = [];
    BrnSelectionEntity node = this;
    tmp.add(node);
    while (tmp.isNotEmpty) {
      node = tmp.removeLast();
      node.isSelected = false;
      node.children.forEach((data) {
        tmp.add(data);
      });
    }
  }

  List<BrnSelectionEntity> currentTagListForEntity() {
    List<BrnSelectionEntity> list = [];
    children.forEach((data) {
      if (data.filterType != BrnSelectionFilterType.range &&
          data.filterType != BrnSelectionFilterType.dateRange &&
          data.filterType != BrnSelectionFilterType.dateRangeCalendar) {
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
    if (extMap.containsKey('defaultShowCount')) {
      defaultCount = extMap['defaultShowCount'] ?? 3;
    }
    return defaultCount;
  }

  List<BrnSelectionEntity> currentRangeListForEntity() {
    List<BrnSelectionEntity> list = [];
    children.forEach((data) {
      if (data.filterType == BrnSelectionFilterType.range ||
          data.filterType == BrnSelectionFilterType.dateRange ||
          data.filterType == BrnSelectionFilterType.dateRangeCalendar) {
        list.add(data);
      }
    });
    return list;
  }

  bool isValidRange() {
    if (this.filterType == BrnSelectionFilterType.range ||
        this.filterType == BrnSelectionFilterType.dateRange ||
        this.filterType == BrnSelectionFilterType.dateRangeCalendar) {
      DateTime minTime = DateTime.parse(datePickerMinDatetime);
      DateTime maxTime = DateTime.parse(datePickerMaxDatetime);
      int limitMin = int.tryParse(extMap['min']?.toString() ?? "") ??
          (this.filterType == BrnSelectionFilterType.dateRange ||
                  this.filterType == BrnSelectionFilterType.dateRangeCalendar
              ? minTime.millisecondsSinceEpoch
              : 0);
      // 日期最大值没设置 默认是2121年01月01日 08:00:00
      int limitMax = int.tryParse(extMap['max']?.toString() ?? "") ??
          (this.filterType == BrnSelectionFilterType.dateRange ||
                  this.filterType == BrnSelectionFilterType.dateRangeCalendar
              ? maxTime.millisecondsSinceEpoch
              : 9999);

      if (customMap != null && customMap!.isNotEmpty) {
        String min = customMap!['min'] ?? "";
        String max = customMap!['max'] ?? "";
        if (min.isEmpty && max.isEmpty) {
          return true;
        }
        int? inputMin = int.tryParse(customMap!['min'] ?? "");
        int? inputMax = int.tryParse(customMap!['max'] ?? "");

        if (inputMax != null && inputMin != null) {
          if (inputMin >= limitMin &&
              inputMax <= limitMax &&
              inputMax >= inputMin) {
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
    return children.indexWhere((data) {
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
      extMap.hashCode ^
      customMap.hashCode ^
      type.hashCode ^
      parent.hashCode ^
      filterType.hashCode;
}
