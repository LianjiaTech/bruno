

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TitleSelectInputExamplePage extends StatefulWidget {
  final String _title;

  TitleSelectInputExamplePage(this._title);

  @override
  State<StatefulWidget> createState() {
    return TitleSelectInputState();
  }
}

class TitleSelectInputState extends State<TitleSelectInputExamplePage> {
  late List<String> _list;
  TextEditingController controller = TextEditingController()..text = '123456';

  @override
  void initState() {
    super.initState();
    _list = [];
    _list.add('手机号');
    _list.add('座机');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: widget._title,
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
            BrnTitleSelectInputFormItem(
              title: _list[0],
              hint: "请输入",
              controller: controller,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              selectedIndex: -1,
              selectList: _list,
              onTip: () {
                BrnToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                BrnToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                BrnToast.show("点击触发onRemoveTap回调", context);
              },
              onChanged: (newValue) {
                BrnToast.show("点击触发回调_${newValue}_onChanged", context);
              },
              onTitleSelected: (String title, int index) {
                if ('座机' == title && controller.text.length > 5) {
                  BrnToast.show('输入长度不符合要求', context);
                  controller.text = '111***1111';
                }
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 80, 20, 5),
              child: Text(
                "全功能样式：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            BrnTitleSelectInputFormItem(
              controller: TextEditingController()..text = "124",
              prefixIconType: BrnPrefixIconType.add,
              isRequire: true,
              isEdit: false,
              error: "必填项不能为空",
              subTitle: "这里是副标题",
              tipLabel: "标签",
              title: _list[0],
              hint: "请输入",
              selectedIndex: -1,
              selectList: _list,
              onTip: () {
                BrnToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                BrnToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                BrnToast.show("点击触发onRemoveTap回调", context);
              },
              onChanged: (newValue) {
                BrnToast.show("点击触发回调_${newValue}_onChanged", context);
              },
              onTitleSelected: (String title, int index) {
                BrnToast.show("点击触发回调_${title}_${index}_onChanged", context);
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 80, 20, 5),
              child: Text(
                "no error：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            BrnTitleSelectInputFormItem(
              controller: TextEditingController()..text = "124",
              prefixIconType: BrnPrefixIconType.add,
              isRequire: true,
              isEdit: false,
              subTitle: "这里是副标题",
              tipLabel: "标签",
              title: _list[0],
              hint: "请输入",
              selectedIndex: -1,
              selectList: _list,
              onTip: () {
                BrnToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                BrnToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                BrnToast.show("点击触发onRemoveTap回调", context);
              },
              onChanged: (newValue) {
                BrnToast.show("点击触发回调_${newValue}_onChanged", context);
              },
              onTitleSelected: (String title, int index) {
                BrnToast.show("点击触发回调_${title}_${index}_onChanged", context);
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 80, 20, 5),
              child: Text(
                "全功能样式：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            BrnTitleSelectInputFormItem(
              controller: TextEditingController()..text = "不可编辑时+ -号可点击",
              prefixIconType: BrnPrefixIconType.add,
              isRequire: true,
              isEdit: false,
              isPrefixIconEnabled: false,
              error: "必填项不能为空",
              subTitle: "这里是副标题",
              tipLabel: "标签",
              title: _list[0],
              hint: "请输入",
              selectedIndex: -1,
              selectList: _list,
              onTip: () {
                BrnToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                BrnToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                BrnToast.show("点击触发onRemoveTap回调", context);
              },
              onChanged: (newValue) {
                BrnToast.show("点击触发回调_${newValue}_onChanged", context);
              },
              onTitleSelected: (String title, int index) {
                BrnToast.show("点击触发回调_${title}_${index}_onChanged", context);
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                "禁用态下可添加删除：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            BrnTitleSelectInputFormItem(
              controller: TextEditingController()..text = "不可编辑时+ -号可点击",
              prefixIconType: BrnPrefixIconType.add,
              isRequire: true,
              isEdit: false,
              isPrefixIconEnabled: true,
              error: "必填项不能为空",
              subTitle: "这里是副标题",
              tipLabel: "标签",
              title: _list[0],
              hint: "请输入",
              selectedIndex: -1,
              selectList: _list,
              onTip: () {
                BrnToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                BrnToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                BrnToast.show("点击触发onRemoveTap回调", context);
              },
              onChanged: (newValue) {
                BrnToast.show("点击触发回调_${newValue}_onChanged", context);
              },
              onTitleSelected: (String title, int index) {
                BrnToast.show("点击触发回调_${title}_${index}_onChanged", context);
              },
            ),
          ],
        ));
  }
}
