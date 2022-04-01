

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class SelectionViewMoreFilterExamplePage extends StatefulWidget {
  final String _title;
  final List<BrnSelectionEntity>? _filters;

  SelectionViewMoreFilterExamplePage(this._title, this._filters);

  @override
  _SelectionViewExamplePageState createState() =>
      _SelectionViewExamplePageState();
}

class _SelectionViewExamplePageState
    extends State<SelectionViewMoreFilterExamplePage> {
  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(title: widget._title),
        body: Column(
          children: <Widget>[
            BrnSelectionView(
              originalSelectionData: widget._filters!,
              onMoreSelectionMenuClick: (int index, BrnOpenMorePage openMore) {
                openMore(updateData: false);
              },
              onSelectionChanged: (int menuIndex,
                  Map<String, String> filterParams,
                  Map<String, String> customParams,
                  BrnSetCustomSelectionMenuTitle setCustomTitleFunction) {},
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
