

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BaseTitleExamplePage extends StatelessWidget {
  final String _title;

  BaseTitleExamplePage(this._title);

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
            BrnBaseTitle(
              title: "基本样式",
              subTitle: "这里是副标题",
              onTip: () {
                BrnToast.show("点击触发回调_onTip", context);
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                "自定义右侧区域视图样式：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            BrnBaseTitle(
              error: "必填项不能为空",
              title: "全功能样式",
              subTitle: "这里是副标题",
              tipLabel: "提示",
              isRequire: true,
              customActionWidget: Container(
                color: Colors.lightBlue,
                child: Center(
                    child:
                        Text('我是自定义视图', style: TextStyle(color: Colors.white))),
              ),
              onTip: () {
                BrnToast.show("点击触发回调_onTip", context);
              },
            ),
          ],
        ));
  }
}
