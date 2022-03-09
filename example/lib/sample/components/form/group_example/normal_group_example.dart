

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class NormalGroupExample extends StatelessWidget {
  final String _title;

  NormalGroupExample(this._title);

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
            BrnNormalFormGroup(
              title: "普通分组",
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
            BrnNormalFormGroup(
              title: "普通分组",
              subTitle: "这里是副标题",
              deleteLabel: "删除",
              tipLabel: "标签",
              error: "必填项不能为空",
              isRequire: true,
              isEdit: true,
              onRemoveTap: () {
                BrnToast.show("点击触发回调_onRemoveTap", context);
              },
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
