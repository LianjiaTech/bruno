

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class SelectAllTitleExamplePage extends StatelessWidget {
  final String _title;

  SelectAllTitleExamplePage(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: _title,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Text(
                "基本样式：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            BrnSelectAllTitle(
              title: "基本样式",
              subTitle: "这里是副标题",
              selectText: '全选标题',
              selectState: false,
              onSelectAll: (int index, bool isSelect) {
                BrnToast.show("全选回调_onSelectAll", context);
              },
              onTip: () {
                BrnToast.show("点击触发回调_onTip", context);
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                "全功能样式：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            BrnSelectAllTitle(
              error: "必填项不能为空",
              title: "全功能样式",
              subTitle: "这里是副标题",
              selectText: '全选标题文案',
              tipLabel: "提示",
              isRequire: true,
              customActionWidget: Container(
                color: Colors.lightBlue,
                child: Center(
                    child:
                        Text('我是自定义视图', style: TextStyle(color: Colors.white))),
              ),
              onSelectAll: (int index, bool isSelect) {
                BrnToast.show("全选回调_onSelectAll", context);
              },
              onTip: () {
                BrnToast.show("点击触发回调_onTip", context);
              },
            ),
          ],
        ));
  }
}
