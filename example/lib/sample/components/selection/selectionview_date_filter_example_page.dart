

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class SelectionViewDateFilterExamplePage extends StatefulWidget {
  final String _title;
  final List<BrnSelectionEntity> _filters;

  SelectionViewDateFilterExamplePage(this._title, this._filters);

  @override
  _SelectionViewExamplePageState createState() =>
      _SelectionViewExamplePageState(_filters);
}

class _SelectionViewExamplePageState
    extends State<SelectionViewDateFilterExamplePage> {
  late List<BrnSelectionEntity> _filterData;

  _SelectionViewExamplePageState(List<BrnSelectionEntity> filters) {
    _filterData = filters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(title: widget._title),
        body: Column(
          children: <Widget>[
            BrnSelectionView(
              originalSelectionData: _filterData,
              onCustomSelectionMenuClick: (int index,
                  BrnSelectionEntity customMenuItem,
                  BrnSetCustomSelectionParams customHandleCallBack) {
                customHandleCallBack({"customKey": "customValue"});
              },
              onMoreSelectionMenuClick:
                  (int index, BrnOpenMorePage openMorePage) {
                openMorePage(
                    updateData: false, moreSelections: widget._filters);
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
              padding: EdgeInsets.only(top: 400),
              alignment: Alignment.center,
              child: Text("背景内容区域"),
            )
          ],
        ));
  }
}
