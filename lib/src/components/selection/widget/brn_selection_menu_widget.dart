import 'dart:async';

import 'package:bruno/src/components/picker/time_picker/brn_date_time_formatter.dart';
import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';
import 'package:bruno/src/components/selection/brn_selection_view.dart';
import 'package:bruno/src/components/selection/controller/brn_selection_view_controller.dart';
import 'package:bruno/src/components/selection/brn_selection_util.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_animate_widget.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_list_widget.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_menu_item_widget.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_range_widget.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:bruno/src/utils/brn_event_bus.dart';
import 'package:bruno/src/utils/i18n/brn_date_picker_i18n.dart';
import 'package:flutter/material.dart';

typedef bool BrnOnMenuItemClick(int index);

typedef void BrnOnRangeSelectionConfirm(
    BrnSelectionEntity results, int firstIndex, int secondIndex, int thirdIndex);

class BrnSelectionMenuWidget extends StatefulWidget {
  final List<BrnSelectionEntity> data;
  final BuildContext context;
  final double height;
  final double width;
  final BrnOnRangeSelectionConfirm onConfirm;
  final BrnOnMenuItemClick onMenuItemClick;
  final BrnConfigTagCountPerRow configRowCount;

  ///筛选所在列表的外部列表滚动需要收起筛选，此处为最外层列表，有点恶心，但是暂时只想到这个方法，有更好方式的一定要告诉我
  final ScrollController extraScrollController;

  ///指定筛选固定的相对于屏幕的顶部距离，默认null不指定
  final double constantTop;

  BrnSelectionViewController selectionViewController;

  BrnSelectionConfig themeData;

  BrnSelectionMenuWidget(
      {@required this.data,
      @required this.context,
      this.height = 50.0,
      this.width,
      this.onMenuItemClick,
      this.onConfirm,
      this.configRowCount,
      this.extraScrollController,
      this.constantTop,
      this.selectionViewController,
      this.themeData});

  @override
  _BrnSelectionMenuWidgetState createState() => _BrnSelectionMenuWidgetState();
}

class _BrnSelectionMenuWidgetState extends State<BrnSelectionMenuWidget> {
  bool _needRefreshTitle = true;
  List<BrnSelectionEntity> result;
  List<String> titles = List();
  List<bool> menuItemActiveState = List();
  List<bool> menuItemHighlightState = List();
  BrnSelectionListViewController listViewController = BrnSelectionListViewController();
  ScrollController _scrollController;

  StreamSubscription _refreshTitleSubscription;

  StreamSubscription _closeSelectionPopupWindowSubscription;

  @override
  void initState() {
    super.initState();
    _refreshTitleSubscription =
        EventBus.instance.on<RefreshMenuTitleEvent>().listen((RefreshMenuTitleEvent event) {
      _needRefreshTitle = true;
      setState(() {});
    });

    _closeSelectionPopupWindowSubscription =
        EventBus.instance.on<CloseSelectionViewEvent>().listen((CloseSelectionViewEvent event) {
      _closeSelectionPopupWindow();
    });

    if (widget.extraScrollController != null) {
      _scrollController = widget.extraScrollController;
      _scrollController.addListener(_closeSelectionPopupWindow);
    }

    result = List<BrnSelectionEntity>();
    if (widget.data != null) {
      for (BrnSelectionEntity parentEntity in widget.data) {
        titles.add(parentEntity.title);
        menuItemActiveState.add(false);
        menuItemHighlightState.add(false);
      }
    }
  }

  void _closeSelectionPopupWindow() {
    if (listViewController?.isShow ?? false) {
      listViewController.isShow = false;
      listViewController.hide();
      listViewController.entry?.remove();
      listViewController.entry = null;
      setState(() {
        for (int i = 0; i < menuItemActiveState.length; i++) {
          if (i != listViewController.menuIndex) {
            menuItemActiveState[i] = false;
          } else {
            menuItemActiveState[i] = !menuItemActiveState[i];
          }
          if (widget.data[listViewController.menuIndex].type == 'more') {
            menuItemActiveState[i] = false;
          }
        }
      });
    }
  }

  dispose() {
    _scrollController?.removeListener(_closeSelectionPopupWindow);
    _refreshTitleSubscription?.cancel();
    _closeSelectionPopupWindowSubscription?.cancel();
    listViewController?.isShow = false;
    listViewController?.hide();
    listViewController?.entry?.remove();
    listViewController?.entry = null;
    super.dispose();
  }

  /// 根据【Filter组】 创建 widget。
  void _createEntry(BrnSelectionEntity entity) {
    var content = isRange(entity) ? _createRangeView(entity) : _createSelectionListView(entity);
    OverlayEntry entry = OverlayEntry(builder: (context) {
      return GestureDetector(
        onTap: () {
          _closeSelectionPopupWindow();
        },
        child: Container(
          padding: EdgeInsets.only(
            top: listViewController.listViewTop,
          ),
          child: Stack(
            children: <Widget>[
              BrnSelectionAnimationWidget(controller: listViewController, view: content)
            ],
          ),
        ),
      );
    });

    listViewController.screenHeight = MediaQuery.of(widget.context).size.height;
    listViewController.entry = entry;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: (widget.width != null) ? widget.width : MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 990,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _configMenuItems(),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              height: 0.5,
              color: widget.themeData.commonConfig.dividerColorBase,
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _configMenuItems() {
    List<Widget> itemViewList = List();
    itemViewList.add(Padding(
      padding: EdgeInsets.only(left: 14),
    ));
    for (int index = 0; index < titles.length; index++) {
      if (_needRefreshTitle) {
        refreshSelectionMenuTitle(index, widget.data[index]);
        if (index == titles.length - 1) {
          _needRefreshTitle = false;
        }
      }
      itemViewList.add(Padding(
        padding: EdgeInsets.only(left: 6),
      ));
      itemViewList.add(BrnSelectionMenuItemWidget(
        title: titles[index],
        themeData: widget.themeData,
        active: menuItemActiveState[index],
        isHighLight: menuItemActiveState[index] || menuItemHighlightState[index],
        itemClickFunction: () {
          if (widget.onMenuItemClick != null) {
            /// 拦截 menuItem 点击。
            if (widget.onMenuItemClick(index)) {
              return;
            }
          }
          final RenderBox dropDownItemRenderBox = context.findRenderObject();

          var position = dropDownItemRenderBox.localToGlobal(Offset.zero, ancestor: null);
          var size = dropDownItemRenderBox.size;
          listViewController.listViewTop = size.height + (widget.constantTop ?? position.dy);
          if (listViewController.isShow && listViewController.menuIndex != index) {
            listViewController.hide();
            listViewController.entry?.remove();
            listViewController.entry = null;
          }

          if (listViewController.isShow) {
            listViewController.hide();
            listViewController.entry?.remove();
            listViewController.entry = null;
          } else {
            /// 点击不是 More、自定义类型，则直接展开。
            if (widget.data[index].filterType != BrnSelectionFilterType.More &&
                widget.data[index].filterType != BrnSelectionFilterType.CustomHandle) {
              /// 创建 筛选组件的的入口
              _createEntry(widget.data[index]);
              Overlay.of(widget.context).insert(listViewController.entry);
              listViewController.show(index);
            } else if (widget.data[index].filterType == BrnSelectionFilterType.CustomHandle) {
              /// 记录自定义筛选 menu 的点击状态，当点击自定义的 menu 时，menu 文案默认高亮。
              listViewController.show(index);
              refreshSelectionMenuTitle(index, widget.data[index]);
            } else {
              refreshSelectionMenuTitle(index, widget.data[index]);
            }
          }

          setState(() {
            for (int i = 0; i < menuItemActiveState.length; i++) {
              if (i != index) {
                menuItemActiveState[i] = false;
              } else {
                menuItemActiveState[i] = !menuItemActiveState[i];
              }
              if (widget.data[index].type == 'more') {
                menuItemActiveState[i] = false;
              }
            }
          });
        },
      ));
      itemViewList.add(Padding(
        padding: EdgeInsets.only(left: 6),
      ));
    }
    itemViewList.add(Padding(
      padding: EdgeInsets.only(left: 14),
    ));
    return itemViewList;
  }

  /// 1、子筛选项包含自定义范围的时候，使用 Tag 模式展示。
  /// 2、被指定为 Tag 模式展示。
  /// 3、只有一列筛选数据，且为多选时，使用 Tag 模式展示
  bool isRange(BrnSelectionEntity entity) {
    if (entity.children != null) {
      if (BrnSelectionUtil.hasRangeItem(entity.children) ||
          entity.filterShowType == BrnSelectionWindowType.Range) {
        return true;
      }
      var totalLevel = BrnSelectionUtil.getTotalLevel(entity);
      if (totalLevel == 1 && entity.filterType == BrnSelectionFilterType.Checkbox) {
        return true;
      }
    }
    return false;
  }

  Widget _createRangeView(BrnSelectionEntity entity) {
    int rowCount;
    if (widget.configRowCount != null) {
      rowCount = widget.configRowCount(widget.data.indexOf(entity), entity) ?? rowCount;
    }
    return BrnRangeSelectionGroupWidget(
      entity: entity,
      marginTop: listViewController.listViewTop,
      maxContentHeight:
          DESIGN_SELECTION_HEIGHT / DESIGN_SCREEN_HEIGHT * MediaQuery.of(context).size.height,
      // UI 给出的内容高度比例 248:812
      themeData: widget.themeData,
      rowount: rowCount,
      bgClickFunction: () {
        setState(() {
          menuItemActiveState[listViewController.menuIndex] = false;
          if (entity.selectedListWithoutUnlimit().length > 0) {
            menuItemHighlightState[listViewController.menuIndex] = true;
          }
          listViewController.hide();
          listViewController.entry?.remove();
          listViewController.entry = null;
        });
      },
      onSelectionConfirm:
          (BrnSelectionEntity result, int firstIndex, int secondIndex, int thirdIndex) {
        setState(() {
          onConfirmSelect(entity, result, firstIndex, secondIndex, thirdIndex);
        });
      },
    );
  }

  Widget _createSelectionListView(BrnSelectionEntity entity) {
    /// 顶层筛选 Tab
    return BrnListSelectionGroupWidget(
      entity: entity,
      maxContentHeight:
          DESIGN_SELECTION_HEIGHT / DESIGN_SCREEN_HEIGHT * MediaQuery.of(context).size.height,
      themeData: widget.themeData,
      // UI 给出的内容高度比例 248:812
      bgClickFunction: () {
        setState(() {
          menuItemActiveState[listViewController.menuIndex] = false;
          if (entity.selectedListWithoutUnlimit().length > 0) {
            menuItemHighlightState[listViewController.menuIndex] = true;
          }
          listViewController.hide();
          listViewController.entry?.remove();
          listViewController.entry = null;
        });
      },
      onSelectionConfirm:
          (BrnSelectionEntity result, int firstIndex, int secondIndex, int thirdIndex) {
        setState(() {
          onConfirmSelect(entity, result, firstIndex, secondIndex, thirdIndex);
        });
      },
    );
  }

  void onConfirmSelect(BrnSelectionEntity entity, BrnSelectionEntity result, int firstIndex,
      int secondIndex, int thirdIndex) {
    if (listViewController.menuIndex < titles.length) {
      if (widget.onConfirm != null) {
        widget.onConfirm(result, firstIndex, secondIndex, thirdIndex);
      }
      menuItemActiveState[listViewController.menuIndex] = false;
      refreshSelectionMenuTitle(listViewController.menuIndex, entity);
      listViewController.hide();
      listViewController.entry?.remove();
      listViewController.entry = null;
    }
  }

  /// 筛选 Title 展示规则
  String getSelectedResultTitle(BrnSelectionEntity entity) {
    /// 更多筛选不改变 title.故返回 null
    if (entity.filterType == BrnSelectionFilterType.More) {
      return null;
    }
    if (BrunoTools.isEmpty(entity.customTitle)) {
      return getTitle(entity);
    } else {
      return entity.customTitle;
    }
  }

  String getTitle(BrnSelectionEntity entity) {
    String title;
    if (entity != null) {
      List<BrnSelectionEntity> firstColumn = BrnSelectionUtil.currentSelectListForEntity(entity);
      List<BrnSelectionEntity> secondColumn = List();
      List<BrnSelectionEntity> thirdColumn = List();
      if (firstColumn != null && firstColumn.length > 0) {
        for (BrnSelectionEntity firstEntity in firstColumn) {
          if (firstEntity != null) {
            secondColumn.addAll(BrnSelectionUtil.currentSelectListForEntity(firstEntity));
            if (secondColumn != null && secondColumn.length > 0) {
              for (BrnSelectionEntity secondEntity in secondColumn) {
                thirdColumn.addAll(BrnSelectionUtil.currentSelectListForEntity(secondEntity));
              }
            }
          }
        }
      }

      if (firstColumn.length == 0 || firstColumn.length > 1) {
        title = entity.title;
      } else {
        /// 第一列选中了一个，为【不限】类型，使用上一级别的名字展示。
        if (firstColumn[0].isUnLimit()) {
          title = entity.title;
        } else if (firstColumn[0].filterType == BrnSelectionFilterType.Range ||
            firstColumn[0].filterType == BrnSelectionFilterType.Date ||
            firstColumn[0].filterType == BrnSelectionFilterType.DateRange ||
            firstColumn[0].filterType == BrnSelectionFilterType.DateRangeCalendar) {
          title = getDateAndRangeTitle(firstColumn, entity);
        } else {
          if (secondColumn.length == 0 || secondColumn.length > 1) {
            title = firstColumn[0].title;
          } else {
            /// 第二列选中了一个，为【不限】类型，使用上一级别的名字展示。
            if (secondColumn[0].isUnLimit()) {
              title = firstColumn[0].title;
            } else if (secondColumn[0].filterType == BrnSelectionFilterType.Range ||
                secondColumn[0].filterType == BrnSelectionFilterType.Date ||
                secondColumn[0].filterType == BrnSelectionFilterType.DateRange ||
                secondColumn[0].filterType == BrnSelectionFilterType.DateRangeCalendar) {
              title = getDateAndRangeTitle(secondColumn, firstColumn[0]);
            } else {
              if (thirdColumn.length == 0 || thirdColumn.length > 1) {
                title = secondColumn[0].title;
              } else {
                /// 第三列选中了一个，为【不限】类型，使用上一级别的名字展示。
                if (thirdColumn[0].isUnLimit()) {
                  title = secondColumn[0].title;
                } else if (thirdColumn[0].filterType == BrnSelectionFilterType.Range ||
                    thirdColumn[0].filterType == BrnSelectionFilterType.Date ||
                    thirdColumn[0].filterType == BrnSelectionFilterType.DateRange ||
                    thirdColumn[0].filterType == BrnSelectionFilterType.DateRangeCalendar) {
                  title = getDateAndRangeTitle(thirdColumn, secondColumn[0]);
                } else {
                  title = thirdColumn[0].title;
                }
              }
            }
          }
        }
      }
      String joinTitle = getJoinTitle(entity, firstColumn, secondColumn, thirdColumn);
      title = BrunoTools.isEmpty(joinTitle) ? title : joinTitle;
    }
    return title;
  }

  String getDateAndRangeTitle(List<BrnSelectionEntity> list, BrnSelectionEntity entity) {
    String title = "";
    if (!BrunoTools.isEmpty(list[0].customMap)) {
      if (list[0].filterType == BrnSelectionFilterType.Range) {
        title =
            '${list[0].customMap['min']}-${list[0].customMap['max']}(${list[0].extMap['unit']?.toString()})';
      } else if (list[0].filterType == BrnSelectionFilterType.DateRange ||
          list[0].filterType == BrnSelectionFilterType.DateRangeCalendar) {
        title = getDateRangeTitle(list);
      }
    } else {
      if (list[0].filterType == BrnSelectionFilterType.Date) {
        title = getDateTimeTitle(list);
      } else {
        title = entity.title;
      }
    }
    return title;
  }

  String getDateRangeTitle(List<BrnSelectionEntity> list) {
    String minDateTime = "";
    String maxDateTime = "";
    if (list[0].customMap != null &&
        list[0].customMap['min'] != null &&
        int.tryParse(list[0].customMap['min']) != null) {
      minDateTime = DateTimeFormatter.formatDate(
          DateTimeFormatter.convertIntValueToDateTime(list[0].customMap['min']),
          'yyyy年MM月dd日',
          DateTimePickerLocale.zh_cn);
    }
    if (list[0].customMap != null &&
        list[0].customMap['max'] != null &&
        int.tryParse(list[0].customMap['max']) != null) {
      maxDateTime = DateTimeFormatter.formatDate(
          DateTimeFormatter.convertIntValueToDateTime(list[0].customMap['max']),
          'yyyy年MM月dd日',
          DateTimePickerLocale.zh_cn);
    }
    return '$minDateTime-$maxDateTime';
  }

  String getDateTimeTitle(List<BrnSelectionEntity> list) {
    String title = "";
    int msDateTime = int.tryParse(list[0].value ?? "");
    title = msDateTime != null
        ? DateTimeFormatter.formatDate(DateTime.fromMillisecondsSinceEpoch(msDateTime),
            'yyyy年MM月dd日', DateTimePickerLocale.zh_cn)
        : list[0].title;
    return title;
  }

  String getJoinTitle(BrnSelectionEntity entity, List<BrnSelectionEntity> firstColumn,
      List<BrnSelectionEntity> secondColumn, List<BrnSelectionEntity> thirdColumn) {
    String title = "";
    if (entity.canJoinTitle) {
      if (firstColumn.length == 1) {
        title = firstColumn[0].title ?? "";
      }
      if (secondColumn.length == 1) {
        title += secondColumn[0].title ?? "";
      }
      if (thirdColumn.length == 1) {
        title += thirdColumn[0].title ?? "";
      }
    }
    return title;
  }

  void refreshSelectionMenuTitle(int index, BrnSelectionEntity entity) {
    if (entity.filterType == BrnSelectionFilterType.More) {
      if (entity.allSelectedList().length > 0) {
        menuItemHighlightState[index] = true;
      } else {
        menuItemHighlightState[index] = false;
      }
      return;
    }
    String title = getSelectedResultTitle(entity);
    if (title != null) {
      titles[index] = title;
    }
    if (entity.selectedListWithoutUnlimit().length > 0) {
      menuItemHighlightState[index] = true;
    } else if (!BrunoTools.isEmpty(entity.customTitle)) {
      menuItemHighlightState[index] = entity.isCustomTitleHighLight;
    } else {
      menuItemHighlightState[index] = false;
    }
  }
}
