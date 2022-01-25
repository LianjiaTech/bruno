import 'dart:core';

import 'package:bruno/src/components/gallery/config/brn_basic_gallery_config.dart';
import 'package:bruno/src/components/gallery/config/brn_controller.dart';
import 'package:bruno/src/components/gallery/page/brn_gallery_summary_page.dart';
import 'package:bruno/src/components/navbar/brn_appbar.dart';
import 'package:bruno/src/components/tabbar/normal/brn_tab_bar.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:bruno/src/theme/configs/brn_appbar_config.dart';
import 'package:bruno/src/theme/configs/brn_gallery_detail_config.dart';
import 'package:bruno/src/theme/configs/brn_tabbar_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 查看大图交互模式-详情页
/// 组件提供了（列表页<-->详情页）这种交互模式的骨架，
/// 适用于查看图片，视频 PDF 等场景。
/// 默认只实现了图片的查看，如果想要扩展视频或者pdf自行扩展配置接口可实现。
/// ignore: must_be_immutable
class BrnGalleryDetailPage extends StatefulWidget {
  /// 该交互下所有 item 的配置集合
  final List<BrnBasicGroupConfig> allConfig;

  /// 初始位于第几组，默认 0
  final initGroupId;

  /// 初始位于组内的第几个，默认 0
  final initIndexId;

  /// 是否来自于列表页，一般情况不要使用，默认 false
  final bool fromSummary;

  /// 右上角自定义设置按钮，若为空，则展示 "全部图片"
  final Widget Function(int? groupId, int? indexId)? detailRightAction;

  /// 控制图片查看刷新
  final BrnGalleryController? controller;

  /// 主题配置
  BrnGalleryDetailConfig? themeData;

  BrnGalleryDetailPage(
      {Key? key,
      required this.allConfig,
      this.initGroupId = 0,
      this.initIndexId = 0,
      this.fromSummary = false,
      this.detailRightAction,
      this.controller,
      this.themeData})
      : super(key: key) {
    this.themeData ??= BrnGalleryDetailConfig();
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .galleryDetailConfig
        .merge(this.themeData);
  }

  @override
  _BrnGalleryDetailPageState createState() => _BrnGalleryDetailPageState();
}

class _BrnGalleryDetailPageState extends State<BrnGalleryDetailPage>
    with TickerProviderStateMixin {
  /// title 关联的通知，因为 title 与图片所处的位置关联
  ValueNotifier<String>? _titleNotifier;
  TabController? _tabController;
  List<BrnBasicGroupConfig> _allConfig = <BrnBasicGroupConfig>[];
  int? _curTab;
  int? _curIndex;
  bool _assorted = false;
  List<Widget> _columnViews = <Widget>[];
  List<BadgeTab> _tabs = <BadgeTab>[];
  String _groupTitle = "";
  String _indexTitle = "";
  PageController? _pageController;
  List<Widget> _pageViews = <Widget>[];
  Map _groupStartPosition = Map();
  Map _groupCount = Map();
  int _allCount = 0;
  BrnAppBarConfig? _appBarConfig;

  late BrnTabBarConfig _tabBarConfig;

  @override
  void initState() {
    super.initState();

    // 打平 appbar
    _appBarConfig = BrnThemeConfigurator.instance
        .getConfig(configId: widget.themeData!.configId)
        .appBarConfig
        .merge(BrnAppBarConfig(
            titleStyle: widget.themeData!.appbarTitleStyle,
            backgroundColor: widget.themeData!.appbarBackgroundColor,
            actionsStyle: widget.themeData!.appbarActionStyle));

    // 打平 tabBar
    _tabBarConfig = BrnThemeConfigurator.instance
        .getConfig(configId: widget.themeData!.configId)
        .tabBarConfig
        .merge(BrnTabBarConfig(
          unselectedLabelStyle: widget.themeData!.tabBarUnSelectedLabelStyle,
          labelStyle: widget.themeData!.tabBarLabelStyle,
          backgroundColor: widget.themeData!.tabBarBackgroundColor,
        ));

    _curIndex = widget.initIndexId;
    _curTab = widget.initGroupId;
    if (widget.controller != null) {
      widget.controller!.addListener(_refreshByController);
    }
  }

  @override
  void didUpdateWidget(BrnGalleryDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null &&
        oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_refreshByController);
      widget.controller!.addListener(_refreshByController);
    }
  }

  void _refreshByController() {
    if (mounted) {
      _curIndex = widget.controller!.indexId;
      _curTab = widget.controller!.groupId;
      setState(() {});
    }
  }

  /// 根据groupIndex和index查page的位置
  int? _getPagePosition(int? groupIndex, int? index) {
    return _groupStartPosition[groupIndex] + index;
  }

  /// 根据page的位置反查groupIndex和index
  List<int> _getGroupIndexAndIndex(int pagePosition) {
    List<int> result = <int>[];
    MapEntry entry = _groupStartPosition.entries.toList().firstWhere((entry) {
      return (entry.value > pagePosition);
    });
    result.add(entry.key - 1);
    result.add(pagePosition - (_groupStartPosition[entry.key - 1]) as int);
    return result;
  }

  void _reset() {
    _pageViews.clear();
    _tabs.clear();
    _columnViews.clear();
    _allConfig.clear();
    // 过滤 config 中内容为空的选项
    widget.allConfig.forEach((e) {
      if (e.configList != null && e.configList!.isNotEmpty) {
        _allConfig.add(e);
      }
    });

    _allCount = 0;
    _groupCount.clear();
    _groupStartPosition.clear();
    _titleNotifier = null;
    _tabController = null;
  }

  void _buildViews() {
    _reset();
    _titleNotifier = ValueNotifier<String>('');
    _tabController = TabController(
        length: _allConfig.length, vsync: this, initialIndex: _curTab!)
      ..addListener(() {
        _curTab = _tabController!.index;
      });

    int i = 0;
    for (; i < _allConfig.length; i++) {
      _groupStartPosition[i] = _allCount;
      _allCount += _allConfig[i].configList!.length;
      _groupCount[i] = _allConfig[i].configList!.length;
    }
    _groupStartPosition[i] = _allCount;

    _pageController =
        PageController(initialPage: _getPagePosition(_curTab, _curIndex)!);
    _assorted = _allConfig.length > 1;

    _allConfig.forEach((item) => _tabs.add(
        BadgeTab(text: '${item.title ?? ""}(${item.configList!.length})')));
    if (_allConfig.length > 1)
      _columnViews.add(BrnTabBar(
        backgroundcolor: _tabBarConfig.backgroundColor,
        unselectedLabelStyle:
            _tabBarConfig.unselectedLabelStyle.generateTextStyle(),
        unselectedLabelColor: _tabBarConfig.unselectedLabelStyle.color,
        labelColor: _tabBarConfig.labelStyle.color,
        indicatorColor: _tabBarConfig.labelStyle.color,
        labelStyle: _tabBarConfig.labelStyle.generateTextStyle(),
        tabs: _tabs,
        controller: _tabController,
        onTap: (state, index) {
          _pageController!.animateToPage(_getPagePosition(index, 0)!,
              duration: Duration(microseconds: 100), curve: Curves.linear);
        },
      ));

    for (int i = 0; i < _allConfig.length; i++) {
      for (int j = 0; j < _allConfig[i].configList!.length; j++) {
        _pageViews.add(_allConfig[i]
            .configList![j]
            .buildDetailWidget(context, _allConfig, i, j));
      }
    }
    _groupTitle = _allConfig[_curTab!].title ?? "";
    _indexTitle =
        "${_curIndex! + 1}/${_allConfig[_curTab!].configList!.length}";
    _titleNotifier?.value =
        _assorted ? "$_groupTitle($_indexTitle)" : "$_indexTitle";

    _columnViews.add(Expanded(
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) async {
          //当滑动时动态改变title信息以及确认tab是否需要切换
          await _moveToIndex(index);
        },
        children: _pageViews,
      ),
    ));
  }

  Future<void>? _moveToIndex(index) {
    // 改变 title
    List<int> pos = _getGroupIndexAndIndex(index);
    _indexTitle = "${pos[1] + 1}/${_groupCount[pos[0]]}";
    _groupTitle = _allConfig[pos[0]].title ?? "";
    _curIndex = pos[1];
    // 处理是是否需要切换 tab
    if (_curTab != pos[0]) {
      _curTab = pos[0];
      _tabController!.animateTo(pos[0]);
    }
    _titleNotifier?.value =
        _assorted ? "$_groupTitle($_indexTitle)" : "$_indexTitle";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _buildViews();
    return Scaffold(
      key: GlobalKey(),
      appBar: BrnAppBar(
        brightness: widget.themeData!.appbarBrightness,
        backgroundColor: _appBarConfig!.backgroundColor,
        showDefaultBottom: false,
        themeData: _appBarConfig,
        title: ValueListenableBuilder(
          valueListenable: _titleNotifier!,
          builder: (c, String v, _) {
            return Text(
              v,
              style: _appBarConfig!.titleStyle.generateTextStyle(),
            );
          },
        ),
        actions: widget.detailRightAction != null
            ? ValueListenableBuilder(
                builder: (c, v, _) =>
                    widget.detailRightAction!(_curTab, _curIndex),
                valueListenable: _titleNotifier!,
              )
            : BrnTextAction(
                '全部图片',
                themeData: _appBarConfig,
                iconPressed: () {
                  if (widget.fromSummary) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) {
                      return BrnGallerySummaryPage(
                        controller: widget.controller,
                        allConfig: _allConfig,
                        fromDetail: true,
                      );
                    })).then((result) {
                      if (result is List) {
                        _tabController!.animateTo(result[0]);
                        _pageController!.jumpToPage(
                            _getPagePosition(result[0], result[1])!);
                      }
                    });
                  }
                },
              ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if (_allConfig.isEmpty) return Row();
    return NotificationListener(
      child: Container(
        color: widget.themeData!.pageBackgroundColor,
        child: Column(
          children: _columnViews,
        ),
      ),
    );
  }
}
