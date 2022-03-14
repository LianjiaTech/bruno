

import 'package:bruno/src/components/line/brn_line.dart';
import 'package:bruno/src/components/tabbar/indicator/brn_custom_width_indicator.dart';
import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/material.dart';

/// 描述: 一级切换标题

class BrnSwitchTitle extends StatefulWidget {
  /// 标题的文案列表
  final List<String> nameList;

  /// 默认选中index
  /// 默认值0
  final int defaultSelectIndex;

  /// 选中时的回调
  /// index 选中的title的索引
  final void Function(int index)? onSelect;

  /// 标题的 padding，默认 `EdgeInsets.fromLTRB(0, 14, 20, 14)`
  final EdgeInsets padding;

  /// 下划线的高度，默认是 2
  final double indicatorWeight;

  /// 下划线的宽度，默认是 24。indicatorWidth 要大于等于 indicatorWeight。
  final double indicatorWidth;

  /// 控制tab切换，默认不需要传递
  /// 只在需要外部控制tab切换时传递
  final TabController? controller;

  /// 选中时的标题样式，默认 `TextStyle(fontWeight: FontWeight.w600,fontSize: 18)`
  final TextStyle? selectedTextStyle;

  /// 未选中时的标题样式，默认 `TextStyle(fontWeight: FontWeight.w600,fontSize: 18)`
  final TextStyle? unselectedTextStyle;

  const BrnSwitchTitle(
      {Key? key,
      required this.nameList,
      this.defaultSelectIndex = 0,
      this.onSelect,
      this.indicatorWeight = 2.0,
      this.indicatorWidth = 24.0,
      this.padding = const EdgeInsets.fromLTRB(0, 14, 20, 14),
      this.controller,
      this.selectedTextStyle,
      this.unselectedTextStyle})
      : super(key: key);

  @override
  _BrnSwitchTitleState createState() => _BrnSwitchTitleState();
}

class _BrnSwitchTitleState extends State<BrnSwitchTitle>
    with TickerProviderStateMixin {
  static final Color _color = Color(0XFF243238);

  TabController? _controller;

  int _defaultSelectIndex = 0;

  @override
  void didUpdateWidget(BrnSwitchTitle oldWidget) {
    super.didUpdateWidget(oldWidget);
    _defaultSelectIndex = widget.defaultSelectIndex;
    if (_controller != null) {
      _controller!.index = _defaultSelectIndex;
    }
  }

  @override
  void initState() {
    super.initState();
    _defaultSelectIndex = widget.defaultSelectIndex;
    _controller = widget.controller ??
        TabController(
          initialIndex: _defaultSelectIndex,
          length: widget.nameList.length,
          vsync: this,
        );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.nameList.length > 1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _toggleButtonsWidget(context),
          BrnLine(),
        ],
      );
    } else {
      return _toggleButtonsWidget(context);
    }
  }

  Widget _toggleButtonsWidget(context) {
    if (widget.nameList.isEmpty) {
      return Container(
        height: 0,
        width: 0,
      );
    }

    List<Widget> widgetChildren = widget.nameList.map((name) {
      Text tx = Text(name);

      /// 有下划线的时候，需要将下划线的高度3减去
      double tempBottomPadding = widget.padding.bottom;
      double bottomPadding = widget.nameList.length == 1
          ? tempBottomPadding
          : tempBottomPadding - 3;
      if (bottomPadding < 0) {
        bottomPadding = 0;
      }

      return Container(
        padding: EdgeInsets.fromLTRB(widget.padding.left, widget.padding.top,
            widget.padding.right, bottomPadding),
        child: tx,
      );
    }).toList();

    Decoration _indicator = CustomWidthUnderlineTabIndicator(
      width: widget.indicatorWidth,
      insets: EdgeInsets.only(
          left: widget.padding.left, right: widget.padding.right),
      borderSide: BorderSide(
        width: widget.indicatorWeight,
        color:
            BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary,
      ),
    );

    return Container(
      color: Colors.white,
      child: TabBar(
        isScrollable: true,
        tabs: widgetChildren,
        controller: _controller,
        //选中态颜色，只有一个item时，默认黑色加粗，多个item时为主题色
        labelColor: widget.nameList.length == 1
            ? _color
            : BrnThemeConfigurator.instance
                .getConfig()
                .commonConfig
                .brandPrimary,
        labelStyle: widget.selectedTextStyle ??
            TextStyle(
              //选中态
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
        // 设置为 0 完全由外部的 padding 控制间距
        labelPadding: const EdgeInsets.all(0),
        //未选中态颜色
        unselectedLabelColor: _color,
        //未选中态样式
        unselectedLabelStyle: widget.unselectedTextStyle ??
            TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
        indicator: widget.nameList.length == 1 ? BoxDecoration() : _indicator,
        // weight 设置为0，让外部通过 padding 设置下划线和标题间的距离
        indicatorWeight: 0,
        onTap: (index) {
          if (null != widget.onSelect && widget.nameList.length > 1) {
            widget.onSelect!(index);
          }
        },
      ),
    );
  }
}
