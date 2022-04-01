

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class SelectionViewLimitMaxSelectedCountExamplePage extends StatefulWidget {
  final String _title;
  final List<BrnSelectionEntity> _filterData;

  SelectionViewLimitMaxSelectedCountExamplePage(this._title, this._filterData);

  @override
  _SelectionViewExamplePageState createState() =>
      _SelectionViewExamplePageState();
}

class _SelectionViewExamplePageState
    extends State<SelectionViewLimitMaxSelectedCountExamplePage> {
  List<BrnSelectionEntity>? items;

  BrnSelectionViewController? controller;

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
            selectionViewController: controller,
            originalSelectionData: widget._filterData,
            onSelectionChanged: (int menuIndex,
                Map<String, String> filterParams,
                Map<String, String> customParams,
                BrnSetCustomSelectionMenuTitle setCustomTitleFunction) {
              BrnToast.show(
                  'filterParams : $filterParams' +
                      ',\n customParams : $customParams',
                  context);
            },
            onMenuClickInterceptor: (index) {
              if (index == 4) {
                BrnToast.show('第$index个被拦截了', context);
                return true;
              } else {
                return false;
              }
            },
            onSelectionPreShow: (int index, BrnSelectionEntity entity) {
              if (entity.key == "role" || entity.key == "guidePrice") {
                return BrnSelectionWindowType.range;
              }
              return entity.filterShowType!;
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
