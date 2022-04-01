

import 'package:bruno/bruno.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

class CustomPickerExamplePage extends StatelessWidget {
  CustomPickerExamplePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: '自定义底部弹窗',
        ),
        body: ListView(
          children: <Widget>[
            ListItem(
              title: "底部弹窗的内容为输入框",
              describe: '被键盘抬起',
              isShowLine: false,
              onPressed: () {
                BrnBottomPicker.show(context, onCancel: () {
                  Navigator.of(context).pop();
                },
                    onConfirm: () {},
                    contentWidget: Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '键盘抬起，不遮挡picker',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 20,
                            ),
                          ),
                          TextField(
                            autofocus: true,
                            decoration: InputDecoration(hintText: '请输入'),
                          )
                        ],
                      ),
                    ));
              },
            ),
            ListItem(
              title: "底部弹窗确定取消事件",
              describe: '支持底部弹窗确定取消事件并不关闭弹窗',
              onPressed: () {
                BrnBottomPicker.show(context, onConfirm: () {
                  BrnToast.show('不关闭', context);
                }, onCancel: () {
                  BrnToast.show('不关闭', context);
                },
                    contentWidget: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '通过属性支持确定和取消不关闭弹窗',
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ));
              },
            ),
            ListItem(
              title: "底部弹窗不显示title",
              describe: '支持底部弹窗不显示title',
              onPressed: () {
                BrnBottomPicker.show(context,
                    showTitle: false,
                    contentWidget: Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'showTitle 属性设置为 false，不显示顶部title区域，',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '其他区域可以完全自定义',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
            ListItem(
              title: "点击遮罩不关闭",
              describe: '支持点击遮罩不关闭',
              onPressed: () {
                BrnBottomPicker.show(context,
                    barrierDismissible: false,
                    contentWidget: Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '键盘抬起，不遮挡picker',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 20,
                            ),
                          ),
                          TextField(
                            autofocus: true,
                            decoration: InputDecoration(hintText: '请输入'),
                          )
                        ],
                      ),
                    ));
              },
            ),
          ],
        ));
  }
}
