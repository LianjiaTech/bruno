

import 'package:bruno/src/theme/brn_theme_configurator.dart';
import 'package:flutter/material.dart';

/// 描述: 二级切换标题

class BrnSubSwitchTitle extends StatefulWidget {
  /// 标题的文案列表
  final List<String> nameList;

  /// 默认选中index
  /// 默认值0
  final int defaultSelectIndex;

  /// 选中回调
  final void Function(int index)? onSelect;

  /// 二级标题的padding
  /// 默认 EdgeInsets.only(right: 20)
  final EdgeInsets? padding;

  /// tab切换控制器，默认不需要传递
  final TabController? controller;

  const BrnSubSwitchTitle({
    Key? key,
    required this.nameList,
    this.defaultSelectIndex = 0,
    this.onSelect,
    this.padding,
    this.controller,
  }) : super(key: key);

  @override
  _BrnSubSwitchTitleState createState() => _BrnSubSwitchTitleState();
}

class _BrnSubSwitchTitleState extends State<BrnSubSwitchTitle>
    with TickerProviderStateMixin {
  List<Widget>? widgetList;

  TabController? _controller;

  int _defaultSelectIndex = 0;

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
  void didUpdateWidget(BrnSubSwitchTitle oldWidget) {
    super.didUpdateWidget(oldWidget);
    _defaultSelectIndex = widget.defaultSelectIndex;
    if (_controller != null) {
      _controller!.index = _defaultSelectIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _toggleButtonsWidget(context);
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
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
        ),
        padding: widget.padding ?? EdgeInsets.only(right: 20),
        child: tx,
      );
    }).toList();

    return TabBar(
      controller: _controller,
      isScrollable: true,
      tabs: widgetChildren,
      //设置之后不显示底部下划线
      indicator: const BoxDecoration(),
      indicatorWeight: 0,
      //选中态颜色，只有一个item时，默认黑色加粗，多个item时为主题色
      labelColor: widget.nameList.length == 1
          ? BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase
          : BrnThemeConfigurator.instance.getConfig().commonConfig.brandPrimary,
      labelStyle: TextStyle(
        //选中态
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      labelPadding: EdgeInsets.all(0),
      //未选中态颜色
      unselectedLabelColor:
          BrnThemeConfigurator.instance.getConfig().commonConfig.colorTextBase,
      //未选中态样式
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      onTap: (index) {
        if (null != widget.onSelect) {
          widget.onSelect!(index);
        }
      },
    );
  }
}
