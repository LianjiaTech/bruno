

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/card/bubble/common_bubble_example.dart';
import 'package:flutter/material.dart';

class SelectionViewMoreCustomFloatLayerExamplePage extends StatefulWidget {
  final String _title;
  final List<BrnSelectionEntity>? _filterData;

  SelectionViewMoreCustomFloatLayerExamplePage(this._title, this._filterData);

  @override
  _SelectionViewExamplePageState createState() =>
      _SelectionViewExamplePageState();
}

class _SelectionViewExamplePageState
    extends State<SelectionViewMoreCustomFloatLayerExamplePage> {
  List<BrnSelectionEntity>? items;

  BrnSelectionViewController? controller;

  var selectionKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    controller = BrnSelectionViewController();
  }

  @override
  void dispose() {
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
              child: Text("点击关闭弹窗"),
              onTap: () {
                controller!.closeSelectionView();
              },
            ),
          ),
          BrnSelectionView(
            key: selectionKey,
            selectionViewController: controller,
            originalSelectionData: widget._filterData!,
            onMoreSelectionMenuClick:
                (int index, BrnOpenMorePage openMorePage) {
              openMorePage(updateData: false);
            },
            onCustomFloatingLayerClick: (int customFloatingLayerIndex,
                BrnSelectionEntity customLayerEntity,
                BrnSetCustomFloatingLayerSelectionParams resultCallBack) {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return BubbleExample();
                },
              )).then((data) {
                Map<String, String> result = Map();
                result['Key1'] = 'Value1';
                result['Key2'] = 'Value2';
                List<BrnSelectionEntity> resultEntity = [];
                result.forEach((userId, userName) {
                  resultEntity.add(BrnSelectionEntity(
                      value: userId,
                      title: userName,
                      isSelected: true,
                      type: 'radio'));
                });
                resultCallBack(resultEntity);
              });
            },
            onSelectionChanged: (int menuIndex,
                Map<String, String> filterParams,
                Map<String, String> customParams,
                BrnSetCustomSelectionMenuTitle setCustomTitleFunction) {
              BrnToast.show(
                  'filterParams : $filterParams' +
                      ',\n customParams : $customParams',
                  context);
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 300),
            alignment: Alignment.center,
            child: Text("背景内容区域"),
          ),
        ],
      )),
    );
  }
}
