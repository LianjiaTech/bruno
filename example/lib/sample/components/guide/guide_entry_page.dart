

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/guide/force_guide_example.dart';
import 'package:example/sample/components/guide/soft_intro_example.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/material.dart';

class GuideEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: "引导示例",
      ),
      body: ListView(
        children: [
          ListItem(
            title: "强引导组件",
            isShowLine: false,
            describe: '强引导组件example',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return ForceGuideExample();
                },
              ));
            },
          ),
          ListItem(
            title: "弱引导组件",
            isSupportTheme: true,
            describe: '弱引导组件example',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return SoftGuideExample();
                },
              ));
            },
          ),
        ],
      ),
    );
  }
}
