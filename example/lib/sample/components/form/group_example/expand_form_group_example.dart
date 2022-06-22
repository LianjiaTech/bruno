

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class ExpendFormGroupExample extends StatelessWidget {
  final String _title;

  ExpendFormGroupExample(this._title);

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
                "基本样式",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            BrnExpandableGroup(
              title: "展开收起分组",
              subtitle: "带箭头类型的子标题",
              backgroundColor: Colors.blue,
              children: [
                BrnTextInputFormItem(
                  title: "示例子项1",
                  hint: "请输入",
                  onChanged: (newValue) {
                    BrnToast.show("点击触发回调_${newValue}_onChanged", context);
                  },
                ),
                BrnTextInputFormItem(
                  title: "示例子项2",
                  hint: "请输入",
                  onChanged: (newValue) {
                    BrnToast.show("点击触发回调_${newValue}_onChanged", context);
                  },
                ),
                BrnTextInputFormItem(
                  title: "示例子项3",
                  hint: "请输入",
                  onChanged: (newValue) {
                    BrnToast.show("点击触发回调_${newValue}_onChanged", context);
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
