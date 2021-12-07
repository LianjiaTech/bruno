import 'dart:async';
import 'dart:ui';

import 'package:bruno/src/components/tabbar/normal/brn_tab_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 构建指定索引的Widget
typedef AnchorTabWidgetIndexedBuilder = Widget Function(BuildContext context, int index);

/// 构建指定索引的Tab
typedef AnchorTabIndexedBuilder = BadgeTab Function(BuildContext context, int index);

class BrnAnchorTab extends StatefulWidget {
  // TabBar的样式
  final BrnAnchorTabBarStyle tabBarStyle;
  final AnchorTabWidgetIndexedBuilder widgetIndexedBuilder;
  final AnchorTabIndexedBuilder tabIndexedBuilder;
  final Widget tabDivider;

  //设置tab与widget的个数
  final int itemCount;

  BrnAnchorTab(
      {@required this.widgetIndexedBuilder,
      @required this.tabIndexedBuilder,
      @required this.itemCount,
      this.tabDivider,
      this.tabBarStyle = const BrnAnchorTabBarStyle()});

  @override
  _BrnScrollAnchorTabWidgetState createState() => _BrnScrollAnchorTabWidgetState();
}

class _BrnScrollAnchorTabWidgetState extends State<BrnAnchorTab>
    with SingleTickerProviderStateMixin {
  //用于控制 滑动
  ScrollController scrollController;

  //用于 滑动 和 tab 之间的通信
  StreamController<int> streamController;

  //用于控制tab
  TabController tabController;

  //滑动组件的 key
  GlobalKey key;

  //当前选中的索引
  int currentIndex;

  //滑动组件的元素、
  List<Widget> bodyWidgetList;

  //滑动组件的元素的key
  List<GlobalKey> bodyKeyList;

  //每个元素在滑动组件中的位置
  List<double> cardOffsetList;

  //tab
  List<BadgeTab> tabList;

  //是否点击滑动
  bool tab = false;

  //滑动组件在屏幕的位置
  double listDy = 0;

  @override
  void initState() {
    streamController = StreamController();
    scrollController = ScrollController();

    key = GlobalKey();
    cardOffsetList = List.filled(widget.itemCount, -1.0);
    bodyWidgetList = List();
    bodyKeyList = List();
    tabList = List();

    currentIndex = 0;
    tabController = TabController(length: widget.itemCount, vsync: this);

    fillKeyList();
    fillList();
    fillTab();

    WidgetsBinding.instance.addPostFrameCallback((da) {
      fillOffset();
      scrollController.addListener(() {
        updateOffset();
        currentIndex = createIndex(scrollController.offset);
        //防止再次 发送消息
        if (!tab) streamController.add(currentIndex);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        StreamBuilder<int>(
          initialData: currentIndex,
          stream: streamController.stream,
          builder: (context, snap) {
            tabController.index = currentIndex;
            return BrnTabBar(
              indicatorColor: widget.tabBarStyle.indicatorColor,
              indicatorWeight: widget.tabBarStyle.indicatorWeight,
              indicatorPadding: widget.tabBarStyle.indicatorPadding,
              labelColor: widget.tabBarStyle.labelColor,
              labelStyle: widget.tabBarStyle.labelStyle,
              labelPadding: widget.tabBarStyle.labelPadding ?? EdgeInsets.zero,
              unselectedLabelColor: widget.tabBarStyle.unselectedLabelColor,
              unselectedLabelStyle: widget.tabBarStyle.unselectedLabelStyle,
              dragStartBehavior: widget.tabBarStyle.dragStartBehavior,
              controller: tabController,
              tabs: tabList,
              onTap: (state, index) {
                state.refreshBadgeState(index);
                currentIndex = index;
                tab = true;
                scrollController
                    .animateTo(cardOffsetList[index],
                        duration: Duration(milliseconds: 100), curve: Curves.linear)
                    .whenComplete(() {
                  tab = false;
                });
              },
            );
          },
        ),
        widget.tabDivider ??
            Container(
              height: 0,
              width: 0,
            ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: bodyWidgetList,
            ),
            key: key,
            controller: scrollController,
          ),
        )
      ],
    );
  }

  void fillList() {
    if (widget.widgetIndexedBuilder != null) {
      for (int i = 0, n = widget.itemCount; i < n; i++) {
        bodyWidgetList.add(
          Container(key: bodyKeyList[i], child: widget.widgetIndexedBuilder(context, i)),
        );
      }
    }
  }

  void fillKeyList() {
    for (int i = 0, n = widget.itemCount; i < n; i++) {
      bodyKeyList.add(GlobalKey());
    }
  }

  void fillOffset() {
    Offset globalToLocal =
        (key.currentContext.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
    listDy = globalToLocal.dy;

    for (int i = 0, n = widget.itemCount; i < n; i++) {
      if (cardOffsetList[i] == -1.0) if (bodyKeyList[i].currentContext != null) {
        double cardOffset = (bodyKeyList[i].currentContext.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero) //相对于原点 控件的位置
            .dy; //y点坐标

        cardOffsetList[i] = cardOffset + scrollController.offset - listDy;
      }
    }
  }

  void fillTab() {
    if (widget.tabIndexedBuilder != null) {
      for (int i = 0, n = widget.itemCount; i < n; i++) {
        tabList.add(widget.tabIndexedBuilder(context, i));
      }
    }
  }

  void updateOffset() {
    for (int i = 0, n = widget.itemCount; i < n; i++) {
      if (cardOffsetList[i] == -1.0) if (bodyKeyList[i].currentContext != null) {
        double cardOffset = (bodyKeyList[i].currentContext.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero) //相对于原点 控件的位置
            .dy; //y点坐标

        cardOffsetList[i] = cardOffset + scrollController.offset - listDy;
      }
    }
  }

  //根据偏移量 确定tab索引
  int createIndex(double offset) {
    int index = 0;
    for (int i = 0, n = widget.itemCount; i < n; i++) {
      if (offset >= cardOffsetList[i] && (offset <= cardOffsetList[i + 1])) {
        return i;
      }
    }
    return index;
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    streamController.close();
    scrollController.dispose();
  }
}

class BrnAnchorTabBarStyle {
  final Color indicatorColor;

  final double indicatorWeight;

  final EdgeInsetsGeometry indicatorPadding;

  final Color labelColor;

  final Color unselectedLabelColor;

  final TextStyle labelStyle;

  final EdgeInsetsGeometry labelPadding;

  final TextStyle unselectedLabelStyle;

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
