

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class SelectionViewMultiRangeExamplePage extends StatefulWidget {
  final String _title;
  final List<BrnSelectionEntity>? _filters;

  SelectionViewMultiRangeExamplePage(this._title, this._filters);

  @override
  _SelectionViewExamplePageState createState() =>
      _SelectionViewExamplePageState();
}

class _SelectionViewExamplePageState
    extends State<SelectionViewMultiRangeExamplePage> {
  List<String>? titles;

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
              onSelectionChanged: (int menuIndex,
                  Map<String, String> filterParams,
                  Map<String, String> customParams,
                  BrnSetCustomSelectionMenuTitle setCustomTitleFunction) {
                BrnToast.show(filterParams.toString(), context);
              },
              onSelectionPreShow: (int index, BrnSelectionEntity entity) {
                if (entity.key == "one_range_key" ||
                    entity.key == "two_range_key") {
                  return BrnSelectionWindowType.range;
                }
                return entity.filterShowType!;
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
