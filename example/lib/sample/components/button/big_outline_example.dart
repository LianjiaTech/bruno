import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BigOutlineButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BrnAppBar(
        title: '大边框按钮',
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
              text: '按钮宽度为屏幕宽度，按钮的高度为48，按钮的背景色主题色，按钮的圆角为4。按钮的边框线为0xffD7D7D7\n'
                  '按钮的文案最多居中显示一行，字号16号，字体w500，文字颜色为0xff222222。',
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            Container(
              width: 100,
              child: BrnBigOutlineButton(
                title: '提交',
                onTap: () {
                  BrnToast.show('点击了按钮', context);
                },
              ),
            ),
            Text(
              '正常案例 无点击事件',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnBigOutlineButton(
              title: '提交',
            ),
            Text(
              '置灰案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnBigOutlineButton(
              title: '提交',
              isEnable: false,
              onTap: () {
                BrnToast.show('点击了按钮', context);
              },
            ),
            Text(
              '文案过长',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnBigOutlineButton(
              title: '按钮的文案特别长按钮的文案特别长按钮的文案特别长按钮的文案特别长',
              onTap: () {
                BrnToast.show('点击了按钮', context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
