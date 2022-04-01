

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

/// 描述: 带按钮的通知example

class BrnNoticeBarWithButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        title: '通知样式01',
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
              text:
                  '高度56，左边为标签，中间是通知内容，右边是按钮， 其中通知内容必传，标签和按钮文案如果是空，就不显示。所有颜色均支持自定义',
            ),
            Text(
              '默认样式',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnNoticeBarWithButton(
              content: '这是通知内容',
            ),
            Text(
              '正常样式',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnNoticeBarWithButton(
              leftTagText: '任务',
              content: '这是通知内容',
              rightButtonText: '去完成',
              onRightButtonTap: () {
                BrnToast.show('点击右侧按钮', context);
              },
            ),
            Text(
              '跑马灯',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnNoticeBarWithButton(
              leftTagText: '任务',
              content: '这是跑马灯的通知内容跑马灯的通知内容跑马灯的通知内容跑马灯的通知内容',
              rightButtonText: '去完成',
              marquee: true,
              onRightButtonTap: () {
                BrnToast.show('点击右侧按钮', context);
              },
            ),
            Text(
              '隐藏左侧标签',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnNoticeBarWithButton(
              content: '这是通知内容',
              rightButtonText: '去完成',
              onRightButtonTap: () {
                BrnToast.show('点击右侧按钮', context);
              },
            ),
            Text(
              '隐藏右侧按钮',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnNoticeBarWithButton(
              leftTagText: '任务',
              content: '这是通知内容',
            ),
            Text(
              '通知文案长，不跑马灯',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnNoticeBarWithButton(
              leftTagText: '任务',
              content: '这是通知内容这是通知内容这是通知内容这是通知内容这是通知内容',
              rightButtonText: '去完成',
              onRightButtonTap: () {
                BrnToast.show('点击右侧按钮', context);
              },
            ),
            Text(
              '自定义文字和背景颜色',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            BrnNoticeBarWithButton(
              leftTagText: '任务',
              leftTagBackgroundColor: Color(0xFFE0EDFF),
              leftTagTextColor: Color(0xFF0984F9),
              content: '这是通知内容这是通知内容这是通知内容这是通知内容这是通知内容',
              backgroundColor: Color(0xFFEBFFF7),
              contentTextColor: Color(0xFF00AE66),
              rightButtonText: '去完成',
              rightButtonBorderColor: Color(0xFF0984F9),
              rightButtonTextColor: Color(0xFF0984F9),
              onRightButtonTap: () {
                BrnToast.show('点击右侧按钮', context);
              },
            ),
            SizedBox(
              height: 50,
            ),
          ])),
    );
  }
}
