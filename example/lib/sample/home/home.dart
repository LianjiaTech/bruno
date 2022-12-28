

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
          BrnTextAction( "切换组件词条语言",key: _moreKey, iconPressed: (){
            BrnPopupListWindow.showPopListWindow(context, _moreKey,
                data: ['BrnResourceEn', 'ResourceDe'],
                onItemClick: (int index, item) {
                  if(index == 0) {
                    BrnToast.showInCenter(text: "已切换为英语词条（BrnResourceEn）。\n注意：组件传入的默认值会影响词条展示", context: context);
                    ChangeLocalEvent.locale = Locale('en', 'US');
                    ChangeLocalEvent()..dispatch(context);
                  } else {
                    BrnToast.showInCenter(text: "已切换为德语词条（ResourceDe 部分）。\n注意：组件传入的默认值会影响词条展示", context: context);
                    ChangeLocalEvent.locale =  Locale('de', 'DE');
                    ChangeLocalEvent()..dispatch(context);
                  }
                  return false;
                });
          },)
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
