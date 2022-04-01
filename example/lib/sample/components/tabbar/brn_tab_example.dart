

import 'package:bruno/bruno.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

import 'brn_tabbar_sticky_example.dart';

class BrnTabExample extends StatefulWidget {
  @override
  _BrnTabExampleState createState() => _BrnTabExampleState();
}

class _BrnTabExampleState extends State<BrnTabExample>
    with TickerProviderStateMixin {
  BrnCloseWindowController? closeWindowController;

  @override
  void initState() {
    super.initState();
    closeWindowController = BrnCloseWindowController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: BrnAppBar(
            title: 'BrnTab示例',
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListItem(
                  title: "BrnTabBarBadge实现",
                  isShowLine: false,
                ),
                Divider(),
                Center(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (context) {
                        return BrnTabbarStickyExample();
                      }));
                    },
                    child: Text("Tabbar点击自动收起example"),
                  ),
                ),
                Divider(),
                _createExpandedMoreTabbarWidgets(),
                Divider(),
                _createStableTabbar4Widgets(),
                Divider(),
                _createStableTabbarWidgets(),
                Divider(),
                _createTabbarBadgeWidgets(),
                Divider(),
                _createStableTabbarBadgeWidgets(),
                Divider(),
                _createDividerTabbarWidgets(),
                Divider(),
                _createCustomTabbarWidgets(),
                Divider(),
                _createTopTabbarWidgets(),
                Divider(),
                _createTopTabbarCountWidgets(),
                Divider(),
                _createOriginWidgets(),
              ],
            ),
          ),
        ),
        onWillPop: () {
          if (closeWindowController!.isShow) {
            closeWindowController!.closeMoreWindow();
            return Future.value(false);
          }
          return Future.value(true);
        });
  }

  _createExpandedMoreTabbarWidgets() {
    var tabs = <BadgeTab>[];
    tabs.add(BadgeTab(text: "业务一"));
    tabs.add(BadgeTab(text: "业务二"));
    tabs.add(BadgeTab(text: "业务三"));
    tabs.add(BadgeTab(text: "业务四"));
    tabs.add(BadgeTab(text: "业务五"));
    TabController tabController =
        TabController(length: tabs.length, vsync: this);
    return BrnTabBar(
      controller: tabController,
      tabs: tabs,
      showMore: true,
      moreWindowText: "Tabs描述",
      closeController: closeWindowController,
      onTap: (state, index) {
        state.refreshBadgeState(index);
      },
    );
  }

  _createStableTabbar4Widgets() {
    var tabs = <BadgeTab>[];
    tabs.add(BadgeTab(text: "业务一"));
    tabs.add(BadgeTab(text: "业务二"));
    tabs.add(BadgeTab(text: "业务三"));
    tabs.add(BadgeTab(text: "业务四"));
    TabController tabController =
        TabController(length: tabs.length, vsync: this);
    return BrnTabBar(
      controller: tabController,
      tabs: tabs,
      onTap: (state, index) {
        state.refreshBadgeState(index);
      },
    );
  }

  _createStableTabbarWidgets() {
    var tabs = <BadgeTab>[];
    tabs.add(BadgeTab(text: "特殊业务详情一", badgeText: "新"));
    tabs.add(BadgeTab(text: "业务二", badgeNum: 22));
    tabs.add(BadgeTab(text: "业务三", badgeNum: 11));
    tabs.add(BadgeTab(text: "业务四", showRedBadge: true));
    tabs.add(BadgeTab(text: "业务五", badgeNum: 12));
    tabs.add(BadgeTab(text: "业务六", badgeNum: 30));
    tabs.add(BadgeTab(text: "业务七"));
    tabs.add(BadgeTab(text: "业务八", badgeNum: 23));
    tabs.add(BadgeTab(text: "业务九"));
    TabController tabController =
        TabController(length: tabs.length, vsync: this);
    return BrnTabBar(
      controller: tabController,
      tabs: tabs,
      mode: BrnTabBarBadgeMode.origin,
      isScroll: false,
      labelPadding: EdgeInsets.only(left: 20, right: 12),
      indicatorPadding: EdgeInsets.only(left: 10),
      onTap: (state, index) {
        BrnToast.show("点击了", context);
      },
    );
  }

  _createTabbarBadgeWidgets() {
    var tabs = <BadgeTab>[];
    tabs.add(BadgeTab(text: "业务一", badgeText: "新"));
    tabs.add(BadgeTab(text: "业务二", badgeNum: 22));
    tabs.add(BadgeTab(text: "业务三", badgeNum: 11));
    tabs.add(BadgeTab(text: "业务四", showRedBadge: true));
    tabs.add(BadgeTab(text: "业务五", badgeNum: 12));
    tabs.add(BadgeTab(text: "业务六", badgeNum: 30));
    tabs.add(BadgeTab(text: "业务七"));
    tabs.add(BadgeTab(text: "业务八", badgeNum: 23));
    tabs.add(BadgeTab(text: "业务九", badgeNum: 43));
    TabController tabController =
        TabController(length: tabs.length, vsync: this);
    return BrnTabBar(
      controller: tabController,
      tabs: tabs,
      onTap: (state, index) {
        state.refreshBadgeState(index);
      },
    );
  }

  _createStableTabbarBadgeWidgets() {
    var tabs = <BadgeTab>[];
    tabs.add(BadgeTab(text: "业务一", badgeNum: 100));
    tabs.add(BadgeTab(text: "业务二", badgeNum: 22));
    tabs.add(BadgeTab(text: "业务三", badgeNum: 11));
    tabs.add(BadgeTab(text: "业务四"));
    TabController tabController =
        TabController(length: tabs.length, vsync: this);
    return BrnTabBar(
      controller: tabController,
      tabs: tabs,
      onTap: (state, index) {
        state.refreshBadgeState(index);
      },
    );
  }

  _createDividerTabbarWidgets() {
    var tabs = <BadgeTab>[];
    tabs.add(BadgeTab(text: "业务一", topText: "1"));
    tabs.add(BadgeTab(text: "业务二", topText: "2"));
    tabs.add(BadgeTab(text: "业务三", topText: "3"));
    tabs.add(BadgeTab(text: "业务四", topText: "4"));
    tabs.add(BadgeTab(text: "业务五", topText: "5"));
    TabController tabController =
        TabController(length: tabs.length, vsync: this);
    return BrnTabBar(
      controller: tabController,
      tabs: tabs,
      hasIndex: true,
      hasDivider: true,
      onTap: (state, index) {},
    );
  }

  ///
  /// 自定义Tab宽度，如果tab宽度之和大于屏幕宽度，默认能左右滚动
  ///
  _createCustomTabbarWidgets() {
    var tabs = <BadgeTab>[];
    tabs.add(BadgeTab(text: "业务一", badgeNum: 2));
    tabs.add(BadgeTab(text: "业务二"));
    tabs.add(BadgeTab(text: "业务三", badgeNum: 33));
    TabController tabController =
        TabController(length: tabs.length, vsync: this);
    return BrnTabBar(
      controller: tabController,
      tabs: tabs,
      tabWidth: 80,
      hasIndex: true,
      hasDivider: false,
      onTap: (state, index) {},
    );
  }

  _createTopTabbarWidgets() {
    var tabs = <BadgeTab>[];
    tabs.add(BadgeTab(text: "08月09日", topText: "今天"));
    tabs.add(BadgeTab(text: "08月10日", topText: "明天"));
    tabs.add(BadgeTab(text: "08月11日", topText: "周三"));
    tabs.add(BadgeTab(text: "08月12日", topText: "周四"));
    tabs.add(BadgeTab(text: "08月13日", topText: "周五"));
    TabController tabController =
        TabController(length: tabs.length, vsync: this);
    return BrnTabBar(
      controller: tabController,
      tabs: tabs,
      hasIndex: true,
      labelColor: Color(0xFF21C1B5),
      indicatorColor: Color(0xFF21C1B5),
      hasDivider: true,
      onTap: (state, index) {},
    );
  }

  _createTopTabbarCountWidgets() {
    var tabs = <BadgeTab>[];
    tabs.add(BadgeTab(text: "08月09日", topText: "今天"));
    tabs.add(BadgeTab(text: "08月10日", topText: "明天"));
    tabs.add(BadgeTab(text: "08月11日", topText: "周三"));
    TabController tabController =
        TabController(length: tabs.length, vsync: this);
    return BrnTabBar(
      controller: tabController,
      tabs: tabs,
      hasIndex: true,
      labelColor: Color(0xFF21C1B5),
      indicatorColor: Color(0xFF21C1B5),
      hasDivider: true,
      onTap: (state, index) {},
    );
  }

  _createOriginWidgets() {
    var tabs = <BadgeTab>[];
    tabs.add(BadgeTab(text: "业务一", badgeText: "新"));
    tabs.add(BadgeTab(text: "业务二", badgeNum: 22));
    tabs.add(BadgeTab(text: "业务三", badgeNum: 11));
    tabs.add(BadgeTab(text: "业务四", showRedBadge: true));
    tabs.add(BadgeTab(text: "业务五", badgeNum: 12));
    tabs.add(BadgeTab(text: "业务六", badgeNum: 30));
    tabs.add(BadgeTab(text: "业务七"));
    tabs.add(BadgeTab(text: "业务八", badgeNum: 23));
    tabs.add(BadgeTab(text: "业务九"));
    TabController tabController =
        TabController(length: tabs.length, vsync: this);
    return BrnTabBar(
      controller: tabController,
      tabs: tabs,
      mode: BrnTabBarBadgeMode.origin,
      isScroll: false,
      labelPadding: EdgeInsets.only(left: 20, right: 12),
      indicatorPadding: EdgeInsets.only(left: 10),
      onTap: (state, index) {},
    );
  }
}
