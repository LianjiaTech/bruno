

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class StateTagExample extends StatefulWidget {
  @override
  _StateTagExampleState createState() => _StateTagExampleState();
}

class _StateTagExampleState extends State<StateTagExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '状态角标签',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '规则',
              style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            BrnBubbleText(maxLines: 4, text: '同自定义标签'),
            Text(
              '等待状态',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnStateTag(
              tagText: '待进行',
              tagState: TagState.waiting,
            ),
            Text(
              '失效状态',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnStateTag(
              tagText: '失效态',
              tagState: TagState.invalidate,
            ),
            Text(
              '运行状态',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnStateTag(
              tagText: '进行中',
              tagState: TagState.running,
            ),
            Text(
              '失败状态',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnStateTag(
              tagText: '失败态',
              tagState: TagState.failed,
            ),
            Text(
              '成功状态',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnStateTag(
              tagText: '成功态',
              tagState: TagState.succeed,
            ),
            Text(
              '自定义',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnStateTag(
              backgroundColor: Colors.green,
              textColor: Colors.white,
              tagText: '自定义标签自定义标签自定义标签自定义标签自定义标签自定义标签自定义标签自定义标签',
            ),
            Container(
              height: 20,
            ),
            BrnStateTag(
              tagText: '自定义标签自定义标签自定义标标别长特别签自定义标签自定义标签',
            ),
            Text(
              '异常案例：文案特别长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnStateTag(
              tagText:
                  '标题特别长特别长特别长特别长特别长特别长特别长特别长标题特别长特别长特别长特别长特别长特别长特别长特别长标题特别长特别长特别长特别长特别长特别长特别长特别长',
            ),
          ],
        ),
      ),
    );
  }
}
