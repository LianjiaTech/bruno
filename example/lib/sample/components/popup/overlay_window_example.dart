

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class OverlayWindowExample extends StatefulWidget {
  final String _title;

  OverlayWindowExample(this._title);

  @override
  State<StatefulWidget> createState() => OverlayWindowExamplePageState();
}

class OverlayWindowExamplePageState extends State<OverlayWindowExample> {
  BrnOverlayController? _overlayController;
  FocusNode _focusNode = FocusNode();
  GlobalKey _searchBarKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: widget._title,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[_searchBar()],
          ),
        ));
  }

  ///
  /// 搜索框
  ///
  Widget _searchBar() {
    return Container(
      child: BrnSearchText(
        key: _searchBarKey,
        innerPadding: EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 8),
        maxHeight: 84,
        innerColor: Colors.white,
        hintText: "请输入小区名称",
        borderRadius: BorderRadius.all(Radius.circular(10)),
        normalBorder: Border.all(
            color: Color(0xFF999999), width: 1, style: BorderStyle.solid),
        activeBorder: Border.all(
            color: Color(0xFF0984F9), width: 1, style: BorderStyle.solid),
        focusNode: _focusNode,
        onTextClear: () {
          _focusNode.unfocus();
          _overlayController?.removeOverlay();
          return false;
        },
        autoFocus: false,
        onActionTap: () {
          _overlayController?.removeOverlay();
        },
        onTextCommit: (text) {
          _overlayController?.removeOverlay();
        },
        onTextChange: (text) {
          if (text == '') {
            _overlayController?.removeOverlay();
            return;
          }
          if (_overlayController == null ||
              _overlayController!.isOverlayShowing == false) {
            _overlayController = BrnOverlayWindow.showOverlayWindow(
                context, _searchBarKey,
                content: _sugListView(),
                autoDismissOnTouchOutSide: true,
                popDirection: BrnOverlayPopDirection.bottom);
          }
        },
      ),
    );
  }

  ///
  /// 搜索sug
  ///
  Widget _sugListView() {
    return Container(
      width: 250,
      height: 200,
      margin: EdgeInsets.only(left: 56),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Center(
          child: Text('1. 可自定义搜索内容视图；\n2.输入关键字时自动展示，清除时自动关闭。',
              style: const TextStyle(color: Colors.white))),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        border: Border.all(color: Color(0xFFEEEEEE), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
  }

  @override
  void dispose() {
    _overlayController?.removeOverlay();
    super.dispose();
  }
}
