import 'package:badges/badges.dart';
import 'package:bruno/src/components/popup/brn_measure_size.dart';
import 'package:bruno/src/components/tabbar/indicator/brn_custom_width_indicator.dart';
import 'package:bruno/src/components/tabbar/normal/brn_tabbar_controller.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/brn_theme.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 单个tab选中的回调
/// [state]:当前组件的State对象，[BrnTabBarState]
/// [index]:当前组件的角标
typedef BrnTabBarOnTap = Function(BrnTabBarState state, int index);

const double _tagDefaultSize = 75.0;

/// 带小红点的Tabbar
// ignore: must_be_immutable
class BrnTabBar extends StatefulWidget {
  /// BrnTabBarBadge填充的数据，长度匹配控制器的TabController.length
  final List<BadgeTab>? tabs;

  /// [BrnTabBar] 的tab模式
  /// 默认：[BrnTabBarBadgeMode.average]（按照屏幕平均分配模式）
  final BrnTabBarBadgeMode mode;

  /// 是否能滑动(当tab数量大于4个，默认都是滚动的，再设置此属性无效)
  final bool isScroll;

  /// Tabbar的整体高度
  final double? tabHeight;

  /// TabBar的padding
  final EdgeInsetsGeometry padding;

  /// 控制Tab的切换
  final TabController? controller;

  /// TabBar背景颜色
  final Color backgroundcolor;

  /// 指示器的颜色
  final Color? indicatorColor;

  /// 指示器的高度
  final double? indicatorWeight;

  /// 指示器的宽度
  final double? indicatorWidth;

  final EdgeInsetsGeometry indicatorPadding;

  /// 选中Tab文本的颜色
  final Color? labelColor;

  /// 选中Tab文本的样式
  final TextStyle? labelStyle;

  /// Tab文本的Padding
  final EdgeInsetsGeometry labelPadding;

  /// 未选中Tab文本的颜色
  final Color? unselectedLabelColor;

  /// 未中Tab文本的样式
  final TextStyle? unselectedLabelStyle;

  /// 处理拖拽开始行为方式，默认DragStartBehavior.start
  final DragStartBehavior dragStartBehavior;

  /// Tab的选中点击事件
  final BrnTabBarOnTap? onTap;

  /// 添加的Tab的宽度(指定tabWidth就不会均分屏幕宽度)
  final double? tabWidth;

  /// 是否显示分隔线
  final bool hasDivider;

  /// 是否显示角标
  final bool hasIndex;

  /// 展开更多Tabs
  final bool showMore;

  /// 展开更多弹框标题
  final String? moreWindowText;

  /// 更多弹框弹出的时候
  final VoidCallback? onMorePop;

  /// 更多弹框关闭控制器
  final BrnCloseWindowController? closeController;

  /// tag间距
  final double? tagSpacing;

  /// 每行tag数
  final int? preLineTagCount;

  /// tag高度
  final double? tagHeight;

  BrnTabBarConfig? themeData;

  BrnTabBar({
    required this.tabs,
    this.mode = BrnTabBarBadgeMode.average,
    this.isScroll = false,
    this.tabHeight,
    this.padding = EdgeInsets.zero,
    this.controller,
    this.backgroundcolor = const Color(0xffffffff),
    this.indicatorColor,
    this.indicatorWeight,
    this.indicatorWidth,
    this.indicatorPadding = EdgeInsets.zero,
    this.labelColor,
    this.labelStyle,
    this.labelPadding = EdgeInsets.zero,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onTap,
    this.tabWidth,
    this.hasDivider = false,
    this.hasIndex = false,
    this.showMore = false,
    this.moreWindowText,
    this.onMorePop,
    this.closeController,
    this.themeData,
    this.tagSpacing,
    this.preLineTagCount,
    this.tagHeight,
  }) : assert(tabs == null || tabs is List<BadgeTab>) {
    this.themeData ??= BrnTabBarConfig();
    this.themeData = this.themeData!.merge(BrnTabBarConfig(
          backgroundColor: backgroundcolor,
          tabHeight: tabHeight,
          indicatorHeight: indicatorWeight,
          indicatorWidth: indicatorWidth,
          labelStyle: BrnTextStyle.withStyle(labelStyle),
          unselectedLabelStyle: BrnTextStyle.withStyle(unselectedLabelStyle),
          tagSpacing: tagSpacing,
          preLineTagCount: preLineTagCount,
          tagHeight: tagHeight,
        ));
    this.themeData = BrnThemeConfigurator.instance
        .getConfig(configId: this.themeData!.configId)
        .tabBarConfig
        .merge(this.themeData);
  }

  @override
  BrnTabBarState createState() => BrnTabBarState(closeController);
}

/// BrnTabBarBadge的tab分配模式
enum BrnTabBarBadgeMode {
  /// 原始的默认TabBar的分配模式
  origin,

  /// 默认的按照4.5等分模式
  average
}

class BrnTabBarState extends State<BrnTabBar> {
  /// 小红点容器的样式
  late BadgeShape _badgeShape;

  /// 小红点文案
  late String _badgeText;

  /// 小红点容器内边距
  late EdgeInsets _badgePadding;

  /// 小红点上偏移量
  double _paddingTop = 0;

  /// 小红点右偏移量
  double _paddingRight = 0;

  /// 小红点圆角
  late BorderRadiusGeometry _borderRadius;

  /// 展开更多的按钮宽度
  final double _moreSpacing = 50;

  /// BrnTabBarBadge展开更多数据处理控制器
  late BrnTabbarController _brnTabbarController;

  /// BrnTabBarBadge展开更多关闭处理控制器
  BrnCloseWindowController? _closeWindowController;

  BrnTabBarState(BrnCloseWindowController? closeController) {
    this._closeWindowController = closeController;
  }

  @override
  void initState() {
    super.initState();
    _brnTabbarController = BrnTabbarController();
    // 监听更多弹框tab选中变化的时候
    _brnTabbarController.addListener(() {
      _closeWindowController?.syncWindowState(_brnTabbarController.isShow);
      // 更新TabBar选中位置
      if (widget.controller != null) {
        widget.controller!.animateTo(_brnTabbarController.selectIndex);
      }
      // 刷新选中TabBar小红点
      refreshBadgeState(_brnTabbarController.selectIndex);
      // 更新Tabbar更多图标样式
      setState(() {});
    });

    _closeWindowController?.getCloseController().stream.listen((event) {
      _brnTabbarController.hide();
      _brnTabbarController.entry?.remove();
      _brnTabbarController.entry = null;
    });

    widget.controller?.addListener(_handleTabIndexChangeTick);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.removeListener(_handleTabIndexChangeTick);
  }

  void _handleTabIndexChangeTick() {
    if (widget.controller?.index.toDouble() ==
        widget.controller?.animation?.value) {
      _brnTabbarController.selectIndex = widget.controller?.index ?? 0;
      _brnTabbarController.isShow = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      constraints: BoxConstraints(minHeight: widget.themeData!.tabHeight),
      color: widget.themeData!.backgroundColor,
      child: widget.showMore
          ? Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - _moreSpacing,
            child: _buildTabBar(),
          ),
          showMoreWidget(context)
        ],
      )
          : _buildTabBar(),
    );
  }

  // 构建TabBar样式
  TabBar _buildTabBar() {
    return TabBar(
        tabs: fillWidgetByDataList(),
        controller: widget.controller,
        isScrollable: widget.tabs!.length > 4 ||
            widget.tabWidth != null ||
            widget.isScroll,
        labelColor: widget.labelColor ?? widget.themeData!.labelStyle.color,
        labelStyle: widget.labelStyle ??
            widget.themeData!.labelStyle.generateTextStyle(),
        labelPadding: widget.labelPadding,
        unselectedLabelColor: widget.unselectedLabelColor ??
            widget.themeData!.unselectedLabelStyle.color,
        unselectedLabelStyle: widget.unselectedLabelStyle ??
            widget.themeData!.unselectedLabelStyle.generateTextStyle(),
        dragStartBehavior: widget.dragStartBehavior,
        onTap: (index) {
          if (widget.onTap != null) {
            widget.onTap!(this, index);
            _brnTabbarController.setSelectIndex(index);
            _brnTabbarController.isShow = false;
            _brnTabbarController.entry?.remove();
            _brnTabbarController.entry = null;
          }
        },
        indicator: CustomWidthUnderlineTabIndicator(
          insets: widget.indicatorPadding,
          borderSide: BorderSide(
            width: widget.themeData!.indicatorHeight,
            color: widget.indicatorColor ?? widget.themeData!.labelStyle.color!,
          ),
          width: widget.themeData!.indicatorWidth,
        ));
  }

  // 展开更多Widget
  Widget showMoreWidget(BuildContext context) {
    return Visibility(
      visible: widget.showMore,
      child: GestureDetector(
        onTap: () {
          if (!_brnTabbarController.isShow &&
              widget.controller!.index.toDouble() ==
                  widget.controller!.animation!.value) {
            _brnTabbarController.show();
            if (widget.onMorePop != null) {
              widget.onMorePop!();
            }
            showMoreWindow(context);
            setState(() {});
          } else {
            hideMoreWindow();
            setState(() {});
          }
        },
        child: Container(
            width: _moreSpacing,
            height: widget.themeData!.tabHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0x05000000),
                    offset: Offset(-3, 0),
                    spreadRadius: -1)
              ],
            ),
            child: !_brnTabbarController.isShow
                ? BrunoTools.getAssetImage(BrnAsset.iconTriangleDown)
                : BrunoTools.getAssetImageWithBandColor(
                    BrnAsset.iconTriangleUp)),
      ),
    );
  }

  // 更新选中tab的小红点状态
  void refreshBadgeState(int index) {
    setState(() {
      BadgeTab badgeTab = widget.tabs![index];
      if (badgeTab.isAutoDismiss) {
        badgeTab.badgeNum = null;
        badgeTab.badgeText = null;
        badgeTab.showRedBadge = false;
      }
    });
  }

  List<Widget> fillWidgetByDataList() {
    List<Widget> widgets = <Widget>[];
    List<BadgeTab>? tabList = widget.tabs;
    if (tabList != null && tabList.isNotEmpty) {
      double? minWidth;
      if (widget.tabWidth != null) {
        minWidth = widget.tabWidth;
      } else {
        double tabUseWidth = widget.showMore
            ? MediaQuery.of(context).size.width - _moreSpacing
            : MediaQuery.of(context).size.width;
        if (tabList.length <= 4) {
          minWidth = tabUseWidth / tabList.length;
        } else {
          minWidth = tabUseWidth / 4.5;
        }
      }
      for (int i = 0; i < tabList.length; i++) {
        BadgeTab badgeTab = tabList[i];
        if (widget.mode == BrnTabBarBadgeMode.average) {
          widgets.add(
              _wrapAverageWidget(badgeTab, minWidth, i == tabList.length - 1));
        } else {
          widgets.add(_wrapOriginWidget(badgeTab, i == tabList.length - 1));
        }
      }
    }
    return widgets;
  }

  // 原始的自适应的tab样式
  Widget _wrapOriginWidget(BadgeTab badgeTab, bool lastElement) {
    caculateBadgeParams(badgeTab);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 47,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                  visible: widget.hasIndex && badgeTab.topText != null,
                  child: Text(
                    badgeTab.topText ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Badge(
                showBadge: (badgeTab.badgeNum != null
                        ? badgeTab.badgeNum! > 0
                        : false) ||
                    badgeTab.showRedBadge ||
                    (badgeTab.badgeText != null
                        ? badgeTab.badgeText!.isNotEmpty
                        : false),
                badgeContent: Text(
                  _badgeText,
                  style: TextStyle(
                      color: Color(0xFFFFFFFF), fontSize: 10, height: 1),
                ),
                shape: _badgeShape,
                elevation: 0,
                toAnimate: false,
                borderRadius: _borderRadius,
                alignment: Alignment.topLeft,
                padding: _badgePadding,
                position:
                    BadgePosition.topEnd(top: _paddingTop, end: _paddingRight),
                child: Text(badgeTab.text!,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis),
              )
            ],
          ),
        ),
        Visibility(
          visible: widget.hasDivider && !lastElement,
          child: Container(
            width: 1,
            height: 20,
            color: Color(0xffe4e6f0),
          ),
        )
      ],
    );
  }

  // 定制的等分tab样式
  Widget _wrapAverageWidget(
      BadgeTab badgeTab, double? minWidth, bool lastElement) {
    caculateBadgeParams(badgeTab);
    return Container(
      width: minWidth,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Container(
            alignment: Alignment.center,
            height: 47,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Visibility(
                    visible: widget.hasIndex && badgeTab.topText != null,
                    child: Text(
                      badgeTab.topText ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                Badge(
                  showBadge: (badgeTab.badgeNum != null
                          ? badgeTab.badgeNum! > 0
                          : false) ||
                      badgeTab.showRedBadge ||
                      (badgeTab.badgeText != null
                          ? badgeTab.badgeText!.isNotEmpty
                          : false),
                  badgeContent: Text(
                    _badgeText,
                    style: TextStyle(
                        color: Color(0xFFFFFFFF), fontSize: 10, height: 1),
                  ),
                  shape: _badgeShape,
                  elevation: 0,
                  toAnimate: false,
                  borderRadius: _borderRadius,
                  alignment: Alignment.topLeft,
                  padding: _badgePadding,
                  position: BadgePosition.topEnd(
                      top: _paddingTop, end: _paddingRight),
                  child: Text(badgeTab.text!,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          )),
          Visibility(
            visible: widget.hasDivider && !lastElement,
            child: Container(
              width: 1,
              height: 20,
              color: Color(0xffe4e6f0),
            ),
          )
        ],
      ),
    );
  }

  // 计算小红点尺寸相关参数
  void caculateBadgeParams(BadgeTab badgeTab) {
    if (badgeTab.badgeNum != null) {
      if (badgeTab.badgeNum! < 10) {
        _badgePadding = EdgeInsets.all(5);
        _badgeShape = BadgeShape.circle;
        _badgeText = badgeTab.badgeNum?.toString() ?? "";
        _paddingTop = -8;
        _paddingRight = -18;
        _borderRadius = BorderRadius.all(Radius.circular(8.5));
      } else if (badgeTab.badgeNum! > 99) {
        _badgePadding = EdgeInsets.fromLTRB(4, 3, 4, 2);
        _badgeShape = BadgeShape.square;
        _badgeText = "99+";
        _paddingRight = -27;
        _paddingTop = -5;
        _borderRadius = BorderRadius.all(Radius.circular(8.5));
      } else {
        _badgePadding = EdgeInsets.fromLTRB(4, 3, 4, 2);
        _badgeShape = BadgeShape.square;
        _badgeText = badgeTab.badgeNum?.toString() ?? "";
        _paddingTop = -5;
        _paddingRight = -20;
        _borderRadius = BorderRadius.all(Radius.circular(8.5));
      }
    } else {
      if (badgeTab.badgeText != null && badgeTab.badgeText!.isNotEmpty) {
        _badgePadding = EdgeInsets.fromLTRB(5, 3, 5, 2);
        _badgeShape = BadgeShape.square;
        _badgeText = badgeTab.badgeText?.toString() ?? "";
        _paddingTop = -5;
        _paddingRight = -20;
        _borderRadius = BorderRadius.only(
            topLeft: Radius.circular(8.5),
            topRight: Radius.circular(8.5),
            bottomRight: Radius.circular(8.5),
            bottomLeft: Radius.circular(0));
      } else {
        _badgePadding = EdgeInsets.all(4);
        _badgeShape = BadgeShape.circle;
        _badgeText = "";
        _paddingRight = -8;
        _borderRadius = BorderRadius.all(Radius.circular(8.5));
      }
    }
  }

  // 展开更多
  void showMoreWindow(BuildContext context) {
    final RenderBox dropDownItemRenderBox =
        context.findRenderObject() as RenderBox;
    var position =
        dropDownItemRenderBox.localToGlobal(Offset.zero, ancestor: null);
    var size = dropDownItemRenderBox.size;
    _brnTabbarController.top = size.height + position.dy;

    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return GestureDetector(
        onTap: () {
          hideMoreWindow();
        },
        onVerticalDragStart: (_) {
          hideMoreWindow();
        },
        onHorizontalDragStart: (_) {
          hideMoreWindow();
        },
        child: Container(
          padding: EdgeInsets.only(
            top: _brnTabbarController.top!,
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                width: MediaQuery.of(context).size.width,
                left: 0,
                child: Material(
                  color: Color(0xB3000000),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                        _brnTabbarController.top!,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: _TabBarOverlayWidget(
                        tabs: widget.tabs,
                        moreWindowText: widget.moreWindowText,
                        brnTabbarController: _brnTabbarController,
                        themeData: widget.themeData!,
                        spacing: widget.themeData!.tagSpacing,
                        preLineTagCount: widget.themeData!.preLineTagCount,
                        tagHeight: widget.themeData!.tagHeight,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
    _brnTabbarController.screenHeight = MediaQuery.of(context).size.height;
    if (_brnTabbarController.entry != null) {
      resetEntry();
    }
    _brnTabbarController.entry = overlayEntry;
    Overlay.of(context)!.insert(_brnTabbarController.entry!);
  }

  void resetEntry() {
    _brnTabbarController.entry?.remove();
    _brnTabbarController.entry = null;
  }

  void hideMoreWindow() {
    if (_brnTabbarController.isShow) {
      _brnTabbarController.hide();
      resetEntry();
    }
  }
}

// 更多弹框样式
// ignore: must_be_immutable
class _TabBarOverlayWidget extends StatefulWidget {
  List<BadgeTab>? tabs;

  String? moreWindowText;

  BrnTabbarController? brnTabbarController;

  BrnTabBarConfig themeData;

  /// tag间距
  double spacing;

  /// 每行tag数
  int preLineTagCount;

  /// tag高度
  double? tagHeight;

  _TabBarOverlayWidget(
      {this.tabs,
      this.moreWindowText,
      this.brnTabbarController,
      required this.themeData,
      this.spacing: 12.0,
      this.preLineTagCount: 4,
      this.tagHeight});

  @override
  _TabBarOverlayWidgetState createState() => _TabBarOverlayWidgetState();
}

class _TabBarOverlayWidgetState extends State<_TabBarOverlayWidget> {
  /// tag宽度
  double _tagWidth = _tagDefaultSize;

  double _padding = 20;

  double _parentWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    return createMoreWindowView();
  }

  // 展开更多弹框样式
  Widget createMoreWindowView() {
    return MeasureSize(
      onChange: (size) {
        setState(() {
          _parentWidth = size.width;
        });
      },
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          onVerticalDragStart: (_) {},
          onHorizontalDragStart: (_) {},
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                        visible: widget.moreWindowText != null &&
                            widget.moreWindowText!.isNotEmpty,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            widget.moreWindowText ?? "",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff222222),
                                fontWeight: FontWeight.w700),
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.only(top: 12),
                      child: _createMoreItems(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createMoreItems() {
    // 计算tag的宽度
    _tagWidth = (_parentWidth -
            widget.spacing * (widget.preLineTagCount - 1) -
            _padding * 2) /
        widget.preLineTagCount;
    _tagWidth = _tagWidth <= _tagDefaultSize ? _tagDefaultSize : _tagWidth;
    List<Widget> widgets = <Widget>[];
    List<BadgeTab>? tabList = widget.tabs;
    if (tabList != null && tabList.isNotEmpty) {
      for (int i = 0; i < tabList.length; i++) {
        BadgeTab badgeTab = tabList[i];
        widgets.add(_createMoreItemWidget(badgeTab, i));
      }
    }
    return Wrap(
      spacing: widget.spacing,
      runSpacing: 12,
      children: widgets,
    );
  }

  Widget _createMoreItemWidget(BadgeTab badgeTab, int index) {
    return GestureDetector(
      onTap: () {
        if (widget.brnTabbarController!.selectIndex == index) {
          widget.brnTabbarController?.setSelectIndex(index);
          widget.brnTabbarController?.isShow = false;
          widget.brnTabbarController?.entry?.remove();
          widget.brnTabbarController?.entry = null;
          setState(() {});
        } else {
          widget.brnTabbarController!.setSelectIndex(index);
          widget.brnTabbarController?.isShow = false;
          widget.brnTabbarController?.entry?.remove();
          widget.brnTabbarController?.entry = null;
          setState(() {});
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: widget.brnTabbarController!.selectIndex == index
                ? widget.themeData.tagSelectedBgColor
                : widget.themeData.tagNormalBgColor,
            borderRadius: BorderRadius.circular(widget.themeData.tagRadius)),
        height: widget.tagHeight,
        width: _tagWidth,
        child: Text(
          badgeTab.text ?? '',
          textAlign: TextAlign.center,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: widget.brnTabbarController!.selectIndex == index
              ? widget.themeData.tagSelectedTextStyle.generateTextStyle()
              : widget.themeData.tagNormalTextStyle.generateTextStyle(),
        ),
      ),
    );
  }
}

class BadgeTab {
  BadgeTab(
      {this.key,
        this.text,
        this.badgeNum,
        this.topText,
        this.badgeText,
        this.showRedBadge = false,
        this.isAutoDismiss = true});

  final Key? key;

  /// Tab文本
  final String? text;

  /// 红点数字
  int? badgeNum;

  /// tab顶部文本信息
  String? topText;

  /// 红点显示的文本
  String? badgeText;

  /// 是否显示小红点，默认badgeNum没设置，不显示
  bool showRedBadge;

  /// 小红点是否自动消失
  bool isAutoDismiss;
}
