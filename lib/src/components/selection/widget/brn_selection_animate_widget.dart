import 'package:bruno/src/components/selection/controller/brn_selection_view_controller.dart';
import 'package:flutter/material.dart';

typedef void MaskClickFunction(int index);

class BrnSelectionAnimationWidget extends StatefulWidget {
  final BrnSelectionListViewController controller;
  final Widget view;
  final int animationMilliseconds;

  const BrnSelectionAnimationWidget(
      {Key key, @required this.controller, @required this.view, this.animationMilliseconds = 100})
      : super(key: key);

  @override
  _BrnSelectionAnimationWidgetState createState() => _BrnSelectionAnimationWidgetState();
}

class _BrnSelectionAnimationWidgetState extends State<BrnSelectionAnimationWidget>
    with SingleTickerProviderStateMixin {
  bool _isControllerDisposed = false;
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onController);
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.animationMilliseconds), vsync: this);
  }

  dispose() {
    widget.controller?.removeListener(_onController);
    _controller.dispose();
    _isControllerDisposed = true;
    super.dispose();
  }

  _onController() {
    _showListViewWidget();
  }

  @override
  Widget build(BuildContext context) {
    _controller.duration = Duration(milliseconds: widget.animationMilliseconds);
    return _buildListViewWidget();
  }

  _showListViewWidget() {
    if (widget.view == null) {
      return;
    }

    _animation =
        Tween(begin: 0.0, end: widget.controller.screenHeight - widget.controller.listViewTop)
            .animate(_controller)
              ..addListener(() {
                //这行如果不写，没有动画效果
                setState(() {});
              });

    if (_isControllerDisposed) return;

    if (_animation.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  Widget _buildListViewWidget() {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      left: 0,
      child: Material(
        color: Color(0xB3000000),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - widget.controller.listViewTop,
          child: Padding(
            padding: EdgeInsets.all(0),
            child: widget.view,
          ),
        ),
      ),
    );
  }
}
