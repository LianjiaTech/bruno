
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

/// 第二种searchba的示例，场景应用于 页面标题的下方
class SearchTextExample extends StatefulWidget {
  @override
  _SearchTextExampleState createState() => _SearchTextExampleState();
}

class _SearchTextExampleState extends State<SearchTextExample> {
  FocusNode focusNode = FocusNode();
  BrnSearchTextController scontroller = BrnSearchTextController();

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    textController.addListener(() {
      if (focusNode.hasFocus) {
        if (!BrunoTools.isEmpty(textController.text)) {
          scontroller.isClearShow = true;
          scontroller.isActionShow = true;
        }
      }
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (!BrunoTools.isEmpty(textController.text)) {
          scontroller.isClearShow = true;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '搜索输入框示例',
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 40,
          ),
          BrnSearchText(
            focusNode: focusNode,
            controller: textController,
            searchController: scontroller..isActionShow = true,
            onTextClear: () {
              debugPrint('sss');
              return false;
            },
            autoFocus: true,
            onActionTap: () {
              scontroller.isClearShow = false;
              scontroller.isActionShow = false;
              focusNode.unfocus();
              BrnToast.show('取消', context);
            },
            onTextCommit: (text) {
              BrnToast.show('提交内容 : $text', context);
            },
            onTextChange: (text) {
              BrnToast.show('输入内容 : $text', context);
            },
          ),
          Container(
            height: 20,
          ),
          Container(
            width: 200,
            child: BrnSearchText(
              innerPadding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              maxHeight: 60,
              innerColor: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              normalBorder: Border.all(
                  color: Color(0xFFF0F0F0), width: 1, style: BorderStyle.solid),
              activeBorder: Border.all(
                  color: Color(0xFF0984F9), width: 1, style: BorderStyle.solid),
              onTextClear: () {
                debugPrint('sss');
                focusNode.unfocus();
                return false;
              },
              autoFocus: true,
              action: Container(),
              onActionTap: () {
                BrnToast.show('取消', context);
              },
              onTextCommit: (text) {
                BrnToast.show('提交内容 : $text', context);
              },
              onTextChange: (text) {
                BrnToast.show('输入内容 : $text', context);
              },
            ),
          )
        ],
      )),
    );
  }
}
