import 'package:bruno/bruno.dart';
import 'package:example/sample/components/button/big_main_example.dart';
import 'package:example/sample/components/button/big_outline_example.dart';
import 'package:example/sample/components/button/small_main_example.dart';
import 'package:example/sample/components/button/brn_small_outline_example.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

import 'big_fu_example.dart';
import 'big_ghost_example.dart';

class ButtonEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '按钮',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListItem(
              title: '大主按钮',
              describe: '宽度为屏幕宽度，背景色为主题色',
              isShowLine: false,
              isSupportTheme: true,
              describeColor: Color(0xFF222222),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BigMainButtonExample();
                }));
              },
            ),
            ListItem(
              title: '大边框按钮',
              isSupportTheme: true,
              describe: '宽度为屏幕宽度，背景色为白色，带有边框线',
              describeColor: Color(0xFF222222),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BigOutlineButtonExample();
                }));
              },
            ),
            ListItem(
              title: '大辅助色按钮',
              describe: '宽度为屏幕宽度，背景色为次级辅助色',
              describeColor: Color(0xFF222222),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BigFuButtonExample();
                }));
              },
            ),
            ListItem(
              title: '大幽灵按钮',
              isSupportTheme: true,
              describe: '宽度为屏幕宽度，背景色为浅主题色',
              describeColor: Color(0xFF222222),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BigGhostButtonExample();
                }));
              },
            ),
            ListItem(
              title: '小主按钮',
              describe: '最小宽度为84，宽度自适应文字',
              isSupportTheme: true,
              describeColor: Color(0xFF222222),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BrnSmallMainButtonExample();
                }));
              },
            ),
            ListItem(
              title: '小边框按钮',
              isSupportTheme: true,
              describe: '最小宽度为84，宽度自适应文字',
              describeColor: Color(0xFF222222),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BrnSmallOutlineButtonExample();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
