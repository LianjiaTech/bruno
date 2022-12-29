import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class SelectionViewCustomHandleFilterExamplePage extends StatefulWidget {
  final String _title;
  final List<BrnSelectionEntity>? _filters;

  SelectionViewCustomHandleFilterExamplePage(this._title, this._filters);

  @override
  _SelectionViewExamplePageState createState() => _SelectionViewExamplePageState();
}

class _SelectionViewExamplePageState extends State<SelectionViewCustomHandleFilterExamplePage> {
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
              onCustomSelectionMenuClick: (int index, BrnSelectionEntity customMenuItem,
                  BrnSetCustomSelectionParams customHandleCallBack) {
                /// 用户操作一段时间之后，将自定义参数回传，触发 onSelectionChanged回调。
                BrnDialogManager.showConfirmDialog(context,
                    cancel: '取消', confirm: '确定', message: '点击确定，回传自定义参数到筛选', onConfirm: () {
                  count++;
                  customHandleCallBack({"CKey": "CValue" + '$count'});
                  Navigator.pop(context);
                }, onCancel: () {
                  Navigator.pop(context);
                });
              },
              onSelectionChanged: (int menuIndex,
                  Map<String, String> filterParams,
                  Map<String, String> customParams,
                  BrnSetCustomSelectionMenuTitle setCustomTitleFunction) {
                if (menuIndex == 1) {
                  setCustomTitleFunction(
                      menuTitle: BrunoTools.isEmpty(customParams) ? "" : customParams['CKey'] ?? "",
                      isMenuTitleHighLight: !BrunoTools.isEmpty(customParams['CKey']));
                }
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
