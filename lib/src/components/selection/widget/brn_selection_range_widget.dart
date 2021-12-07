import 'dart:ui';

import 'package:bruno/src/components/button/brn_big_main_button.dart';
import 'package:bruno/src/components/calendar/brn_calendar_view.dart';
import 'package:bruno/src/components/line/brn_line.dart';
import 'package:bruno/src/components/picker/time_picker/brn_date_time_formatter.dart';
import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';
import 'package:bruno/src/components/selection/brn_selection_util.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_date_range_item_widget.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_menu_widget.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_range_input_item_widget.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_range_tag_widget.dart';
import 'package:bruno/src/components/tabbar/normal/brn_tab_bar.dart';
import 'package:bruno/src/components/toast/brn_toast.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:bruno/src/utils/brn_event_bus.dart';
import 'package:bruno/src/utils/brn_text_util.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef void BrnOnRangeSelectionBgClick();

// ignore: must_be_immutable
class BrnRangeSelectionGroupWidget extends StatefulWidget {
  static final double screenWidth = window.physicalSize.width / window.devicePixelRatio;

  final BrnSelectionEntity entity;
  final double maxContentHeight;
  final bool showSelectedCount;
  final BrnOnRangeSelectionBgClick bgClickFunction;
  final BrnOnRangeSelectionConfirm onSelectionConfirm;

  final int rowount;

  final double marginTop;

  BrnSelectionConfig themeData;

  BrnRangeSelectionGroupWidget(
      {Key key,
      @required this.entity,
      this.maxContentHeight = DESIGN_SELECTION_HEIGHT,
      this.rowount,
      this.showSelectedCount = false,
      this.bgClickFunction,
      this.onSelectionConfirm,
      this.marginTop = 0,
      this.themeData});

  @override
  _BrnRangeSelectionGroupWidgetState createState() => _BrnRangeSelectionGroupWidgetState();
}

class _BrnRangeSelectionGroupWidgetState extends State<BrnRangeSelectionGroupWidget>
    with SingleTickerProviderStateMixin {
  List<BrnSelectionEntity> _originalSelectedItemsList = List();
  List<BrnSelectionEntity> _firstList = List();
  List<BrnSelectionEntity> _secondList = List();
  int _firstIndex;
  int _secondIndex;
  int totalLevel = 0;

  TabController _tabController;
  List<Widget> tabs;

  TextEditingController _minTextEditingController = TextEditingController();
  TextEditingController _maxTextEditingController = TextEditingController();

  bool _isConfirmClick = false;

  @override
  void initState() {
    _initData();
    _tabController = TabController(vsync: this, length: _firstList.length);
    if (_firstIndex >= 0) {
      _tabController.index = _firstIndex;
    }
    _tabController.addListener(() {
      _clearAllSelectedItems();
      clearNotTagItem(totalLevel == 1 ? _firstList : _firstList[_tabController.index].children);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    if (!_isConfirmClick) {
      _resetSelectionDatas(widget.entity);
      clearNotTagItem(totalLevel == 1 ? _firstList : _firstList[_tabController.index].children);
      _resetCustomMapData();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    totalLevel = BrnSelectionUtil.getTotalLevel(widget.entity);
    return GestureDetector(
      onTap: () {
        _backgroundTap();
      },
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: Column(
            children: _configWidgets(),
          ),
        ),
      ),
    );
  }

  //pragma mark -- config widgets

  List<Widget> _configWidgets() {
    List<Widget> widgetList = List();
    widgetList.add(_listWidget());
    return widgetList;
  }

  Widget _listWidget() {
    Widget rangeWidget;

    if (_firstList != null && _secondList == null) {
      /// 1、仅有一级的情况
      /// 1.2 一级多选 || 存在自定义范围的情况
      rangeWidget = _createNewTagAndRangeWidget(_firstList, null, Colors.white);
    } else if (_firstList != null && _secondList != null) {
      /// 2、有二级的情况
      rangeWidget = _createNewTagAndRangeWidget(_firstList, _secondList, Colors.white);
    }

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      constraints: hasCalendarItem(widget.entity)
          ? BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.bottom -
                  widget.marginTop)
          : BoxConstraints(maxHeight: widget.maxContentHeight + DESIGN_BOTTOM_HEIGHT),
      child: rangeWidget,
    );
  }

  Widget _createNewTagAndRangeWidget(
      List<BrnSelectionEntity> firstList, List<BrnSelectionEntity> secondList, Color white) {
    if (firstList != null && BrnSelectionUtil.getTotalLevel(widget.entity) == 1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child:
                  Column(mainAxisSize: MainAxisSize.min, children: getOneTabContent(widget.entity)),
            ),
          ),
          BrnLine(
            height: 0.5,
          ),
          _bottomWidget()
        ],
      );
    } else if (firstList != null && BrnSelectionUtil.getTotalLevel(widget.entity) == 2) {
      var tabBar = BrnTabBar(
        tabHeight: 50,
        controller: _tabController,
        tabs: firstList.map((f) => BadgeTab(text: f.title)).toList(),
      );
      var tabContent = SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: getOneTabContent(firstList[_tabController.index])));

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          tabBar,
          Flexible(
            child: tabContent,
          ),
          BrnLine(
            height: 0.5,
          ),
          _bottomWidget()
        ],
      );
    } else {
      return Container();
    }
  }

  List<Widget> getOneTabContent(BrnSelectionEntity filterItem) {
    List<BrnSelectionEntity> subFilterList = filterItem.children;

    /// TODO 还要添加 Date  DateRange 类型的判断。
    List<BrnSelectionEntity> tagFilterList = subFilterList
        .where((f) =>
            f.filterType != BrnSelectionFilterType.Range &&
            f.filterType != BrnSelectionFilterType.Date &&
            f.filterType != BrnSelectionFilterType.DateRange &&
            f.filterType != BrnSelectionFilterType.DateRangeCalendar)
        .toList();
    Size maxWidthSize;
    for (BrnSelectionEntity entity in subFilterList) {
      Size size = BrnTextUtil.textSize(
          entity.title, widget.themeData.tagNormalTextStyle.generateTextStyle());
      if (maxWidthSize == null) {
        maxWidthSize = size;
      } else {
        if (maxWidthSize.width < size.width) {
          maxWidthSize = size;
        }
      }
    }

    int tagWidth;

    ///如果指定展示列，则按照指定列展示，否则动态计算宽度。最大不超过四列。
    if (widget.rowount == null) {
      int oneCountTagWidth = (BrnRangeSelectionGroupWidget.screenWidth - 40 - 12 * (1 - 1)) ~/ 1;
      int twoCountTagWidth = (BrnRangeSelectionGroupWidget.screenWidth - 40 - 12 * (2 - 1)) ~/ 2;
      int threeCountTagWidth = (BrnRangeSelectionGroupWidget.screenWidth - 40 - 12 * (3 - 1)) ~/ 3;
      int fourCountTagWidth = (BrnRangeSelectionGroupWidget.screenWidth - 40 - 12 * (4 - 1)) ~/ 4;
      if (maxWidthSize.width > twoCountTagWidth) {
        tagWidth = oneCountTagWidth;
      } else if (threeCountTagWidth < maxWidthSize.width &&
          maxWidthSize.width <= twoCountTagWidth) {
        tagWidth = twoCountTagWidth;
      } else if (fourCountTagWidth < maxWidthSize.width &&
          maxWidthSize.width <= threeCountTagWidth) {
        tagWidth = threeCountTagWidth;
      } else {
        tagWidth = fourCountTagWidth;
      }
    } else {
      tagWidth = (BrnRangeSelectionGroupWidget.screenWidth - 40 - 12 * (widget.rowount - 1)) ~/
          widget.rowount;
    }

    var tagContainer = (tagFilterList?.length ?? 0) > 0
        ? Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: BrnSelectionRangeTagWidget(
                tagWidth: tagWidth,
                tagFilterList: tagFilterList,
                initFocusedindex: getInitFocusedIndex(subFilterList),
                themeData: widget.themeData,
                onSelect: (index, isSelected) {
                  setState(() {
                    _setFirstIndex(_tabController.index);
                    _setSecondIndex(index);
                    clearNotTagItem(
                        totalLevel == 1 ? _firstList : _firstList[_tabController.index].children);
                    _clearEditRangeText();
                  });
                }),
          )
        : Container();

    var content;
    for (BrnSelectionEntity item in subFilterList) {
      if (item.filterType == BrnSelectionFilterType.Range) {
        content = BrnSelectionRangeItemWidget(
            item: item,
            minTextEditingController: _minTextEditingController,
            maxTextEditingController: _maxTextEditingController,
            themeData: widget.themeData,
            onFocusChanged: (bool focus) {
              item.isSelected = focus;
              if (focus) {
                setState(() {
                  clearTagSelectStatus(subFilterList);
                });
              }
            });
        break;
      } else if (item.filterType == BrnSelectionFilterType.DateRange) {
        content = BrnSelectionDateRangeItemWidget(
            item: item,
            minTextEditingController: _minTextEditingController,
            maxTextEditingController: _maxTextEditingController,
            themeData: widget.themeData,
            onTapped: () {
              setState(() {
                clearTagSelectStatus(subFilterList);
              });
            });
        break;
      } else if (item.filterType == BrnSelectionFilterType.Date) {
        DateTime initialStartDate = DateTimeFormatter.convertIntValueToDateTime(item.value);
        DateTime initialEndDate = DateTimeFormatter.convertIntValueToDateTime(item.value);
        content = BrnCalendarView(
          key: GlobalKey(),
          selectMode: SelectMode.SINGLE,
          initStartSelectedDate: initialStartDate,
          initEndSelectedDate: initialEndDate,
          initDisplayDate: initialEndDate,
          startEndDateChange: (DateTime startDate, DateTime endDate) {
            item.value = startDate.millisecondsSinceEpoch.toString();
            item.isSelected = true;
            setState(() {
              clearTagSelectStatus(subFilterList);
            });
          },
        );
      } else if (item.filterType == BrnSelectionFilterType.DateRangeCalendar) {
        DateTime initialStartDate = item.customMap == null
            ? null
            : DateTimeFormatter.convertIntValueToDateTime(item.customMap['min']);
        DateTime initialEndDate = item.customMap == null
            ? null
            : DateTimeFormatter.convertIntValueToDateTime(item.customMap['max']);
        content = BrnCalendarView(
          key: GlobalKey(),
          selectMode: SelectMode.RANGE,
          initStartSelectedDate: initialStartDate,
          initEndSelectedDate: initialEndDate,
          startEndDateChange: (DateTime startDate, DateTime endDate) {
            item.customMap = {};
            item.customMap = {
              'min': startDate?.millisecondsSinceEpoch?.toString(),
              'max': endDate?.millisecondsSinceEpoch?.toString()
            };
            item.isSelected = true;
            setState(() {
              clearTagSelectStatus(subFilterList);
            });
          },
        );
      }
    }
    var widgets = <Widget>[tagContainer];
    if (content != null) {
      widgets.add(content);
    }
    return widgets;
  }

  Widget _bottomWidget() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(8, 11, 20, 11),
      child: Row(
        children: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 12, right: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 24,
                    width: 24,
                    child: BrunoTools.getAssetImage(BrnAsset.iconSelectionReset),
                  ),
                  Text(
                    '重置',
                    style: widget.themeData.resetTextStyle.generateTextStyle(),
                  )
                ],
              ),
            ),
            onTap: _clearAllSelectedItems,
          ),
          Expanded(
            child: BrnBigMainButton(
              title: '确定',
              onTap: () {
                _confirmButtonClickEvent();
              },
            ),
          )
        ],
      ),
    );
  }

  //pragma mark -- event responder

  /// 点击确定按钮时，处理数据。
  ///
  void _confirmButtonClickEvent() {
    _isConfirmClick = true;

    if (totalLevel == 2) {
      List<BrnSelectionEntity> subFilterList =
          widget.entity.children[_tabController.index].children;
      List<BrnSelectionEntity> selectItems = subFilterList.where((f) => f.isSelected).toList();
      if (selectItems.length > 0) {
        _firstList[_tabController.index].isSelected = true;
      } else {
        _firstList[_tabController.index].isSelected = false;
      }
    }

    // 处理Range类型的校验
    BrnSelectionEntity rangeEntity = getSelectRangeItem(
        totalLevel == 1 ? _firstList : _firstList[_tabController.index].children);
    if (rangeEntity != null) {
      if (rangeEntity.customMap != null &&
          ((rangeEntity.customMap['min'] != null && rangeEntity.customMap['min'].length > 0) ||
              (rangeEntity.customMap['max'] != null && rangeEntity.customMap['max'].length > 0))) {
        if (!rangeEntity.isValidRange()) {
          FocusScope.of(context).requestFocus(FocusNode());
          if (rangeEntity?.filterType == BrnSelectionFilterType.Range) {
            BrnToast.show('您输入的区间有误', context);
          } else if (rangeEntity?.filterType == BrnSelectionFilterType.DateRange ||
              rangeEntity?.filterType == BrnSelectionFilterType.DateRangeCalendar) {
            BrnToast.show('您选择的区间有误', context);
          }
          return;
        }
      } else {
        rangeEntity.isSelected = false;
      }
    }

    if (widget.onSelectionConfirm != null) {
      widget.onSelectionConfirm(widget.entity, _firstIndex, _secondIndex, -1);
    }
  }

  void _clearAllSelectedItems() {
    _resetSelectionDatas(widget.entity);
    clearNotTagItem(totalLevel == 1 ? _firstList : _firstList[_tabController.index].children);
    _clearEditRangeText();
    setState(() {
      _configDefaultInitSelectIndex();
      _refreshDataSource();
    });
  }

  // 初始化数据
  void _initData() {
    // 生成筛选节点树
    _originalSelectedItemsList = widget.entity.selectedList();
    for (BrnSelectionEntity entity in _originalSelectedItemsList) {
      entity.isSelected = true;
      if (entity.customMap != null) {
        entity.originalCustomMap = Map.from(entity.customMap);
      }
    }
    // 初始化每列的选中 index 为 -1，未选中。
    _configDefaultInitSelectIndex();
    // 遍历数据源，设置真正选中的index
    _configDefaultSelectedData();
    // 使用真正选中的index来刷新数组
    _refreshDataSource();
  }

  // 设置默认无选中项的时候默认选择index
  void _configDefaultInitSelectIndex() {
    _firstIndex = _secondIndex = -1;
  }

  void _setFirstIndex(int firstIndex) {
    _firstIndex = firstIndex;
    _secondIndex = -1;
    if (widget.entity.children.length > _firstIndex) {
      List<BrnSelectionEntity> seconds = widget.entity.children[_firstIndex].children;
      if (seconds != null) {
        for (BrnSelectionEntity entity in seconds) {
          if (entity.isSelected) {
            _setSecondIndex(seconds.indexOf(entity));
            break;
          }
        }
      }
    }
    setState(() {
      _refreshDataSource();
    });
  }

  void _setSecondIndex(int secondIndex) {
    _secondIndex = secondIndex;
    setState(() {
      _refreshDataSource();
    });
  }

  // 刷新3个ListView的数据源
  void _refreshDataSource() {
    _firstList = widget.entity.children;
    if (_firstIndex >= 0 && _firstList.length > _firstIndex) {
      _secondList = _firstList[_firstIndex].children;
    } else {
      _secondList = null;
    }
  }

  void _configDefaultSelectedData() {
    _firstList = widget.entity.children;
    //是否已选择的item里面有第一列的
    if (_firstList == null) {
      _secondIndex = -1;
      _secondList = null;
      return;
    }
    for (BrnSelectionEntity entity in _firstList) {
      if (entity.isSelected) {
        _firstIndex = _firstList.indexOf(entity);
        break;
      }
    }

    if (_firstIndex >= 0 && _firstIndex < _firstList.length) {
      _secondList = _firstList[_firstIndex].children;
      if (_secondList != null) {
        for (BrnSelectionEntity entity in _secondList) {
          if (entity.isSelected) {
            _secondIndex = _secondList.indexOf(entity);
            break;
          }
        }
      }
    }
  }

  //设置数据为未选中状态
  void _resetSelectionDatas(BrnSelectionEntity entity) {
    entity.isSelected = false;
    entity.customMap = null;
    if (entity.children != null) {
      for (BrnSelectionEntity subEntity in entity.children) {
        _resetSelectionDatas(subEntity);
      }
    }
  }

  void clearNotTagItem(List<BrnSelectionEntity> subFilterList) {
    subFilterList
        ?.where((f) =>
            f.filterType == BrnSelectionFilterType.Range ||
            f.filterType == BrnSelectionFilterType.Date ||
            f.filterType == BrnSelectionFilterType.DateRange ||
            f.filterType == BrnSelectionFilterType.DateRangeCalendar)
        ?.forEach((f) {
      f.isSelected = false;
      f.customMap = null;
      f.value = null;
    });
  }

  void _clearEditRangeText() {
    _minTextEditingController.text = "";
    _maxTextEditingController.text = "";
    EventBus.instance.fire(ClearSelectionFocusEvent());
  }

  void clearTagSelectStatus(List<BrnSelectionEntity> subFilterList) {
    subFilterList
        .where((f) => f.filterType != BrnSelectionFilterType.Range)
        .where((f) => f.filterType != BrnSelectionFilterType.Date)
        .where((f) => f.filterType != BrnSelectionFilterType.DateRange)
        .where((f) => f.filterType != BrnSelectionFilterType.DateRangeCalendar)
        .forEach((f) {
      f.isSelected = false;
      f.customMap = null;
    });
  }

  /// 获取针对 Range 类型进行value 检查。 DateRange、DateRangeCalendar 类型不需要检查，因为在选择时间的时候已经做了时间范围限制。
  BrnSelectionEntity getSelectRangeItem(List<BrnSelectionEntity> filterList) {
    List<BrnSelectionEntity> ranges = filterList
        ?.where((f) =>
            (f.filterType == BrnSelectionFilterType.Range ||
                f.filterType == BrnSelectionFilterType.DateRange ||
                f.filterType == BrnSelectionFilterType.DateRangeCalendar) &&
            f.isSelected)
        ?.toList();

    if (ranges.length > 0) {
      return ranges[0];
    }
    return null;
  }

  void _backgroundTap() {
    _resetSelectStatus();
    if (widget.bgClickFunction != null) {
      widget.bgClickFunction();
    }
  }

  void _resetSelectStatus() {
    _clearAllSelectedItems();
    _resetCustomMapData();
  }

  ///数据还原
  void _resetCustomMapData() {
    for (BrnSelectionEntity commonEntity in _originalSelectedItemsList) {
      commonEntity.isSelected = true;
      if (commonEntity.originalCustomMap != null) {
        commonEntity.customMap = Map.from(commonEntity.originalCustomMap);
      }
    }
  }

  /// 如果自定义输入和默认选中都没有，则尝试默认高亮【不限】这种类型的 Tag。
  int getInitFocusedIndex(List<BrnSelectionEntity> subFilterList) {
    bool isCustomInputSelected = false;
    for (BrnSelectionEntity entity in subFilterList) {
      if (BrnSelectionFilterType.Range == entity.filterType ||
          BrnSelectionFilterType.DateRange == entity.filterType ||
          BrnSelectionFilterType.DateRangeCalendar == entity.filterType) {
        isCustomInputSelected = entity.isSelected;
        break;
      }
    }

    var selectedItem = subFilterList
        ?.where((f) =>
            f.filterType != BrnSelectionFilterType.Range &&
            f.filterType != BrnSelectionFilterType.DateRange &&
            f.filterType != BrnSelectionFilterType.DateRangeCalendar &&
            f.isSelected)
        ?.toList();
    if (!isCustomInputSelected && BrunoTools.isEmpty(selectedItem)) {
      for (BrnSelectionEntity item in subFilterList) {
        if (item.isUnLimit()) {
          return subFilterList.indexOf(item);
        }
      }
    }

    return -1;
  }

  bool hasCalendarItem(BrnSelectionEntity entity) {
    bool hasCalendarItem = false;
    if (entity != null && entity.children != null) {
      /// 查找第一层级
      hasCalendarItem = entity.children
              .where((_) =>
                  _.filterType == BrnSelectionFilterType.Date ||
                  _.filterType == BrnSelectionFilterType.DateRangeCalendar)
              .toList()
              .length >
          0;

      /// 查找第二层级
      if (!hasCalendarItem) {
        for (BrnSelectionEntity subItem in entity.children) {
          int count = subItem.children
                  ?.where((_) =>
                      _.filterType == BrnSelectionFilterType.Date ||
                      _.filterType == BrnSelectionFilterType.DateRangeCalendar)
                  ?.toList()
                  ?.length ??
              0;
          if (count > 0) {
            hasCalendarItem = true;
            break;
          }
        }
      }
    }
    return hasCalendarItem;
  }
}
