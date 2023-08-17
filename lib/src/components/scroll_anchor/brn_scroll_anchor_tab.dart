import 'package:bindings_compatible/bindings_compatible.dart';
import 'package:bruno/src/components/popup/brn_measure_size.dart';
import 'package:bruno/src/components/tabbar/normal/brn_tab_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 构建指定索引的Widget
typedef AnchorTabWidgetIndexedBuilder = Widget Function(BuildContext context, int index);

/// 构建指定索引的Tab
typedef AnchorTabIndexedBuilder = BadgeTab Function(BuildContext context, int index);

/// 滑动锚点组件
class BrnAnchorTab extends StatefulWidget {
  /// TabBar的样式
  final BrnAnchorTabBarStyle tabBarStyle;

  /// 构建指定索引的Widget
  final AnchorTabWidgetIndexedBuilder? widgetIndexedBuilder;

  /// 构建指定索引的Tab
  final AnchorTabIndexedBuilder tabIndexedBuilder;

  /// Tab与内容之间的分割线
  final Widget? tabDivider;

  /// 设置tab与widget的个数
  final int itemCount;

  BrnAnchorTab(
      {required this.widgetIndexedBuilder,
      required this.tabIndexedBuilder,
      required this.itemCount,
      this.tabDivider,
      this.tabBarStyle = const BrnAnchorTabBarStyle()});

  @override
  _BrnScrollAnchorTabWidgetState createState() => _BrnScrollAnchorTabWidgetState();
}

class _BrnScrollAnchorTabWidgetState extends State<BrnAnchorTab>
    with SingleTickerProviderStateMixin {
  /// 用于控制 滑动
  late ScrollController _scrollController;

  /// 用于控制tab
  late TabController _tabController;

  /// 滑动组件的 key
  late GlobalKey _key;

  /// 当前选中的索引
  int currentIndex = 0;

  /// 滑动组件的元素的key
  late List<GlobalKey> _bodyKeyList;

  /// 每个元素在滑动组件中的位置
  late List<double> _cardOffsetList;

  /// 是否点击滑动
  bool tab = false;

  /// 滑动组件在屏幕的位置
  double listDy = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _key = GlobalKey();
    _cardOffsetList = List.filled(widget.itemCount, -1.0);
    _bodyKeyList = [];
    currentIndex = 0;
    _tabController = TabController(length: widget.itemCount, vsync: this);

    fillKeyList();

    useWidgetsBinding().addPostFrameCallback((da) {
      fillOffset();
      _scrollController.addListener(() {
        _updateOffset();
        currentIndex = createIndex(_scrollController.offset);
        //防止再次 发送消息
        if (!tab) {
          _tabController.index = currentIndex;
        }
      });
    });
  }

  @override
  void didUpdateWidget(BrnAnchorTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    _cardOffsetList = List.filled(widget.itemCount, -1.0);
    int sub = widget.itemCount - oldWidget.itemCount;
    if (sub < 0) {
      _bodyKeyList = _bodyKeyList.sublist(0, widget.itemCount);
    } else if (sub > 0) {
      for (int i = 0; i < sub; i++) {
        _bodyKeyList.add(GlobalKey());
      }
    }
    if (sub != 0) {
      _tabController = TabController(length: widget.itemCount, vsync: this);
    }
    useWidgetsBinding().addPostFrameCallback((da) {
      fillOffset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        BrnTabBar(
          indicatorColor: widget.tabBarStyle.indicatorColor,
          indicatorWeight: widget.tabBarStyle.indicatorWeight,
          indicatorPadding: widget.tabBarStyle.indicatorPadding,
          labelColor: widget.tabBarStyle.labelColor,
          labelStyle: widget.tabBarStyle.labelStyle,
          labelPadding: widget.tabBarStyle.labelPadding ?? EdgeInsets.zero,
          unselectedLabelColor: widget.tabBarStyle.unselectedLabelColor,
          unselectedLabelStyle: widget.tabBarStyle.unselectedLabelStyle,
          dragStartBehavior: widget.tabBarStyle.dragStartBehavior,
          controller: _tabController,
          tabs: _fillTab(),
          onTap: (state, index) {
            state.refreshBadgeState(index);
            currentIndex = index;
            tab = true;
            _scrollController
                .animateTo(_cardOffsetList[index],
                    duration: Duration(milliseconds: 100), curve: Curves.linear)
                .whenComplete(() {
              tab = false;
            });
          },
        ),
        widget.tabDivider ?? const SizedBox.shrink(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _fillList(),
            ),
            key: _key,
            controller: _scrollController,
          ),
        )
      ],
    );
  }

  List<Widget> _fillList() {
    List<Widget> tmpWidget = [];
    if (widget.widgetIndexedBuilder != null) {
      for (int i = 0, n = widget.itemCount; i < n; i++) {
        Widget itemWidget =
            Container(key: _bodyKeyList[i], child: widget.widgetIndexedBuilder!(context, i));
        itemWidget = MeasureSize(
          onChange: (size) {
            _updateOffset();
          },
          child: itemWidget,
        );
        tmpWidget.add(itemWidget);
      }
    }
    return tmpWidget;
  }

  void fillKeyList() {
    for (int i = 0, n = widget.itemCount; i < n; i++) {
      _bodyKeyList.add(GlobalKey());
    }
  }

  void fillOffset() {
    Offset globalToLocal =
        (_key.currentContext!.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
    listDy = globalToLocal.dy;

    for (int i = 0, n = widget.itemCount; i < n; i++) {
      if (_cardOffsetList[i] == -1.0 && _bodyKeyList[i].currentContext != null) {
        double cardOffset = (_bodyKeyList[i].currentContext!.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero) //相对于原点 控件的位置
            .dy; //y点坐标

        _cardOffsetList[i] = cardOffset + _scrollController.offset - listDy;
      }
    }
  }

  List<BadgeTab> _fillTab() {
    List<BadgeTab> tmp = [];
    for (int i = 0, n = widget.itemCount; i < n; i++) {
      tmp.add(widget.tabIndexedBuilder(context, i));
    }
    return tmp;
  }

  void _updateOffset() {
    for (int i = 0, n = widget.itemCount; i < n; i++) {
      if (_bodyKeyList[i].currentContext != null) {
        double cardOffset = (_bodyKeyList[i].currentContext!.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero) //相对于原点 控件的位置
            .dy; //y点坐标

        _cardOffsetList[i] = cardOffset + _scrollController.offset - listDy;
      }
    }
  }

  /// 根据偏移量 确定tab索引
  int createIndex(double offset) {
    int index = widget.itemCount - 1;
    for (int i = 0; i < widget.itemCount - 1; i++) {
      if (offset >= _cardOffsetList[i] && (offset <= _cardOffsetList[i + 1])) {
        return i;
      }
    }
    return index;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }
}

class BrnAnchorTabBarStyle {
  final Color? indicatorColor;

  final double indicatorWeight;

  final EdgeInsetsGeometry indicatorPadding;

  final Color? labelColor;

  final Color? unselectedLabelColor;

  final TextStyle? labelStyle;

  final EdgeInsetsGeometry? labelPadding;

  final TextStyle? unselectedLabelStyle;

  final DragStartBehavior dragStartBehavior;

  const BrnAnchorTabBarStyle({
    this.indicatorColor,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
  });
}
