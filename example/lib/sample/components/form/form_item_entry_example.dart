// @dart=2.9

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/form/all_item_style_example.dart';
import 'package:example/sample/components/form/form_page_example.dart';
import 'package:example/sample/home/list_item.dart';

import 'package:flutter/material.dart';

class FormItemExamplePage extends StatelessWidget {
  final String _title;

  FormItemExamplePage(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: _title,
        ),
        body: ListView(
          children: <Widget>[
            ListItem(
              title: "表单项不同形态展示",
              isSupportTheme: true,
              isShowLine: false,
              describe: '各表单项',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AllFormItemStyleExamplePage("各表单项");
                  },
                ));
              },
            ),
            ListItem(
              title: "各表单项真实页面案例-退回订单",
              isSupportTheme: true,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return FormPageExample();
                  },
                ));
              },
            ),
          ],
        ));
  }
}
