

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class TextQuickSelectInputExamplePage extends StatefulWidget {
  final String _title;

  TextQuickSelectInputExamplePage(this._title);

  @override
  State<StatefulWidget> createState() {
    return _TextQuickSelectInputExamplePageState(this._title);
  }
}

class _TextQuickSelectInputExamplePageState
    extends State<TextQuickSelectInputExamplePage> {
  final String _title;
  String selectedStr = '';
  String selectedStrAllFunctionExample = '';
  List<String> options = ['选项1', '选项2', '选项3', '选项4', '选项5', '选项6', '选项7'];
  late List<bool> status;
  List<bool>? statusAllFunctionExample;

  _TextQuickSelectInputExamplePageState(this._title);

  @override
  void initState() {
    super.initState();

    status = List.filled(options.length, false);
    statusAllFunctionExample = List.filled(options.length, false);
  }

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
            BrnTextQuickSelectFormItem(
              title: "证件类型",
              btnsTxt: options,
              value: selectedStr,
              // selectBtnList: status,
              isBtnsScroll: true,
              onBtnSelectChanged: (int index) {
                status[index] = !status[index];
                if (status[index]) {
                  selectedStr += '${options[index]} ';
                } else if (selectedStr.contains(options[index])) {
                  selectedStr =
                      selectedStr.replaceFirst('${options[index]} ', '');
                }
                BrnToast.show(
                    "点击触发onBtnSelectChanged回调。\n index:$index", context);
                setState(() {});
              },
              onTip: () {
                BrnToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                BrnToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                BrnToast.show("点击触发onRemoveTap回调", context);
              },
              onTap: () {
                BrnToast.show("点击触发回调_onTap", context);
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
            BrnTextQuickSelectFormItem(
              prefixIconType: BrnPrefixIconType.add,
              isRequire: true,
              btnsTxt: options,
              selectBtnList: statusAllFunctionExample,
              value: selectedStrAllFunctionExample,
              isBtnsScroll: true,
              error: "必填项不能为空",
              title: "证件类型",
              subTitle: "这里是副标题",
              tipLabel: "标签",
              onBtnSelectChanged: (index) {
                statusAllFunctionExample![index] =
                    !statusAllFunctionExample![index];
                if (statusAllFunctionExample![index]) {
                  selectedStrAllFunctionExample += '${options[index]} ';
                } else if (selectedStrAllFunctionExample
                    .contains(options[index])) {
                  selectedStrAllFunctionExample = selectedStrAllFunctionExample
                      .replaceFirst('${options[index]} ', '');
                }
                BrnToast.show(
                    "点击触发onBtnSelectChanged回调。\n index:$index", context);
                setState(() {});
              },
              onTip: () {
                BrnToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                BrnToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                BrnToast.show("点击触发onRemoveTap回调", context);
              },
              onTap: () {
                BrnToast.show("点击触发回调_onTap", context);
              },
            ),
          ],
        ));
  }
}
