

import 'package:bruno/bruno.dart';
import 'package:example/sample/home/card_data_config.dart';
import 'package:example/sample/home/group_card.dart';
import 'package:flutter/material.dart';

import 'setting.dart';
/// 主页面
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'UI组件',
        leading: null,
        automaticallyImplyLeading: false,
        actions: [
          BrnIconAction(
            iconPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return Setting();
                },
              ));
            },
            child: Image.asset(
              'assets/image/setting.png',
              scale: 3.0,
              height: 20,
              width: 20,
            ),
          ),
        ],
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    List<GroupInfo> list = CardDataConfig.getAllGroup();

    return Container(
        color: Color(0xFFF8F8F8),
        padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(top: 10),
                child: GroupCard(
                  groupInfo: list[index],
                ),
              );
            }));
  }
}
