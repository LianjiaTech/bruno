

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/step/brn_horizontal_step_example.dart';
import 'package:example/sample/components/step/step_line_example.dart';
import 'package:example/sample/home/list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: "步骤条示例",
      ),
      body: ListView(
        children: [
          ListItem(
            title: "横向步骤条",
            isShowLine: false,
            describe: "显示流程阶段，告知用户'我在哪/我能去哪'，跟随主题色",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return BrnHorizontalStepExamplePage(title: "步骤条");
                },
              ));
            },
          ),
          ListItem(
            title: "竖向步骤条",
            describe: '显示步骤、时间线',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return StepLineExample();
                },
              ));
            },
          ),
        ],
      ),
    );
  }
}
