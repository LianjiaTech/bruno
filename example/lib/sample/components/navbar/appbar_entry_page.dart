

import 'package:bruno/bruno.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:example/sample/components/navbar/nav_bar_example_page.dart';
import 'package:flutter/material.dart';

class AppbarEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BrnAppBar(
          title: 'NavBar示例',
        ),
        body: ListView(
          children: <Widget>[
            ListItem(
              title: "NavBar示例",
              describe: 'Navbar/黑/2个文字模块切换+左右2icon',
              isShowLine: false,
              onPressed: () {
                _openNavBarPage(context, 0);
              },
            ),
            ListItem(
              title: "NavBar示例",
              describe: 'Navbar/黑/文字标题+左侧2icon+右侧文字+浮窗',
              onPressed: () {
                _openNavBarPage(context, 4);
              },
            ),
            ListItem(
              title: "NavBar示例",
              describe: 'Navbar/黑/文字标题+下拉选择',
              onPressed: () {
                _openNavBarPage(context, 5);
              },
            ),
            ListItem(
              title: "Navbar示例",
              describe: 'Navbar/白/文字标题+左侧icon',
              onPressed: () {
                _openNavBarPage(context, 8);
              },
            ),
            ListItem(
              title: "Navbar示例",
              describe: 'Navbar/白/文字标题+文字标签+左侧icon',
              onPressed: () {
                _openNavBarPage(context, 9);
              },
            ),
            ListItem(
              title: "Navbar 白色搜索结束示例",
              onPressed: () {
                _openNavBarPage(context, 19);
              },
            ),
            ListItem(
              title: "Navbar示例",
              describe: 'Navbar/白/文字标题+左侧2icon+右侧文字+浮窗',
              onPressed: () {
                _openNavBarPage(context, 10);
              },
            ),
            ListItem(
              title: "Navbar示例",
              describe: 'Navbar/黑',
              onPressed: () {
                _openNavBarPage(context, 11);
              },
            ),
            ListItem(
              title: "Navbar示例",
              describe: 'Navbar/白',
              onPressed: () {
                _openNavBarPage(context, 12);
              },
            ),
            ListItem(
              title: "SearchBar示例",
              describe: 'SearchBar/黑/类型不切换+文字提示+取消',
              onPressed: () {
                _openNavBarPage(context, 13);
              },
            ),
            ListItem(
              title: "SearchBar示例-白",
              describe: 'SearchBar/白/类型不切换+文字提示+取消',
              onPressed: () {
                _openNavBarPage(context, 16);
              },
            ),
            ListItem(
              title: "Navbar示例",
              describe: '多文本切换',
              onPressed: () {
                _openNavBarPage(context, 14);
              },
            ),
            ListItem(
              title: "搜索示例",
              describe: '多文本切换',
              onPressed: () {
                _openNavBarPage(context, 15);
              },
            ),
            ListItem(
              title: "搜索示例",
              describe: '搜索无leading',
              onPressed: () {
                _openNavBarPage(context, 17);
              },
            ),
          ],
        ));
  }

  _openNavBarPage(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NavBarPage(index);
    }));
  }
}
