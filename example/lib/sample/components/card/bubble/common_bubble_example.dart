

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BubbleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '气泡信息',
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
              ),
            ),
            BrnBubbleText(
              maxLines: 3,
              text: '最多显示两行文本，背景边框的圆角是4，左上角是特殊的形状，\n '
                  '文本的字号是14，颜色为深色',
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnInsertInfo(
              infoText: '推荐理由：“满五唯一”“临近地铁”“首付低”，多出折行显示，文字展开的样式文。',
            ),
            Text(
              '异常案例文案过长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnInsertInfo(
              infoText:
                  '推荐理由：“满五唯一”“临近地铁”“首付低”，多出折行显示，文字展开的样式文。按钮的文案特别长按钮的文案特别长按钮的文案特别长按钮的文案特别长',
            ),
            Text(
              '异常案例文案过少',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnInsertInfo(
              infoText: '推荐理由',
            ),
            Text(
              '异常案例文案长度为0',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnInsertInfo(
              infoText: '',
            ),
          ],
        ),
      ),
    );
  }
}
