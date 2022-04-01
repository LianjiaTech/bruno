

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class FlatSelectionThreeTagsExample extends StatefulWidget {
  final String _title;
  final List<BrnSelectionEntity> _filterData;

  FlatSelectionThreeTagsExample(this._title, this._filterData);

  @override
  _SelectionViewExamplePageState createState() =>
      _SelectionViewExamplePageState();
}

class _SelectionViewExamplePageState
    extends State<FlatSelectionThreeTagsExample> {
  BrnSelectionEntity? entity;

  BrnFlatSelectionController? controller;

  var selectionKey = GlobalKey();

  bool _isShow = true;

  @override
  void initState() {
    super.initState();

    controller = BrnFlatSelectionController();
  }

  @override
  void dispose() {
    controller!.dispose();
    controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(title: widget._title),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: GestureDetector(
              child: Text("点击关闭展开"),
              onTap: () {
                setState(() {
                  _isShow = !_isShow;
                });
              },
            ),
          ),
          _isShow
              ? Column(
                  children: <Widget>[
                    Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: 400,
                        child: BrnFlatSelection(
                            entityDataList: widget._filterData,
                            confirmCallback: (data) {
                              var str = "";
                              data.forEach(
                                  (k, v) => str = str + " " + '$k: $v');
                              BrnToast.show(str, context);
                            },
                            controller: controller)),
                    _bottomWidget(),
                  ],
                )
              : new Container(),
        ],
      )),
    );
  }

  Widget _bottomWidget() {
    return Column(
      children: <Widget>[
        Divider(
          height: 0.3,
          color: Color(0xFFF0F0F0),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(8, 11, 20, 11),
          child: Row(
            children: <Widget>[
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(left: 12, right: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 24,
                        width: 24,
                        child: BrunoTools.getAssetImage(
                            BrnAsset.iconSelectionReset),
                      ),
                      Text(
                        "重置",
                        style:
                            TextStyle(fontSize: 11, color: Color(0xFF999999)),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  if (controller != null) {
                    controller!.resetSelectedOptions();
                  }
                },
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  BrnBigOutlineButton(
                      width: 104,
                      title: "取消",
                      onTap: () {
                        if (controller != null) {
                          controller!.cancelSelectedOptions();
                          setState(() {
                            _isShow = false;
                          });
                        }
                      }),
                  Container(
                    width: 20,
                  ),
                  BrnBigMainButton(
                      width: 104,
                      title: "确定",
                      onTap: () {
                        if (controller != null) {
                          controller!.confirmSelectedOptions();
                          setState(() {
                            _isShow = false;
                          });
                        }
                      }),
                ],
              ))
            ],
          ),
        )
      ],
    );
  }
}
