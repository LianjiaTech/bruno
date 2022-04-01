

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/empty/abnormal_state_example.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

class AbnormalStatesEntryPage extends StatelessWidget {
  final _title;

  AbnormalStatesEntryPage(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: _title,
        ),
        body: ListView(
          children: <Widget>[
            ListItem(
              title: "异常信息+操作",
              isSupportTheme: true,
              isShowLine: false,
              describe: '异常信息+操作',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AbnomalStateExample(
                      caseIndex: 0,
                    );
                  },
                ));
              },
            ),
            ListItem(
              title: "异常信息居中展示",
              isSupportTheme: true,
              describe: '异常信息居中展示',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AbnomalStateExample(
                      caseIndex: 1,
                    );
                  },
                ));
              },
            ),
            ListItem(
              title: "异常信息默认展示",
              isSupportTheme: true,
              describe: '异常信息默认展示',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AbnomalStateExample(
                      caseIndex: 2,
                    );
                  },
                ));
              },
            ),
            ListItem(
              title: "大模块空态",
              isSupportTheme: true,
              describe: '大模块空态',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AbnomalStateExample(
                      caseIndex: 3,
                    );
                  },
                ));
              },
            ),
            ListItem(
              title: "单按钮效果",
              isSupportTheme: true,
              describe: '单按钮效果',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AbnomalStateExample(
                      caseIndex: 4,
                    );
                  },
                ));
              },
            ),
            ListItem(
              title: "双按钮效果",
              isSupportTheme: true,
              describe: '双按钮效果',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AbnomalStateExample(
                      caseIndex: 5,
                    );
                  },
                ));
              },
            ),
            ListItem(
              title: "小模块空态",
              isSupportTheme: true,
              describe: '小模块空态',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AbnomalStateExample(
                      caseIndex: 6,
                    );
                  },
                ));
              },
            ),
          ],
        ));
  }
}
