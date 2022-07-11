

import 'package:bruno/bruno.dart';
import 'package:example/sample/home/card_data_config.dart';
import 'package:example/sample/home/group_card.dart';
import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
/// 主页面
class HomePage extends StatelessWidget {
  GlobalKey _moreKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: 'UI组件',
        leading: null,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            child: Icon(
              Icons.more_horiz,
              key: _moreKey,
              color: Colors.black54,
            ),
            onTap: () {
              BrnPopupListWindow.showPopListWindow(context, _moreKey, data: ['切换语言', '测试动态增加语言'],
                  onItemClick: (int index, item) {
               if(index == 0) {
                 ChangeLocalEvent.locale = ChangeLocalEvent.locale.languageCode == 'zh'
                     ? Locale('en', 'US')
                     : Locale('zh', 'CN');
                 ChangeLocalEvent()..dispatch(context);
               } else {
                 ChangeLocalEvent.locale = ChangeLocalEvent.locale.languageCode == 'zh'
                     ? Locale('de', 'DE')
                     : Locale('zh', 'CN');
                 ChangeLocalEvent()..dispatch(context);
               }
                return false;
              });
            },
          )
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
