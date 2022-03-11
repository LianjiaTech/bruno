import 'package:bruno/bruno.dart';
import 'package:example/sample/components/button/brn_text_button_panel_example.dart';
import 'package:example/sample/components/button/button_panel_example.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

class ButtonPanelEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '按钮集合示例',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListItem(
              title: '普通按钮集合',
              describe: '主按钮、次按钮、icon按钮的集合',
              isShowLine: false,
              describeColor: Color(0xFF222222),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ButtonPanelExample();
                }));
              },
            ),
            ListItem(
              title: '文本按钮集合',
              describe: '文本类型按钮集合',
              describeColor: Color(0xFF222222),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BrnTextButtonPanelExample();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
