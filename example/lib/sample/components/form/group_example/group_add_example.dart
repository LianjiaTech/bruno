

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class GroupAddExamplePage extends StatelessWidget {
  final String _title;

  GroupAddExamplePage(this._title);

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
            BrnAddLabel(
              title: "添加组",
              onTap: () {
                BrnToast.show("点击触发onTap回调", context);
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                "全功能样式-禁用：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            BrnAddLabel(
              isEdit: false,
              title: "添加组",
              onTap: () {
                BrnToast.show("点击触发onTap回调", context);
              },
            ),
          ],
        ));
  }
}
