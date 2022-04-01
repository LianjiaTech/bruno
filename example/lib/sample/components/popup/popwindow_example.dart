

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class PopWindowExamplePage extends StatefulWidget {
  final String _title;

  PopWindowExamplePage(this._title);

  @override
  State<StatefulWidget> createState() => PopWindowExamplePageState();
}

class PopWindowExamplePageState extends State<PopWindowExamplePage> {
  GlobalKey? _leftKey;
  GlobalKey? _leftKey1;
  GlobalKey? _leftKey2;
  GlobalKey? _leftKey3;
  GlobalKey? _leftKey4;
  GlobalKey? _leftKey5;
  GlobalKey? _leftKey6;
  GlobalKey? _leftKey7;

  BrnOverlayController? overlayController;

  @override
  void initState() {
    super.initState();
    _leftKey = GlobalKey();
    _leftKey1 = GlobalKey();
    _leftKey2 = GlobalKey();
    _leftKey3 = GlobalKey();
    _leftKey4 = GlobalKey();
    _leftKey5 = GlobalKey();
    _leftKey6 = GlobalKey();
    _leftKey7 = GlobalKey();
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
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: ElevatedButton(
                  key: _leftKey,
                  onPressed: () {
                    BrnPopupWindow.showPopWindow(context, "提示内容", _leftKey!,
                        hasCloseIcon: true);
                  },
                  child: Text("左侧带关闭Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  key: _leftKey1,
                  onPressed: () {
                    BrnPopupWindow.showPopWindow(
                        context, "提示内容提示内容提示内容提示内容提示内容提示内容提示内容提示内容", _leftKey1!,
                        hasCloseIcon: false);
                  },
                  child: Text("左侧带无关闭Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  key: _leftKey2,
                  onPressed: () {
                    BrnPopupWindow.showPopWindow(context,
                        "提示内容提示内容提示内容提示内容提示内容提示内容提示内容提示内容提示内容", _leftKey2!,
                        popDirection: BrnPopupDirection.top,
                        hasCloseIcon: true);
                  },
                  child: Text("左侧带关闭，箭头朝下Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  key: _leftKey3,
                  onPressed: () {
                    BrnPopupWindow.showPopWindow(
                        context, "提示内容提示内容提示内容提示内容提示内容提示内容提示内容提示内容", _leftKey3!,
                        dismissCallback: () {},
                        popDirection: BrnPopupDirection.top);
                  },
                  child: Text("左侧无关闭，箭头朝下Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 250),
                child: ElevatedButton(
                  key: _leftKey4,
                  onPressed: () {
                    BrnPopupWindow.showPopWindow(
                        context, "提示内容提示内容提示内容提示内容提示内容提示内容提示内容提示内容", _leftKey4!,
                        hasCloseIcon: true,
                        dismissCallback: () {},
                        popDirection: BrnPopupDirection.bottom);
                  },
                  child: Text("右侧带关闭Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 250),
                child: ElevatedButton(
                  key: _leftKey5,
                  onPressed: () {
                    BrnPopupWindow.showPopWindow(
                        context, "提示内容提示内容提示内容提示内容", _leftKey5!,
                        hasCloseIcon: false,
                        dismissCallback: () {},
                        popDirection: BrnPopupDirection.bottom);
                  },
                  child: Text("右侧无关闭Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 250),
                child: ElevatedButton(
                  key: _leftKey6,
                  onPressed: () {
                    BrnPopupWindow.showPopWindow(
                        context, "提示内容提示内容提示内容提示内容提示内容提示内容", _leftKey6!,
                        hasCloseIcon: true,
                        canWrap: false,
                        dismissCallback: () {},
                        popDirection: BrnPopupDirection.top);
                  },
                  child: Text("右侧带关闭，箭头朝下Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 250),
                child: ElevatedButton(
                  key: _leftKey7,
                  onPressed: () {
                    BrnPopupWindow.showPopWindow(
                        context, "提示内容提示内容提示内容提示内容提示内容提示内容", _leftKey7!,
                        hasCloseIcon: false,
                        dismissCallback: () {},
                        popDirection: BrnPopupDirection.top);
                  },
                  child: Text("右侧无关闭，箭头朝下Tips"),
                ),
              ),
            ],
          ),
        ));
  }
}
