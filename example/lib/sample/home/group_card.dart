

import 'package:bruno/bruno.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:example/sample/home/card_data_config.dart';
import 'package:example/sample/home/expandable_container_widget.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatefulWidget {
  final GroupInfo? groupInfo;

  GroupCard({
    Key? key,
    this.groupInfo,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GroupCardState();
  }
}

class GroupCardState extends State<GroupCard>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);
  BrnExpandableContainerController? _controller;
  Widget? _arrowIcon;
  late Animation<double> _iconTurns;
  late bool _initExpand;
  AnimationController? _animationController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = BrnExpandableContainerController();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _initExpand = widget.groupInfo!.isExpand;
    _iconTurns = _animationController!.drive(_halfTween.chain(_easeInTween));
    if (_initExpand) {
      _arrowIcon = Icon(Icons.keyboard_arrow_up);
    } else {
      _arrowIcon = Icon(Icons.keyboard_arrow_down);
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BrnPickerClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      child: BrnExpandableContainerWidget(
        key: widget.key,
        expandableController: _controller,
        initiallyExpanded: _initExpand,
        onExpansionChanged: (isExpand) {
          if (isExpand) {
            _arrowIcon = Icon(Icons.keyboard_arrow_up);
          } else {
            _arrowIcon = Icon(Icons.keyboard_arrow_down);
          }
          widget.groupInfo!.isExpand = isExpand;
        },
        headerBuilder: (_) {
          return GestureDetector(
            onTap: () {
              _controller?.toggle();
            },
            child: Container(
              color: Color(0xFFEEEEEE),
              padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    widget.groupInfo!.groupName,
                    style: TextStyle(color: Color(0xFF222222), fontSize: 18),
                  )),
                  RotationTransition(
                    turns: _iconTurns,
                    child: _arrowIcon,
                  )
                ],
              ),
            ),
          );
        },
        child: _getContentWidget(),
      ),
    );
  }

  Widget _getContentWidget() {
    if (widget.groupInfo == null || widget.groupInfo!.children == null) {
      return const SizedBox.shrink();
    }
    return ListView.builder(
      physics: new NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.groupInfo?.children?.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.white,
          child: ListItem(
            isSupportTheme:
                widget.groupInfo?.children![index].isSupportTheme ?? false,
            isShowLine: !(index == 0),
            title: widget.groupInfo?.children![index].groupName ?? '',
            describe: widget.groupInfo?.children![index].desc ?? '',
            onPressed: () {
              if (widget.groupInfo?.children != null &&
                  widget.groupInfo?.children![index].navigatorPage != null) {
                widget.groupInfo?.children![index].navigatorPage!(context);
              }
            },
          ),
        );
      },
    );
  }
}
